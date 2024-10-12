# In a new file, e.g., utils.py
from .models import UserPersistentData

def save_persistent_data(user, data):
    print("save_persistent_data")
    user_data= UserPersistentData.objects.get(user=user)
    user_data.data = data
    user_data.save()



def load_persistent_data(user):
    print('I am updating the session data now')
    try: 
        return UserPersistentData.objects.get(user=user).data
    except UserPersistentData.DoesNotExist:
        return {}
