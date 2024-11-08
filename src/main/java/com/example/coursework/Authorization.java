package com.example.coursework;

import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.input.MouseEvent;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

import java.util.Objects;

public class Authorization {
    @FXML
    private Button buttonEnter, buttonRegistration, buttonSee;

    @FXML
    private TextField textLogin, textPasswordSee;

    @FXML
    private PasswordField textPassword;

    int k;
    String fio, role;
    static int id_client, id_staff;

    Database database = new Database();

    public static void showAlertError(String title, String content) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(content);
        Stage stage = (Stage) alert.getDialogPane().getScene().getWindow();
        stage.getIcons().add(new Image("C:\\Users\\Anna\\IdeaProjects\\coursework\\src\\main\\resources\\com\\example\\coursework\\content\\logo.png"));
        alert.showAndWait();
    }
    public static void showAlert(String title, String content) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(content);
        Stage stage = (Stage) alert.getDialogPane().getScene().getWindow();
        stage.getIcons().add(new Image("C:\\Users\\Anna\\IdeaProjects\\coursework\\src\\main\\resources\\com\\example\\coursework\\content\\logo.png"));
        alert.showAndWait();
    }
    @FXML
    public void close() {
        Stage stage = (Stage) buttonEnter.getScene().getWindow();
        stage.close();
    }

    @FXML
    void initialize() {

        textPasswordSee.setVisible(false);

        buttonSee.addEventHandler(MouseEvent.MOUSE_CLICKED, new EventHandler<MouseEvent>() {

            @Override
            public void handle(MouseEvent mouseEvent) {
                if (textPassword.getText().isEmpty()) {
                    textPassword.setText(textPassword.getText());
                }
            }
        });

        buttonSee.addEventHandler(MouseEvent.MOUSE_CLICKED, new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent mouseEvent) {
                k++;
                if (!textPassword.getText().isEmpty() & (k % 2 == 1)) {
                    textPasswordSee.setText(textPassword.getText());
                    textPasswordSee.setVisible(true);
                    textPassword.setText(textPasswordSee.getText());
                } else {
                    textPassword.setText(textPasswordSee.getText());
                    textPasswordSee.setVisible(false);
                }
            }
        });

        buttonEnter.addEventHandler(MouseEvent.MOUSE_CLICKED, new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent mouseEvent) {
                try {
                    if (!textLogin.getText().trim().isEmpty() && !textPassword.getText().trim().isEmpty()) {
                        int n, n1, m, m1;
                        n = database.getStaff(textLogin.getText(), textPassword.getText());
                        m = database.getStaff(textLogin.getText(), textPasswordSee.getText());
                        n1 = database.getClients(textLogin.getText(), textPassword.getText());
                        m1 = database.getClients(textLogin.getText(), textPasswordSee.getText());
                        if (n != 0 || m != 0 || n1 != 0 || m1 != 0) {
                            showAlert("","Авторизация прошла успешно.");
                            id_client = database.getClientForReview(textLogin.getText());
                            close();

                            if (Objects.equals(database.getRole(textLogin.getText()), "Сотрудник")
                                    || Objects.equals(database.getRole(textLogin.getText()), "Администратор")) {

                                FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("MainAccount.fxml"));
                                Scene scene = new Scene(fxmlLoader.load(), 1093, 826);
                                Stage stage = new Stage();
                                stage.setScene(scene);
                                stage.show();
                                stage.setResizable(false);
                                stage.getIcons().add(new Image("C:\\Users\\Anna\\IdeaProjects\\coursework\\src\\main\\resources\\com\\example\\coursework\\content\\logo.png"));

                                id_staff = database.getIdStaff(textLogin.getText(),textPassword.getText());
                                MainAccount mainAccount = fxmlLoader.getController();
                                fio = database.getFioStaff(textLogin.getText());
                                mainAccount.labelFio.setText(fio);
                                role = String.valueOf(database.getRole(textLogin.getText()));
                                mainAccount.labelRole.setText(role);
                            } else {

                                FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("account.fxml"));
                                Scene scene = new Scene(fxmlLoader.load(), 1093, 826);
                                Stage stage = new Stage();
                                stage.setScene(scene);
                                stage.show();
                                stage.setResizable(false);
                                stage.getIcons().add(new Image("C:\\Users\\Anna\\IdeaProjects\\coursework\\src\\main\\resources\\com\\example\\coursework\\content\\logo.png"));

                                Account account = fxmlLoader.getController();
                                fio = database.getFioClient(textLogin.getText());
                                account.labelFio.setText(fio);
                                account.labelRole.setText("Клиент");
                            }
                        } else {
                            showAlertError("Ошибка","Произошла ошибка при входе в личный кабинет.");
                            FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("captcha.fxml"));
                            Scene scene = new Scene(fxmlLoader.load(), 300, 140);
                            Stage stage = new Stage();
                            stage.setScene(scene);
                            stage.setResizable(false);
                            stage.initStyle(StageStyle.UNDECORATED);
                            stage.initModality(Modality.APPLICATION_MODAL);
                            stage.show();
                            stage.getIcons().add(new Image("C:\\Users\\Anna\\IdeaProjects\\coursework\\src\\main\\resources\\com\\example\\coursework\\content\\logo.png"));
                        }
                    }else showAlertError("Ошибка","Заполните все поля.");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });

        buttonRegistration.addEventHandler(MouseEvent.MOUSE_CLICKED, new EventHandler<MouseEvent>() {

            @Override
            public void handle(MouseEvent mouseEvent) {
                try {
                    FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("registration.fxml"));
                    Scene scene = new Scene(fxmlLoader.load(), 375, 448);
                    Stage stage = new Stage();
                    stage.setScene(scene);
                    stage.show();
                    stage.setResizable(false);
                    stage.getIcons().add(new Image("C:\\Users\\Anna\\IdeaProjects\\coursework\\src\\main\\resources\\com\\example\\coursework\\content\\logo.png"));

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }
}