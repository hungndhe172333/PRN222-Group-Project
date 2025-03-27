namespace ElectronicShopTeam14.Models
{
    public class BillViewModel
    {
        public string OrderId { get; set; }
        public DateTime Date { get; set; }
        public string CustomerName { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public decimal Total { get; set; }
        public string Payment { get; set; }
        public string PaymentStatus { get; set; }
        public string OrderStatus { get; set; }
        public int ItemCount { get; set; }
        public string DeliveryNumber { get; set; }
        public string Priority { get; set; }

        public static string GetOrderStatusClass(string status)
        {
            return status.ToLower() switch
            {
                "completed" => "border-success text-success",
                "packaging" => "border-warning text-warning",
                "canceled" => "border-danger text-danger",
                _ => "border-secondary text-secondary"
            };
        }
    }

}
