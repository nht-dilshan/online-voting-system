<%-- 
    Document   : index
    Created on : Jan 6, 2025, 11:35:57 PM
    Author     : NHT-Dilshan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VoteStream
        </title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                background: linear-gradient(to bottom right, #055f4d, #2f3e46);
                color: #f8f9fa;
            }
            .hero h1 span {
                color: #28a745;
            }
            .hero a.btn-success {
                transition: transform 0.2s ease, background-color 0.2s ease;
            }
            .hero a.btn-success:hover {
                background-color: #218838;
                transform: scale(1.05);
            }

        </style>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark p-3 mt-3 mx-3 rounded">
            <div class="container-fluid">
                <a href="index.jsp" class="navbar-brand"> VoteStream  </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="navbar-nav me-auto mb-2 mb-lg-0 px-2">
                            <a class="nav-link" href="index.jsp">Home</a>
                        </li>
                        <li class="navbar-nav me-auto mb-2 mb-lg-0 px-2">
                            <a class="nav-link" href="about_us.jsp">About</a>
                        </li>
                        <li class="navbar-nav me-auto mb-2 mb-lg-0 px-2">
                            <a class="nav-link" href="contact_us.jsp">Contact</a>
                        </li>
                        <li class="navbar-nav me-auto mb-2 mb-lg-0 px-2">
                            <a class="btn btn-success" href="sign_in.jsp">Sign In</a>
                        </li>
                        <li class="navbar-nav me-auto mb-2 mb-lg-0">
                            <a class="btn btn-success" href="sign_up.jsp">Sign Up</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <div style="display: flex; justify-content: center; align-items: center; height: 90vh; background: url('path/to/your/background.jpg') no-repeat center center fixed; background-size: cover;">
            <div class="container p-5 text-center hero">
                <h1 class="font-weight-bold">
                    Unlock the power of your vote with <span>VOTESTREAM</span>
                </h1>
                <p class="mt-4 fs-5 text-light">
                    Welcome to our innovative voting platform, where your voice becomes the catalyst for change.<br> 
                    Join us on a transformative journey, empowering you to shape the future you desire.
                </p>
                <div class="mt-4">
                    <a href="sign_in.jsp" class="btn btn-success btn-lg">Get Started</a>
                </div>
            </div>
        </div>
    </body>
</html>
