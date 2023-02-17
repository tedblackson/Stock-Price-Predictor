import numpy as np
import pickle
import pandas as pd
import requests
import os.path

class DecisionTreeModel:
    def __init__(self):
        self.model = None
        self.data = None

    def load_model(self, ticker):
        
        filename =  os.path.join(os.getcwd(), 'modelapi', 'models', ticker + '_model.pickle')



        with open(filename, 'rb') as f:
            self.model = pickle.load(f)


    def predict(self, days):
        x_future = self.data[:days]
        return self.model.predict(x_future)

        
    def preprocess(self, ticker):
        url = "https://yh-finance.p.rapidapi.com/stock/v3/get-historical-data"

        querystring = {"symbol": ticker,"region":"US"}

        headers = {
        	"X-RapidAPI-Key": "dc1757ec8cmsh586c7464a85bf17p1b88adjsn724a94afb79c",
        	"X-RapidAPI-Host": "yh-finance.p.rapidapi.com"
        }

        response = requests.request("GET", url, headers=headers, params=querystring)
        df = pd.DataFrame(response.json()['prices'])

        df2 = df['close']
        df2 = df2.fillna(df2.mean())
        
        x_future = df2.values
        x_future = x_future.reshape(-1, 1)
        self.data = x_future
        





        