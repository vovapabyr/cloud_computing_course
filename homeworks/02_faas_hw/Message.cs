using System;

namespace CloudComputing.Fass02
{
    public class Message
    {
        public string Id {get; set;} = Guid.NewGuid().ToString();

        public string Text {get; set;}

        public override string ToString()
        {
            return $"{Id}: {Text}";
        }
    }
}