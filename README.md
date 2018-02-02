## Postgraph/Graphile
NB: this is written assuming MacOSX device.

# Getting Started

1. Make sure that you have the [Postgres App](https://postgresapp.com/) on your device, and create a DB. 
2. Recommended: install the app [Postico](https://eggerapps.at/postico/), and connect to your local Postgres DB.
3. In terminal, globally install postgraphile: 
    ```
    npm install -g postgraphile
    ```
3. Write out your Postgres SQL schema in a file.sql - make sure you save it, so that you can easily clear out and fix any mistakes to your PostgresDB. NB: you should create a schema, and then create tables attached to that schema, such as:
    ```
    create schema superheroes;
    create table superheroes.hello (
        id serial primary key,
        greeting text not null check (char_length(greeting) < 80)
    );
    comment on table superheroes.hello is 'Just a practice table to test capabilities.';
    ```
4. When your schema is all written out, add it to your DB by running each statement in Postico.
5. Now, it's time to connect to your database! It's important to remember that postgraphile expects to be pointed towards a schema, such as 'superheroes' in this example. Ex:
    ```
    postgraphile -c postgres://postgres:@localhost:5432/postgres --schema superheroes    
    ```

