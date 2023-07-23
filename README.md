# WillaDB PostgREST
===================

Architecture
------------

![Deployment Diagram](diagrams/deployment-diagram.png)

Usage
-----

**Start the containers**

`docker-compose up -d`

**Tearing down the containers**

`docker-compose down --remove-orphans -v`

**Demo Application**

Located at [http://localhost:4321](http://localhost:4321)

**Postgrest**

Located at [http://localhost:3000](http://localhost:3000)

Try things like:
* [http://localhost:3000/tables](http://localhost:3000/tables)
* [http://localhost:3000/columns?table_name=like.*key*&position=gt.1&select=table_name,column_name](http://localhost:3000/columns?table_name=like.*key*&position=gt.1&select=table_name,column_name)

**Swagger UI**

Located at [http://localhost:8088](http://localhost:8088)
