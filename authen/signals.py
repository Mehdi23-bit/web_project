from django.dispatch import receiver
from allauth.account.signals import user_signed_up, user_logged_in
from .models import Profile, UserPersistentData
from django.db.models.signals import post_save
from django.contrib.auth.models import User
from social_django.models import UserSocialAuth
from .save_session import load_persistent_data

@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)
        UserPersistentData.objects.create(user=instance)
        print("Profile and UserPersistentData created for new user")

@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()
    instance.userpersistentdata.save()  # Ensure this line does not raise an error
    print("Profile saved for user")

@receiver(user_signed_up)
def create_profile_on_signup(request, user, **kwargs):
    print("User signed up signal received")
    Profile.objects.get_or_create(user=user)
    UserPersistentData.objects.get_or_create(user=user)  # Ensure UserPersistentData is created

@receiver(user_logged_in)
def handle_google_login(sender, request, user, **kwargs):
    try:
        # Check if the login was done using Google
        social = user.social_auth.get(provider='google-oauth2')
        print(f"User {user.email} logged in with Google!")

        # Ensure UserPersistentData exists
        user_data, created = UserPersistentData.objects.get_or_create(user=user)
        
        # Load persistent data into session
        request.session['session_key'] = load_persistent_data(user)
    except UserSocialAuth.DoesNotExist:
        # User didn't log in using Google, skip this
        pass

