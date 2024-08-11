from django.urls import path
from . import views

app_name='learning_logs'

urlpatterns=[
    path('index',views.greeting,name='greeting'),
    path('index/<int:topic_id>',views.topic,name='topic'),
    path('',views.home,name='home'),
]