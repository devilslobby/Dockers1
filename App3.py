from flask import Flask, request, jsonify

app = Flask(__name__)

# This route accepts a path parameter and optional query parameters
@app.route('/user/<username>', methods=['GET'])
def get_user_info(username):
    age = request.args.get('age')
    city = request.args.get('city')

    return jsonify({
        "username": username,
        "age": age,
        "city": city
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

    