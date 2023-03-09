import ballerina/http;
import wso2/choreo.sendemail;
import ballerina/log;

@display {label: "Recipient's Email"}
configurable string emailAddress = ?;
configurable string sub = "sub1";
configurable string x1 = "x1";
configurable string x2 = ?;
sendemail:Client sendemailEndpoint = check new ();

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get greeting(string name) returns string|error {
        // Send a response back to the caller.
        if name is "" {
            return error("name should not be empty!");
        }

        sendemail:Client sendemailEndpoint = check new ();
        string mailBody = string `Hello ${name} Sub: ${sub} x1: ${x1} x2: ${x2}`;
        _ = check sendemailEndpoint->sendEmail(emailAddress, string `Name: ${name} Sub: ${sub}`, mailBody);
        log:printInfo(string `Email sent successfully Name:${name} Sub:${sub}`);
        return "Hello, " + name;
    }
}
