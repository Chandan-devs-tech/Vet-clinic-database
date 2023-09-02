/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT,
    name VARCHAR, 
    date_of_birth DATE, 
    escape_attempts INT, 
    neutered BOOLEAN, 
    weight_kg DECIMAL
);

ALTER TABLE animals ADD COLUMN species VARCHAR(50);

CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY,full_name VARCHAR(50),age INT,PRIMARY KEY(id));

CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY,name VARCHAR(50),PRIMARY KEY(id));

ALTER TABLE animals ADD COLUMN new_id INT GENERATED ALWAYS AS IDENTITY;
SELECT * FROM animals;
ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals RENAME COLUMN new_id TO id;
ALTER TABLE animals ADD PRIMARY KEY(id);
\d animals

ALTER TABLE animals DROP COLUMN species;
SELECT * FROM animals;

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species_id FOREIGN KEY(species_id) REFERENCES species(id);
\d animals

ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner_id FOREIGN KEY(owner_id) REFERENCES owners(id);
\d animals


CREATE TABLE vets (id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(50), age INT, date_of_graduation DATE, PRIMARY KEY(id));
SELECT * FROM vets;

CREATE TABLE specializations (species_id INT REFERENCES species(id), vets_id INT REFERENCES  vets(id), PRIMARY KEY(speci
es_id,vets_id));
\d specializations

CREATE TABLE visits (visit_id INT GENERATED ALWAYS AS IDENTITY,animal_id INT REFERENCES animals(id),vet_id INT REFERENCES vets(id),visit_date DATE,PRIMARY KEY (visit_id));
\d visits