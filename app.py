from flask import Flask, request, jsonify

app = Flask(__name__)

# In-memory database
users = {
    1: {'id': 1, 'name': 'Abdo', 'age': 24, 'city': 'Cairo'},
    2: {'id': 2, 'name': 'tony', 'age': 30, 'city': 'New York'},
    3: {'id': 3, 'name': 'david', 'age': 33, 'city': 'cairo'},
}

next_id = 4


@app.route('/')
def index():
    return 'Welcome to the homepage!'

# SQL <-- ORM --> flask app

# GET /users - Get a list of users
@app.route('/users', methods=['GET'])
def get_users():
    return jsonify(users)




# GET /users/<id> - Get a specific user by ID
@app.route('/users/<int:id>', methods=['GET'])
def get_user(id):
    user = users.get(id)
    if user is None:
        return jsonify({'error': 'User not found'}), 404
    return jsonify(user)




# POST /users - Create a new user
@app.route('/users', methods=['POST'])
def create_user():
    global next_id
    data = request.get_json()
    new_user = {
        'id': next_id,
        'name': data.get('name'),
        'age': data.get('age'),
        'city': data.get('city')
    }
    users[next_id] = new_user
    next_id += 1
    return jsonify(new_user), 201




# DELETE /users/<id> - Delete a specific user by ID
@app.route('/users/<int:id>', methods=['DELETE'])

def delete_user(id):
    global users
    user = users.get(id)
    if user is None:
        return jsonify({'error': 'User not found'}), 404
    del users[id]
    return jsonify({'message': 'User deleted'}), 200





# PUT /users/<id> - Update a specific user by ID
@app.route('/users/<int:id>', methods=['PATCH'])
def update_user(id):
    user = users.get(id)
    if user is None:
        return jsonify({'error': 'User not found'}), 404
    data = request.get_json()
    user['name'] = data.get('name', user['name'])
    user['age'] = data.get('age', user['age'])
    user['city'] = data.get('city', user['city'])
    users[id] = user
    return jsonify(user)



if __name__ == '__main__':
    app.run(
        debug=True,
        host='localhost',
        port=3000)
    

