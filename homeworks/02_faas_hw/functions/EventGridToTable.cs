// Default URL for triggering event grid function in the local environment.
// http://localhost:7071/runtime/webhooks/EventGrid?functionName={functionname}
using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.EventGrid;
using Microsoft.Extensions.Logging;
using Azure.Messaging.EventGrid;
using Azure.Data.Tables;
using Newtonsoft.Json;
using Azure;
using System.Threading.Tasks;

namespace CloudComputing.Fass02
{
    public static class EventGridToTable
    {
        [FunctionName("EventGridToTable")]
        public static async Task Run([EventGridTrigger]EventGridEvent eventGridEvent, ILogger log)
        {
            log.LogInformation("Start adding new message to table.");

            var message = JsonConvert.DeserializeObject<Message>(eventGridEvent.Data.ToString());

            log.LogInformation($"New Message { message }.");

            var connectionString = Environment.GetEnvironmentVariable("STORAGE_ACCOUNT_MESSAGES_TABLE_CONNECTION_STRING");
            var tableName = Environment.GetEnvironmentVariable("MESSAGES_TABLE_NAME");

            await ResiliencePolicyBuilder.ResiliencePolicy.ExecuteAsync(async () => 
            {
                TableClient tableClient = new TableClient(connectionString, tableName);
                var messageEntity = new TableEntity(eventGridEvent.Subject, message.Id);
                messageEntity.Add("text", message.Text);
                var addEntityResult = await tableClient.AddEntityAsync<TableEntity>(messageEntity);
                return addEntityResult;
            });

            log.LogInformation($"Successfully added message { message }.");
        }
    }
}
