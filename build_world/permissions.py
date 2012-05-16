from django.shortcuts import get_object_or_404

from build_world.models import Entity, MemberRelation as Relation

ranks = ('chief_contrib', 'chief_editor', 'contributor', 'editor', 'artist')
# Each rule consists of a tuple consiting of:
# (domain tuple, perms tuple)
# The domain tuple lists the other ranks over which this rank has power.
# The perms tuple lists the different actions they are allowed to perform.
# @TODO Is there a better place to put these?
rules = {'chief_contrib': (('editor', 'contributor', 'artist',), ('view', 'edit', 'submit', 'submit_art', 'delete', 'promote', 'kick',)), 
    'chief_editor': (('editor'), ('view', 'edit', 'delete', 'promote', 'kick',)),
    'editor': ((), ('view', 'edit',)),
    'contributor': ((), ('view', 'submit', )),
    'artist': ((), ('view', 'submit_art', )),
}

def has_view_perms(user, entity):
    """Returns True if a user has view permissions for a given entity,a nd
    False otherwise.
    """
    if not entity.private:
        return True
    if entity.founder == user:
        return True

    return has_permission('view', user, entity)

def has_edit_perms(user, entity):
    """Returns True if a user has edit permissions for a given entity,a nd
    False otherwise.
    """
    return has_permission('edit', user, entity)

def has_submit_perms(owner, entity):
    """Takes in the new owner of an entity and the entity. Returns true if the
    user had the permissions to submit that entity. Returns false otherwise.
    NOTE: This function assumes the user has already logged in.
    """
    # NOTE We use the entity's parent to determine if a user has permission to
    # submit content within that entity.
    # Always allowed to create a new entity if it does not have a parent (eg.
    # make a new World).
    if not entity.parent:
        return True
    return has_permission('submit', owner, entity.parent)

def get_submit_entities(user):
    """Return all entities to which the given user is able to submit."""
    # Naive approach: query for all entities. Then exclude every entity to
    # which the current user cannot submit, using has_submit_perms().
    entities = Entity.objects.all()
    for entity in entities[:]:
        if not has_permission('submit', user, entity):
            entities = entities.exclude(id=entity.id)

    return entities

def has_promote_perms(user, entity):
    """Finds out if a user has the permission to promote within an entity."""
    return has_permission('promote', user, entity)

# @TODO Combine this with get_submit_entities to remove code duplication.
def get_promote_entities(user):
    # Naive approach: query for all entities and exclude those to which the
    # user cannot submit.
    entities = Entity.objects.all()
    for entity in entities[:]:
        if not has_permission('promote', user, entity):
            entities = entities.exclude(id=entity.id)

    return entities

def has_kick_perms(user, entity):
    """Finds out if a user has the permission to kick another user within an
    entity. 
    NOTE: This assumes that there is max. 1 relation per user per entity.
    """
    if has_permission('kick', user, entity):
        return True
    return False
    
def is_user_kickable(user, entity):
    """Regardless of the user doing the kicking, determine whether or not the
    target can be kicked.
    """
    if entity.owner == user:
        return False
    relation = Relation.objects.get(entity=entity, user=user)
    # @TODO This list should be somewhere more global, called 'unkickable'.
    if relation.relation in ('chief_contrib', 'chief_editor'):
        return False

    return True

# @NOTE Fix the naming convention. This does not seem to fit with the other
# functions.
def outranks(user, target_rank, entity):
    """Checks if a user outranks the target user in the given entity. Return
    True if so, False otherwise.
    """
    if user == entity.owner:
        return True
    relation = Relation.objects.get(entity=entity, user=user)
    if relation.relation == target_rank:
        return False
    # @TODO Write a function to pull data out of the 'rules' var.
    if 'all' in rules[relation.relation][0]:
        return True
    elif target_rank in rules[relation.relation][0]:
        return True

    return False

# @NOTE The parameter convention is all over the place, but taking in a
# relation is the most efficient option here.
def get_outranks_list(user, entity):
    """Return a list of all ranks that the given person outranks. This is
    useful when, say, trying to understand to which ranks a person can promote.
    NOTE: The relation is built in the case the the relevant user is an owner
    or founder.
    """
    rank_list = [rank for rank in ranks 
        if outranks(user, rank, entity)]
    return rank_list

def has_permission(permission, user, entity):
    """Given the type of permission (eg. 'edit'), the user, and the entity,
    search for a relation determining that the user is allowed to perform the
    required action and return True. Return False otherwise.
    """
    # If user is not authenticated (ie. is AnonymousUser), return False.
    if not user.is_authenticated():
        return False

    # Loop through the entity and each parent to determine if any relations
    # exist that provide trickle-down permissions.
    while entity != None:
        # If user is the owner of the entity (or a parent), let them do
        # anything.
        if entity.owner == user:
            return True
        try:
            # Query for the current user's relations to that entity.
            relation = Relation.objects.get(user=user, entity=entity)
            if permission in rules[relation.relation][1]:
                return True
        except Relation.DoesNotExist:
            pass

        entity = entity.parent
    return False
