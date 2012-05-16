from django.shortcuts import get_object_or_404, render_to_response
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse, HttpResponseRedirect
from django.core.urlresolvers import reverse

from build_world.models import Entity, EntityCreateForm, SectionForm, WorldForm, StoryForm, WorldNonOwnerForm, StoryNonOwnerForm, SectionNonOwnerForm, MemberRelation as Relation, MemberRelationForm, EntityVersion
from build_world.permissions import has_view_perms, has_edit_perms, has_submit_perms, get_submit_entities, get_promote_entities, has_promote_perms, has_kick_perms, is_user_kickable, outranks, get_outranks_list

# Generic Views
from django.views.generic import DetailView, UpdateView, CreateView, DeleteView

# Helpers
import markdown
import copy
from build_world import utility

class EntityDetailView(DetailView):
    """Used for displaying any entity (eg. World, Story, Section)."""
    context_object_name = "entity"
    model = Entity
    template_name = 'build_world/entity.html'

    def __init__(self, *args, **kwargs):
        # @TODO Use self.render_to_response for some reason?
        self.error_page = render_to_response('build_world/error.html',
            { 'message':'You are not allowed to view this entity.' })
    
    def dispatch(self, request, *args, **kwargs):
        entity = get_object_or_404(Entity, **kwargs)
        if not has_view_perms(request.user, entity):
            return self.error_page
        return super(self.__class__, self).dispatch(request, *args, **kwargs)

    def get_queryset(self):
        entity = get_object_or_404(Entity, **self.kwargs)
        return Entity.objects.filter(pk=entity.id)

    def get_context_data(self, **kwargs):
        context = super(EntityDetailView, self).get_context_data(**kwargs)
        # Query for all people's relations to the current Entity.
        entity = kwargs['object']
        relations = Relation.objects.filter(entity=entity)
        context['relations'] = relations
        context['user_can_promote'] = has_promote_perms(self.request.user, entity)
        context['user_can_edit'] = has_edit_perms(self.request.user, entity)
        return context

    def get_object(self, queryset=None):
        entity = super(EntityDetailView, self).get_object(queryset)
        entity.body = convert_to_html(entity.body)
        entity.description = convert_to_html(entity.description)
        entity.notes = convert_to_html(entity.notes)
        return entity

