# Instructions and results
Run chekov in docker to check policies of [03_terraform_faas_hw](../03_terraform_faas_hw/) project: ```docker run --volume ~/documents/cloud-computing-course/homeworks/03_terraform_faas_hw:/tf bridgecrew/checkov:2.3.199 --quiet --compact --directory /tf```. On the picture below you could see a number of falied checks:
![first-policy-check](https://github.com/vovapabyr/cloud_computing_course/assets/25819135/87f724d0-fca1-48e0-81dd-d05a2092ea7b)
- fix ```CKV_AZURE_193``` failed check with setting ```public_network_access_enabled``` to ```false``` in [events.tf](../03_terraform_faas_hw/modules/main/events.tf) file and observe that the check passes:
![events-policy-fixed-tf](https://github.com/vovapabyr/cloud_computing_course/assets/25819135/bdfe9938-553d-48a9-8695-2078e85055d8)
![events-policy-fixed-result](https://github.com/vovapabyr/cloud_computing_course/assets/25819135/19be3fe6-c00b-4024-97f3-2d9139a183a1)
- fix ```CKV_AZURE_44``` failed check with setting ```min_tls_version``` to ```TLS1_2``` in [function.tf](../03_terraform_faas_hw/modules/main/function.tf) file and observe that the check passes:
![storage-account-policy-fixed-tf](https://github.com/vovapabyr/cloud_computing_course/assets/25819135/2985a1e6-6a46-43c7-a924-cf91bf094570)
![storage-account-policy-fixed-result](https://github.com/vovapabyr/cloud_computing_course/assets/25819135/cf7e3a58-d245-41fa-802a-2a1f7c1a38b7)
