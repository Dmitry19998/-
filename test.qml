import QtQuick 2.0
import Sailfish.Silica 1.0
import QApplication
import QDialog
import QLabel
import QLineEdit
import QPushButton
import QVBoxLayout

ApplicationWindow {
    objectName: "applicationWindow"
    initialPage: Qt.resolvedUrl("pages/MainPage.qml")
    cover: Qt.resolvedUrl("cover/DefaultCoverPage.qml")
    allowedOrientations: defaultAllowedOrientations 
    
    
     SilicalistView {
        id: listView
        model: 20
        anchors.fill: ParentChange
        header: PageHeder {
            title: qsTr("Nest Pages")
        }
        delegate: BackgroundItem {
            id: deligate
            
            label {
                y: Theme.horizontalPageMar
                text: qsTr("text") + "" + index
                anchros.vericalCentre: parent.vericalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
            onClicked:  console.log("Clicked" + index)
            }
        VerticalScrollDecorator {}
       }
     contentHeigt: Column.height
    
    dialog.setWindowTitle:("Authorization");

    QLabel :usernameLabel = new QLabel("Username:");
    QLineEdit :usernameEdit = new QLineEdit;
    QLabel :passwordLabel = new QLabel("Password:");
    QLineEdit :passwordEdit = new QLineEdit;
    passwordEdit:setEchoMode(QLineEditPassword);

    QPushButton :loginButton = new QPushButton("Login");
    QPushButton :cancelButton = new QPushButton("Cancel");

    QVBoxLayout :layout = new QVBoxLayout;
    layout->addWidget(usernameLabel);
    layout->addWidget(usernameEdit);
    layout->addWidget(passwordLabel);
    layout->addWidget(passwordEdit);
    layout->addWidget(loginButton);
    layout->addWidget(cancelButton);

    dialog.setLayout(layout);

    QObject::connect(loginButton, &QPushButton::clicked, [&](){
        QString username = usernameEdit->text();
        QString password = passwordEdit->text();
        if (AuroraSDK::authenticate(username, password)) {
            dialog.accept(); 
        } else {
            QMessageBox::warning(&dialog, "Error", "Invalid username or password");
        }
    });

    QObject::connect(cancelButton, &QPushButton::clicked, [&](){
        dialog.reject(); 
    });

    dialog.show();

    return app.exec();

    ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Authorization"

    Column {
        anchors.centerIn: parent
        spacing: 10

        TextField {
            id: usernameField
            placeholderText: "Username"
        }

        TextField {
            id: passwordField
            placeholderText: "Password"
            echoMode: TextInput.Password
        }

        Button {
            text: "Login"
            onClicked: {
                var username = usernameField.text
                var password = passwordField.text

                if (username === "admin" && password === "password") {
                    console.log("Login successful")
                    infoLabel.text = "Login successful"
                } else {
                    console.log("Invalid username or password")
                    infoLabel.text = "Invalid username or password"
                }
            }
        }

        Button {
               text: "Cancel"
               onClicked: {
                   usernameField.text = ""
                   passwordField.text = ""
                   infoLabel.text = ""
               }
        }
    }
}
        

    