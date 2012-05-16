from django.db import models
from django.contrib.auth.models import User
from django.forms import ModelForm

from build_world.fields import EntityCharField, EntityTextField
import merge_in_memory as mim_module

class Entity(models.Model):
    choices = (('world', 'World'), ('story', 'Story'), ('section', 'Section'))
    etype = models.CharField('Entity type', max_length='32', choices=choices, db_column='type',
        db_index=True, help_text='Specify the type of entity (eg.  World, Story) you are creating.', default='world')
    parent = models.ForeignKey('self', null=True, blank=True,
        help_text='Indicate to which entity (eg. World, Story, Section) this belongs.')
    founder = models.ForeignKey(User, related_name='founders')
    owner = models.ForeignKey(User, null=True, blank=True)
    name = EntityCharField(max_length=100)
    body = EntityTextField(blank=True)
    description = EntityTextField(max_length=1000, blank=True,
        help_text='Describe your project. This description will be visible to everyone.')
    notes = EntityTextField(blank=True, help_text='This is a place for storing any notes you might want to keep about the project.')
    private = models.BooleanField(default=False)
    active_version = models.ForeignKey('EntityVersion', related_name='active_version', null=True, blank=True, default=None)

    def __unicode__(self):
        return self.etype + ": " + self.name

    def has_same_data(self, other, reverse=False, **kwargs):
        """Takes in another entity and possibly some diffs to apply. Applies the diffs to self temporarily and checks if the primary attributes of the two entities are identical.
        """
        if type(self) != type(other):
            return False

        merger = mim_module.Merger()
        body = self.body
        description = self.description
        notes = self.notes

        if 'body_diff' in kwargs:
            body = merger.diff_apply(body, kwargs['body_diff'], reverse)
        if 'descr_diff' in kwargs:
            description = merger.diff_apply(description, kwargs['descr_diff'], reverse)
        if 'notes_diff' in kwargs:
            notes = merger.diff_apply(notes, kwargs['notes_diff'], reverse)

        # TEST OUTPUT
        return self.body + "<br />" + body + "<br />" + other.body + "<br />" + kwargs['body_diff']
        return body
        return other.body

        if body == other.body and description == other.description and notes == other.notes:
            return True

        return False

    def get_to_version(self, version):
        """Takes a version and tracks the current entity forward or back to
        that version by applying diffs.
        """
        try:
            curr_version_num = self.active_version.version_num
        except AttributeError:
            curr_version_num = 0

        try:
            target_version_num = version.version_num
        except AttributeError:
            target_version_num = 0

        # Get a list of versions that are in between this entity and the target
        # version.
        if curr_version_num <= target_version_num:
            reverse = False
            versions = EntityVersion.objects.filter(
                entity=self, 
                version_num__gt=curr_version_num, 
                version_num__lte=target_version_num)
        else:
            reverse = True
            versions = EntityVersion.objects.filter(
                entity=self, 
                version_num__lte=curr_version_num, 
                version_num__gt=target_version_num)
        for ver in versions:
            self.apply_version(ver, reverse=reverse)

    def apply_version(self, version, reverse=False):
        """Takes a version and applies its diffs to the current entity."""
        self.apply_diff_strings(reverse, body_diff=version.body,
            descr_diff=version.description, notes_diff=version.notes)


    def apply_diff_strings(self, reverse=False, **kwargs):
        """Takes a set of diffs and applies them to the relevant attributes."""
        merger = mim_module.Merger()
        if 'body_diff' in kwargs:
            self.body = merger.diff_apply(self.body, kwargs['body_diff'], reverse)
        if 'descr_diff' in kwargs:
            self.description = merger.diff_apply(self.description, kwargs['descr_diff'], reverse)
        if 'notes_diff' in kwargs:
            self.notes = merger.diff_apply(self.notes, kwargs['notes_diff'], reverse)

    def make_version_with_diffs(self, other, version=None):
        """Take in another entity and possibly a version. Return a version
        containing the diff of self and the other entity (in that order).
        """
        merger = mim_module.Merger()
        if type(self) != type(other):
            return False
        if not version:
            version = EntityVersion()
        version.body = merger.diff_make(self.body, other.body)
        version.description = merger.diff_make(self.description, other.description)
        version.notes = merger.diff_make(self.notes, other.notes)
        return version
     
