from build_world.models import Entity, MemberRelation
from django.contrib import admin

admin.site.register(Entity)
admin.site.register(MemberRelation)

"""admin.site.register(World, WorldAdmin)
class WorldAdmin(admin.ModelAdmin):
    fields = ['name', 'description']"""
