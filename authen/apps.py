from django.apps import AppConfig


class AuthenConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'authen'
# your_app/apps.py

from django.apps import AppConfig

class YourAppConfig(AppConfig):
    name = 'authen'

    def ready(self):
        import authen.signals
