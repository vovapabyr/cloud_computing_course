# Instructions and results
Run chekov in docker to check policies of [03_terraform_faas_hw](../03_terraform_faas_hw/) project: ```docker run --volume ~/documents/cloud-computing-course/homeworks/03_terraform_faas_hw:/tf bridgecrew/checkov:2.3.199 --quiet --compact --directory /tf```. On the picture below you could see a number of falied checks:

- fix ```CKV_AZURE_193``` failed check with setting ```public_network_access_enabled``` to ```false``` in [events.tf](../03_terraform_faas_hw/modules/main/events.tf) file and observe that the check passes:

- fix ```CKV_AZURE_44``` failed check with setting ```min_tls_version``` to ```TLS1_2``` in [function.tf](../03_terraform_faas_hw/modules/main/function.tf) file and observe that the check passes:
