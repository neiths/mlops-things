import uvicorn
from fastapi import FastAPI, Query, Path
import joblib

vectorizer = joblib.load("model/count_vectorizer.pkl")

model = joblib.load("model/naive_bayes.pkl")

app = FastAPI()

@app.get("/")
async def index():
    return {"text": "our first route"}

@app.get('/predict/{name}')
async def predict(name: str = Path(...)):

    vect = vectorizer.transform([name]).toarray()
    result = model.predict(vect)

    return {"orig_name": name, "prediction": result[0]}


if __name__ == '__main__':
    uvicorn.run(app, host="127.0.0.1", port=8000)

