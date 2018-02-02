create schema superheroes;


create table superheroes.hello (
	id serial primary key,
	greeting text not null check (char_length(greeting) < 80)
);

insert into superheroes.hello (greeting) values ('hello');
insert into superheroes.hello (greeting) values ('hi');
insert into superheroes.hello (greeting) values ('cheers');

select * from superheroes.hello;

create type superheroes.league as enum (
  'avengers',
  'xmen',
  'justice league',
  'solo'
);

-- create type superheroes.species as enum (
--   'human',
--   'kryptonian',
--   'human - mutant',
--   'goddess'
-- );

create table superheroes.species (
    id serial primary key,
    name text not null check (char_length(name) < 80),
    typical_powers text not null check (char_length(typical_powers) < 1000),
    origin text not null check (char_length(origin) < 1000)
)
insert into superheroes.species (name, typical_powers, origin) values ('goddess', 'Control over certain elements, immortality, flight, super strength and speed, enhanced senses and intelligence.', 'Celestial realms');
insert into superheroes.species (name, typical_powers, origin) values ('human', 'None inherent, but may have above average intelligence and trained in arts of combat espionage.', 'Earth');
insert into superheroes.species (name, typical_powers, origin) values ('human - mutant', 'Control over some aspect such as telekinesis or telepathy, magnetic fields, reality distortian, super healing, weather or elements - depends on the X gene.', 'Earth');
insert into superheroes.species (name, typical_powers, origin) values ('kryptonian', 'Powers of super speed and strength, flight, laser vision, x-ray vision, freeze breath, indestructible - all powers granted by yellow sun radiation.', 'Krypton (destroyed)');


create table superheroes.heroes (
    id serial primary key,
    name text not null check (char_length(name) < 80),
    league superheroes.league,
    species integer not null references superheroes.species(id)
)

insert into superheroes.heroes (name, league, species) values ('Diana of Themiscyra', 'justice league', 1);
insert into superheroes.heroes (name, league, species) values ('Scarlet Witch', 'avengers', 3);
insert into superheroes.heroes (name, league, species) values ('Black Widow', 'avengers', 2);
insert into superheroes.heroes (name, league, species) values ('Supergirl', 'justice league', 4);
insert into superheroes.heroes (name, league, species) values ('Phoenix', 'xmen', 3);
insert into superheroes.heroes (name, league, species) values ('Storm', 'xmen', 3);
insert into superheroes.heroes (name, league, species) values ('Rogue', 'xmen', 3);
insert into superheroes.heroes (name, league, species) values ('Valkyrie', 'solo', 1);

comment on table superheroes.heroes is 'A hero''s identity and league association.';
comment on column superheroes.heroes.id is 'The primary unique identifier for the hero.';
comment on column superheroes.heroes.league is 'The league association wo which the hero belongs.';
comment on column superheroes.heroes.species is 'The hero''s species, often the source of their power.';

create table superheroes.alterEgos (
    id serial primary key,
    name text not null check (char_length(name) < 80),
    superhero_id integer not null references superheroes.heroes(id),
    occupation text not null check (char_length(occupation) < 120),
    is_Secret boolean
)

insert into superheroes.alterEgos (name, superhero_id, occupation, is_Secret) values ('Diana Prince', 1, 'Art & Ancient Artifect Restorer', TRUE);
insert into superheroes.alterEgos (name, superhero_id, occupation, is_Secret) values ('Wanda Maximoff', 2, 'Avenger', FALSE);
insert into superheroes.alterEgos (name, superhero_id, occupation, is_Secret) values ('Natasha Romanoff', 3, 'Avenger', FALSE);
insert into superheroes.alterEgos (name, superhero_id, occupation, is_Secret) values ('Kara Zor-El Danvers', 4, 'Reporter', TRUE);
insert into superheroes.alterEgos (name, superhero_id, occupation, is_Secret) values ('Jean Grey', 5, 'Teacher', TRUE);
insert into superheroes.alterEgos (name, superhero_id, occupation, is_Secret) values ('Ororo Monroe', 6, 'Teacher', TRUE);
insert into superheroes.alterEgos (name, superhero_id, occupation, is_Secret) values ('Marie D''Ancanto', 7, 'Student', TRUE);
insert into superheroes.alterEgos (name, superhero_id, occupation, is_Secret) values ('N/A', 8, 'Asgardian Elite Warrior', FALSE);

select * from superheroes.heroes as heroes join superheroes.alterEgos as alters on heroes.id = alters.superhero_id;
select heroes.name, heroes.league, heroes.species, alters.name as alter_ego, alters.occupation, alters.is_secret from superheroes.heroes as heroes join superheroes.alterEgos as alters on heroes.id = alters.superhero_id;


comment on table superheroes.alterEgos is 'A table of heroes'' alternate identities, secret or not.';
comment on column superheroes.alterEgos.id is 'The primary unique identifier for the alternate identity.';
comment on column superheroes.alterEgos.superhero_id is 'The id of the hero associated with this alternate identity.';
comment on column superheroes.alterEgos.occupation is 'The alternate identity''s occupation.';
comment on column superheroes.alterEgos.is_Secret is 'Whether or not the alternate identity is a secret.';