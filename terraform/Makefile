
ENV_VARS_DIR := env-vars
ENV := local


.PHONY tf_init:
tf_init:
	terraform init 

.PHONY tf_format:
tf_format:
	terraform fmt -recursive

.PHONY tf_validate:
tf_validate:
	terraform validate

.PHONY tf_plan:
tf_plan:
	terraform plan -var-file=$(ENV_VARS_DIR)/$(ENV).tfvars

.PHONY tf_apply:
tf_apply:
	terraform apply -var-file=$(ENV_VARS_DIR)/$(ENV).tfvars

## Speculative destroy (Wont destroy anything, just show what will be destroyed)
.PHONY tf_destroy:
	terraform plan -destroy -var-file=$(ENV_VARS_DIR)/$(ENV).tfvars
