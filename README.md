# BYUI Data Science SQL Server Usage Guide

## Introduction
The purpose of the BYUI Data Science SQL Server is to twofold:
1. Provide a convenient mechanism for Data Science students to store and retrieve data for large projects.
2. Provide an authentic experience that prepares Data Science students to interface with a SQL Server in the workplace.

To fulfill this ongoing purpose, this guide provides instruction for maintenance and use of the BYUI Data Science SQL Server. Two distinct roles, each with their own set of server permissions have been created to preserve the rigorous structure of the server. These roles are titled **“Editor”** and **“Student”**. **Editors** are responsible for creating a new database on the server for each project, uploading initial data to that database, and maintaining the database throughout the lifetime of its associated project. **Students** have the ability to use the server to read data into their sessions of RStudio. The remainder of this guide provides specific instruction for each of these two roles.


## Editor Role Instructions
*Editors are responsible for creating a new database on the server for each project, uploading initial data to that database, and maintaining the database throughout the lifetime of its associated project.*

### Getting Started with Microsoft SQL Server Management 

#### Download the Software
*Microsoft SQL Server Management Studio (SSMS) is an interactive interface to manage databases on a server.*
1. Visit https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms and follow the instuctions to download the newest version of Microsoft SQL Server Management Studio (SSMS).
2. Execute the downloaded file to install the program.

#### Connecting to the Server (ONLY WORKS ON CAMPUS)
*You will need to login to the server every time you launch Microsoft SSMS.*
1. In the dialogue box that appears titled "Connect to Server" enter the following information:  
Server type: Database Engine  
Server name: shiny.byui.edu  
Authentication: SQL Server Authentication  
Login: editor  
Password: (Reach out to Brother Hathaway to get the password to our SQL Server *editor* account.)
2. Click "connect"

### Creating a Database
*We will use one new database to hold all necessary datatables for each new project on the Server.*
1. Within the "Object Explorer" pane in Microsoft SSMS, right-click on the folder titled "Databases".
2. Click the option "New Database" in the dropdown menu.
3. Type a name for the database in the "Database name" field.
4. Click "OK" to initialize your empty new database.

### Uploading Data
*When using SQL Server only for data storage we don't need to worry much about datatypes and keys.*
1. Ensure that the data is downloaded on your computer and saved as a `.csv` file.
2. Within the "Object Explorer" pane in Microsoft SSMS, expand the folder titled "Databases".
3. Right-click on the name of your database object.
4. Hover over the "Tasks" item in the dropdown list and click on the "Import Flat File..." option.
5. Click "Next".
6. Click "Browse" and navigate to your data.
7. Enter the name for your new datatable.
8. Click "Next" two times.
9. Check the "Allow Nulls" box for every item.
10. Click "Next".
10. Click "Finish".

### Deleting Mistakes

#### Delete a Table
1. Within the "Object Explorer" pane in Microsoft SSMS, expand the folder titled "Databases".
2. Expand your database object and the folder inside titled "Tables".
3. Right click on the table you would like to delete.
4. Click the "Delete" option the dropdown menu.
5. Click "OK".

### Delete a Database
1. Within the "Object Explorer" pane in Microsoft SSMS, expand the folder titled "Databases".
2. Right click on the database you would like to delete.
3. Click the "Delete" option the dropdown menu.
4. Click "OK".

## Student Role Instructions
*Students have the ability to use the server to read data into their sessions of RStudio.*

### Establishing a Connection to the Server (ONLY WORKS ON CAMPUS)
*To access your database, you must first create a special "connection" object.*
1. Run the following code snippet within your RStudio session to load a function called "connect" into your environment: `source("https://bit.ly/byuisql")`
2. Speak to your project's designated Editor to learn the name of your project's database on the server.
3. Run the following code snippet within your RStudio session to create a connection object named "connection" that points to your database: `connection <- connect("name of your database")`
4. Enter the password. (Reach out to Brother Hathaway to get the password to our SQL Server *student* account.)

### Reading Data into RStudio

#### Creating a Query Object
*A query object specifies exactly what information you would like to read from the database.*
1. Speak to your project's designated Editor to learn the name of your project's tables on the server.
2. Create a query object using the `tbl()` function from the `dplyr` package.  
For example: `query <- tbl(connection, "name_of_the_table")`

#### Condensing the Data (Optional)
*If a dataset in its full form is to large to fit on your computer, you can specify a way to summarize it before transfering it to your device.*
1. Transform your query object using dplyr functions such as `mutate()`, `filter()`, `select()`, `group_by()`, and `summarize()`. (Nearly any dplyr operation works.)  
For example: 
```
query <- query %>% 
  mutate(new_col = colA * colB) %>% 
  filter(new_col > 5) %>% 
  group_by(colC) %>% 
  summarize(top = mean(new_col))
```

#### Turning the Query into an R DataFrame
*Turning a query object into a dataframe only requires one simple step.*
1. Use the `collect()` function from the dbplyr package to convert your query into a local dataframe.  
For example: `data <- collect(query)`.
