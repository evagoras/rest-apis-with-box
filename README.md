# A ColdBox RESTful API
This is a showcase of how to create a REST API using ColdBox. It contains many concepts, such as versioning, validation, custom serialization, and separation of layers to Controllers, Services and DAOs.

## Installation
You will need to run the project using CommandBox. Download the project locally on your computer. Then start up CommandBox and navigate to the `wwwroot` folder of the project and run `start`:

```
cd wwwroot
start
```

A Bootstrap page should appear running at [127.0.0.1:8085](http://127.0.0.1:8085).

## Database
The project uses the `cfartgallery` database as its data store, running in an sqlite db file. Since the sqlite drivers do not come standard in Adobe or Lucee, you will need to add the driver to get things working.

By default I am using Lucee 5 as the application server. You will need to add the file `/database/sqlite-jdbc--3.14.2.1.jar` to these folders depending if you are using a Mac/*nix or Windows:

1. Mac/*nix - `/Users/{yourusername}/.CommandBox/server/{randomstring}-rest-apis-with-box/lucee-5.1.0.34/WEB-INF/lucee/{randomstring}/lib`.
2. Windows - TO DO.

