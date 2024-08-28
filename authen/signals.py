# your_app/signals.py

from django.dispatch import receiver
from allauth.account.signals import user_signed_up, user_logged_in
from .models import Profile,UserPersistentData
from django.db.models.signals import post_save
from django.contrib.auth.models import User

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
