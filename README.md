# MASHA-Smart-Job-Solutions-with-Data-Science-and-Machine-Learning

Find the Live  Project on this link : [ https://psz5gu-iyampaye-ribert.shinyapps.io/NISR/]





MASHA: Smart Job Solutions with Data Science and Machine Learning
MASHA is a platform designed to tackle youth unemployment in Rwanda using AI and machine learning to provide personalized job recommendations, career tools, and labor market insights. It matches users with job opportunities and equips them with resources to enhance their employability.

Features
Job Matching & Recommendations: AI-driven job suggestions based on user profiles.
Labor Market Insights: Real-time analysis of job trends and market growth.
AI Interview Trainer: Feedback on interview performance using speech-to-text.
Skill Assessment: Tools to assess skills and suggest suitable career paths.
Career Tools: Resume builders, job applications, and career guidance materials.
Architecture
MASHA is built on a microservices architecture with components including:

Data Pipeline: Collects and processes real-time job data.
Machine Learning Models: Predict job trends and match candidates to jobs.
Web Interface: A Shiny-based dashboard for displaying results and recommendations.
Backend API: Provides real-time access to processed data.
Database: Stores user profiles and job data (PostgreSQL).
Technologies Used
Languages: R (Shiny), Python (for ML models)
Machine Learning: Scikit-learn, Keras/TensorFlow
Web Scraping: BeautifulSoup, Scrapy
Database: PostgreSQL
Frontend: HTML, CSS, JavaScript
Installation
Clone the repository and install dependencies for R and Python.
Set up the PostgreSQL database and run migrations.
Run the Shiny app with shiny::runApp("app/").
Usage
Access personalized job recommendations and labor market insights through the dashboard.
Use tools like the Resume Builder and Skill Assessment for career development.
Get job suggestions based on your profile and receive resources for each job.
Team
Ribert Iyimpaye: Machine Learning Model Developer
Nadine Umutesi: Data Pipeline Architect
Pascaline Ufitinema: UI/UX Designer
Contributing
Contributions are welcome! Fork the repository, make changes, and submit a pull request.



Acknowledgements
University of Rwanda: Support for the project.
OpenAI: For GPT-3 and Whisper models used in interview training.
R Community: For Shiny, enabling powerful web interfaces.
