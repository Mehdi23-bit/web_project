"""
Django settings for ll_project project.

Generated by 'django-admin startproject' using Django 4.1.13.

For more information on this file, see
https://docs.djangoproject.com/en/4.1/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/4.1/ref/settings/
"""

from pathlib import Path
import os
from django.urls import reverse_lazy
from dotenv import load_dotenv



load_dotenv()

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-u510lzwpsgmlz99%&8^$3%dz^0ecg&wvkypsm))k)n33v#nsn+'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ["afbd-197-146-122-76.ngrok-free.app","localhost",'127.0.0.1' ]

CSRF_TRUSTED_ORIGINS = [
    'https://afbd-197-146-122-76.ngrok-free.app',  # Replace with your actual Ngrok URL
]

# Application definition

INSTALLED_APPS = [
    'myapp',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django_extensions',
    'authen',
    'django.contrib.sites',
    'paypal.standard.ipn',
    'payment.apps.PaymentConfig',
    'social_django'

]
PAYPAL_TEST = True

PAYPAL_RECEIVER_EMAIL="sb-b5smm32419244@business.example.com"

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'allauth.account.middleware.AccountMiddleware',
    'social_django.middleware.SocialAuthExceptionMiddleware',
    'authen.middleware.RequestLoggingMiddleware',
     'authen.middleware.RequestMiddleware'
]

ROOT_URLCONF = 'll_project.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'myapp.context_processor.cart',
                'myapp.context_processor.category',
                'social_django.context_processors.backends',
                'social_django.context_processors.login_redirect'
            ],
        },
    },
]

WSGI_APPLICATION = 'll_project.wsgi.application'


# Database
# https://docs.djangoproject.com/en/4.1/ref/settings/#databases


import os
from dotenv import load_dotenv 
load_dotenv()
DATABASE_URL = os.getenv("DATABASE_URL")

DATABASES = {
    'default': {

        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'mydb',
        'USER': 'myuser',
        'PASSWORD': 'mypassword',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}



SITE_ID=2

AUTHENTICATION_BACKENDS = (
     'django.contrib.auth.backends.ModelBackend',
    'social_core.backends.google.GoogleOAuth2',
    'social_core.backends.google.GoogleOAuth',
)

LOGIN_URL='authen:login_page'
LOGIN_REDIRECT_URL = 'myapp:product_list'
LOGOUT_URL='authen:logout'
LOGOUT_REDIRECT_URL='authen:login_page'
SOCIAL_AUTH_GOOGLE_OAUTH2_KEY=os.getenv("SOCIAL_AUTH_GOOGLE_OAUTH2_KEY")
SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET=os.getenv("SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET")


SOCIAL_AUTH_PIPELINE = (
    'social_core.pipeline.social_auth.social_details',
    'social_core.pipeline.social_auth.social_uid',
    'social_core.pipeline.social_auth.auth_allowed',
    'social_core.pipeline.social_auth.social_user',
    'social_core.pipeline.user.get_username',
    'social_core.pipeline.user.create_user',
    'social_core.pipeline.social_auth.associate_user',
    'social_core.pipeline.social_auth.load_extra_data',
    'social_core.pipeline.user.user_details',
    'authen.pipeline.load_user_persistent_data',  # Add this line
)



# Password validation
# https://docs.djangoproject.com/en/4.1/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/4.1/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.1/howto/static-files/


# Static files (CSS, JavaScript, images)
STATIC_URL = '/static/'

# This directory should contain your static files during development
STATICFILES_DIRS = [os.path.join(BASE_DIR, 'static')]

MEDIA_URL='media/'
MEDIA_ROOT=os.path.join(BASE_DIR,'media')

# This directory is where static files will be collected during production
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')

# Default primary key field type
# https://docs.djangoproject.com/en/4.1/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
# settings.py

# Define the URL where authenticated users should be redirected upon successful login


# Optionally, configure the session cookie age (default is 2 weeks)
SESSION_COOKIE_AGE = 60 * 60 * 24 * 7  # Set to 1 week (in seconds)
APPEND_SLASH = True
SESSION_SAVE_EVERY_REQUEST = True
if DEBUG:
    WHITENOISE_AUTOREFRESH = True
