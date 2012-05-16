from django.conf.urls.defaults import patterns, include, url
from users.models import UserProfile, UserProfileForm
from users.views import ProfileDetailView, ProfileUpdateView
from django.contrib.auth import views as auth_views

#import users as users

# TEST
from django.views.generic import TemplateView

urlpatterns = patterns('', 
    url(r'^join/$', 'users.views.register', name='join'),
    url(r'^profile/$', 'users.views.self_profile',
        name='user_profile_current'),
    url(r'^profile/(?P<pk>\d+)/$', ProfileDetailView.as_view(),
        name='profile'),
    url(r'^profile/(?P<pk>\d+)/edit/$', ProfileUpdateView.as_view(form_class=UserProfileForm,
        model=UserProfile, success_url='/profile/%(user_id)s'),
        name='user_profile_edit'),

    # Unfinished: Password reset URL rules.
    url(r'^passreset/$', auth_views.password_reset, name='password_reset'),
    url(r'^passreset/done/$', auth_views.password_reset_done, name='password_reset_done'),
    url(r'^passreset/confirm/(?P<uidb64>[-\w]+)/(?P<token>[-\w]+)/$', auth_views.password_reset_confirm, name='password_reset_confirm'),
    url(r'^passreset/complete/$', auth_views.password_reset_complete, name='password_reset_complete'),

    # TEST
    url(r'^test/$', TemplateView.as_view(template_name='test.html'), name='test'),
)


"""url(r'^join/$', CreateView.as_view(
    form_class=RegistrationForm,
    model=User,
    template_name='registration/join.html',
    # @TODO This should be dynamic in order to direct to the current home page, whatever that is.
    success_url='/',
), name='join'),"""
