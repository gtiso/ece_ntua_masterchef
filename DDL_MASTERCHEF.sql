CREATE DATABASE  IF NOT EXISTS `masterchef` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `masterchef`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: masterchef
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `calories`
--

DROP TABLE IF EXISTS `calories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calories` (
  `Recipe_ID` int(11) NOT NULL,
  `Calories` int(11) NOT NULL,
  `Proteins` int(11) NOT NULL,
  `Carbs` int(11) NOT NULL,
  `Fats` int(11) NOT NULL,
  KEY `idx_Carbs` (`Carbs`),
  KEY `fk_recipe_id` (`Recipe_ID`),
  CONSTRAINT `fk_recipe_id` FOREIGN KEY (`Recipe_ID`) REFERENCES `recipes` (`Recipe_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cook_cuisines`
--

DROP TABLE IF EXISTS `cook_cuisines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cook_cuisines` (
  `Cuisine_ID` int(11) NOT NULL,
  `Cook_ID` int(11) NOT NULL,
  PRIMARY KEY (`Cuisine_ID`,`Cook_ID`),
  KEY `fk_cook_cuisines_cook_id` (`Cook_ID`),
  KEY `fk_cook_cuisines_cuisine_id` (`Cuisine_ID`),
  CONSTRAINT `fk_cook_cuisines_cook_id` FOREIGN KEY (`Cook_ID`) REFERENCES `cooks` (`Cook_ID`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cook_cuisines_cuisine_id` FOREIGN KEY (`Cuisine_ID`) REFERENCES `cuisines` (`Cuisine_ID`) ON UPDATE CASCADE,
  CONSTRAINT `chk_Cuisine_ID` CHECK (`Cuisine_ID` > 0),
  CONSTRAINT `chk_Cook_ID` CHECK (`Cook_ID` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cooks`
--

DROP TABLE IF EXISTS `cooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cooks` (
  `Cook_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Surname` varchar(50) NOT NULL,
  `Age` int(11) NOT NULL,
  `Birthdate` date NOT NULL,
  `Phone_Number` varchar(20) NOT NULL,
  `Experience_Years` int(11) NOT NULL,
  `Ranking` text NOT NULL,
  `Episode_Calls` int(11) NOT NULL,
  `Judge_Episode_Calls` int(11) NOT NULL,
  `Function_Calls` int(11) NOT NULL,
  `Image` text NOT NULL,
  `Caption` varchar(50) NOT NULL,
  PRIMARY KEY (`Cook_ID`),
  KEY `idx_age` (`Age`),
  FULLTEXT KEY `idx_ranking` (`Ranking`),
  CONSTRAINT `chk_Age` CHECK (`Age` >= 18),
  CONSTRAINT `chk_Experience_years` CHECK (`Experience_Years` >= 0),
  CONSTRAINT `chk_Ranking` CHECK (`Ranking` = 'A Cook' or `Ranking` = 'B Cook' or `Ranking` = 'C Cook' or `Ranking` = 'Sous Chef' or `Ranking` = 'Chef')
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cuisines`
--

DROP TABLE IF EXISTS `cuisines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuisines` (
  `Cuisine_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Cuisine_Name` varchar(45) NOT NULL,
  `Episode_Calls` int(11) NOT NULL,
  `Image` text NOT NULL,
  `Caption` varchar(50) NOT NULL,
  PRIMARY KEY (`Cuisine_ID`),
  FULLTEXT KEY `idx_Cuisine_Name` (`Cuisine_Name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `episodes`
--

DROP TABLE IF EXISTS `episodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episodes` (
  `Season_ID` int(11) NOT NULL,
  `Episode_ID` int(11) NOT NULL,
  `Cook_ID` int(11) NOT NULL,
  `Cook_FullName` varchar(45) NOT NULL,
  `Recipe_ID` int(11) NOT NULL,
  `Recipe_Name` varchar(45) NOT NULL,
  `Judge1_Grade` int(11) NOT NULL,
  `Judge1_Name` varchar(45) NOT NULL,
  `Judge2_Grade` int(11) NOT NULL,
  `Judge2_Name` varchar(45) NOT NULL,
  `Judge3_Grade` int(11) NOT NULL,
  `Judge3_Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Episode_ID`,`Cook_ID`),
  KEY `idx_season_id` (`Season_ID`),
  KEY `fk_episodes_Cook_ID` (`Cook_ID`),
  KEY `fk_episodes_recipe_id` (`Recipe_ID`),
  FULLTEXT KEY `idx_recipe_name` (`Recipe_Name`),
  FULLTEXT KEY `idx_judge1_name` (`Judge1_Name`),
  FULLTEXT KEY `idx_judge2_name` (`Judge2_Name`),
  FULLTEXT KEY `idx_judge3_name` (`Judge3_Name`),
  CONSTRAINT `fk_episodes_Cook_ID` FOREIGN KEY (`Cook_ID`) REFERENCES `cooks` (`Cook_ID`) ON UPDATE CASCADE,
  CONSTRAINT `fk_episodes_recipe_id` FOREIGN KEY (`Recipe_ID`) REFERENCES `recipes` (`Recipe_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `Equipment_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Equipment_Name` varchar(45) NOT NULL,
  `Equipment_Instructions` text NOT NULL,
  `Image` text NOT NULL,
  `Caption` varchar(50) NOT NULL,
  PRIMARY KEY (`Equipment_ID`),
  FULLTEXT KEY `idx_Equipment_Name` (`Equipment_Name`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `foodgroup`
--

DROP TABLE IF EXISTS `foodgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foodgroup` (
  `Foodgroup_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Foodgroup_Name` varchar(45) NOT NULL,
  `Foodgroup_Category` varchar(45) NOT NULL,
  `Foodgroup_Description` varchar(255) NOT NULL,
  `Image` text NOT NULL,
  `Caption` varchar(50) NOT NULL,
  PRIMARY KEY (`Foodgroup_ID`),
  FULLTEXT KEY `idx_Foodgroup_Name` (`Foodgroup_Name`),
  CONSTRAINT `chk_Foodgroup_Category` CHECK (`Foodgroup_Category` = 'Carb-Based' or `Foodgroup_Category` = 'Dairy-Based' or `Foodgroup_Category` = 'Vegan' or `Foodgroup_Category` = 'Egg-Based' or `Foodgroup_Category` = 'Meat-Based' or `Foodgroup_Category` = 'Seafood' or `Foodgroup_Category` = 'Fat-Based' or `Foodgroup_Category` = 'Sweets' or `Foodgroup_Category` = 'Beverages')
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients` (
  `Ingredient_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Foodgroup_ID` int(11) NOT NULL,
  `Ingredient_Name` varchar(45) NOT NULL,
  `Ingredient_Calories` int(11) NOT NULL,
  `Ingredient_Proteins` float NOT NULL,
  `Ingredient_Carbs` float NOT NULL,
  `Ingredient_Fats` float NOT NULL,
  `Image` text NOT NULL,
  `Caption` varchar(50) NOT NULL,
  PRIMARY KEY (`Ingredient_ID`),
  KEY `fk_Foodgroup_ID` (`Foodgroup_ID`),
  CONSTRAINT `fk_Foodgroup_ID` FOREIGN KEY (`Foodgroup_ID`) REFERENCES `foodgroup` (`Foodgroup_ID`) ON UPDATE CASCADE,
  CONSTRAINT `chk_Foodgroup_ID` CHECK (`Foodgroup_ID` between 1 and 12),
  CONSTRAINT `chk_Ingredient_Calories` CHECK (`Ingredient_Calories` >= 0),
  CONSTRAINT `chk_Ingredient_Proteins` CHECK (`Ingredient_Proteins` >= 0),
  CONSTRAINT `chk_Ingredient_Fats` CHECK (`Ingredient_Proteins` >= 0),
  CONSTRAINT `chk_Ingredient_Carbs` CHECK (`Ingredient_Carbs` >= 0)
) ENGINE=InnoDB AUTO_INCREMENT=413 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe_equipment`
--

DROP TABLE IF EXISTS `recipe_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_equipment` (
  `Recipe_ID` int(11) NOT NULL,
  `Equipment_ID` int(11) NOT NULL,
  PRIMARY KEY (`Recipe_ID`,`Equipment_ID`),
  KEY `fk_recipe_equipment_Foodgroup_ID` (`Equipment_ID`),
  CONSTRAINT `fk_recipe_equipment_Foodgroup_ID` FOREIGN KEY (`Equipment_ID`) REFERENCES `equipment` (`Equipment_ID`) ON UPDATE CASCADE,
  CONSTRAINT `fk_recipe_equipment_Recipe_ID` FOREIGN KEY (`Recipe_ID`) REFERENCES `recipes` (`Recipe_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe_ingredients`
--

DROP TABLE IF EXISTS `recipe_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_ingredients` (
  `Recipe_ID` int(11) NOT NULL,
  `Ingredient_ID` int(11) NOT NULL,
  `Basic_Ingredients` tinyint(4) NOT NULL,
  `Quantity` int(11) NOT NULL,
  PRIMARY KEY (`Recipe_ID`,`Ingredient_ID`),
  KEY `fk_recipe_ingredients_Ingredient_ID` (`Ingredient_ID`),
  CONSTRAINT `fk_recipe_ingredients_Ingredient_ID` FOREIGN KEY (`Ingredient_ID`) REFERENCES `ingredients` (`Ingredient_ID`) ON UPDATE CASCADE,
  CONSTRAINT `fk_recipe_ingredients_Recipe_ID` FOREIGN KEY (`Recipe_ID`) REFERENCES `recipes` (`Recipe_ID`) ON UPDATE CASCADE,
  CONSTRAINT `chk_Recipe_ID` CHECK (`Recipe_ID` > 0),
  CONSTRAINT `chk_Ingredient_ID` CHECK (`Ingredient_ID` > 0),
  CONSTRAINT `chk_Basic_Ingredients` CHECK (`Basic_Ingredients` = 0 or `Basic_Ingredients` = 1),
  CONSTRAINT `chk_Quantity` CHECK (`Quantity` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `masterchef`.`calories_update_insert` AFTER INSERT ON `recipe_ingredients` FOR EACH ROW
BEGIN
	DECLARE serv INT;
    DECLARE proteins_before INT;
    DECLARE carbs_before INT;
    DECLARE fats_before INT;
    DECLARE proteins_after INT;
    DECLARE carbs_after INT;
    DECLARE fats_after INT;
    
    SELECT Servings INTO serv 
		FROM recipes WHERE Recipe_ID = NEW.Recipe_ID;
	
    SELECT Proteins, Carbs, Fats
		INTO proteins_before, carbs_before, fats_before 
		FROM calories WHERE Recipe_ID = NEW.Recipe_ID;
	
    SELECT ((Ingredient_Proteins*NEW.Quantity/100)/serv) + proteins_before, ((Ingredient_Carbs*NEW.Quantity/100)/serv) + carbs_before, ((Ingredient_Fats*NEW.Quantity/100)/serv) + fats_before
		INTO proteins_after, carbs_after, fats_after
		FROM ingredients WHERE ingredient_id = NEW.Ingredient_ID;
        
	UPDATE calories SET Proteins = proteins_after, Carbs = carbs_after, Fats = fats_after WHERE Recipe_ID = NEW.Recipe_ID;
	UPDATE calories SET Calories = (4*proteins_after + 4*carbs_after + 9*fats_after) WHERE Recipe_ID = NEW.Recipe_ID;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `masterchef`.`calories_update_update` 
AFTER UPDATE ON `recipe_ingredients` 
FOR EACH ROW
BEGIN
    DECLARE serv INT;
    DECLARE proteins_before INT;
    DECLARE carbs_before INT;
    DECLARE fats_before INT;
    DECLARE proteins_old INT;
    DECLARE carbs_old INT;
    DECLARE fats_old INT;
    DECLARE proteins_new INT;
    DECLARE carbs_new INT;
    DECLARE fats_new INT;
    
    -- Get the number of servings for the recipe
    SELECT Servings INTO serv 
    FROM recipes 
    WHERE Recipe_ID = NEW.Recipe_ID;
    
    -- Get the current values of proteins, carbs, and fats from the calories table
    SELECT Proteins, Carbs, Fats
    INTO proteins_before, carbs_before, fats_before 
    FROM calories 
    WHERE Recipe_ID = NEW.Recipe_ID;
    
    -- Calculate the old nutritional values
    SELECT ((Ingredient_Proteins * OLD.Quantity / 100) / serv), 
           ((Ingredient_Carbs * OLD.Quantity / 100) / serv), 
           ((Ingredient_Fats * OLD.Quantity / 100) / serv)
    INTO proteins_old, carbs_old, fats_old
    FROM ingredients 
    WHERE ingredient_id = OLD.Ingredient_ID;
    
    -- Calculate the new nutritional values
    SELECT ((Ingredient_Proteins * NEW.Quantity / 100) / serv), 
           ((Ingredient_Carbs * NEW.Quantity / 100) / serv), 
           ((Ingredient_Fats * NEW.Quantity / 100) / serv)
    INTO proteins_new, carbs_new, fats_new
    FROM ingredients 
    WHERE ingredient_id = NEW.Ingredient_ID;
    
    -- Update the calories table with the new values
    UPDATE calories 
    SET Proteins = proteins_before - proteins_old + proteins_new, 
        Carbs = carbs_before - carbs_old + carbs_new, 
        Fats = fats_before - fats_old + fats_new 
    WHERE Recipe_ID = NEW.Recipe_ID;
    
    -- Update the total calories
    UPDATE calories 
    SET Calories = (4 * (proteins_before - proteins_old + proteins_new) + 
                    4 * (carbs_before - carbs_old + carbs_new) + 
                    9 * (fats_before - fats_old + fats_new)) 
    WHERE Recipe_ID = NEW.Recipe_ID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `masterchef`.`calories_update_delete` AFTER DELETE ON `recipe_ingredients` FOR EACH ROW
BEGIN
	DECLARE serv INT;
    DECLARE proteins_before INT;
    DECLARE carbs_before INT;
    DECLARE fats_before INT;
    DECLARE proteins_after INT;
    DECLARE carbs_after INT;
    DECLARE fats_after INT;
    
    SELECT Servings INTO serv 
		FROM recipes WHERE Recipe_ID = OLD.Recipe_ID;
	
    SELECT Proteins, Carbs, Fats
		INTO proteins_before, carbs_before, fats_before 
		FROM calories WHERE Recipe_ID = OLD.Recipe_ID;
	
    SELECT proteins_before - ((Ingredient_Proteins*OLD.Quantity/100)/serv), carbs_before - ((Ingredient_Carbs*OLD.Quantity/100)/serv), fats_before - ((Ingredient_Fats*OLD.Quantity/100)/serv)
		INTO proteins_after, carbs_after, fats_after
		FROM ingredients WHERE ingredient_id = OLD.Ingredient_ID;
        
	UPDATE calories SET Proteins = proteins_after, Carbs = carbs_after, Fats = fats_after WHERE Recipe_ID = OLD.Recipe_ID;
	UPDATE calories SET Calories = (4*proteins_after + 4*carbs_after + 9*fats_after) WHERE Recipe_ID = OLD.Recipe_ID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `recipe_steps`
--

DROP TABLE IF EXISTS `recipe_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_steps` (
  `Recipe_ID` int(11) NOT NULL,
  `Step_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Step_Number` int(11) DEFAULT NULL,
  `Step_Description` text DEFAULT NULL,
  PRIMARY KEY (`Step_ID`),
  KEY `Recipe_ID_idx` (`Recipe_ID`),
  CONSTRAINT `fk_recipe_steps_Recipe_ID` FOREIGN KEY (`Recipe_ID`) REFERENCES `recipes` (`Recipe_ID`) ON UPDATE CASCADE,
  CONSTRAINT `chk_Step_Number` CHECK (`Step_Number` > 0),
  CONSTRAINT `chk_Recipe_ID` CHECK (`Recipe_ID` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=413 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe_tags`
--

DROP TABLE IF EXISTS `recipe_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_tags` (
  `Recipe_ID` int(11) NOT NULL,
  `Tag_ID` int(11) NOT NULL,
  PRIMARY KEY (`Recipe_ID`,`Tag_ID`),
  KEY `fk_recipe_tags_Tag_ID` (`Tag_ID`),
  CONSTRAINT `fk_recipe_tags_Recipe_ID` FOREIGN KEY (`Recipe_ID`) REFERENCES `recipes` (`Recipe_ID`) ON UPDATE CASCADE,
  CONSTRAINT `fk_recipe_tags_Tag_ID` FOREIGN KEY (`Tag_ID`) REFERENCES `tags` (`Tag_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe_theme`
--

DROP TABLE IF EXISTS `recipe_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_theme` (
  `Recipe_ID` int(11) NOT NULL,
  `Theme_ID` int(11) NOT NULL,
  PRIMARY KEY (`Recipe_ID`,`Theme_ID`),
  KEY `fk_recipe_theme_Theme_ID` (`Theme_ID`),
  CONSTRAINT `fk_recipe_theme_Recipe_ID` FOREIGN KEY (`Recipe_ID`) REFERENCES `recipes` (`Recipe_ID`) ON UPDATE CASCADE,
  CONSTRAINT `fk_recipe_theme_Theme_ID` FOREIGN KEY (`Theme_ID`) REFERENCES `theme` (`Theme_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipes` (
  `Recipe_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Cuisine_ID` int(11) NOT NULL,
  `Difficulty` int(11) NOT NULL,
  `Type` varchar(45) NOT NULL,
  `Category` varchar(45) DEFAULT NULL,
  `Name` varchar(45) NOT NULL,
  `Description` text NOT NULL,
  `Meal` varchar(20) NOT NULL,
  `Total_Time` time NOT NULL,
  `Servings` int(11) NOT NULL,
  `Episode_Calls` int(11) NOT NULL,
  `Image` text NOT NULL,
  `Caption` varchar(50) NOT NULL,
  PRIMARY KEY (`Recipe_ID`),
  KEY `idx_cuisine_id` (`Cuisine_ID`),
  KEY `idx_servings` (`Servings`),
  KEY `idx_episode_calls` (`Episode_Calls`),
  KEY `idx_Difficulty` (`Difficulty`),
  FULLTEXT KEY `idx_name` (`Name`),
  CONSTRAINT `fk_recipes_Cuisine_ID` FOREIGN KEY (`Cuisine_ID`) REFERENCES `cuisines` (`Cuisine_ID`) ON UPDATE CASCADE,
  CONSTRAINT `chk_Difficulty` CHECK (`Difficulty` between 1 and 5),
  CONSTRAINT `chk_Cuisine_ID` CHECK (`Cuisine_ID` between 1 and 15),
  CONSTRAINT `chk_Category` CHECK (`Category` = 'Dairy-Based' or `Category` = 'Carb-Based' or `Category` = 'Meat-Based' or `Category` = 'Vegan' or `Category` = 'Seafood'),
  CONSTRAINT `chk_Type` CHECK (`Type` = 'Cookery' or `Type` = 'Pastry'),
  CONSTRAINT `chk_Meal` CHECK (`Meal` = 'DINNER' or `Meal` = 'DESSERT' or `Meal` = 'LUNCH' or `Meal` = 'APPETIZER'),
  CONSTRAINT `chk_Servings` CHECK (`Servings` > 0),
  CONSTRAINT `chk_Total_Time` CHECK (`Total_Time` > '00:00:00')
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `Tag_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Tag_Name` varchar(45) NOT NULL,
  `Image` text NOT NULL,
  `Caption` varchar(50) NOT NULL,
  PRIMARY KEY (`Tag_ID`),
  FULLTEXT KEY `idx_Tag_Name` (`Tag_Name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `theme`
--

DROP TABLE IF EXISTS `theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theme` (
  `Theme_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Theme_Name` varchar(255) NOT NULL,
  `Theme_Description` text NOT NULL,
  `Image` text NOT NULL,
  `Caption` varchar(50) NOT NULL,
  PRIMARY KEY (`Theme_ID`),
  FULLTEXT KEY `idx_Theme_Name` (`Theme_Name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time`
--

DROP TABLE IF EXISTS `time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time` (
  `Recipe_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Recipe_Name` varchar(255) NOT NULL,
  `Total_Time` time NOT NULL,
  `Preparation_Time` time NOT NULL,
  `Execution_Time` time NOT NULL,
  PRIMARY KEY (`Recipe_ID`),
  CONSTRAINT `fk_time_Recipe_ID` FOREIGN KEY (`Recipe_ID`) REFERENCES `recipes` (`Recipe_ID`) ON UPDATE CASCADE,
  CONSTRAINT `chk_Total_Time` CHECK (`Total_Time` > '00:00:00'),
  CONSTRAINT `chk_Preparation_Time` CHECK (`Preparation_Time` > '00:00:00'),
  CONSTRAINT `chk_Execution_Time` CHECK (`Execution_Time` > '00:00:00')
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tips`
--

DROP TABLE IF EXISTS `tips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tips` (
  `Tip_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Recipe_ID` int(11) NOT NULL,
  `Tip_Description` text NOT NULL,
  PRIMARY KEY (`Tip_ID`),
  KEY `fk_tips_Recipe_ID` (`Recipe_ID`),
  CONSTRAINT `fk_tips_Recipe_ID` FOREIGN KEY (`Recipe_ID`) REFERENCES `recipes` (`Recipe_ID`) ON UPDATE CASCADE,
  CONSTRAINT `chk_Recipe_ID` CHECK (`Recipe_ID` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=988 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `masterchef`.`limit_tips_per_recipe` BEFORE INSERT ON `tips` FOR EACH ROW
BEGIN
	DECLARE tip_count INT;

    SELECT COUNT(*)
    INTO tip_count
    FROM tips
    WHERE recipe_ID = NEW.recipe_ID;

    IF tip_count >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot add more than 3 tips per recipe_ID';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'masterchef'
--

--
-- Dumping routines for database 'masterchef'
--
/*!50003 DROP FUNCTION IF EXISTS `CookToName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CookToName`(ck_id INT) RETURNS varchar(100) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
BEGIN
	DECLARE rtn VARCHAR(100);
	SELECT CONCAT(Name, " ", Surname) INTO rtn FROM cooks WHERE cooks.Cook_ID = ck_id;
	RETURN rtn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CuisineToCook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CuisineToCook`(csn_id INT) RETURNS int(11)
BEGIN
	DECLARE rtn INT;
	SELECT cc.Cook_ID INTO rtn 
		FROM cook_cuisines cc 
        WHERE cc.Cuisine_ID = csn_id AND ((SELECT Function_Calls FROM cooks c WHERE c.Cook_ID = cc.Cook_ID) = 0) AND ((SELECT Episode_Calls FROM cooks c WHERE c.Cook_ID = cc.Cook_ID) < 3)
		ORDER BY RAND() LIMIT 1;
    UPDATE cooks SET Function_Calls = 1 WHERE Cook_ID = rtn;
	RETURN rtn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CuisineToRecipeID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CuisineToRecipeID`(csn_id INT) RETURNS int(11)
BEGIN
	DECLARE rtn INT;
	SELECT recipes.Recipe_ID INTO rtn FROM recipes WHERE recipes.Cuisine_ID = csn_id AND Episode_Calls < 3 ORDER BY RAND() LIMIT 1;
	RETURN rtn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GradingSystem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GradingSystem`() RETURNS int(11)
BEGIN
	RETURN FLOOR(1 + (RAND() * 5));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `RecipeIDToRecipeName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `RecipeIDToRecipeName`(csn_id INT) RETURNS varchar(100) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
BEGIN
	DECLARE rtn VARCHAR(100);
	SELECT recipes.Name INTO rtn FROM recipes WHERE recipes.Recipe_ID = csn_id;
	RETURN rtn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `RecipeNameToCuisineID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `RecipeNameToCuisineID`(rcp_name VARCHAR(100)) RETURNS varchar(100) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
BEGIN
	DECLARE rtn VARCHAR(100);
	SELECT Cuisine_ID INTO rtn FROM recipes WHERE Name = rcp_name;
	RETURN rtn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `RecipeNameToRecipeID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `RecipeNameToRecipeID`(RecipeName VARCHAR(100)) RETURNS int(11)
BEGIN
    DECLARE RecipeID INT;

    SELECT Recipe_ID INTO RecipeID
    FROM recipes 
    WHERE Name = RecipeName;

    RETURN RecipeID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ClearCallValues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ClearCallValues`()
BEGIN
	UPDATE cooks SET Episode_Calls = 0, Judge_Episode_Calls = 0, Function_Calls = 0;
    UPDATE cuisines SET Episode_Calls = 0;
    UPDATE recipes SET Episode_Calls = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateAdminUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateAdminUser`()
BEGIN
    CREATE USER IF NOT EXISTS'admin'@'localhost' IDENTIFIED BY 'admin';
	GRANT SELECT,INSERT,UPDATE,ALTER,SHOW VIEW,TRIGGER,LOCK TABLES ON masterchef.* TO 'admin'@'localhost';
	FLUSH PRIVILEGES;
	SHOW GRANTS FOR 'admin'@'localhost';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateCookUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateCookUser`(ck_id INT)
BEGIN
DECLARE sql_query VARCHAR(500);
    DECLARE view_name VARCHAR(50);
    
-- Creating User
    SET sql_query = CONCAT("CREATE USER IF NOT EXISTS 'cook", ck_id, "'@'localhost' IDENTIFIED BY 'cook'");
    SET @sql = sql_query;
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
    
-- VIEWS
    -- Recipes View
    SET view_name = CONCAT("cook",ck_id,"_recipe_vw");
    SET sql_query = CONCAT('DROP VIEW IF EXISTS ', view_name);
    SET @sql = sql_query;
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
	SET sql_query = CONCAT("CREATE VIEW ",view_name," AS SELECT * FROM recipes WHERE Recipe_ID IN (SELECT Recipe_ID FROM episodes WHERE Cook_ID = ",ck_id,")");
	SET @sql = sql_query;
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
    
    -- Recipe Ingredients View
    SET view_name = CONCAT("cook", ck_id, "_recipe_ingredients_vw");
    SET sql_query = CONCAT('DROP VIEW IF EXISTS ', view_name);
    SET @sql = sql_query;
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SET sql_query = CONCAT("CREATE VIEW ",view_name," AS SELECT * FROM recipe_ingredients WHERE Recipe_ID IN (SELECT distinct Recipe_ID FROM episodes WHERE Cook_ID = ",ck_id,")");
    SET @sql = sql_query;
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
    
    -- Cook View
    SET view_name = CONCAT("cook", ck_id, "_vw");
    SET sql_query = CONCAT('DROP VIEW IF EXISTS ', view_name);
    SET @sql = sql_query;
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SET sql_query = CONCAT("CREATE VIEW ",view_name," AS SELECT * FROM cooks WHERE Cook_ID = ", ck_id);
    SET @sql = sql_query;
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
    
-- GRANTS
    -- Grant on cook_recipe_vw
    SET view_name = CONCAT("masterchef.cook",ck_id,"_recipe_vw");
    SET sql_query = CONCAT("GRANT SELECT,UPDATE,INSERT ON ", view_name, " TO 'cook", ck_id, "'@'localhost'");
    SET @sql = sql_query;
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
    
    -- Grant on cook_recipe_ingredients_vw
    SET view_name = CONCAT("masterchef.cook",ck_id,"_recipe_ingredients_vw");
    SET sql_query = CONCAT("GRANT SELECT,UPDATE,INSERT ON ", view_name, " TO 'cook", ck_id, "'@'localhost'");
    SET @sql = sql_query;
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;

    -- Grant on cook_vw
    SET view_name = CONCAT("masterchef.cook",ck_id,"_vw");
    SET sql_query = CONCAT("GRANT SELECT,UPDATE ON ", view_name, " TO 'cook", ck_id, "'@'localhost'");
    SET @sql = sql_query;
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
    
    SET sql_query = CONCAT("FLUSH PRIVILEGES");
    SET @sql = sql_query;
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_1`()
BEGIN
	WITH AverageCookTable AS (
		SELECT Cook_FullName AS Cook, AVG(Judge1_Grade + Judge2_Grade + Judge3_Grade) AS AvgJudgeGrade FROM episodes GROUP BY Cook_FullName
	),	AverageCuisineTableAux AS (
		SELECT (SELECT Cuisine_Name FROM cuisines WHERE Cuisine_ID = RecipeNameToCuisineID(Recipe_Name)) AS CuisineName, AVG(Judge1_Grade + Judge2_Grade + Judge3_Grade) AS AvgJudgeGrade FROM episodes GROUP BY Recipe_Name
	), 	AverageCuisineTable AS (
		SELECT * FROM AverageCuisineTableAux GROUP BY CuisineName
	)	
		SELECT CuisineName AS 'Cuisine / Cook Name', AvgJudgeGrade FROM AverageCuisineTable 
		UNION ALL SELECT Cook AS 'Cuisine / Cook Name', AvgJudgeGrade FROM AverageCookTable;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_10` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_10`()
BEGIN
	WITH StartingTable AS (
			SELECT Season_ID, Recipe_ID, RecipeNameToCuisineID(Recipe_Name) AS Cuisine_ID
			FROM episodes
    ),	SeasonGroupedTable AS (
			SELECT Season_ID, Cuisine_ID, COUNT(*) AS Counter
			FROM StartingTable
			GROUP BY Season_ID, Cuisine_ID
	), 	FilteredGroupedTable AS (
			SELECT * FROM SeasonGroupedTable WHERE Counter > 2
	), 	FinalTable AS ( 
			SELECT t1.Season_ID AS Season, t1.Cuisine_ID, (t1.Counter + t2.Counter) AS Sum_Counter
            FROM FilteredGroupedTable t1
			JOIN FilteredGroupedTable t2 ON t1.Cuisine_ID = t2.Cuisine_ID AND t1.Season_ID = t2.Season_ID - 1
			ORDER BY t1.Cuisine_ID, t1.Season_ID
	), 	Final AS (
			SELECT DISTINCT t1.Cuisine_ID
			FROM FinalTable t1
			JOIN FinalTable t2 ON t1.Season = t2.Season AND t1.Sum_Counter = t2.Sum_Counter AND t1.Cuisine_ID <> t2.Cuisine_ID
			ORDER BY t1.Season, t1.Cuisine_ID
	)	SELECT * FROM Final;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_11` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_11`()
BEGIN
	WITH StartingTable AS (
		SELECT Season_ID, Episode_ID, Cook_FullName, Judge1_Grade, Judge1_Name, Judge2_Grade, Judge2_Name, Judge3_Grade, Judge3_Name
		FROM masterchef.episodes ORDER BY Episode_ID
	),	SumTable AS (
		SELECT Episode_ID, Judge1_Name AS JudgeName, Cook_FullName, Judge1_Grade AS Judge_Grade FROM StartingTable
		UNION ALL SELECT Episode_ID, Judge2_Name AS JudgeName, Cook_FullName, Judge2_Grade AS Judge_Grade FROM StartingTable
		UNION ALL SELECT Episode_ID, Judge3_Name AS JudgeName, Cook_FullName, Judge3_Grade AS Judge_Grade FROM StartingTable
	),	FinalTable AS (
		SELECT JudgeName, Cook_FullName, SUM(Judge_Grade) AS Grade FROM SumTable GROUP BY JudgeName,Cook_FullName ORDER BY JudgeName,Cook_FullName
	),	RankedGrades AS (
		SELECT JudgeName, Cook_FullName, Grade, ROW_NUMBER() OVER (PARTITION BY JudgeName ORDER BY Grade DESC) AS rn
		FROM FinalTable
	)	SELECT JudgeName, Cook_FullName, Grade FROM RankedGrades WHERE rn = 1 ORDER BY Grade DESC LIMIT 5;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_12` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_12`()
BEGIN 
	SELECT sub.Season_ID AS Year, sub.Episode_ID, sub.Difficulty_Sum
	FROM (     
		SELECT e.Season_ID, e.Episode_ID, SUM(r.Difficulty) AS Difficulty_Sum, ROW_NUMBER() 
        OVER (PARTITION BY e.Season_ID ORDER BY SUM(r.Difficulty) DESC) AS rn
		FROM Episodes e
		INNER JOIN Recipes r ON r.Name = e.Recipe_Name
		GROUP BY e.Season_ID, e.Episode_ID
	) AS sub
	WHERE sub.rn = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_13` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_13`()
Begin

	DROP TEMPORARY TABLE IF EXISTS temp_cooks;
    
	CREATE TEMPORARY TABLE temp_cooks(
		Cook_Name VARCHAR(255),
		Ranking INT
	);

	INSERT INTO temp_cooks(Ranking,Cook_Name) 
	SELECT CASE 
		WHEN Ranking = 'C Cook' THEN 1
        WHEN Ranking = 'B Cook' THEN 2
        WHEN Ranking = 'A Cook' THEN 3		
		WHEN Ranking = 'Sous Chef' THEN 4
		WHEN Ranking = 'Chef' THEN 5
		ELSE Ranking 
	END AS new_chef_rank,concat(cooks.Name, ' ' ,cooks.Surname)
	FROM cooks;

	WITH StartingTable AS (
		SELECT episodes.Cook_FullName,episodes.Episode_ID FROM episodes 
		UNION SELECT episodes.Judge1_Name,episodes.Episode_ID FROM episodes 
		UNION SELECT episodes.Judge2_Name,episodes.Episode_ID FROM episodes 
		UNION SELECT episodes.Judge3_Name,episodes.Episode_ID FROM episodes
    ), SecondTable AS (
		SELECT  (SELECT tc.Ranking FROM temp_cooks tc WHERE tc.Cook_Name = s.Cook_FullName) AS Cook_Rank, s.* FROM StartingTable s
        ORDER BY Episode_ID
	), FinalTable AS ( 
		SELECT Episode_ID, SUM(Cook_Rank) AS RankSum FROM SecondTable GROUP BY Episode_ID 
	) SELECT * FROM FinalTable ORDER BY RankSum LIMIT 1;

    DROP TEMPORARY TABLE IF EXISTS temp_cooks;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_14` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_14`()
BEGIN
	WITH StartingTable AS (
		SELECT e.Recipe_ID, rt.Theme_ID FROM episodes e
		JOIN recipe_theme rt ON rt.Recipe_ID = e.Recipe_ID
	)	
		SELECT Theme_ID, COUNT(Theme_ID) AS Appearance_Counter 
		FROM StartingTable GROUP BY Theme_ID ORDER BY 2 DESC LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_15` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_15`()
Begin 
SELECT foodgroup.Foodgroup_Name
FROM foodgroup 
WHERE foodgroup.Foodgroup_Name NOT IN (
    SELECT DISTINCT foodgroup.Foodgroup_Name
    FROM episodes 
    JOIN recipes ON recipes.Name = episodes.Recipe_Name
    JOIN recipe_ingredients ON recipe_ingredients.Recipe_ID = recipes.Recipe_ID
    JOIN ingredients ON ingredients.Ingredient_ID = recipe_ingredients.Ingredient_ID
    JOIN foodgroup ON foodgroup.Foodgroup_ID = ingredients.Foodgroup_ID
);
 End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_2`(IN szn_id INT, IN cuis_id INT)
BEGIN
	WITH CooksFromCuisine AS (
    SELECT (SELECT CONCAT(c.Name," ", c.Surname) FROM cooks c WHERE c.Cook_ID = cc.Cook_ID) AS Cook FROM cook_cuisines cc WHERE cc.Cuisine_ID = cuis_id
)    SELECT DISTINCT Cook_FullName FROM episodes WHERE Season_ID = szn_id AND Cook_FullName IN (SELECT * FROM CooksFromCuisine);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_3`()
BEGIN 

create temporary table temp_cooks(
Age INT,
Cook_FullName VARCHAR(255)
);
 
 INSERT INTO temp_cooks (Age,Cook_FullName)
SELECT cooks.Age,CONCAT(Name, ' ', Surname) AS Cook_FullName
FROM cooks;

SELECT temp_cooks.Age,temp_cooks.Cook_FullName, COUNT(temp_cooks.Cook_FullName) AS Num_of_Recipes
from temp_cooks 
Inner join episodes ON temp_cooks.Cook_FullName = episodes.Cook_FullName
WHERE temp_cooks.Age < 30
GROUP by temp_cooks.Cook_FullName
Order By Num_of_Recipes DESC;

DROP TEMPORARY TABLE IF EXISTS temp_cooks;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_4` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_4`()
BEGIN
	SELECT CONCAT(c.Name, ' ', c.Surname) AS CooksWhoAreNotJudges
	FROM cooks c
	WHERE NOT EXISTS (
		SELECT 1
		FROM episodes e
		WHERE CONCAT(c.Name, ' ', c.Surname) IN (e.Judge1_Name, e.Judge2_Name, e.Judge3_Name)
	);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_5` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_5`()
BEGIN
	WITH 
    DistinctedTables AS (
        SELECT DISTINCT Season_ID, Judge1_Name, Judge2_Name, Judge3_Name
        FROM episodes
    ),
    CombinedTables AS (
        SELECT Season_ID, Judge1_Name AS JudgeName FROM DistinctedTables
        UNION ALL
        SELECT Season_ID, Judge2_Name AS JudgeName FROM DistinctedTables
        UNION ALL
        SELECT Season_ID, Judge3_Name AS JudgeName FROM DistinctedTables
    ),
    FinalTable AS (
        SELECT Season_ID, JudgeName, COUNT(JudgeName) AS Times_Presented
        FROM CombinedTables
        GROUP BY Season_ID, JudgeName
        HAVING COUNT(JudgeName) > 3
            ),
         JudgePairs AS (
        SELECT DISTINCT ft1.Season_ID, ft1.JudgeName, ft1.Times_Presented
        FROM FinalTable ft1
        JOIN FinalTable ft2 ON ft1.Season_ID = ft2.Season_ID
                           AND ft1.Times_Presented = ft2.Times_Presented
                           AND ft1.JudgeName <> ft2.JudgeName
    )
		SELECT JudgeName, Season_ID, Times_Presented AS Appearance_Times
		FROM JudgePairs
		ORDER BY Season_ID, Times_Presented DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_6` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_6`()
BEGIN
	WITH StartingTable AS (
	SELECT DISTINCT e.Recipe_ID, e.Recipe_Name, rt.Tag_ID, t.Tag_Name 
	FROM episodes e 
	JOIN recipes r ON r.Recipe_ID = e.Recipe_ID
	JOIN recipe_tags rt ON e.Recipe_ID = rt.Recipe_ID
	JOIN tags t ON rt.Tag_ID = t.Tag_ID
	ORDER BY 1
), 	RecipeTagPairs AS (
	SELECT CONCAT("(",t1.Tag_ID,',',t2.Tag_ID,")") AS RecipeTagPair
	FROM StartingTable t1
	JOIN StartingTable t2 ON t1.Recipe_ID = t2.Recipe_ID
	WHERE t1.Tag_ID < t2.Tag_ID
)	SELECT RecipeTagPair AS TagPair, COUNT(*) AS TimesPresented
	FROM RecipeTagPairs
	GROUP BY RecipeTagPair
	ORDER BY 2 DESC LIMIT 3;
    
    -- QUERY PLAN WITH FORCE INDEX
    /* WITH StartingTable AS (
	SELECT DISTINCT e.Recipe_ID, e.Recipe_Name, rt.Tag_ID, t.Tag_Name 
	FROM episodes e 
	JOIN recipes r ON r.Recipe_ID = e.Recipe_ID
	JOIN recipe_tags rt FORCE INDEX (PRIMARY) ON e.Recipe_ID = rt.Recipe_ID
	JOIN tags t ON rt.Tag_ID = t.Tag_ID
	ORDER BY 1
), 	RecipeTagPairs AS (
	SELECT CONCAT("(",t1.Tag_ID,',',t2.Tag_ID,")") AS RecipeTagPair
	FROM StartingTable t1
	JOIN StartingTable t2 ON t1.Recipe_ID = t2.Recipe_ID
	WHERE t1.Tag_ID < t2.Tag_ID
)	SELECT RecipeTagPair, COUNT(*) AS TimesPresented
	FROM RecipeTagPairs
	GROUP BY RecipeTagPair
	ORDER BY 2 DESC LIMIT 3; */
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_7` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_7`()
BEGIN
	WITH CookTimes AS (SELECT Cook_FullName, COUNT(*) AS Times_Presented FROM episodes GROUP BY Cook_FullName ORDER BY Times_Presented DESC)
	,MaxTimes AS (SELECT COUNT(*) AS Times_Presented FROM episodes GROUP BY Cook_FullName ORDER BY Times_Presented DESC LIMIT 1)
    SELECT Cook_FullName, Times_Presented FROM CookTimes WHERE Times_Presented < ((SELECT * FROM MaxTimes) - 4);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_8` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_8`()
BEGIN
	WITH RecipeEquipmentList AS (
		SELECT re.Recipe_ID, COUNT(*) AS Times_Presented 
		FROM recipe_equipment re GROUP BY re.Recipe_ID
	),	UpdatedTable AS (
		SELECT e.Season_ID, e.Episode_ID, e.Recipe_Name, rel.Times_Presented FROM episodes e 
		JOIN recipes r ON r.Name = e.Recipe_Name
		JOIN RecipeEquipmentList rel ON r.Recipe_ID = rel.Recipe_ID
	)	
		SELECT e.Episode_ID, SUM(e.Times_Presented) AS TotalTimes 
		FROM UpdatedTable e GROUP BY e.Episode_ID ORDER BY TotalTimes DESC LIMIT 1;
    
    -- QUERY PLAN WITH FORCE INDEX
	/* WITH RecipeEquipmentList AS (
		SELECT re.Recipe_ID, COUNT(*) AS Times_Presented 
		FROM recipe_equipment re GROUP BY re.Recipe_ID
	),	UpdatedTable AS (
		SELECT e.Season_ID, e.Episode_ID, e.Recipe_Name, rel.Times_Presented
		FROM episodes e FORCE INDEX (idx_recipe_name)
		JOIN recipes r FORCE INDEX (PRIMARY) ON r.Name = e.Recipe_Name
		JOIN RecipeEquipmentList rel ON r.Recipe_ID = rel.Recipe_ID
	)	
		SELECT e.Episode_ID, SUM(e.Times_Presented) AS TotalTimes 
		FROM UpdatedTable e GROUP BY e.Episode_ID ORDER BY TotalTimes DESC LIMIT 1; */
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Question_9` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Question_9`()
BEGIN 
Select episodes.Season_ID, AVG(calories.carbs) AS Average_Carbs_Per_Season
From episodes
INNER JOIN Recipes ON Recipes.Name = episodes.Recipe_Name
INNER JOIN Calories ON Calories.Recipe_ID = Recipes.Recipe_ID
GROUP BY episodes.Season_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RunEpisode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RunEpisode`(season_id INT, episode_id INT)
BEGIN
	-- Cleanup: Drop temporary tables
    DROP TEMPORARY TABLE IF EXISTS temp_cuisines;
    DROP TEMPORARY TABLE IF EXISTS temp_cooks;
	DROP TEMPORARY TABLE IF EXISTS temp_judges;
	DROP TEMPORARY TABLE IF EXISTS result;

    -- Temporary table to store cuisines
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_cuisines (
        Cuisine_ID INT PRIMARY KEY,
        Recipe_ID INT,
        Recipe_Name VARCHAR(100),
        Calls INT
    );

    -- Temporary table to store the cooks and cuisines
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_cooks (
        Cook_ID INT,
		Cuisine_ID INT,
        Name VARCHAR(100),
        PRIMARY KEY (Cook_ID, Cuisine_ID)
    );
    
    -- Temporary table to store the judges
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_judges (
		ID INT,
        Judge_ID INT PRIMARY KEY,
        Full_Name VARCHAR(100)
    );

	-- Temporary table to store the result
    CREATE TEMPORARY TABLE IF NOT EXISTS result (
		Cook_ID INT,
        Cook_FullName VARCHAR(100),
        Recipe_ID INT,
        Recipe_Name VARCHAR(100),
        Judge1_Grade INT,
        Judge1 VARCHAR(100),
        Judge2_Grade INT,
        Judge2 VARCHAR(100),
        Judge3_Grade INT,
        Judge3 VARCHAR(100)
    );
    
    -- Clear the temporary tables
    TRUNCATE TABLE temp_cuisines;
    TRUNCATE TABLE temp_cooks;
    TRUNCATE TABLE temp_judges;
    TRUNCATE TABLE result;
    UPDATE cooks SET Function_Calls = 0;

	INSERT INTO temp_cuisines (Cuisine_ID, Calls)
		SELECT c.Cuisine_ID, c.Episode_Calls
			FROM cuisines c 
			WHERE c.Episode_Calls < 3 
			ORDER BY RAND()
			LIMIT 10;
    
    UPDATE temp_cuisines SET temp_cuisines.Recipe_ID = CuisineToRecipeID(temp_cuisines.Cuisine_ID);
    UPDATE temp_cuisines SET temp_cuisines.Recipe_Name = RecipeIDToRecipeName(temp_cuisines.Recipe_ID);
	
	INSERT INTO temp_cooks (Cuisine_ID) 
		SELECT Cuisine_ID 
        FROM temp_cuisines;
	
    UPDATE temp_cooks SET temp_cooks.Cook_ID = CuisineToCook(temp_cooks.Cuisine_ID);
    UPDATE temp_cooks SET temp_cooks.Name = CookToName(temp_cooks.Cook_ID);
    
	INSERT INTO temp_judges (Judge_ID, Full_Name)
		SELECT c.Cook_ID, CONCAT(c.name, " ", c.surname) 
			FROM cooks c
            WHERE c.Cook_ID NOT IN (SELECT temp_cooks.Cook_ID FROM temp_cooks) AND Judge_Episode_Calls < 3
			ORDER BY RAND()
			LIMIT 3;
	
    SET @row_number = 0;
    UPDATE temp_judges SET ID = (@row_number:=@row_number + 1);
    
    -- Checking the 3 sequential executions ---------------------------------------------------------------------
    -- Cuisines
    UPDATE cuisines 
		SET Episode_Calls = 0
		WHERE cuisine_ID NOT IN (SELECT TEMP_CUISINES.Cuisine_ID FROM TEMP_CUISINES);

	UPDATE cuisines 
		SET Episode_Calls = Episode_Calls + 1
		WHERE cuisine_ID IN (SELECT TEMP_CUISINES.Cuisine_ID FROM TEMP_CUISINES);
        
	-- Cooks
	UPDATE cooks 
		SET Episode_Calls = 0
		WHERE Cook_ID NOT IN (SELECT temp_cooks.Cook_ID FROM temp_cooks);

	UPDATE cooks 
		SET Episode_Calls = Episode_Calls + 1
		WHERE Cook_ID IN (SELECT temp_cooks.Cook_ID FROM temp_cooks);
	
    -- Judges
	UPDATE cooks 
		SET Judge_Episode_Calls = 0
		WHERE Cook_ID NOT IN (SELECT temp_judges.Judge_ID FROM temp_judges);

	UPDATE cooks 
		SET Judge_Episode_Calls = Judge_Episode_Calls + 1
		WHERE Cook_ID IN (SELECT temp_judges.Judge_ID FROM temp_judges);
    
	-- Recipes
	UPDATE recipes 
		SET Episode_Calls = 0
		WHERE Recipe_ID NOT IN (SELECT temp_cuisines.Recipe_ID FROM temp_cuisines);

	UPDATE recipes 
		SET Episode_Calls = Episode_Calls + 1
		WHERE Recipe_ID IN (SELECT temp_cuisines.Recipe_ID FROM temp_cuisines);
    -- ------------------------------------------------------------------------------------------------
    
    -- Make and Return the result
    INSERT INTO result (Cook_ID, Cook_FullName, Recipe_ID, Recipe_Name) 
		SELECT tc.Cook_ID, tc.Name, tcc.Recipe_ID, tcc.Recipe_Name
		FROM temp_cooks tc 
        JOIN temp_cuisines tcc ON tc.Cuisine_ID = tcc.Cuisine_ID;
	
    UPDATE result SET Judge1_Grade = GradingSystem();
    UPDATE result SET Judge2_Grade = GradingSystem();
    UPDATE result SET Judge3_Grade = GradingSystem();
    UPDATE result SET Judge1 = (SELECT Full_Name FROM temp_judges WHERE ID = 1);
    UPDATE result SET Judge2 = (SELECT Full_Name FROM temp_judges WHERE ID = 2);
    UPDATE result SET Judge3 = (SELECT Full_Name FROM temp_judges WHERE ID = 3);

	INSERT INTO episodes(Season_ID, Episode_ID, Cook_ID, Cook_FullName, Recipe_ID, Recipe_Name, Judge1_Grade, Judge1_Name, Judge2_Grade, Judge2_Name, Judge3_Grade, Judge3_Name) 
		SELECT season_id, episode_id, r.* FROM result r;

	-- Output for debugging / Check the Episode_Calls
	#SELECT Episode_ID, c.Episode_Calls AS Calls, r.* FROM result r, cooks c WHERE CONCAT(c.Name, " ", c.Surname) = r.Cook_FullName; 
    
    -- Cleanup: Drop temporary tables
    DROP TEMPORARY TABLE IF EXISTS temp_cuisines;
    DROP TEMPORARY TABLE IF EXISTS temp_cooks;
	DROP TEMPORARY TABLE IF EXISTS temp_judges;
	DROP TEMPORARY TABLE IF EXISTS result;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RunSeasons` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RunSeasons`(seasons INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	DECLARE episode_counter INT DEFAULT 1;
    DECLARE j INT;
    
    TRUNCATE TABLE episodes;
    
    outer_loop: LOOP
        IF i > seasons THEN
            LEAVE outer_loop;
        END IF;
        
        SET j = 1;
        
        CALL ClearCallValues();
        
        inner_loop: LOOP
            IF j > 10 THEN
                LEAVE inner_loop;
            END IF;
            
			CALL RunEpisode(i, episode_counter);
		
			SET j = j + 1;
            SET episode_counter = episode_counter + 1;
			END LOOP inner_loop;
        SET i = i + 1;
    END LOOP outer_loop;
    
    CALL ClearCallValues();
    
    	WITH StartingTable AS (
		SELECT Season_ID, Episode_ID, Cook_ID, Cook_FullName, Recipe_Name, (Judge1_Grade + Judge2_Grade + Judge3_Grade) AS Judge_Grade, Judge1_Name, Judge2_Name, Judge3_Name
		FROM episodes
    ),	MaxGradeCooks AS (
		SELECT Season_ID, Cook_ID, MAX(Judge_Grade) AS JudgeGrade FROM StartingTable GROUP BY Season_ID
	),	CompletedCooksTable AS ( 
		SELECT st.Season_ID, st.Cook_ID, st.Cook_FullName, st.Judge_Grade FROM StartingTable st WHERE Judge_Grade IN (SELECT mxc.JudgeGrade FROM MaxGradeCooks mxc)
	),	CookRankIncluded AS (
		SELECT cct.*, (SELECT c.Ranking FROM cooks c WHERE c.cook_id = cct.cook_id) AS Cook_Rank FROM completedcookstable cct
	), 	FinalTable AS (
		SELECT cri.Season_ID, cri.Cook_ID, cri.Cook_FullName, cri.Judge_Grade, (CASE 
		WHEN Cook_Rank = 'C Cook' THEN 1
        WHEN Cook_Rank = 'B Cook' THEN 2
        WHEN Cook_Rank = 'A Cook' THEN 3		
		WHEN Cook_Rank = 'Sous Chef' THEN 4
		WHEN Cook_Rank = 'Chef' THEN 5
		ELSE Cook_Rank 
		END) AS CookRank, ROW_NUMBER() OVER (PARTITION BY Season_ID ORDER BY Judge_Grade DESC, CookRank DESC) AS RowCookRank FROM CookRankIncluded cri
	)	SELECT Season_ID, Cook_FullName AS WinnerCook, Judge_Grade AS JudgeTotalGrade FROM FinalTable WHERE RowCookRank = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-26 23:01:07
