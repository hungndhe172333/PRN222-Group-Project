using System.Threading.Tasks;

namespace ElectronicShopTeam14.Services
{
    public interface IEmailService
    {
        Task SendEmailAsync(string email, string subject, string message);
    }
}
