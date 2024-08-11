from django.shortcuts import render
from .models import Topic

# Create your views here.
def greeting(request):
    topics=Topic.objects.all()
    context={'topics': topics}
    return render(request,'topics.html',context)

def topic(request,topic_id):
    topic=Topic.objects.get(pk=topic_id)
    entries=topic.entry_set.all()
    dictionary={'topic':topic,'entries':entries}
    return render(request,'index.html',dictionary)



def home(request):
    return render(request,'home.html')