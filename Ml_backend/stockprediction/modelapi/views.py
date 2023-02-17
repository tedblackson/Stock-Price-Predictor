import sys, os
sys.path.append(os.path.join(os.getcwd(), 'prediction.py'))

from django.http import JsonResponse
from .prediction import DecisionTreeModel
import numpy as np
import json
from django.views.decorators.csrf import csrf_exempt
import pandas as pd
@csrf_exempt
def predict(request):
    if request.method == 'POST':
        
        data = json.loads(request.body)
        duration = data['duration']
        ticker = data['ticker']
        model = DecisionTreeModel()
        model.load_model(ticker)
        model.preprocess(ticker)
        predicted = model.predict(duration)
        predicted = list(predicted)
        response = {'prediction' : predicted}
        return JsonResponse(response)
