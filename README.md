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
