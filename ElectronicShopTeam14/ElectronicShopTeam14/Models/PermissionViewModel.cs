namespace ElectronicShopTeam14.Models
{
    public class PermissionViewModel
    {
        public long UserId { get; set; }
        public string UserEmail { get; set; }
        public bool IsAdmin { get; set; }
        public bool IsStoreStaff { get; set; }
    }
}
