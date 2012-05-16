from django.db import models

from bs4 import BeautifulSoup

class EntityCharField(models.CharField):
    """Extend the CharField class and override the clean() method. This ensures
    that the data is cleaned for all HTML.
    """
    def clean(self, *args, **kwargs):
        cleaned_data = super(EntityCharField, self).clean(*args, **kwargs)
        cleaned_data = clean_text(cleaned_data)
        return cleaned_data

class EntityTextField(models.TextField):
    """Extend the TextField class and override the clean() method. This ensures
    that the data is cleaned for all HTML.
    """
    def clean(self, *args, **kwargs):
        cleaned_data = super(EntityTextField, self).clean(*args, **kwargs)
        cleaned_data = clean_text(cleaned_data)
        return cleaned_data

def clean_text(text):
    """Use BeautifulSoup to remove any HTML tags.
    NOTE: This is not yet secure. There are ways to hide a tag within a tag
    such that BeautifulSoup4 will render the hidden tag.
    Eg. <<script>script>alert("You've been hacked!");</</script>script>
    For details, see:
    http://stackoverflow.com/questions/699468/python-html-sanitizer-scrubber-filter/812785#812785
    """
    # @TODO Make this more secure!
    # Find all tags on the page that have text and concatenate them.
    # ie. Remove all tags while keeping their content.
    soup = BeautifulSoup(text)
    return ''.join(soup.find_all(text=True))