class MemberRelation(models.Model):
    """Stores information about which user can contribute to which entities, and at what permission levels, and so on.
    """
    entity = models.ForeignKey(Entity)
    user = models.ForeignKey(User)
    ranks = (('chief_contrib', 'Chief Contributor'), ('chief_editor', 'Chief Editor'), ('editor', 'Editor'),
        ('contributor', 'Contributor'), ('artist', 'Artist'))
    relation = models.CharField(max_length=64, choices=ranks)

    def __unicode__(self):
        return self.user.username + ", " + self.relation + " of " + str(self.entity)

class Version(models.Model):
    """Stores the changes a person has made to an entity, or the data for a new
    entity that has yet to be accepted.
    NOTE: This relies on the merge_in_memory package, found at: 
    https://github.com/danielmoniz/merge_in_memory
    """
    version_num = models.IntegerField(null=True, blank=True)

    class Meta:
        abstract = True

    def __unicode__(self):
        return self.version_num

class EntityVersion(Version):
    """Stores entity data in a version."""
    entity = models.ForeignKey(Entity, null=True)
    modifies = models.ForeignKey('self', null=True, blank=True)
    active = models.BooleanField(default=False)
    body = EntityTextField(null=True, blank=True)
    description = EntityTextField(null=True, blank=True)
    notes = EntityTextField(null=True, blank=True)
    edited = models.BooleanField(default=False)
    accepted = models.BooleanField(default=False)
    user = models.ForeignKey(User)

    def __unicode__(self):
        output_list = [
            str(self.entity), 
            "modified by " + str(self.user),
            str(self.version_num)]
        if self.active:
            output_list.append('ACTIVE')
        else:
            output_list.append('ACTIVE')

        return ', '.join(output_list)

    def make_version_from_entities(self, entity1, entity2):
        """Take in two entities and modify this version's relevant fields to
        reflect the changes in the entities.
        NOTE: This is primarily used with a real entity and a dummy entity.
        Therefore only the text fields need modifying.
        """
        # Generate the diffs and call entity1.make_version_with_diffs
        pass



# FORMS ================================================================
class MemberRelationForm(ModelForm):
    """Allow users to create/modify/modify the permissions of others."""
    class Meta:
        model = MemberRelation
        exclude = ('entity')
     
class EntityForm(ModelForm):
    """A class for modifying an Entity."""
    class Meta:
        model = Entity
     
class EntityCreateForm(EntityForm):
    """A class for creating a new Entity. Leaves out both Founder and Owner.
    """
    class Meta(EntityForm.Meta):
        exclude = ('founder', 'owner', 'active_version',)

class WorldForm(EntityForm):
    """A class describing a form for modifying a World."""
    class Meta(EntityForm.Meta):
        exclude = ('parent', 'founder', 'body', 'active_version')

class WorldNonOwnerForm(WorldForm):
    """A class describing a form for modifying a World as a non-owner."""
    class Meta(WorldForm.Meta):
        exclude = ('parent', 'founder', 'body', 'owner', 'active_version')

class StoryForm(EntityForm):
    """A class describing a form for modifying a Story."""
    class Meta(EntityForm.Meta):
        exclude = ('founder', 'active_version')

class StoryNonOwnerForm(StoryForm):
    """A class describing a form for modifying a Story as a non-owner."""
    class Meta(StoryForm.Meta):
        exclude = ('founder', 'owner', 'active_version')

class SectionForm(EntityForm):
    """A class describing a form for modifying a Section."""
    class Meta(EntityForm.Meta):
        exclude = ('founder', 'active_version')

class SectionNonOwnerForm(SectionForm):
    """A class describing a form for modifying a Section as a non-owner."""
    class Meta(SectionForm.Meta):
        exclude = ('founder', 'owner', 'active_version')