# @TODO EntityUpdateView and EntityCreateView are very similar. Find a way to duplicate less code.
class EntityUpdateView(UpdateView):
    """Used for editing any entity, be it a World, Story, or Section."""
    template_name = 'build_world/edit_entity.html'
    model = Entity

    def __init__(self, *args, **kwargs):
        # @TODO Use self.render_to_response for some reason?
        self.error_page = render_to_response('build_world/error.html',
            { 'message':'You are not allowed to edit this entity.' })

    @method_decorator(login_required)
    def dispatch(self, request, *args, **kwargs):
        # @TODO Find a way to move the success_url line to __init__. The kwargs seem to be available in dispatch, but not __init__.
        self.success_url = reverse('build_world:entity', kwargs={ 'etype':kwargs['etype'], 'pk':kwargs['pk'] })

        entity = Entity.objects.get(id=kwargs['pk'])
        if not has_edit_perms(request.user, entity):
            return self.error_page

        # Create a new blank (ie. active=False) version if editing an entity.
        # @NOTE @TODO This does not work if someone loads a cached version of
        # the page! Eg. if someone hits back, dispatch() is not hit.
        if request.method == 'GET':
            version = utility.create_entity_version(entity, request.user)
            version.save()

        return super(EntityUpdateView, self).dispatch(request, *args, **kwargs)

    def get_form_class(self):
        """Check the keywords for to determine the type of entity and whether
        or not the current user is the owner. Return a ModelForm based on this
        info.
        """
        etype = self.kwargs['etype']
        entity = Entity.objects.get(id=self.kwargs['pk'])
        if self.request.user == entity.owner:
            if etype == 'world':
                return WorldForm
            elif etype == 'story':
                return StoryForm
            elif etype == 'section':
                return SectionForm
        else:
            # These forms leave out the 'owner' field.
            if etype == 'world':
                return WorldNonOwnerForm
            elif etype == 'story':
                return StoryNonOwnerForm
            elif etype == 'section':
                return SectionNonOwnerForm

    def get_form(self, form_class):
        """Return the form after having modified its querysets to match
        permissions.
        """
        form = super(EntityUpdateView, self).get_form(form_class)

        # Determine all valid parents. Remove itself from list.
        parents = get_submit_entities(self.request.user)
        entity = form.save(commit=False)
        parents = parents.exclude(id=entity.id)
        # @TODO Is there a more elegant way to limit the choices for parent?
        try:
            form.fields['parent'].queryset = parents
        except KeyError:
            pass
        return form

    def form_valid(self, form):
        """Creates a version from the existing data. Grabs the latest inactive
        version that was created when the user loaded the Edit page (or craete
        one if none exists). Warns the user if other edits have been made since
        they began editing.
        """
        # Save the entity only once we know the editor/edits are legit.
        entity = form.save(commit=False)

        # Find the most recent inactive/open version and use it.
        open_versions = EntityVersion.objects.filter(entity=entity, user=self.request.user, active=False).order_by('-id')
        if open_versions:
            version = open_versions[0]
        else:
            # Otherwise, make a new version and assume that the user is editing
            # the latest version of the entity.
            # @TODO Warn the user somehow against clicking Back to editt or
            # using cached versions of the page.
            version = utility.create_entity_version(
                entity=entity, user=self.request.user)

        if version.modifies == entity.active_version:
            # @TODO If the entity's current version does not exist, simply save the new version and point the entity to it.
            if version.modifies == None:
                pass
            else:
                pass
            # Find the diff, fill out the version, and modify the entity.
            old_entity = copy.deepcopy(entity)
            old_entity = utility.build_entity_to_version(entity.active_version)
            version = old_entity.make_version_with_diffs(entity, version)
            try:
                version.version_num = entity.active_version.version_num + 1
            except AttributeError:
                version.version_num = 1
            version.active = True
            version.accepted = True
            version.edited = True
            version.save()

            # Only save the entity if there are no conflicts.
            entity.active_version = version
            entity.save()

            # Clean up inactive versions for the user.
            EntityVersion.objects.filter(active=False, user=self.request.user).delete()

            return HttpResponseRedirect(self.success_url)
        else:
            # Then somebody has modified it since you've started editing.
            return HttpResponse('versions not equal - someome tampered. Show conflicts!')

class EntityCreateView(CreateView):
    """Used for editing any entity, be it a World, Story, or Section."""
    template_name = 'build_world/create.html'
    model = Entity
    form_class = EntityCreateForm

    def __init__(self, *args, **kwargs):
        # @TODO Use self.render_to_response for some reason?
        self.error_page = render_to_response('build_world/error.html',
            {'message':'You are not allowed to submit to this particular entity.'})

    @method_decorator(login_required)
    def dispatch(self, request, *args, **kwargs):
        return super(self.__class__, self).dispatch(request, *args, **kwargs)

    def get_form(self, form_class):
        """Return the form after having modified its querysets to match
        permissions.
        """
        form = super(self.__class__, self).get_form(form_class)
        parents = get_submit_entities(self.request.user)
        try:
            form.fields['parent'].queryset = parents
        except KeyError:
            pass
        return form

    def form_valid(self, form):
        """Checks for permission issues before validating the form as normal.
        """
        # Add author and founder information to the object.
        entity = form.save(commit=False)
        entity.owner = self.request.user
        entity.founder = self.request.user

        # If the user has permission to submit the entity, save it!
        if not has_submit_perms(self.request.user, entity):
            return self.error_page

        # Create and save an initial version.
        version = utility.create_entity_version(
            entity, self.request.user, first=True)

        entity.save()
        version.entity = entity
        version.save()

        # Now that the version has an id, re-save the entity.
        entity.active_version = version
        entity.save()

        # Set success_url to be based on the new entity and redirect.
        self.success_url = reverse('build_world:entity', 
            kwargs={ 'etype':entity.etype, 'pk':entity.id })
        return HttpResponseRedirect(self.success_url)

