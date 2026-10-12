<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Avantika Medical Store : Home Page</title>

    <link rel="stylesheet" href="homePage.css">
    <link rel="stylesheet" href="all.min.css">



    <script src="all.min.js"></script>

</head>

<body>

<div class="container">

     <%@ include file="header.jsp" %>

    <!-- Hero Section -->
    <section class="hero">

        <div class="hero-content">

            <h3>Your Health, Our Priority</h3>

            <h1>

                <span>AVANTIKA</span><br>

                MEDICAL STORE

            </h1>

            <p>

                Your trusted partner for quality medicines and healthcare products.

            </p>

            <div class="features">

                <div class="feature">

                    <div class="icon">

                        <img src="images/verification.png" alt="Verification">

                    </div>

                    <p>

                        100% Authentic<br>

                        Medicines

                    </p>

                </div>

                <div class="feature">

                    <div class="icon">
                     <img src="images/express.png" alt="express">
                     </div>

                    <p>

                        Fast & Secure<br>

                        Delivery

                    </p>

                </div>

                <div class="feature">

                    <div class="icon">
                       <img src="images/avatar.png" alt="avatar">
                    </div>

                    <p>

                        Expert<br>

                        Pharmacists

                    </p>

                </div>

            </div>

            <button class="shop-btn"
                     onclick="window.location.href='categoryPage.jsp?type=category&name=Medicine'">
                 SHOP NOW
             </button>
        </div>

    </section>

    <!-- Category Section -->

    <div class="category-section">

        <h2>SHOP BY CATEGORY</h2>

        <div class="categories">

            <div class="card">

                <img src="images/medicine_icon.png" alt="Medicine">

                <p>

                    <a href="categoryPage.jsp?type=category&name=Medicine">

                        Medicines

                    </a>

                </p>

            </div>

            <div class="card">

                <img src="images/healthcare_icon.png" alt="Health Care">

                <p>

                    <a href="categoryPage.jsp?type=category&name=HealthCare">

                        Health Care

                    </a>

                </p>

            </div>

            <div class="card">

                <img src="images/personalcare_icon.png" alt="Personal Care">

                <p>

                    <a href="categoryPage.jsp?type=category&name=PersonalCare">

                        Personal Care

                    </a>

                </p>

            </div>

            <div class="card">

                <img src="images/babycare_icon.png" alt="Baby Care">

                <p>

                    <a href="categoryPage.jsp?type=category&name=BabyCare">

                        Baby Care

                    </a>

                </p>

            </div>

            <div class="card">

                <img src="images/surgical_icon.png" alt="Surgicals">

                <p>

                    <a href="categoryPage.jsp?type=category&name=Surgicals">

                        Surgicals

                    </a>

                </p>

            </div>

            <div class="card">

                <img src="images/wellness_icon.png" alt="Wellness">

                <p>

                    <a href="categoryPage.jsp?type=category&name=Wellness">

                        Wellness

                    </a>

                </p>

            </div>

            <div class="card">

                <img src="images/offer_icon.png" alt="Offers">

                <p>

                    <a href="categoryPage.jsp?type=category&name=Offers">

                        Offers

                    </a>

                </p>

            </div>

        </div>

        <!-- Bottom Features -->

        <div class="features">

            <div class="feature-box">

                <h3>100% Genuine Products</h3>

                <p>Quality you can trust</p>

            </div>

            <div class="feature-box">

                <h3>Fast Delivery</h3>

                <p>On time, every time</p>

            </div>

            <div class="feature-box">

                <h3>Secure Payments</h3>

                <p>Safe & Secure Transactions</p>

            </div>

            <div class="feature-box">

                <h3>24/7 Customer Support</h3>

                <p>We're here to help</p>

            </div>

        </div>

    </div>

</div>

</body>
</html>