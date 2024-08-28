from django.apps import AppConfig


class AuthenConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'authen'
    def ready(self):
      from .  import signals
