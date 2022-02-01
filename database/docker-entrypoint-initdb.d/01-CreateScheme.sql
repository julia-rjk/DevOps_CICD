CREATE TABLE public.departments(id SERIAL PRIMARY KEY,name VARCHAR NOT NULL);

CREATE TABLE public.students(
 id SERIAL PRIMARY KEY,
 department_id INT NOT NULL REFERENCES departments(id),
 first_name VARCHAR NOT NULL,
 last_name VARCHAR NOT NULL
);