# Automated Test For Terraform Modules

Use go and terratest to test the following modules.
- Pub/Sub

## Install Terraform and Go

If you are using the [Google Cloud Shell](https://cloud.google.com/shell/docs/how-cloud-shell-works), both Terraform and Go are installed.

Follow the instructions to install [Terraform cli](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/gcp-get-started) and [Go](https://golang.org/doc/install).

This repo has been tested on Terraform version `0.14.5`, Go version `1.16` and Google provider version `3.48.0`


## Edit Your Project ID

Please replace `[your-project-id]` in pubsub_test.go to your own project ID in order to pass the project ID value to terraform.

## Execute Automated Test
Change your directory to the test folder after cloning this repo.

`cd dataflow-sample-applications/retail/retail-java-applications/terraform/test`

Execute the test using go test command.

`go test -v`

You will see the following output. First time execution will also install Terratest described in the go.mod file.

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

