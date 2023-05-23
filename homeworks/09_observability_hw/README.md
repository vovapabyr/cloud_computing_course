# Results
## Same request functions logs
In order to track logs from all functions in one place, a dedicated Log Analytic Workspace was created ([link to terraform](../03_terraform_faas_hw/modules/main/log.tf)). Then diagnostic setting of Function App was created which links logs of the function to Log Analytic Workspace mentioned above ([link to terraform](../03_terraform_faas_hw/modules/main/function.tf) - check the end of the file). After sending some http requests we can now track same request logs of all three functions with the help of the next query:
```
FunctionAppLogs
| project FunctionName, FunctionInvocationId, Message, TimeGenerated 
| where Message contains "a0934d3b-1067-448d-a7b5-7fce5435ced3"
| order by TimeGenerated asc
```
## Event Grid Topic metrics
On the custom 'Events Dashboard' below you could see:
 - first row shows number of successfully published and delivered events. Next to it number of failed published and delivred events. We have published 11 messages, that's why you can see 11 succesfully published messages and twice more (22) successfully delivred messages, as we deliver one message to table and blob
 - second row display more thorough metrics on each subscription. First one display event-to-table subscription, another one event-to-blob.

## Functions performance
As you can see on the image below: the avg time of 'EventGridToTable' function execution is 201ms, while 'EventGridToBlob' is 124ms:
   
