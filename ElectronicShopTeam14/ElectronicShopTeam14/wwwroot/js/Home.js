function validateLoginForm() {
    var email = document.getElementById("signinEmail").value;
    var password = document.getElementById("signinPassword").value;

    if (!email.includes("@") || email.length < 5) {
        alert("Email không hợp lệ. Vui lòng nhập địa chỉ email hợp lệ.");
        return false;
    }

    if (password.length < 8 || !/[A-Z]/.test(password)) {
        alert("Mật khẩu phải có ít nhất 8 ký tự và chứa ít nhất một chữ cái in hoa.");
        return false;
    }

    return true;
}

function validateSignupForm() {
    var email = document.getElementById("signupEmail").value;
    var password = document.getElementById("signupPassword").value;
    var confirmPassword = document.getElementById("signupConfirmPassword").value;
    var phone = document.getElementById("signupPhone").value;

    if (!email.includes("@") || email.length < 5) {
        alert("Email không hợp lệ. Vui lòng nhập địa chỉ email hợp lệ.");
        return false;
    }

    if (password.length < 8 || !/[A-Z]/.test(password)) {
        alert("Mật khẩu phải có ít nhất 8 ký tự và chứa ít nhất một chữ cái in hoa.");
        return false;
    }

    if (password !== confirmPassword) {
        alert("Mật khẩu xác nhận không trùng khớp.");
        return false;
    }

    if (!phone.startsWith("0") || phone.length !== 10) {
        alert("Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 số.");
        return false;
    }

    return true;
}
