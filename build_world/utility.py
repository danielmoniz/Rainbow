# IN USE
from build_world.models import Entity, EntityVersion
import merge_in_memory as mim_module

# NOT CURRENTLY IN USE
import random
import time
from hashlib import sha1

# IN USE -----------------------------------------

def create_entity_version(entity=None, user=None, first=False):
    """A helper function for EntityVersion. Do a little bit of logic to set up
    a basic EntityVersion.
    """
    version = EntityVersion()
    if entity:
        version.entity = entity
        try:
            version.modifies = entity.active_version
        except EntityVersion.DoesNotExist:
            pass
    if user:
        version.user = user

    if first:
        version.version_num = 1
        merger = mim_module.Merger()
        version.body = merger.diff_make('', entity.body)
        version.description = merger.diff_make('', entity.description)
        version.notes = merger.diff_make('', entity.notes)
        version.active = True
        version.accepted = True
    return version


def build_entity_to_version(version):
    """Generate the entity again from scratch using its versions."""
    entity = Entity()
    if not version.active:
        return False

    versions = EntityVersion.objects.filter(
        entity=version.entity, active=True, 
        version_num__lte=version.version_num).order_by('version_num')
    for version in versions:
        entity.apply_version(version)
    return entity


# NOT CURRENTLY USED ----------------------------------

def get_valid_keyword_dict(allowed_keys, input_keywords):
    """Takes a list of keywords. Checks the given model for keys(), and returns
    a dictionary consisting only of valid, non-empty keywords."""
    # Determine all valid keywords (allowed and non-empty), and filter by
    # them.
    valid_keywords = [[key, val] for (key, val) in input_keywords if key in
        allowed_keys and val] 
    return dict(valid_keywords)

def generate_random_hash():
    """Generate a random hash to be used as an edit token for authenticity."""
    time_str = str(int(time.time()))
    sha = sha1()
    sha.update(time_str)
    sha.update(str(random.random()))
    return str(sha.hexdigest())
