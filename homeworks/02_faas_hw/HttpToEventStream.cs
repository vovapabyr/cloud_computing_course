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
    public static class HttpToEventStream
    {
        [FunctionName("HttpToEventStream")]
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

            await EnsureSendMessageToEventGridTopicAsync(message, topicEndpoint, topicKey, log);

            log.LogInformation($"Successfully processed message { message }.");

            return new CreatedResult(message.Id, message);
        }

        static async Task EnsureSendMessageToEventGridTopicAsync(Message message, string tokenEndpoint, string topicKey, ILogger log)
        {
            try
            {
                EventGridPublisherClient client = new EventGridPublisherClient(new Uri(tokenEndpoint), new AzureKeyCredential(topicKey));
                EventGridEvent newMessageEvent = new EventGridEvent("HTTP_Messages", "New_Message", "1.0", message);

                // Send the event
                var response = await client.SendEventAsync(newMessageEvent);
                log.LogInformation($"Event Grid Response Status Code: { response.Status }");
                if (response.IsError)
                    await EnsureSendMessageToEventGridTopicAsync(message, tokenEndpoint, topicKey, log);
            }
            catch (Exception ex)
            {
                log.LogError(ex, $"Failed to send {message} to event grid");
                await EnsureSendMessageToEventGridTopicAsync(message, tokenEndpoint, topicKey, log);
            }
        } 
    }
}
