using Microsoft.Extensions.Configuration;
using System;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace ElectronicShopTeam14.Services
{
    public class EmailService : IEmailService
    {
        private readonly string _smtpServer;
        private readonly int _port;
        private readonly string _username;
        private readonly string _password;
        private readonly string _fromEmail;

        public EmailService(IConfiguration configuration)
        {
            _smtpServer = configuration["EmailSettings:SmtpServer"];
            _port = int.Parse(configuration["EmailSettings:Port"]);
            _username = configuration["EmailSettings:Username"];
            _password = configuration["EmailSettings:Password"];
            _fromEmail = configuration["EmailSettings:FromEmail"];
        }

        public async Task SendEmailAsync(string toEmail, string subject, string message)
        {
            try
            {
                using (var client = new SmtpClient())
                {
                    var credential = new NetworkCredential
                    {
                        UserName = _username,
                        Password = _password
                    };

                    client.Credentials = credential;
                    client.Host = _smtpServer;
                    client.Port = _port;
                    client.EnableSsl = true;
                    client.UseDefaultCredentials = false;

                    using (var emailMessage = new MailMessage())
                    {
                        emailMessage.To.Add(new MailAddress(toEmail));
                        emailMessage.From = new MailAddress(_fromEmail);
                        emailMessage.Subject = subject;
                        emailMessage.Body = message;
                        emailMessage.IsBodyHtml = true;

                        await client.SendMailAsync(emailMessage);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Failed to send email: {ex.Message}", ex);
            }
        }

    }
}
