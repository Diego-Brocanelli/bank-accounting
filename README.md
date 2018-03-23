# Bank Accounting

API for execute bank operations. This API respect the principle REST.

Operations supported:

- List all clients.
- List a specific client.
- Deposit.
- Get the client balance.

About the test [Bank accounting](https://gist.github.com/bezelga/f4f6c065a454665122b875b1566d5178)

# Required

- Ruby  V 2.4.1
- Rails V 5.1.5

# Running project

**Get a project copy**

```
git clone https://github.com/Diego-Brocanelli/bank-accounting.git
```

**Generate Database**

```
rake db:migrate
```

**Populate table**

```
rake db:seed
```

Running API

```
rails s
```

# Routes

Action | Verb | Route    | Return | Data Return
-------|-----|----------|--------|-------------
List all clients.| GET  | /acounts | JSON | id, number, balance, created_at, updated_at
List a specific client | GET  | /accounts/:id | JSON | id, number, balance, created_at, updated_at
Deposit| GET  | /accounts/balance/:account_id | JSON | owner, balance
Get the client balance | POST | /accounts/deposit/:source_account_id/:destination_account_id | JSON | message, origin, destination, value, status_code, date
