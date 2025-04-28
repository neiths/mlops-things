FROM tiangolo/uvicorn-gunicorn-fastapi:python3.7

WORKDIR /app

COPY . /app

RUN pip install fastapi uvicorn joblib scikit-learn

EXPOSE 8000

CMD ["python", "app.py"]