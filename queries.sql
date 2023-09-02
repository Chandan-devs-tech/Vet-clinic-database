/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/*Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.*/
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*Inside a transaction:
Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
Verify that changes were made.
Commit the transaction.
Verify that changes persist after commit.*/
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE ('%mon');
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

/*Inside a transaction delete all records in the animals table, then roll back the transaction.
After the rollback verify if all records in the animals table still exists.)*/
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*Inside a transaction:
Delete all animals born after Jan 1st, 2022.
Create a savepoint for the transaction.
Update all animals' weight to be their weight multiplied by -1.
Rollback to the savepoint
Update all animals' weights that are negative to be their weight multiplied by -1.
Commit transaction*/
BEGIN;
DELETE FROM animals WHERE date_of_birth >'2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg*-1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/*How many animals are there?*/
SELECT COUNT(*) FROM animals;

/*How many animals have never tried to escape?*/
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/*What is the average weight of animals?*/
SELECT avg(weight_kg) FROM animals;

/*Who escapes the most, neutered or not neutered animals?*/
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

/*What is the minimum and maximum weight of each type of animal?*/
SELECT species, MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, MIN(weight_kg) FROM animals GROUP BY species;

/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/
SELECT species, avg(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


/*What animals belong to Melody Pond?*/
SELECT name as animal_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name= 'Melody Pond';
/*List of all animals that are pokemon (their type is Pokemon).*/
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
/*List all owners and their animals, remember to include those that don't own any animal.*/
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals. owner_id;
/*How many animals are there per species?*/
SELECT species.name, COUNT(*) as total_animals FROM species JOIN animals ON species.id = animals.species_id GROUP BY species.name;
/*List all Digimon owned by Jennifer Orwell.*/
SELECT animals.name AS animal_name FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
/*List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT animals.name AS animal_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
/*Who owns the most animals?*/
SELECT owners.full_name, COUNT(animals.id) AS total_animals FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name;





SELECT animals.name FROM visits JOIN animals ON visits.animal_id = animals.id WHERE visits.vet_id = 1 ORDER BY visits.visit_date DESC LIMIT 1;

SELECT COUNT(DISTINCT visits.animal_id) FROM visits WHERE visits.vet_id = 3;

SELECT vets.name, species.name FROM specializations FULL JOIN vets ON specializations.vets_id = vets.id FULL JOIN species ON specializations.species_id = species.id;

SELECT animals.name FROM visits JOIN animals ON visits.animal_id = animals.id WHERE visits.vet_id = 3 AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, COUNT(visits.visit_id) AS visit_count FROM visits JOIN animals ON visits.animal_id = animals.id GROUP BY animals.name ORDER BY visit_count DESC LIMIT 1;

SELECT animals.name AS animal_name, MIN(visits.visit_date) AS first_visit_date FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Maisy Smith' GROUP BY animals.name ORDER BY first_visit_date ASC LIMIT 1;

SELECT MAX(visits.visit_date) AS most_recent_visit_date, animals.name AS animal_name, vets.name AS vet_name FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id GROUP BY animals.name, vets.name ORDER BY most_recent_visit_date DESC LIMIT 1;

SELECT COUNT(*) AS num_visit_with_unspecialized_vet FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id LEFT JOIN specializations s ON vt.id = s.vets_id AND a.species_id = s.species_id WHERE s.species_id IS NULL OR s.species_id IS NOT NULL AND vt.id NOT IN (SELECT vet_id FROM specializations WHERE species_id = a.species_id);

SELECT species.name AS specialty_required_in_species, vets.name AS doctor_name FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id JOIN species ON animals.species_id = species.id WHERE vets.name = 'Maisy Smith' GROUP BY species.name, vets.name ORDER BY COUNT(species.name) DESC LIMIT 1;