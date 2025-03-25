// Kết nối SignalR
var connection = new signalR.HubConnectionBuilder()
    .withUrl("/notificationHub")
    .build();

connection.start()
    .then(() => console.log("SignalR Connected!"))
    .catch(err => console.error("SignalR Connection Error: ", err));

// Gửi thông báo từ trang Notification.cshtml
function sendNotification() {
    var message = document.getElementById("notificationInput").value;
    connection.invoke("SendNotification", message).catch(err => console.error(err));
}

// Nhận thông báo và hiển thị trên trang Index.cshtml
connection.on("ReceiveNotification", function (message) {
    var container = document.getElementById("notificationContainer");
    container.innerHTML = message;
    container.style.left = "100%";
    animateNotification();
});

// Tạo hiệu ứng chạy ngang
function animateNotification() {
    var container = document.getElementById("notificationContainer");
    var position = window.innerWidth;

    function step() {
        position -= 2;
        container.style.left = position + "px";

        //if (position + container.offsetWidth > 0) {
        //    requestAnimationFrame(step);
        //} else {
        //    container.style.left = "100%";
        //    requestAnimationFrame(step);
        //}

        // Nếu dòng chữ hoàn toàn đi khỏi màn hình bên trái, đặt lại vị trí bên phải
        if (position + container.offsetWidth < 0) {
            position = window.innerWidth;
        }
        requestAnimationFrame(step);
    }

    requestAnimationFrame(step);
}
