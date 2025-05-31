FROM python:3-alpine 

WORKDIR /app
COPY app.py app.py
COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 3000

# ENTRYPOINT [ "python app.py" ]
# entrypoint causes error - error during container init: exec: "python app.py": executable file not found in $PATH: unknown
# works with CMD
CMD [ "python", "app.py" ]