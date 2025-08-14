using ElectronicShopTeam14.Models;

namespace ElectronicShopTeam14.Services
{
    public interface IUserRepository
    {
        User? GetUserByEmail(string email);

        bool ValidatePassword(string inputPassword, string storedPassword);
        void AddUser(User user);
        //string HashPassword(string password);
        void UpdatePassword(string email, string newPassword);
        string GeneratePasswordResetToken(string email);
        bool ValidatePasswordResetToken(string email, string token);
        User GetUserById(long userId);
        void UpdateUser(User user);
    }
}