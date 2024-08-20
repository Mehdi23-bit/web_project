
class Category:
    def __init__(self,request):
        self.session=request.session
        self.cat=self.session.get('sessioncategory')
        if not self.cat:
            self.cat=request.session['sessioncategory']='all'
    def add(self,category):
        self.cat=category
        self.session['sessioncategory']=category
        