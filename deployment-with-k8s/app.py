import uvicorn
from fastapi import FastAPI, Query
import joblib
import numpy as np
import pandas as pd
import requests


nationality_native_bayes = open("deployment-with-k8s/model/naive_bayes.pkl", "rb")
nationality_native_cv = joblib.load(nationality_native_bayes)

app = FastAPI()

@app.get("/")
async def index():
    return {"text": "our first route"}

@app.get('/predict/{name}')
async def predict(name: str = Query(None, min_length=2, max_length=12)):
  if requests.method == 'GET':
    namequery = requests.form['namequery']
    data = [namequery]
    vect = nationality_native_cv.transform(data).toarray()
    result = nationality_native_cv.predict(vect)
    return {"orig_name": name, "prediction": result}


if __name__ == '__main__':
    uvicorn.run(app, host="127.0.0.1", port=8000)

