using System;
using Azure;
using Polly;
using Polly.Timeout;

namespace CloudComputing.Fass02
{
    public static class ResiliencePolicyBuilder
    {
        public static IAsyncPolicy<Response> ResiliencePolicy => Policy.WrapAsync(RetryPolicy, CircuitBreakerPolicy(4, TimeSpan.FromSeconds(30)), TimeoutPolicy(2));

        public static IAsyncPolicy<Response> RetryPolicy
        {
            get
            {
                return Policy.HandleResult<Response>(r => r.IsError)
                    .Or<Exception>()
                    .WaitAndRetryForeverAsync((retryAttempt, context) => TimeSpan.FromSeconds(Math.Pow(2, retryAttempt)));
            }
        }

        public static IAsyncPolicy<Response> CircuitBreakerPolicy(int handledEventsAllowedBeforeBreaking, TimeSpan durationOfBreak) => Policy.HandleResult<Response>(r => r.IsError)
                    .Or<Exception>()
                    .CircuitBreakerAsync(handledEventsAllowedBeforeBreaking, durationOfBreak);

        public static IAsyncPolicy<Response> TimeoutPolicy(int seconds) => Policy.TimeoutAsync<Response>(seconds, TimeoutStrategy.Pessimistic);
    }
}