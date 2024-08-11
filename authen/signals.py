# your_app/signals.py

from django.dispatch import receiver
from allauth.account.signals import user_signed_up, user_logged_in
from .models import Profile

@receiver(user_signed_up)
def create_profile_on_signup(sender, request, user, **kwargs):
    Profile.objects.get_or_create(user=user)

@receiver(user_logged_in)
def create_profile_on_login(sender, request, user, **kwargs):
    Profile.objects.get_or_create(user=user)
