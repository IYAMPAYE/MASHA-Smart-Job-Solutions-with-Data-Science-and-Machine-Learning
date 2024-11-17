
# **MASHA: Smart Job Solutions with Data Science and Machine Learning**

Find the live project here: [MASHA Dashboard](https://psz5gu-iyampaye-ribert.shinyapps.io/NISR/)

---

## **Overview**
**MASHA** is a platform designed to address youth unemployment in Rwanda by leveraging **AI** and **machine learning**. It provides personalized job recommendations, career development tools, and labor market insights to enhance employability and connect users with job opportunities.

---

## **Features**
- **Job Matching & Recommendations**:  
  AI-driven job suggestions tailored to user profiles.
- **Labor Market Insights**:  
  Real-time analysis of job trends and market growth.
- **AI Interview Trainer**:  
  Provides feedback on interview performance using speech-to-text analysis.
- **Skill Assessment**:  
  Tools to evaluate skills and recommend suitable career paths.
- **Career Tools**:  
  Resume builders, job applications, and career guidance resources.

---

## **Architecture**
**MASHA** is built on a **microservices architecture** with the following components:
- **Data Pipeline**:  
  Collects and processes real-time job data.
- **Machine Learning Models**:  
  Predicts job trends and matches candidates with jobs.
- **Web Interface**:  
  A Shiny-based dashboard to display results and recommendations.
- **Backend API**:  
  Provides real-time access to processed data.
- **Database**:  
  PostgreSQL stores user profiles and job data.

---

## **Technologies Used**
- **Languages**:  
  - R (Shiny)  
  - Python (for machine learning models)
- **Machine Learning**:  
  - Scikit-learn  
  - Keras/TensorFlow
- **Web Scraping**:  
  - BeautifulSoup  
  - Scrapy
- **Database**:  
  - PostgreSQL
- **Frontend**:  
  - HTML  
  - CSS  
  - JavaScript

---

## **Installation**
1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Install dependencies for R and Python.
3. Set up the PostgreSQL database and run migrations.
4. Start the Shiny app:
   ```R
   shiny::runApp("app/")
   ```

---

## **Usage**
- Access personalized **job recommendations** and **labor market insights** through the dashboard.
- Utilize tools like the **Resume Builder** and **Skill Assessment** for career development.
- Receive tailored job suggestions and resources for each opportunity.

---

## **Team**
- **Ribert Iyimpaye**: Machine Learning Model Developer  
- **Nadine Umutesi**: Data Pipeline Architect  
- **Pascaline Ufitinema**: UI/UX Designer  

---

## **Contributing**
We welcome contributions! 🎉  
To contribute:  
1. Fork the repository.  
2. Make changes.  
3. Submit a pull request.

---

## **Acknowledgements**
- **University of Rwanda**: For supporting the project.  
- **OpenAI**: For GPT-3 and Whisper models used in AI interview training.  
- **R Community**: For Shiny, enabling powerful web interfaces.
