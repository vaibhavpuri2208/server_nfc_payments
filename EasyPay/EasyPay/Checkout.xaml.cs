using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;
using Microsoft.Phone.Controls;
using Microsoft.Phone.Shell;
using Windows.Networking.Proximity;
using System.IO;
using System.Text;
using Windows.Storage.Streams;

namespace EasyPay
{
    public partial class Checkout : PhoneApplicationPage
    {
        public Checkout()
        {
            InitializeComponent();
        }

        ProximityDevice device;

        protected override void OnNavigatedTo(System.Windows.Navigation.NavigationEventArgs e)
        {
            base.OnNavigatedTo(e);

            string beers = "";

            if (NavigationContext.QueryString.TryGetValue("beers", out beers))
            {

                beersTextBox.Text = beers;
            }

            System.Diagnostics.Debug.WriteLine("initializing");

            device = ProximityDevice.GetDefault();

            long subscribedMessageId = device.SubscribeForMessage("NDEF", messageReceivedHandler);
        }


        string boundary = "----------" + DateTime.Now.Ticks.ToString();
        void messageReceivedHandler(ProximityDevice device, ProximityMessage message)
        {
            var data = DataReader.FromBuffer(message.Data);

            //uint bla = 1;
            //data.InputStreamOptions.
            data.UnicodeEncoding = Windows.Storage.Streams.UnicodeEncoding.Utf8;
            
            //System.Diagnostics.Debug.WriteLine("data"+data.ReadString(bla));
            //MessageBox.Show("URL received");

            HttpWebRequest poster = WebRequest.Create(new Uri("http://easypaytnw.herokuapp.com/reduce_credit")) as HttpWebRequest;
	        poster.Method = "POST";
            poster.ContentType = "application/x-www-form-urlencoded";

            poster.BeginGetRequestStream(new AsyncCallback(GetRequestStreamCallback), poster);
            // Write message parsing code here...  
        }

        private void GetRequestStreamCallback(IAsyncResult asynchronousResult) {
            HttpWebRequest request = (HttpWebRequest)asynchronousResult.AsyncState;
	        Stream postStream = request.EndGetRequestStream(asynchronousResult);
            //byte[] postData = Encoding.UTF8.GetBytes("user=1&credit=10");
            //request.ContentLength = postData.Length;
	
	        //write boundries and section headers
	        StreamWriter writer = new StreamWriter(postStream);
            Dispatcher.BeginInvoke(delegate {
                writer.Write("customer_id=1&amount=" + beersTextBox.Text);
                writer.Flush();


                //postStream.Write(postData, 0, postData.Length);
                postStream.Flush();
                postStream.Close();

                request.BeginGetResponse(new AsyncCallback(GetResponseCallback), request);
            });
        }
        
        private void GetResponseCallback(IAsyncResult asynchronousResult)
	        {
	            HttpWebRequest request = (HttpWebRequest)asynchronousResult.AsyncState;
	            HttpWebResponse response = (HttpWebResponse)request.EndGetResponse(asynchronousResult);
	            Stream streamResponse = response.GetResponseStream();
	            StreamReader streamRead = new StreamReader(streamResponse);
	            string responseString = streamRead.ReadToEnd();
	            // Close the stream object
	            streamResponse.Close();
	            streamRead.Close();
	            // Release the HttpWebResponse
	            response.Close();

                Dispatcher.BeginInvoke(delegate
                {
                    NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
                });
	        }

       
    }
}