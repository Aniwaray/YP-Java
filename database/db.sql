-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema coursework
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema coursework
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `coursework` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `coursework` ;

-- -----------------------------------------------------
-- Table `coursework`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursework`.`category` (
  `id_category` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_category`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursework`.`manufacture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursework`.`manufacture` (
  `id_manufacture` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_manufacture`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursework`.`model_cars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursework`.`model_cars` (
  `id_model` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_model`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursework`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursework`.`product` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(45) NULL DEFAULT NULL,
  `productDescription` VARCHAR(100) NULL DEFAULT NULL,
  `productPrice` INT NULL DEFAULT NULL,
  `productQuantityInStock` INT NULL DEFAULT NULL,
  `productStatus` VARCHAR(45) NULL DEFAULT NULL,
  `productPhoto` VARCHAR(300) NULL DEFAULT NULL,
  `category_id_category` INT NOT NULL,
  `manufacture_id_manufacture` INT NOT NULL,
  `model_cars_id_model` INT NOT NULL,
  PRIMARY KEY (`id_product`),
  INDEX `fk_product_category1_idx` (`category_id_category` ASC) VISIBLE,
  INDEX `fk_product_manufacture1_idx` (`manufacture_id_manufacture` ASC) VISIBLE,
  INDEX `fk_product_model_cars1_idx` (`model_cars_id_model` ASC) VISIBLE,
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_id_category`)
    REFERENCES `coursework`.`category` (`id_category`),
  CONSTRAINT `fk_product_manufacture1`
    FOREIGN KEY (`manufacture_id_manufacture`)
    REFERENCES `coursework`.`manufacture` (`id_manufacture`),
  CONSTRAINT `fk_product_model_cars1`
    FOREIGN KEY (`model_cars_id_model`)
    REFERENCES `coursework`.`model_cars` (`id_model`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursework`.`additional_photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursework`.`additional_photos` (
  `id_photos` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NULL DEFAULT NULL,
  `product_id_product` INT NOT NULL,
  PRIMARY KEY (`id_photos`),
  INDEX `fk_additionalphotos_product1_idx` (`product_id_product` ASC) VISIBLE,
  CONSTRAINT `fk_additionalphotos_product1`
    FOREIGN KEY (`product_id_product`)
    REFERENCES `coursework`.`product` (`id_product`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursework`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursework`.`clients` (
  `id_clients` INT NOT NULL AUTO_INCREMENT,
  `fio` VARCHAR(45) NULL DEFAULT NULL,
  `login` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `telephone` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_clients`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursework`.`point`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursework`.`point` (
  `id_point` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_point`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursework`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursework`.`role` (
  `id_role` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_role`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursework`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursework`.`staff` (
  `id_staff` INT NOT NULL AUTO_INCREMENT,
  `fio` VARCHAR(45) NULL DEFAULT NULL,
  `login` VARCHAR(100) NULL DEFAULT NULL,
  `password` VARCHAR(100) NULL DEFAULT NULL,
  `telephone` VARCHAR(45) NULL DEFAULT NULL,
  `role_id_role` INT NOT NULL,
  PRIMARY KEY (`id_staff`),
  INDEX `fk_users_role_idx` (`role_id_role` ASC) VISIBLE,
  CONSTRAINT `fk_users_role`
    FOREIGN KEY (`role_id_role`)
    REFERENCES `coursework`.`role` (`id_role`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursework`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursework`.`orders` (
  `id_orders` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL DEFAULT NULL,
  `count_product` INT NULL DEFAULT NULL,
  `final_price` INT NULL DEFAULT NULL,
  `point_id_point` INT NOT NULL,
  `product_id_product` INT NOT NULL,
  `clients_id_clients` INT NOT NULL,
  `staff_id_staff` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_orders`),
  INDEX `fk_users_has_product_product1_idx` (`product_id_product` ASC) VISIBLE,
  INDEX `fk_orders_point1_idx` (`point_id_point` ASC) VISIBLE,
  INDEX `fk_orders_clients1_idx` (`clients_id_clients` ASC) VISIBLE,
  INDEX `fk_staff1_idx` (`staff_id_staff` ASC) VISIBLE,
  CONSTRAINT `fk_orders_clients1`
    FOREIGN KEY (`clients_id_clients`)
    REFERENCES `coursework`.`clients` (`id_clients`),
  CONSTRAINT `fk_orders_point1`
    FOREIGN KEY (`point_id_point`)
    REFERENCES `coursework`.`point` (`id_point`),
  CONSTRAINT `fk_staff1`
    FOREIGN KEY (`staff_id_staff`)
    REFERENCES `coursework`.`staff` (`id_staff`),
  CONSTRAINT `fk_users_has_product_product1`
    FOREIGN KEY (`product_id_product`)
    REFERENCES `coursework`.`product` (`id_product`))
ENGINE = InnoDB
AUTO_INCREMENT = 54
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursework`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursework`.`reviews` (
  `id_reviews` INT NOT NULL,
  `rating` INT NULL DEFAULT NULL,
  `comment` VARCHAR(45) NULL DEFAULT NULL,
  `clients_id_clients` INT NOT NULL,
  `product_id_product` INT NOT NULL,
  PRIMARY KEY (`id_reviews`),
  INDEX `fk_clients_has_product_product2_idx` (`product_id_product` ASC) VISIBLE,
  INDEX `fk_clients_has_product_clients2_idx` (`clients_id_clients` ASC) VISIBLE,
  CONSTRAINT `fk_clients_has_product_clients2`
    FOREIGN KEY (`clients_id_clients`)
    REFERENCES `coursework`.`clients` (`id_clients`),
  CONSTRAINT `fk_clients_has_product_product2`
    FOREIGN KEY (`product_id_product`)
    REFERENCES `coursework`.`product` (`id_product`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `coursework` ;

-- -----------------------------------------------------
-- procedure AddClient
-- -----------------------------------------------------

DELIMITER $$
USE `coursework`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddClient`(
	IN new_fio VARCHAR(45),
    IN new_login VARCHAR(45),
    IN new_password VARCHAR(45),
    IN new_telephone VARCHAR(45)
)
BEGIN
    DECLARE existing_count INT;
    -- Проверяем существующую запись с таким же логином
    SELECT COUNT(*)
    INTO existing_count
    FROM clients
    WHERE login = new_login;
    -- Если клиент с таким логином уже существует, выводим сообщение об ошибке
    IF existing_count > 0 THEN
        SELECT 'Ошибка: клиент с таким логином уже существует' as Success;
    ELSE
        -- Иначе добавляем нового клиента
        INSERT INTO clients (fio, login, password, telephone) VALUES (new_fio, new_login, new_password, new_telephone);
        SELECT 'Новый клиент успешно добавлен' as Success;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddStaff
-- -----------------------------------------------------

DELIMITER $$
USE `coursework`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddStaff`(
	IN new_fio VARCHAR(45),
    IN new_login VARCHAR(45),
    IN new_password VARCHAR(45),
    IN new_telephone VARCHAR(45)
)
BEGIN
    DECLARE existing_count INT;
    -- Проверяем существующую запись с таким же логином
    SELECT COUNT(*)
    INTO existing_count
    FROM staff
    WHERE login = new_login;
    -- Если клиент с таким логином уже существует, выводим сообщение об ошибке
    IF existing_count > 0 THEN
        SELECT 'Ошибка: клиент с таким логином уже существует' as Success;
    ELSE
        -- Иначе добавляем нового клиента
        INSERT INTO clients (fio, login, password, telephone) VALUES (new_fio, new_login, new_password, new_telephone);
        SELECT 'Новый клиент успешно добавлен' as Success;
    END IF;
END$$

DELIMITER ;
USE `coursework`;

DELIMITER $$
USE `coursework`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `coursework`.`UpdateProductStatus`
BEFORE UPDATE ON `coursework`.`product`
FOR EACH ROW
BEGIN
    IF NEW.productQuantityInStock > 0 THEN 
	SET NEW.productStatus = 'Присутствует';
    ELSE
    SET NEW.productStatus = 'Отсутствует';
    END IF;
END$$

USE `coursework`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `coursework`.`prevent_product_deletion`
BEFORE DELETE ON `coursework`.`product`
FOR EACH ROW
BEGIN
    DECLARE products_count INT;
    SELECT COUNT(*) INTO products_count FROM orders WHERE product_id_product = OLD.id_product;
    IF products_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Этот товар нельзя удалить, пока он есть в заказе';
    END IF;
END$$

USE `coursework`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `coursework`.`updateProductQuantity2`
AFTER INSERT ON `coursework`.`orders`
FOR EACH ROW
BEGIN
    DECLARE newQuantity INT;

    SELECT productQuantityInStock - NEW.count_product INTO newQuantity
    FROM product
    WHERE id_product = NEW.product_id_product;

    IF newQuantity < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка: Недостаточно количества на складе';
    ELSE
        UPDATE product
        SET productQuantityInStock = newQuantity
        WHERE id_product = NEW.product_id_product;
    END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
