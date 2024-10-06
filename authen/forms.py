from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.forms import PasswordChangeForm



class LoginForm(forms.Form):
  
   username = forms.CharField(max_length=150)
   password = forms.CharField(widget=forms.PasswordInput)


class SignInForm(UserCreationForm):
    class Meta:
        model=User
        fields=['first_name','last_name','username','email','password1','password2']
    '''def clean_username(self):
        username = self.cleaned_data.get('username')
        if User.objects.filter(username=username).exists():
            raise forms.ValidationError("Username is already taken.")
        return username'''
    

class UserUpdateForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['username', 'email', 'first_name', 'last_name']

class CustomPasswordChangeForm(PasswordChangeForm):
    class Meta:
        model = User
        fields = ['old_password', 'new_password1', 'new_password2']

class CombinedUserUpdateForm(UserUpdateForm, CustomPasswordChangeForm):
    def __init__(self, *args, **kwargs):
        super(CombinedUserUpdateForm, self).__init__(*args, **kwargs)
        self.fields['old_password'].required = False
        self.fields['new_password1'].required = False
        self.fields['new_password2'].required = False

    def save(self, commit=True):
        user = super().save(commit=False)
        if self.cleaned_data['new_password1']:
            user.set_password(self.cleaned_data['new_password1'])
        if commit:
            user.save()
        return user

