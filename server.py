from flask import Flask, jsonify
import json

app = Flask(__name__)

# read the json file
with open('details.json') as file:
    details = json.load(file)

@app.route('/')
def return_scrapedata():
    return jsonify(details)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=2003, debug=True)


