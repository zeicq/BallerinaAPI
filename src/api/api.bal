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
}

service / on new http:Listener(9091) {

}

