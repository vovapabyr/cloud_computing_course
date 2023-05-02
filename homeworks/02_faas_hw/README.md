# Results
## General
Basic resilience policy (Retry + Circuit Breaker + Timeout) is implemented to ensure message delivery through the pipeline. Check [policy builder](ResiliencePolicyBuilder.cs) to see resilience polciy configurations.

## Send new message curl request example
```
curl -i -X POST https://02-faas.azurewebsites.net/api/HttpToEventGrid?code= -H 'Content-Type: application/json' -d '{"text":"msg1"}
```
## New message id tracking through the pipeline
### Http to Event Grid function log
![htpp-to-event-grid-message-id](https://user-images.githubusercontent.com/25819135/235652470-c38ab072-9108-4f88-9a3d-193d92a7355d.PNG)
### Event Grid to Table function log
![event-grid-to-table-message-id](https://user-images.githubusercontent.com/25819135/235652497-40f9139a-67cf-4b3d-ba91-5074839fe142.PNG)
### Table record
![storage-account-table-message-id](https://user-images.githubusercontent.com/25819135/235652542-3cb32e6f-e2f9-4602-8f42-ac78ced4a2dd.PNG)

## Http to Event Grid function unauthorized call without function code
![unauthorized_function_call](https://user-images.githubusercontent.com/25819135/235611323-f83a5eb9-b0b8-4b8d-a56c-74ead1b6bcc9.PNG)

## Http to Event Grid function authorized call with code
![authorized_function_call](https://user-images.githubusercontent.com/25819135/235611454-f6a83053-5385-45d3-a5fd-3a81e9fbbd9d.PNG)

## All Azure portal resources
![image](https://user-images.githubusercontent.com/25819135/235608331-515c56eb-c897-411d-aef1-5b1c638aeb41.png)

