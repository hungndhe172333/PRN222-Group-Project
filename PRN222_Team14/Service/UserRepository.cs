using ElectronicShopTeam14.Models;
using System.Security.Cryptography;
using System.Text;

namespace ElectronicShopTeam14.Services
{
    public class UserRepository : IUserRepository
    {
        private readonly ElectronicShopContext _context;
        private readonly Dictionary<string, (string token, DateTime expiry)> _passwordResetTokens;


        public UserRepository(ElectronicShopContext context)
        {
            _context = context;
            _passwordResetTokens = new Dictionary<string, (string, DateTime)>();
        }

        public User? GetUserByEmail(string email)
        {
            return _context.Users.FirstOrDefault(u => u.UserEmail == email);
        }

        public void AddUser(User user)
        {
            if (user == null)
                throw new ArgumentNullException(nameof(user));

            // Ensure user email is unique
            if (_context.Users.Any(u => u.UserEmail == user.UserEmail))
                throw new InvalidOperationException("Email đã tồn tại trong hệ thống.");

            // Set default values if not provided
            user.IsAdmin ??= "False";
            user.IsStoreStaff ??= "False";
            user.Banned ??= false;

            _context.Users.Add(user);
            _context.SaveChanges();
        }

        public bool ValidatePassword(string inputPassword, string storedPassword)
        {
            // Hash the input password and compare with stored hash
            string hashedInput = HashPassword(inputPassword);
            return hashedInput == storedPassword;
        }

        public string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                // Convert the password string to a byte array
                byte[] passwordBytes = Encoding.UTF8.GetBytes(password);

                // Compute the hash
                byte[] hashBytes = sha256.ComputeHash(passwordBytes);

                // Convert the hash bytes to a string
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < hashBytes.Length; i++)
                {
                    builder.Append(hashBytes[i].ToString("x2")); // Convert to hexadecimal
                }

                return builder.ToString();
            }
        }


        public void UpdatePassword(string email, string newPassword)
        {
            var user = GetUserByEmail(email);
            if (user != null)
            {
                user.UserPass = newPassword;
                _context.SaveChanges();
            }
        }

        public string GeneratePasswordResetToken(string email)
        {
            var token = Convert.ToBase64String(Guid.NewGuid().ToByteArray());
            _passwordResetTokens[email] = (token, DateTime.UtcNow.AddHours(24));
            return token;
        }

        public bool ValidatePasswordResetToken(string email, string token)
        {
            if (_passwordResetTokens.TryGetValue(email, out var tokenInfo))
            {
                if (tokenInfo.token == token && tokenInfo.expiry > DateTime.UtcNow)
                {
                    _passwordResetTokens.Remove(email); // Remove token after use
                    return true;
                }
            }
            return false;
        }

        public User GetUserById(long userId)
        {
            return _context.Users.FirstOrDefault(u => u.UserId == userId);
        }

        public void UpdateUser(User user)
        {
            _context.Users.Update(user);
            _context.SaveChanges();
        }
    }
}


    