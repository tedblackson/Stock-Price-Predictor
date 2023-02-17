from django.urls import path
from modelapi.views import predict

urlpatterns = [
    path('predict/', predict, name='predict'),
]
