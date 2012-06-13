from django.conf.urls.defaults import patterns, include, url
from django.views.generic import ListView, TemplateView
from django.views.generic.simple import redirect_to
from build_world.models import Entity
from build_world.views import EntityUpdateView, EntityCreateView, EntityDetailView, EntityAttrDetailView, EntityListView, RelationCreateView, RelationDeleteView

# Not yet used:
#from django.contrib.auth.forms import PasswordChangeForm

urlpatterns = patterns('', 
    # Global redirect. Make /worlds the home page.
    url(r'^$', redirect_to, {'url': '/browse', 'permanent': False}, name='home'),

    # URLS for unspecific displays
    url(r'^browse/$', EntityListView.as_view(), name='browse'),
    url(r'^browse/(?P<user_id>\d+)/$', EntityListView.as_view(), name='browse_by_user'),

    # URLS for global actions
    url(r'^create/$', EntityCreateView.as_view(), name='create'),
    url(r'^create/(?P<parent>\d+)/$', EntityCreateView.as_view(), name='create_with_parent'),
    url(r'^(?P<etype>world|story|section)/(?P<pk>\d+)/edit/$', EntityUpdateView.as_view(), 
        name='entity_edit'),
    url(r'^(?P<etype>world|story|section)/(?P<pk>\d+)/$', EntityDetailView.as_view(), name='entity'),
    url(r'^(?P<etype>world|story|section)/(?P<pk>\d+)/(?P<attr>\w+)/$', EntityAttrDetailView.as_view(), 
        name='entity_attr'),
    
    url(r'^(?P<etype>world|story|section)/(?P<pk>\d+)/promote/$', RelationCreateView.as_view(), 
        name='promote'),
    url(r'^(?P<etype>world|story|section)/(?P<entity>\d+)/kick/(?P<user>\d+)/$', RelationDeleteView.as_view(), 
        name='kick'),

    # URLS for Worlds
    url(r'^worlds/$', ListView.as_view(
        queryset=Entity.objects.filter(etype='world').order_by('id'),
        context_object_name='entity_list',
        template_name='build_world/entity_type_list.html',
    ), name='build_world-world_list'),

    # URLS for Stories
    url(r'^stories/$', ListView.as_view(
        queryset=Entity.objects.filter(etype='story').order_by('id'),
        context_object_name='entity_list',
        template_name='build_world/entity_type_list.html',
    ), name='build_world-story_list'),
 
    # URLS for Section
    url(r'^sections/$', ListView.as_view(
        queryset=Entity.objects.filter(etype='section').order_by('id'),
        context_object_name='entity_list',
        template_name='build_world/entity_type_list.html',
    ), name='build_world-section_list'),

    # Other displays
    url(r'^markdown/$', TemplateView.as_view(
        template_name='build_world/markdown.html'), name='markdown_help'),
)
