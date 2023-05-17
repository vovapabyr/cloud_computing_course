# How to run
 - Provision all resources except event grid subscription ```terraform apply -target="module.main"```
  ![terraform-apply-main-module](https://github.com/vovapabyr/cloud_computing_course/assets/25819135/d20428dc-15cf-4218-b9ad-f4d15f843f62)
 - Deploy functions from [02_faas_hw](../02_faas_hw)
 - Deploy susbscription and related changes to the function ```terraform plan -target="module.subscription"```. This will delete the functions, deployed from the previous step, but will create the event grid topic subscription 
  ![terraform-apply-subscription-module](https://github.com/vovapabyr/cloud_computing_course/assets/25819135/6079de79-612c-4299-900c-d3e745b2fdbc)
 - Deploy functions from [02_faas_hw](../02_faas_hw) again
 - Trigger http function ```curl -i -X POST https://cloudplatformshw-func.azurewebsites.net/api/HttpToEventGrid?code= -H 'Content-Type: application/json' -d '{"text":"msg1"}```
   ![test-pipeline](https://github.com/vovapabyr/cloud_computing_course/assets/25819135/61a19f6b-5120-449f-8df3-a34f41f457b7)

