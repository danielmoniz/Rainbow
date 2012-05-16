from django.db import models
from django.forms import ModelForm
from django.contrib.auth.forms import UserCreationForm
from django.db.models.signals import post_save
from django.contrib.auth.models import User

class UserForm(ModelForm):
    """A form for creatin and modifying basic user information."""

    class Meta:
        model = User

class UserProfile(models.Model):
    """Stores extra information about a user."""
    user = models.OneToOneField(User, primary_key=True)

    fav_author = models.CharField(max_length=64)

    def get_fields(self):
        """Return a list containing tuples of every field in both the User and
        the UserProfile class.
        """
        fields = get_model_fields(UserProfile)
        # Remove 'id' and 'user' fields.
        #fields = [field for field in fields if field.name != 'id' and field.name != 'user']
        return [(field.name, field.value_to_string(self)) for field in fields]

class UserProfileForm(ModelForm):
    """A form for modifying/creating user profiles."""
    class Meta:
        model = UserProfile
        exclude = ('id', 'user')

def create_user_profile(sender, instance, created, **kwargs):
    if created:
        UserProfile.objects.create(user=instance)
     
def get_model_fields(model):
    """Return a list containing tuples of every field in the class."""
    return model._meta.fields[:]

post_save.connect(create_user_profile, sender=User)

class RegistrationForm(UserCreationForm):
    """Provide a view for creating users with only the requisite fields."""

    class Meta:
        model = User
        # Note that password is taken care of for us by auth's UserCreationForm.
        fields = ('username', 'email')

