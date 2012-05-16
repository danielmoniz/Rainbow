from django.conf.urls import patterns, include, url
from django.views.generic import DetailView

# Uncomment the next two lines to enable the admin:
from django.contrib import admin

# TEST
from django.views.generic import TemplateView

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'rainbow.views.home', name='home'),
    # url(r'^rainbow/', include('rainbow.foo.urls')),

    url(r'^about/$', DetailView.as_view(template_name='about.html'), name="about"),
    url(r'^login/$', 'django.contrib.auth.views.login', name="login"),
    url(r'^logout/$', 'django.contrib.auth.views.logout', {'next_page':'/'}, name="logout"),

    # Include app URLs
    url(r'', include('users.urls', namespace='users')),
    url(r'', include('build_world.urls', namespace='build_world')),
    url(r'^about/$', TemplateView.as_view(template_name='about.html')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
)
