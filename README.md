#### install terraform package like npm init

`~/terraform init`

#### to view terraform execution steps with environment parameter file

`~/terraform plan --var-file=poc.tfvars`

#### for applying changes to the cloud

`~/terraform apply --var-file=poc.tfvars`

## terraform script notes
Terraform considers file extensions _(.tf)_, not file names when running its "apply" and "plan" commands
so, the extension of the variable file of the stage is different _(.tfvar)_

Terraform executes contents of _.tf_ files without any hierarchy.
so The commands (resource, module, data, provider, variable, output, etc.) in the _.tf_ files in the same folder determine the execution hierarchy

##### lambda execution error
https://github.com/aws/serverless-application-model/issues/59

!worked Authentication function when test on SampleApi at another region 

#### Authorizer function error 
https://forums.aws.amazon.com/thread.jspa?threadID=289351
should be ttl = 0 
`CloudWatch log == The client is not authorized to perform this operation.`


### stage depends_on all module 
that is big problem!!

### list sample
- [ ] unchecked item
- [x] checked item
- normal list item
    - sub list item


