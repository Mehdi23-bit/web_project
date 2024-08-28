# In a new file, e.g., utils.py
from .models import UserPersistentData

def save_persistent_data(user, data):
    print("i am saving")
    user_data= UserPersistentData.objects.get(user=user)
    user_data.data = data
    user_data.save()

def load_persistent_data(user):
    try:
        return UserPersistentData.objects.get(user=user).data
    except UserPersistentData.DoesNotExist:
        return {}