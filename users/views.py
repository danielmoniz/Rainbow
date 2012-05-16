from django.shortcuts import render_to_response, redirect
from django.core.urlresolvers import reverse
from django.template import RequestContext
from django.http import HttpResponseRedirect, Http404
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login
from django.views.generic import DetailView, UpdateView

from users.models import UserProfile, RegistrationForm
from build_world.models import Entity, MemberRelation as Relation

class ProfileUpdateView(UpdateView):
    """Used for editing a profile."""
    template_name = 'build_world/edit_entity.html'

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(UpdateView, self).dispatch(*args, **kwargs)

class ProfileDetailView(DetailView):
    """Display information about the User."""
    model = UserProfile
    template_name = 'users/user_profile.html'
    context_object_name = 'profile'

    def get_context_data(self, **kwargs):
        """Add the user's projects to the context data."""
        context = super(ProfileDetailView, self).get_context_data()
        profile = kwargs['object']
        # @TODO Work to decouple users from build_world by moving this query elsewhere.
        projects = Relation.objects.filter(user=profile.user)
        context['relations'] = projects
        context['owned'] = Entity.objects.filter(owner=profile.user)
        return context

def self_profile(request):
    """Redirect a user to their own profile URL. 404 if not logged in."""
    user_id = request.user.id
    if user_id != None:
        return redirect(reverse('users:profile', kwargs={'pk':user_id}))
    else:
        raise Http404

def register(request):
    """Use a RegistrationForm to render a form that can be used to register a
    new user. If there is POST data, the user has tried to submit data.
    Therefore, validate and either redirect (success) or reload with errors
    (failure). Otherwise, load a blank creation form.
    """
    if request.method == "POST":
        form = RegistrationForm(request.POST)
        if form.is_valid():
            form.save()
            # @NOTE This can go in once I'm using the messages framework.
            # messages.info(request, "Thank you for registering! You are now logged in.")
            new_user = authenticate(username=request.POST['username'], 
                password=request.POST['password1'])
            login(request, new_user)
            return HttpResponseRedirect(reverse('build_world:home'))
    else:
        form = RegistrationForm()
    # By now, the form is either invalid, or a blank for is rendered. If
    # invalid, the form will sent errors to render and the old POST data.
    return render_to_response('registration/join.html', { 'form':form }, 
        context_instance=RequestContext(request))
    
