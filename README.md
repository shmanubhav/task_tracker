# TaskTracker

This App uses a PostgreSQL database with 3 tables: users, tasks and task_map

Users have an id, name and email
Tasks have an id, title, description, time taken (in sets of 15 minutes) and whether
the task has been completed or not.
The Task Map table is a relational map between the tables users and tasks and
stores the corresponding user id of the task which has been assigned to them.
It has three fields: id, user_id and task_id
