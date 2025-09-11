from flask import Flask, request
app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello DevSecOps!'

@app.route('/search')
def search():
    q = request.args.get('q','')
    return f'Results for {q}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
