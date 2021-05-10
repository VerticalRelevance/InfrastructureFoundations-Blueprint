![VRLogo](src/Images/vr-logo.png)
# **Infrastructure Foundation**
In this program, a template and data file are uploaded, passed through linting, validated, created, and distributed as a product on to the AWS Service Catalog. From there, the customer can select the instance and have it start up upon request. The end goal of this project is to make the integration of new products into service catalog as simple and streamlined as possible, while also reducing the time spent on testing for compliance and security issues.
## **What is this product?**
![SolutionImage](src/Images/Flowchart.png)
This program takes in an AWS CloudFormation template and passes it through a series of tests. It validates the code to make sure it executes the deployment of an instance properly, as well as to ensure that it is written in a security-focused way. These tests include being passed through a lint service(cfn-lint) as well as through a secret detection program(detect-secrets). Once it passes through these tests, it then goes through one of two paths; the creation of a new product, and the update of an existing product.
## **Naming convention**
In order for the pipeline to execute, the template must be named according to the following rules. The name of the folder should be the name of the product, and the name of the template should be 'nameofproduct'_template.yml, where 'nameofproduct' is the name of the product you are trying to add. The program requires a folder under the Parsing/ServiceCatalog directory that is named after the product that includes a datafile.json with RequestType and Version variables. For new products, the RequestType should be set to New. For existing products, when looking to update, the version in the datafile must be updated. The resulting file structure should look like:  
**Parsing/ServiceCatalog/${*WhichInstance*}/${*WhichInstance*}_template.yml.**

## **Instructions for adding/updating a product**
### For a new product:
1. Create a folder containing the template and datafile.json for the new product, with the folder name and template file name matching the rules in the naming convention. Below is what the datafile.json document should look like/contain. The only time RequestType is set to new is when you are creating a new product. If you are trying to update a product, the datafile.json will have changed the value from New to Old and you will not need to change that value. See the instructions for updating a product for more information.
```json
{"RequestType": "New", "Version": 0.1}
```
2. Upload said folder to the Parsing/ServiceCatalog directory. Make sure that the spelling is the same throughout the project. 
3. Once the pipeline has completed validating the template, it will begin its deployment to Service Catalog. From this point on, follow the common instructions below.

### For updating a product
1. In the datafile.json document, make sure the version has been incrimented to a new version. The pipeline checks to see if the version in the datafile matches the existng version in Service Catalog. If the versions do not match, it will begin to validate the new template and update the product in Service Catalog. Below is what the datafile.json document should look like for an existing product. Note how RequestType is set to Old, and the Version has been changed.
```json
{"RequestType": "Old", "Version": 0.2}
```

2. Upload the updated template and datafile.json to the folder inside of the Parsing/ServiceCatalog directory. Make sure that the Version has been changed, otherwise the pipeline will not deploy the updated template.
3. Follow the common instructions below.

### Common Instructions

4. Compress the following files and folders into a zipped folder called Source(yes it must be capitalized) and upload the file(NOT FOLDER, in S3 a zipped folder is considered a file) to the S3 bucket in this format:
- Source.zip
    - catalog_build
    - Parsing
        - ServiceCatalog
            - ProductName
                - ProductName_template.yml
                - datafile.json

5. Once completed, push the changes in the repository on your local machine to the CodeCommit repository on AWS. This will trigger the pipeline, either creating the new product or updating an existing one. 