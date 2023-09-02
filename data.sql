/* Populate database with sample data. */

INSERT INTO animals(id,name,date_of_birth, escape_attempts, neutered, weight_kg) VALUES(1,'Agumon','2020-2-3',0,TRUE,10.23);
INSERT INTO animals(id,name,date_of_birth, escape_attempts, neutered, weight_kg) VALUES(2,'Gabumon','2018-11-15',2,TRUE,8),(3,'Pikachu','2021-1-7',1,FALSE,15.04),(4,'Devimon','2017-5-12',5,TRUE,11);
INSERT INTO animals (id,name,date_of_birth, escape_attempts, neutered, weight_kg) VALUES(5,'Charmander','2020-02-08',0,FALSE,-11),(6,'Plantmon','2021-11-15',2,TRUE,-5.7),(7,'Squirtle','1993-04-02',3,FALSE,-12.13),(8,'Angemon','2005-06-12',1,TRUE,-45),(9,'Boarmon','2005-06-07',7,TRUE,20.4),(10,'Blossom','1998-10-13',3,TRUE,17),(11,'Ditto','2022-05-14',4,TRUE,22);

INSERT INTO owners (full_name,age) VALUES ('Sam Smith',34),('Jennifer Orwell',19),('Bob',45),('Melody Pond',77),('Dean Winchester',14),('Jodie Whittaker',38);
SELECT * FROM owners;

INSERT INTO species (name) VALUES ('Pokemon'),('Digimon');
SELECT * FROM species;

UPDATE animals SET species_id = species.id FROM species WHERE animals.name LIKE '%mon' AND species.name = 'Digimon';
UPDATE animals SET species_id = species.id FROM species WHERE animals.name NOT LIKE '%mon' AND species.name = 'Pokemon';
SELECT * FROM animals;

UPDATE animals SET owner_id = owners.id FROM owners WHERE animals.name = 'Agumon' AND owners.full_name = 'Sam Smith';
UPDATE animals SET owner_id = owners.id FROM owners WHERE animals.name IN ('Gabumon','Pikachu') AND owners.full_name = 'Jennifer Orwell';
UPDATE animals SET owner_id = owners.id FROM owners WHERE animals.name IN ('Devimon','Plantmon') AND owners.full_name = 'Bob';
UPDATE animals SET owner_id = owners.id FROM owners WHERE animals.name IN ('Charmander','Squirtle','Blossom') AND owners.full_name = 'Melody Pond';
UPDATE animals SET owner_id = owners.id FROM owners WHERE animals.name IN ('Boarmon','Angemon') AND owners.full_name = 'Dean Winchester';
SELECT * FROM animals;
