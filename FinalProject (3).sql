########### Understading & Analayzing the data  // TASK0
# Import all the data on hand to Schema "vivak_dump". Import it as-is without any manipulation

USE vivak_dump;

CREATE TABLE vivak_dump.countries
SELECT * FROM hr.countries;

CREATE TABLE vivak_dump.locations
SELECT * FROM hr.locations;

CREATE TABLE vivak_dump.regions
SELECT * FROM hr.regions;

########### Data Model & ERD  // TASK1

########### VivaKHR Design  // TASK2
# Creating the Schema "VivaKHR" from the DataModel "VivaK_Data_Model"
CREATE SCHEMA VivaKHR;
USE VivaKHR;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Table `VivaKHR`.`regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VivaKHR`.`regions` (
  `region_id` INT NOT NULL,
  `region_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`region_id`),
  UNIQUE INDEX `region_name_UNIQUE` (`region_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VivaKHR`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VivaKHR`.`countries` (
  `country_id` INT NOT NULL,
  `country_code` CHAR(2) NOT NULL,
  `country_name` VARCHAR(45) NOT NULL,
  `region_id` INT NOT NULL,
  PRIMARY KEY (`country_id`),
  INDEX `fk_countries_regions_idx` (`region_id` ASC) VISIBLE,
  UNIQUE INDEX `country_code_UNIQUE` (`country_code` ASC) VISIBLE,
  CONSTRAINT `fk_countries_regions`
    FOREIGN KEY (`region_id`)
    REFERENCES `VivaKHR`.`regions` (`region_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VivaKHR`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VivaKHR`.`locations` (
  `location_code` INT NOT NULL,
  `street_address` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(10) NULL,
  `city` VARCHAR(20) NOT NULL,
  `state_province` VARCHAR(20) NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`location_code`),
  INDEX `fk_locations_countries1_idx` (`country_id` ASC) VISIBLE,
  UNIQUE INDEX `postal_code_UNIQUE` (`postal_code` ASC) VISIBLE,
  CONSTRAINT `fk_locations_countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `VivaKHR`.`countries` (`country_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VivaKHR`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VivaKHR`.`departments` (
  `department_id` INT NOT NULL,
  `department_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE INDEX `department_name_UNIQUE` (`department_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VivaKHR`.`jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VivaKHR`.`jobs` (
  `job_id` INT NOT NULL,
  `job_title` VARCHAR(45) NOT NULL,
  `min_salary` DOUBLE NULL,
  `max_salary` DOUBLE NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`job_id`),
  UNIQUE INDEX `job_title_UNIQUE` (`job_title` ASC) VISIBLE,
  INDEX `fk_jobs_departments1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_jobs_departments1`
    FOREIGN KEY (`department_id`)
    REFERENCES `VivaKHR`.`departments` (`department_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VivaKHR`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VivaKHR`.`employees` (
  `employee_id` INT NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone_no` VARCHAR(20) NOT NULL,
  `job_id` INT NOT NULL,
  `salary` DOUBLE NULL,
  `report_to` INT NOT NULL,
  `hire_date` DATE NOT NULL,
  `location_code` INT NOT NULL,
  `experience_at_VivaK` DECIMAL(6,2) NULL,
  `last_performance_rating` TINYINT(2) NULL,
  `salary_after_increment` DOUBLE NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employees_jobs1_idx` (`job_id` ASC) VISIBLE,
  INDEX `fk_employees_locations1_idx` (`location_code` ASC) VISIBLE,
  INDEX `fk_employees_employees1_idx` (`report_to` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_no_UNIQUE` (`phone_no` ASC) VISIBLE,
  CONSTRAINT lp_rating_check CHECK (last_performance_rating between 0 AND 10),
  CONSTRAINT `fk_employees_jobs1`
    FOREIGN KEY (`job_id`)
    REFERENCES `VivaKHR`.`jobs` (`job_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_employees_locations1`
    FOREIGN KEY (`location_code`)
    REFERENCES `VivaKHR`.`locations` (`location_code`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_employees_employees1`
    FOREIGN KEY (`report_to`)
    REFERENCES `VivaKHR`.`employees` (`employee_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `VivaKHR`.`dependents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VivaKHR`.`dependents` (
  `dependent_id` INT NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `relationship` VARCHAR(10) NOT NULL,
  `employee_id` INT NOT NULL,
  `annual_dependent_benefit` DOUBLE NULL,
  PRIMARY KEY (`dependent_id`),
  INDEX `fk_dependents_employees1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_dependents_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `VivaKHR`.`employees` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




########### End of TASK2

########### Studying the data  // TASK3?
# data manipulation. handling duplicates, missing values etc

#INSERT INTO vivak.country
#SELECT ....

#TASK 4 is all about vivak database
