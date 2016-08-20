from django.shortcuts import render

# Create your views here.

import datetime
from django.http.response import HttpResponse
from django.shortcuts import render_to_response


def sayHello(request):
    s = 'hello world'
    current_time = datetime.datetime.now()
    html = '<html><head></head>' \
           '<body><h1>%s</h1>' \
           '<p>%s</p></body></html>' % (s, current_time)
    return HttpResponse(html)


def showStudent(request):
    list = [{id: 1, 'name': 'Jack'}, {id: 2, 'name': 'Rose'}]
    return render_to_response('student.html', {'students': list})