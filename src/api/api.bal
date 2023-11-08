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

}

