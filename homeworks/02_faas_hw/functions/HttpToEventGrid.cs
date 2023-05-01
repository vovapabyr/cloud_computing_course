using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Azure;
using Azure.Messaging.EventGrid;

namespace CloudComputing.Fass02
{
    public static class HttpToEventGrid
    {
        [FunctionName("HttpToEventGrid")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("Start processing of new message.");

            var messageAsStr = await req.ReadAsStringAsync();
            var message = JsonConvert.DeserializeObject<Message>(messageAsStr);

            log.LogInformation($"New Message { message }.");

            var topicEndpoint = Environment.GetEnvironmentVariable("EVENT_GRID_TOPIC_ENDPOINT");
            var topicKey = Environment.GetEnvironmentVariable("EVENT_GRID_TOPIC_KEY");

            await ResiliencePolicyBuilder.ResiliencePolicy.ExecuteAsync(async () => 
            {
                EventGridPublisherClient client = new EventGridPublisherClient(new Uri(topicEndpoint), new AzureKeyCredential(topicKey));
                EventGridEvent newMessageEvent = new EventGridEvent("HTTP_Messages", "New_Message", "1.0", message);

                // Send the event
                return await client.SendEventAsync(newMessageEvent);               
            });

            log.LogInformation($"Successfully processed message { message }.");

            return new CreatedResult(message.Id, message);
        }
    }
}
