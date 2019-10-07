# flyway-tsqlt-azure-demo
How to use Azure DevOps, Flyway &amp; tSQLt to apply CI/CD to a SQL Server database, according to the Pipeline-as-Code (PaC) approach.


This demo uses a very simple CI/CD pipeline scenario of a small company that uses 3 environments:
"Dev" -> "UAT" -> "Prod".

There will be one database per environment, and they all exist in the same SQL Server instance.

## Repository structure

### "azure-pipelines.yml" file
This is the main file that describes the pipeline as code, and is the entry point for said pipeline. Instead of explicitly containing every detail for the whole pipeline declaration, it makes use of Azure DevOps [Templates](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/templates?view=azure-devops#template-expressions) to break up the entire CI/CD process into smaller components (i.e. the pipeline is broken down into Stages, each Stage is broken down into Jobs, and each Job is broken down into one or more sets of Steps), promoting reusability, readability and adaptability, amongst other traditional best-practices associated with software development. These Templates and associated files can be found in the "pipeline" folder.

### "pipeline" folder
To comply with PaC, the pipeline is described through source-controlled files as much as possible. Pipeline Jobs and Steps are written in YAML, which in turn make use of PowerShell scripts to accomplish most Tasks. PowerShell scripts make use of SQL scripts to interact with the databases (e.g. "Applying Flyway migrations to a target database", "Running Tests"). Files for Stages, Jobs and Steps are grouped into sub-folders.

### "migrations" folder
SQL migrations that describe how the database should change. This is what constitutes a Build Artifact, what should be deployed to each environment's databases.

### "tests" folder
Unit tests written in tSQLt. Used during the "Dev" stage.

### "design" folder
UML-esque diagrams that represent the pipeline in an abstract fashion as if it were software. Designing before coding is an undisputed software development practice, so why not use it for pipeline code too? Obviously the goal isn't to overdocument and produce all kinds of excessive UML diagrams, but to have just a basic, clear visual representation that helps new members of a team to quickly grasp WHAT the pipeline is supposed to do (abstraction, i.e. just the steps and tasks themselves), and HOW it does that (implementation, i.e. which YAML/PowerShell/SQL files are used or implement the abstract Jobs, Steps and Tasks). 

### "demo" folder
Contains a "setup.ps1" script to quickly recreate blank databases for all 3 Stages/Environments - "Dev", "UAT", "Prod".

## Setup
Here's what you need to setup beforehand:

1. Create an Azure DevOps [Organization](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/create-organization?view=azure-devops) and [Project](https://docs.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops);
2. Create 3 [Agent Pools](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops) for your Organization - "Dev", "UAT" and "Prod";
3. Install a self-hosted [Agent](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/agents?view=azure-devops#install) for each of these Pools on your machine. These Agents will run the Build/Deploy jobs on your machine, targeting your local environment DBs;
4. Either use an Azure [Git repo](https://docs.microsoft.com/en-us/azure/devops/repos/git/create-new-repo?view=azure-devops), or [link](https://docs.microsoft.com/en-us/azure/devops/repos/git/import-git-repository?view=azure-devops) the Project you just created to a GitHub repo of your choosing;
3. Install SQL Server on your machine. Originally tested on the SQL Server Developer edition, but should work on other editions, like SQL Server Express;
4. Install [Flyway](https://flywaydb.org/download/) on your machine. Just download and extract the ZIP, and add that folder to your PATH;
5. Open the "azure-pipelines.yml" file, in the repo's root. In the "variables" section, edit "devDeploymentPool"/"uatDeployPool"/"prodDeployPool" to exactly match the names of the pools you created in step 2. Then, edit "databaseName" to something of your choosing ("flyway-tsqlt-azure-demo" by default).
6. Run ".\setupDB.ps1 -databaseName YOUR_DATABASE_NAME" from the repo's root folder, where "YOUR_DATABASE_NAME" is the name you chose in the previous step. If you want to use the default names, simply run ".\setup.ps1 -databaseName flyway-tsqlt-azure-demo" This creates the "Dev", "UAT" and "Prod" databases on your SQL Server instance, and baselines them at version 1. If Dev and UAT already exist, it DROPs and CREATEs them;
	
After that, you're up and running. SQL migrations have been split up into 2 sprints, so you can play around with commiting them at different times and simulate working with the Agile methodology. Check this repo's Issues and Milestones (Closed) for an example.
