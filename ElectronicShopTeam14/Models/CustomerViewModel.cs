namespace ElectronicShopTeam14.Models
{
    public class CustomerViewModel
    {
        public long UserId { get; set; }
        public string UserName { get; set; }
        public string UserEmail { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
        public string DateOfBirth { get; set; }
        public string Status { get; set; }
        public string AdminReason { get; set; }
        public string IsAdmin { get; set; }
        public string IsStoreStaff { get; set; }
        public bool? Banned { get; set; }
    }
}

