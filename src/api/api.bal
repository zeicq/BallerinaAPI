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

service / on new http:Listener(9091) {

}