class RelationCreateView(CreateView):
    """A view for creating a new relation."""
    context_object_name = 'entity'
    template_name = 'build_world/create.html'
    model = Relation
    form_class = MemberRelationForm
    success_url = '/'

    def __init__(self, *args, **kwargs):
        # @TODO Use self.render_to_response for some reason?
        self.error_page = render_to_response('build_world/error.html',
            { 'message':'You are not allowed to promote users within this entity.' })

    @method_decorator(login_required)
    def dispatch(self, request, *args, **kwargs):
        """Disallow users from accessing promote pages when they lack perms."""
        entity = get_object_or_404(Entity, id=kwargs['pk'], etype=kwargs['etype'])
        if not has_promote_perms(request.user, entity):
            return self.error_page
        return super(RelationCreateView, self).dispatch(request, *args, **kwargs)

    def form_valid(self, form):
        """Add an entity to the relation using provided GET info."""
        new_relation = form.save(commit=False)
        new_relation.entity = Entity.objects.get(id=self.kwargs['pk'], etype=self.kwargs['etype'])

        # If a value exists already in the DB, update it.
        try:
            old_relation = Relation.objects.get(user=new_relation.user, entity=new_relation.entity)
            old_relation.relation = new_relation.relation
            old_relation.save()
        except Relation.DoesNotExist:
            new_relation.save()
        return HttpResponseRedirect(reverse('build_world:entity', kwargs={ 'etype':self.kwargs['etype'], 'pk':self.kwargs['pk'] }))

    def get_form(self, form_class):
        """Ensure that the form's fields are limited to allowable actions."""
        form = super(RelationCreateView, self).get_form(form_class)
        entity = Entity.objects.get(id=self.kwargs['pk'])

        # Get the list of ranks that the current user outranks, and allow a
        # user to promote to only those ranks.
        outranks_list = get_outranks_list(self.request.user, entity)
        rank_tuples = Relation().ranks
        ranks = tuple([rank for rank in rank_tuples if rank[0] in outranks_list])
        form.fields['relation'].choices = ranks

        # Find all entities a user can promote within, and limit to those.
        # @NOTE: The field 'entity' does not appear on the form at the date of
        # this writing. This is left in for future use.
        entities = get_promote_entities(self.request.user)
        try:
            form.fields['entity'].queryset = entities
        except KeyError:
            pass

        # Remove the current user and the owner as choices for promotion.
        try:
            form.fields['user'].queryset = form.fields['user'].queryset.exclude(id=self.request.user.id).exclude(id=entity.owner.id)
        except KeyError:
            pass
        return form

class RelationDeleteView(DeleteView):
    """Allows a user to delete a relation, ie. kick someone out of a project."""
    model = Relation
    template_name = 'build_world/kick.html'

    def __init__(self, *args, **kwargs):
        # @TODO Use self.render_to_response for some reason?
        self.no_perms = render_to_response('build_world/error.html',
            { 'message':'You do not have permission to kick people within this entity.' })
        self.do_not_outrank = render_to_response('build_world/error.html',
            { 'message':'You do not outrank this user!' })
        self.unkickable = render_to_response('build_world/error.html',
            { 'message':'You cannot kick this user! Owners and Chiefs cannot be kicked.' })

    @method_decorator(login_required)
    def dispatch(self, request, *args, **kwargs):
        """Find the relation's primary key and send that to DeleteView for
        deletion.
        """
        relation = get_object_or_404(Relation, entity=kwargs['entity'], user=kwargs['user'])
        # Output an error message depending on the user's relations (if need
        # be)
        if not has_kick_perms(request.user, relation.entity):
            return self.no_perms
        if not is_user_kickable(relation.user, relation.entity):
            return self.unkickable
        if not outranks(request.user, relation.relation, relation.entity):
            return self.do_not_outrank

        return super(RelationDeleteView, self).dispatch(request, pk=relation.id, etype=kwargs['etype'], entity=kwargs['entity'])

    def get_success_url(self):
        return reverse('build_world:entity', kwargs={ 'etype':self.kwargs['etype'], 'pk':self.kwargs['entity'] })

def convert_to_html(text):
    """Use markdown to take plain text and convert it to safe HTML."""
    return markdown.markdown(text)
