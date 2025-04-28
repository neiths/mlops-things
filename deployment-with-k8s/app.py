import uvicorn
from fastapi import FastAPI, Query
import joblib

nationality_native_bayes = open("deployment-with-k8s/model/naive_bayes.pkl", "rb")
nationality_native_cv = joblib.load(nationality_native_bayes)

app = FastAPI()

@app.get("/")
async def index():
    return {"text": "our first route"}


if __name__ == '__main__':
    uvicorn.run(app, host="127.0.0.1", port=8000)

