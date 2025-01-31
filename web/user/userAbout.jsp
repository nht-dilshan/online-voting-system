<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Us</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">
    <style>
        .logo-font {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="flex flex-col md:flex-row h-screen bg-gray-100">
    
  <!-- Sidebar -->
    <div class="bg-white shadow-lg h-full w-full md:w-64 fixed md:relative flex flex-col">
       <div class="p-6 border-b border-gray-100">
            <a href="../index.jsp" class="logo-font inline-block">
                <span class="font-bold text-2xl bg-gradient-to-r from-emerald-500 to-emerald-700 bg-clip-text text-transparent hover:from-emerald-600 hover:to-emerald-800 transition-all duration-300 transform hover:scale-105">
                    Vote<span class="text-emerald-500">Stream</span>
                </span>
            </a>
        </div>
        <nav class="mt-6 flex-grow">
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="user_dash.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Home</span>
                </a>
            </div>
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="votingArea.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Voting Area</span>
                </a>
            </div>
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="result.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Results</span>
                </a>
            </div>
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="profile.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Profile</span>
                </a>
            </div>
            <div class="px-6 py-3 bg-gray-300 cursor-pointer">
                <a href="userAbout.jsp" class="flex items-center text-gray-700">
                    <span class="ml-3">About Us</span>
                </a>
            </div>
            <div class="px-6 py-3 mt-auto cursor-pointer">
                <form action="logout.jsp" method="post">
                    <button type="submit" class="w-full bg-red-500 text-white py-2 rounded hover:bg-red-600">Logout</button>
                </form>
            </div>
        </nav>
    </div>

  <!-- Main Content -->
  <div class="w-full flex flex-col items-center p-4 md:p-8 justify-center h-full"> <!-- Added ml-64 to offset sidebar width -->

    <div class="w-full max-w-6xl mx-auto p-6 bg-white rounded-lg shadow-lg h-full overflow-auto">
        <!-- Page Title -->
        <h1 class="text-3xl font-bold mb-6 text-gray-800 text-center">About Us</h1>
        
        <!-- Content Section -->
        <div class="bg-white shadow-md rounded-lg p-8 mb-8">
          <p class="text-lg text-gray-700 leading-relaxed mb-4">
            Welcome to <span class="font-bold text-green-500">VoteStream</span> — your one-stop platform for monitoring and understanding the 2023 election results with clarity and ease. Our mission is to provide real-time data and insights that empower citizens to make informed decisions.
          </p>
          
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Our Vision</h2>
          <p class="text-gray-700 leading-relaxed mb-6">
            At VoteStream, we envision a world where transparency in electoral processes strengthens democracy and builds trust between governments and citizens.
          </p>
          
          <h2 class="text-xl font-semibold text-gray-800 mb-4">What We Do</h2>
          <p class="text-gray-700 leading-relaxed mb-6">
            We provide a user-friendly platform for:
            <ul class="list-disc list-inside mt-3 space-y-2">
              <li>Monitoring registered voters and political parties.</li>
              <li>Displaying real-time election results.</li>
              <li>Ensuring accuracy and reliability of electoral data.</li>
              <li>Promoting transparency and accountability in governance.</li>
            </ul>
          </p>
          
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Meet the Team</h2>
          <p class="text-gray-700 leading-relaxed">
            Our team is made up of dedicated developers, data analysts, and designers working tirelessly to ensure that our platform meets the needs of every user. We believe in the power of collaboration and are committed to providing a seamless experience.
          </p>
        </div>
  
        <!-- Contact Section -->
        <div class="bg-gray-50 shadow-md rounded-lg p-8">
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Contact Us</h2>
          <p class="text-gray-700 mb-4">
            Have questions or suggestions? Feel free to reach out to us:
          </p>
          <div class="space-y-2">
            <p><span class="font-medium">Email:</span> support@VoteStream.com</p>
            <p><span class="font-medium">Phone:</span> +234 800 123 4567</p>
            <p><span class="font-medium">Address:</span> 123 Election Ave, Abuja, Nigeria</p>
          </div>
        </div>
      </div>

  </div>

</body>
</html>
