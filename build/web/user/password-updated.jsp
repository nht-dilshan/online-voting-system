<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Password Updated</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="h-screen flex bg-gray-100 font-sans">

  <!-- Sidebar -->
  <div class="bg-white shadow-lg h-full w-64 fixed flex flex-col">
    <div class="p-6">
        <a href="../index.jsp" class="font-bold text-lg text-emerald-500">VoteStream</a>
    </div>
    <nav class="mt-6 flex-grow">
      <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
          <a href="user_dash.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
          <span class="ml-3">Home</span>
        </a>
      </div>
      <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
          <a href="poll.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
          <span class="ml-3">Poll</span>
        </a>
      </div>
      <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
          <a href="result.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
          <span class="ml-3">Results</span>
        </a>
      </div>
      <div class="px-6 py-3 bg-gray-300 cursor-pointer">
          <a href="profile.jsp" class="flex items-center text-gray-700">
          <span class="ml-3">Profile</span>
        </a>
      </div>
      <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
          <a href="userAbout.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
          <span class="ml-3">About Us</span>
        </a>
      </div>
      <div class="px-6 py-3 mt-auto cursor-pointer">
        <form action="../logout.jsp" method="post">
          <button type="submit" class="w-full bg-red-500 text-white py-2 rounded hover:bg-red-600">Logout</button>
        </form>
      </div>
    </nav>
  </div>

  <!-- Main Content -->
  <div class="ml-64 flex-grow overflow-auto p-6">
    <div class="container mx-auto h-full">
      <!-- Page Title -->
      <h1 class="text-2xl font-bold mb-6 text-gray-800">Password Updated</h1>

      <!-- Confirmation Message -->
      <div class="bg-white shadow-md rounded-lg p-8">
        <p class="text-gray-700 text-lg mb-4">Your password has been successfully updated.</p>
        <a href="profile.jsp" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600">Back to Profile</a>
      </div>
    </div>
  </div>
</body>
</html>