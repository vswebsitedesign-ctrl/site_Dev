<?php
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: /contact/');
    exit;
}

$first_name = trim($_POST['first_name'] ?? '');
$surname    = trim($_POST['surname'] ?? '');
$phone      = trim($_POST['phone'] ?? '');
$postcode   = trim($_POST['postcode'] ?? '');
$services   = isset($_POST['service']) ? (array)$_POST['service'] : [];
$message    = trim($_POST['message'] ?? '');

if (!$first_name || !$phone || !$postcode) {
    header('Location: /contact/?error=missing');
    exit;
}

$to      = 'info@clearances-in-devon.co.uk';
$subject = 'New Enquiry from ' . $first_name . ' ' . $surname;
$body    = "First Name: $first_name\n";
$body   .= "Surname: $surname\n";
$body   .= "Phone: $phone\n";
$body   .= "Postcode: $postcode\n";
$body   .= "Services: " . implode(', ', $services) . "\n";
$body   .= "Message: $message\n";

$headers = 'From: noreply@clearances-in-devon.co.uk' . "\r\n" .
           'Reply-To: ' . $first_name . ' <' . $phone . '>' . "\r\n";

if (mail($to, $subject, $body, $headers)) {
    header('Location: /thank-you/');
} else {
    header('Location: /contact/?error=send');
}
exit;
