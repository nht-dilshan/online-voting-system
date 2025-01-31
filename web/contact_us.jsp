<%-- 
    Document   : contact_us
    Created on : Jan 7, 2025, 5:13:09 PM
    Author     : NHT-Dilshan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-emerald-800 to-gray-700 relative">
  <!-- Background diagonal stripes -->
  <div class="absolute inset-0 overflow-hidden">
    <div class="absolute top-0 right-0 w-1/2 h-full bg-emerald-700 transform skew-x-12"></div>
    <div class="absolute bottom-0 left-0 w-1/2 h-full bg-gray-600 transform -skew-x-12"></div>
  </div>

  <!-- Card Container -->
  <div class="relative w-full max-w-lg mx-4">
    <!-- Contact Card -->
    <div class="bg-white rounded-xl shadow-2xl p-8">
      <!-- Title -->
      <h1 class="text-emerald-500 text-4xl font-bold text-center mb-4">
        Contact Us
      </h1>

      <!-- Subtitle -->
      <p class="text-gray-500 text-center mb-6">
        We'd love to hear from you! Fill out the form below and we'll get back to you.
      </p>

      <!-- Form -->
      <form class="space-y-6" onsubmit="handleContactSubmit(event)">
        <!-- Full Name Field -->
        <div class="space-y-1">
          <label class="block text-gray-600 text-sm font-medium">
            Full Name
          </label>
          <input
            type="text"
            name="fullName"
            placeholder="Enter your full name"
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500"
            required
          />
        </div>

        <!-- Email Field -->
        <div class="space-y-1">
          <label class="block text-gray-600 text-sm font-medium">
            Email Address
          </label>
          <input
            type="email"
            name="email"
            placeholder="Enter your email"
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500"
            required
          />
        </div>

        <!-- Subject Field -->
        <div class="space-y-1">
          <label class="block text-gray-600 text-sm font-medium">
            Subject
          </label>
          <input
            type="text"
            name="subject"
            placeholder="Enter the subject"
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500"
          />
        </div>

        <!-- Message Field -->
        <div class="space-y-1">
          <label class="block text-gray-600 text-sm font-medium">
            Message
          </label>
          <textarea
            name="message"
            rows="4"
            placeholder="Type your message here..."
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500"
            required
          ></textarea>
        </div>

        <!-- Submit Button -->
        <button
          type="submit"
          class="w-full bg-emerald-500 text-white py-3 rounded-lg text-lg font-semibold hover:bg-emerald-600 transition-colors duration-300"
        >
          Send Message
        </button>
      </form>
    </div>
  </div>

  <script>
    function handleContactSubmit(event) {
      event.preventDefault();
      console.log('Contact form submitted');

    }
  </script>
</body>
</html>

