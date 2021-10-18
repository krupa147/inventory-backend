# README

### Prequisites:
* Ruby Version  2.6.2
* Postgres 14

### Setting up

#### Bundle
Install gems with
```bash
bundle
```

#### Configuration
Copy the content of `config/database-sample.yml` and add it to `config/database.yml`. Update username and password with your postgres username and password in `config/database.yml`.

Add master.key file to `config/master.key`. Ask repository author for master.key
#### Database Creation & Migration
Run below command to create the database,
```azure
rails db:create 
```

Run below command to migrate the database,
```azure
rails db:migrate
```

Seed the database with below command,
```azure
rails db:seed
```

### How to run on localhost

Use below command to run rails server
```azure
rails s
```

### Note
* Use `rails c` to access the database console
* `rails db:seed` will create one employee with role IT admin. To access the API use below username and password
    * username: test@test.com
    * password: Test@123
* Postman collection link: [inventory](https://www.getpostman.com/collections/a55100b557ef36ec93af)



