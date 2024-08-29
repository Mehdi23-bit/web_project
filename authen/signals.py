# your_app/signals.py

from django.dispatch import receiver
from allauth.account.signals import user_signed_up, user_logged_in
from .models import Profile,UserPersistentData
from django.db.models.signals import post_save
from django.contrib.auth.models import User
from django.contrib.auth.signals import user_logged_in
from social_django.models import UserSocialAuth
from .save_session import load_persistent_data


@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)
        UserPersistentData.objects.create(user=instance)
        print("Profile created for new user")

@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()
    instance.userpersistentdata.save()
    print("Profile saved for user")

"""@receiver(user_signed_up)
def create_profile_on_signup(request, user, **kwargs):
    print("User signed up signal received")
    Profile.objects.get_or_create(user=user)"""

@receiver(user_logged_in)
def handle_google_login(sender, request, user, **kwargs):
    try:
        # Check if the login was done using Google
        social = user.social_auth.get(provider='google-oauth2')
        # Perform your action here, for example, create a profile or log an event
        print(f"User {user.email} logged in with Google!")
        request.session['session_key'] = load_persistent_data(user)
    except UserSocialAuth.DoesNotExist:
        # User didn't log in using Google, skip this
        pass