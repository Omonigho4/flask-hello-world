import psutil
from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def index():
    def hello_world():
        return "<p>Hello, World!</p>"
  
if __name__ == "__main__" :
    welcome.run(host="0.0.0.0", port = int("5000") , debug=True )
