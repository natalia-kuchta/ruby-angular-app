# Rails Angular Todo app

This project presend 
- simple statefull backend written in ruby on rails with crud on tasks collection.
- angular frontend with one component in which all resources are synchronized with backend thanks to native fetch function

## How to open app

You will need 2 consoles.

In first:

```bash
cd backend && bundle install
bin/rails server
```

it will expose backend on port 3000

In second:

```bash
cd frontend && npm install
npm run start
```

It will expose frontend on port 4200


## Http commands to test backend

Get all tasks

```httpie
http GET http://localhost:3000/tasks
```

Delete first task

```httpie
http DELETE http://localhost:3000/tasks/1
```

Create task

```httpie
echo '{
  "name": "Build something awesome", "completed": false
}' |  \
  http POST http://localhost:3000/tasks \
  content-type:application/json
```

Edit task

```
echo '{
  "id": 4,
  "name": "Learn new framework",
  "completed": true
}' |  \
  http PUT http://localhost:3000/tasks/4 \
  content-type:application/json
```
