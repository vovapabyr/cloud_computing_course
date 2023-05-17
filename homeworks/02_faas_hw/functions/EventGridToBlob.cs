// http://localhost:7071/runtime/webhooks/EventGrid?functionName={functionname}
using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.EventGrid;
using Microsoft.Extensions.Logging;
using Azure.Messaging.EventGrid;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Specialized;

namespace CloudComputing.Fass02
{
    public static class EventGridToBlob
    {
        [FunctionName("EventGridToBlob")]
        public static async Task Run([EventGridTrigger]EventGridEvent eventGridEvent, ILogger log)
        {
            log.LogInformation("Start adding new message to container.");

            var messageAsJson = eventGridEvent.Data.ToString();
            var message = JsonConvert.DeserializeObject<Message>(messageAsJson);

            log.LogInformation($"New Message { message }.");

            var connectionString = Environment.GetEnvironmentVariable("STORAGE_ACCOUNT_MESSAGES_TABLE_CONNECTION_STRING");
            var containerName = Environment.GetEnvironmentVariable("MESSAGES_CONTAINER_NAME");

            await ResiliencePolicyBuilder.ResiliencePolicy.ExecuteAsync(async () => 
            {
                BlobContainerClient containerClient = new BlobContainerClient(connectionString, containerName);
                var blobClient = containerClient.GetBlobClient($"{message.Id}.json");
                var uploadBlobResult = await blobClient.UploadAsync(eventGridEvent.Data);
                return uploadBlobResult.GetRawResponse();
            });

            log.LogInformation($"Successfully added message { message }.");
        }
    }
}
