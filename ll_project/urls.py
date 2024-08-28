"""ll_project URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,include
from django.conf.urls.static import static
from django.conf import settings
from paypal.standard.ipn import signals as paypal_signals
from payment import signals as payment_signals
from allauth.account import signals as user_signals
from authen import signals as profile_view
# This line is just to ensure the signals are connected
paypal_signals.valid_ipn_received.connect(payment_signals.valid_ipn_received_handler)
urlpatterns = [
    path('admin/', admin.site.urls),
    path('',include('authen.urls')),
    path('myapp/',include('myapp.urls')),
    path('social-auth/', include('social_django.urls', namespace='social')),
    path('payment/',include('payment.urls')),
     path('paypal/', include("paypal.standard.ipn.urls")),
     
    ]
urlpatterns+=static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)