import ballerina/http;

class User {
    int id;
    string email;
    string password;

    function init(int id, string email, string password) {
        self.id = id;
        self.email = email;
        self.password = password;
    }
    function toJson() returns json {
        return {
            "id": self.id,
            "email": self.email,
            "password": self.password
        };
    }
}

User[] Users = [
    new User(1, "lorem@ipsum.com", "P@ssw0rd"),
    new User(2, "pablo@ipsum.com", "P@ssw0rd"),
    new User(3, "florian@ipsum.com", "P@ssw0rd"),
    new User(4, "max@ipsum.com", "P@ssw0rd")
];

service / on new http:Listener(9091) {

    resource function get users() returns json? {

        json[] userJsonArray = [];
        foreach var user in Users {
            json userJson = user.toJson();
            userJsonArray.push(userJson);
        }
        return userJsonArray;
    }

    resource function get users/id(int id) returns json? {

        foreach var user in Users {
            if (user.id == id) {
                return user.toJson();
            }
        }
        return null;
    }

    resource function post users(string email, string password) returns http:Response {

        http:Response response = new;
        var idUser = Users.length() + 1;
        User user = new User(idUser, email, password);
        Users.push(user);
        response.setJsonPayload(user.toJson());
        response.statusCode = 200;

        return response;
    }

    resource function post users/resetPassword(string email) returns http:Response {

        var response = new http:Response();
        foreach var user in Users {
            if (user.email == email) {
                response.statusCode = 202;
                break;
            }
            else {
                response.statusCode = 400;
            }
        }
        return response;
    }

    resource function post auth/login(string email, string password) returns http:Response {

        boolean userAuthenticated = false;
        var response = new http:Response();
        foreach var user in Users {
            if (user.email == email && user.password == password) {
                userAuthenticated = true;
                break;
            }
        }
        if (userAuthenticated) {
            response.statusCode = 200;
        } else {
            response.statusCode = 401;
        }
        return response;
    }

}

