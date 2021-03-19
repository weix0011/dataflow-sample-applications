# Automated Test For Terraform Modules

Use go and terratest to test the following modules.
- Pub/Sub

## Install Terraform and Go

If you are using the [Google Cloud Shell](https://cloud.google.com/shell/docs/how-cloud-shell-works), both Terraform and Go are installed.

Follow the instructions to install [Terraform cli](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/gcp-get-started) and [Go](https://golang.org/doc/install).

This repo has been tested on Terraform version `0.14.5`, Go version `1.16` and Google provider version `3.48.0`

## Resources Being Tested

### Pub/Sub
The test will create four topics and three subscriptions in Pub/Sub with names described below. 

**Topics**
- Clickstream-inbound
- Transactions-inbound
- Inventory-inbound
- Inventory-outbound

**Subscriptions**
- Clickstream-inbound-sub
- Transactions-inbound-sub
- Inventory-inbound-sub

After creating these resources successfully, the test will destroy them in order to keep a clean test environment.

## How To Fail The Test and Fix It
**Incorrect terraform directory**

The automated test uses a relative path to identify example usage of the Pub/Sub module. In case when there is no such directory, the test will fail with a fatal error as shown below.

`FatalError{Underlying: error while running command: chdir ../examples/pubsub1: no such file or directory; }`

In order to see this error in action, let's change the relative path to something non-existent.

1. Clone the repository using `git clone` command
2. Execute `cd dataflow-sample-applications/retail/retail-java-applications/terraform/test` to change the directory inside the test folder
3. Identify the assignment statement `TerraformDir: "../examples/pubsub",` in line 25 of `pubsub_test.go` in the test folder
4. Change the relative path to `TerraformDir: "../examples/non-existent",` 
5. Return to command line and execute `go test -v` to run the test

The test will fail as expected.

To conclude, make sure the relative path exists and it is correctly spelled in `pubsub_test.go`.


**Incorrect project ID**

Another way to fail the test is to provide an incorrect project ID. The test will fail with the following error.

```
Error: Error when reading or editing Project Service : 
Request "List Project Services [your-project-id]" returned error: Failed to list enabled services for project [your-project-id]: 
googleapi: Error 400: The resource id [your-project-id] is invalid., badRequest
```

To see this error in action, simply clone the project and execute the test without changing anything.

1. Clone the repository if you have not done so
2. Execute `cd dataflow-sample-applications/retail/retail-java-applications/terraform/test` to change the directory inside the test folder
3. Execute `go test -v` to run the test

The test will fail as expected because the GCP project cannot be found due to incorrect project ID. 

To make sure the test works as expected, please update the project ID according to your environment as described in the next section. 

## Edit Your Project ID

Please replace `[your-project-id]` in pubsub_test.go to your own project ID in order to pass the project ID value to terraform.

1. Clone the repository if you have not done so
2. Execute `cd dataflow-sample-applications/retail/retail-java-applications/terraform/test` to change the directory inside the test folder
3. Update `[your-project-id]` in pubsub_test.go according to your environment


## Execute Automated Test

This section describes steps to execute the automated test, assuming the repository has been cloned.

1. Make sure you are in the test folder: `dataflow-sample-applications/retail/retail-java-applications/terraform/test`
2. Execute the test using `go test -v`


You will see the following output.

```
=== RUN   TestPubsub
TestPubsub 2021-03-12T09:09:11Z retry.go:91: terraform [init -upgrade=false]
TestPubsub 2021-03-12T09:09:11Z logger.go:66: Running command terraform with args [init -upgrade=false]
.
.
.
TestPubsub 2021-03-12T09:10:11Z logger.go:66: module.pubsub.google_project_service.pubsub: Destruction complete after 0s
TestPubsub 2021-03-12T09:10:11Z logger.go:66:
TestPubsub 2021-03-12T09:10:11Z logger.go:66: Destroy complete! Resources: 8 destroyed.
--- PASS: TestPubsub (60.08s)
PASS
ok      dataflow-sample-applications/retail/retail-java-applications/terraform/test     60.090s
```
Congratulations! Your test passed successfully!

