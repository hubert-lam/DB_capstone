-- MySQL Script generated by MySQL Workbench
-- Tue Jul 15 22:21:05 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8mb3 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer` (
  `idCustomer` INT NOT NULL,
  `name` VARCHAR(105) NOT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `tel` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCustomer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `idStaff` INT NOT NULL,
  `nameStaff` VARCHAR(105) NOT NULL,
  `salary` INT NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idStaff`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `idBookings` INT NOT NULL,
  `dateBookings` DATE NOT NULL,
  `table_num` INT NOT NULL,
  `idCustomer` INT NOT NULL,
  `idStaff` INT NULL,
  PRIMARY KEY (`idBookings`),
  INDEX `idCustomer_idx` (`idCustomer` ASC) VISIBLE,
  INDEX `idStaff_idx` (`idStaff` ASC) VISIBLE,
  CONSTRAINT `idCustomer`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `LittleLemonDB`.`Customer` (`idCustomer`),
  CONSTRAINT `idStaff`
    FOREIGN KEY (`idStaff`)
    REFERENCES `LittleLemonDB`.`Staff` (`idStaff`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Delivery` (
  `idDelivery` INT NOT NULL,
  `dateDelivery` DATE NOT NULL,
  `status` VARCHAR(25) NOT NULL,
  `idCustomer` INT NOT NULL,
  PRIMARY KEY (`idDelivery`),
  INDEX `idCusotmer_idx` (`idCustomer` ASC) VISIBLE,
  CONSTRAINT `idDtC`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `LittleLemonDB`.`Customer` (`idCustomer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `idMenuItems` INT NOT NULL,
  `courseName` VARCHAR(105) NOT NULL,
  `starterName` VARCHAR(105) NOT NULL,
  `desertName` VARCHAR(105) NOT NULL,
  PRIMARY KEY (`idMenuItems`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `idMenu` INT NOT NULL,
  `cuisine` VARCHAR(205) NOT NULL,
  `price` DECIMAL(2,0) NOT NULL,
  `idMenuItems` INT NOT NULL,
  PRIMARY KEY (`idMenu`),
  INDEX `idMenuItems_idx` (`idMenuItems` ASC) VISIBLE,
  CONSTRAINT `idMenuItems`
    FOREIGN KEY (`idMenuItems`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`idMenuItems`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `idOrders` INT NOT NULL,
  `dateOrder` DATE NOT NULL,
  `quantityOrder` INT NOT NULL,
  `total_cost` DECIMAL(2,0) NOT NULL,
  `idCustomer` INT NOT NULL,
  `idMenu` INT NOT NULL,
  PRIMARY KEY (`idOrders`),
  INDEX `idCustomer_idx` (`idCustomer` ASC) VISIBLE,
  INDEX `idCuisine_idx` (`idMenu` ASC) VISIBLE,
  CONSTRAINT `idCuisine`
    FOREIGN KEY (`idMenu`)
    REFERENCES `LittleLemonDB`.`Menu` (`idMenu`),
  CONSTRAINT `idOtC`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `LittleLemonDB`.`Customer` (`idCustomer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
