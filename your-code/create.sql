


CREATE SCHEMA IF NOT EXISTS `cars_database` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cars_database` ;

CREATE TABLE IF NOT EXISTS `cars_database`.`invoices` (
  `invoice_id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `car_id` INT NULL,
  `customer_id` INT NULL,
  `staff_id` INT NULL,
  PRIMARY KEY (`invoice_id`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `cars_database`.`customers` (
  `customer_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `phone` INT NULL,
  `email` VARCHAR(45) NULL,
  `adress` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `province` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `zip_code` INT NULL,
  `invoices_invoice_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`, `invoices_invoice_id`),
  INDEX `fk_customers_invoices1_idx` (`invoices_invoice_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_invoices1`
    FOREIGN KEY (`invoices_invoice_id`)
    REFERENCES `cars_database`.`invoices` (`invoice_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `cars_database`.`cars` (
  `car_id` INT NOT NULL,
  `manufacturer` VARCHAR(255) NOT NULL,
  `model` VARCHAR(45) NULL,
  `year` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  `invoices_invoice_id` INT NOT NULL,
  `customers_customer_id` INT NOT NULL,
  PRIMARY KEY (`car_id`, `invoices_invoice_id`, `customers_customer_id`),
  INDEX `fk_cars_invoices_idx` (`invoices_invoice_id` ASC) VISIBLE,
  INDEX `fk_cars_customers1_idx` (`customers_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_cars_invoices`
    FOREIGN KEY (`invoices_invoice_id`)
    REFERENCES `cars_database`.`invoices` (`invoice_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cars_customers1`
    FOREIGN KEY (`customers_customer_id`)
    REFERENCES `cars_database`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `cars_database`.`salesperson` (
  `staff_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `store` VARCHAR(45) NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `cars_database`.`invoices_has_salesperson` (
  `invoices_invoice_id` INT NOT NULL,
  `salesperson_staff_id` INT NOT NULL,
  PRIMARY KEY (`invoices_invoice_id`, `salesperson_staff_id`),
  INDEX `fk_invoices_has_salesperson_salesperson1_idx` (`salesperson_staff_id` ASC) VISIBLE,
  INDEX `fk_invoices_has_salesperson_invoices1_idx` (`invoices_invoice_id` ASC) VISIBLE,
  CONSTRAINT `fk_invoices_has_salesperson_invoices1`
    FOREIGN KEY (`invoices_invoice_id`)
    REFERENCES `cars_database`.`invoices` (`invoice_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoices_has_salesperson_salesperson1`
    FOREIGN KEY (`salesperson_staff_id`)
    REFERENCES `cars_database`.`salesperson` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `cars_database`.`customers_has_salesperson` (
  `customers_customer_id` INT NOT NULL,
  `salesperson_staff_id` INT NOT NULL,
  PRIMARY KEY (`customers_customer_id`, `salesperson_staff_id`),
  INDEX `fk_customers_has_salesperson_salesperson1_idx` (`salesperson_staff_id` ASC) VISIBLE,
  INDEX `fk_customers_has_salesperson_customers1_idx` (`customers_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_has_salesperson_customers1`
    FOREIGN KEY (`customers_customer_id`)
    REFERENCES `cars_database`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_has_salesperson_salesperson1`
    FOREIGN KEY (`salesperson_staff_id`)
    REFERENCES `cars_database`.`salesperson` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

