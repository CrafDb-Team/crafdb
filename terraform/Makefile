
ENV_VARS_DIR := env-vars
ENV := local
DB_USER:= placeholder
DB_ID := placeholder
DB_PW := placeholder

.PHONY tf_setup:
# use the tf_init, tf_format, tf_validate, tf_plan
tf_setup: tf_init tf_format tf_validate tf_plan

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
	terraform plan -var-file=$(ENV_VARS_DIR)/$(ENV).tfvars -var="username=$(DB_USER)" -var="password=$(DB_PW)" -var="rds_instance_identifier=$(DB_ID)"

.PHONY tf_apply:
tf_apply:
	terraform apply -auto-approve -var-file=$(ENV_VARS_DIR)/$(ENV).tfvars -var="username=$(DB_USER)" -var="password=$(DB_PW)" -var="rds_instance_identifier=$(DB_ID)"

## Speculative destroy (Wont destroy anything, just show what will be destroyed)
.PHONY tf_spec_destroy:
	terraform plan -destroy -var-file=$(ENV_VARS_DIR)/$(ENV).tfvars -var="username=$(DB_USER)" -var="password=$(DB_PW)" -var="rds_instance_identifier=$(DB_ID)"

.PHONY tf_destroy:
	terraform destroy -var-file=$(ENV_VARS_DIR)/$(ENV).tfvars -var="username=$(DB_USER)" -var="password=$(DB_PW)" -var="rds_instance_identifier=$(DB_ID)"
