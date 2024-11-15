library(shiny)
library(bslib)
library(ggplot2)
library(echarts4r)
library(reshape)
library(leaflet)
library(shinycssloaders)
library(readxl)
library(plotly)
library(tidyr)
library(dplyr)
library(reactable)
library(DT)
library(formattable)
library(kableExtra)
library(htmltools)
library(rmarkdown)
library(knitr)
library(shinydashboard)
library(scales)
library(shinyjs)
library(httr)
library(openai)
library(dplyr)
library(stringr)
library(lubridate)
library(base64enc)
library(reticulate)



data <- read_xlsx("Datasets/youth_unemployment_data.xlsx")
indicator_columns <- colnames(data)[!colnames(data) %in% c("Year")]
data1<- read.csv("Datasets/education_employment_data_underscores.csv")
interview_questions <- read.csv("interview_questions_dataset.csv")
cleaned_jobs<- read.csv("cleaned_jobs1.csv")
cleaned_jobs<- cleaned_jobs %>% distinct(actual_job_title, .keep_all = TRUE)
employment_data<- read_xlsx("Distribution.xlsx")





ui <- shinyUI( 
  tags$div(id = "homePage",
           navbarPage(theme = bs_theme(version = 4,
                                       primary = "black", 
                                       secondary = "#000000", 
                                       success = "red", 
                                       info = "red", 
                                       base_font = font_google("Montserrat"), 
                                       code_font = font_google("Montserrat"), 
                                       heading_font = font_google("Montserrat"), 
                                       font_scale = NULL, 
                                       `enable-gradients` = TRUE, 
                                       bootswatch = "flatly"),
                      
                      
                      tabPanel( "Home", 
                                
                        
                      ),
                      
                      
                      tabPanel("Home",
                               tags$div(
                                 class = "amazing-paragraph",
                                 tags$h1("Struggling with Unemployment?"),
                                 tags$p(HTML("   Struggling with Unemployment?<br>Your journey to a brighter future starts now.</span> <br>Let data-driven insights lead the way!</span>")),
                                 tags$h1(HTML("Tailored Solutions  <br>For Your Career Success </span>")), 
                                 tags$a(href = "#", class = "cta-button", "Get Your First Job")
                               ), 
                               
                              tags$div(class = "background-img") 
                              
                               
                               
                               
                      ), 
                      
                      
                      
                      tabPanel( "Analysis", 
                                fluidRow( 
                                  
                                  div(
                                    class = "analysis-box",
                                    
                                    # Path line designed on the margin of the box
                                    div(class = "path-line", 
                                        span(class = "path-icon"),
                                        span(class = "path-icon"),
                                        span(class = "path-icon"),
                                        span(class = "path-icon"),
                                        span(class = "path-icon")
                                    ),
                                    
                                    # Newspaper-style layout for questions and visualizations
                                    div(class = "newspaper-style",
                                        h2("What is the Current State of Youth Unemployment in Rwanda?"),
                                        p(HTML("Rwanda’s youth labor market from <span style='color: #fbff00 ;'>2019 to 2024</span> reveals significant shifts in employment and unemployment patterns.
       The <span style='color: #fbff00 ;'>labour force participation rate</span> has steadily increased, rising from <span style='color: #fbff00 ;'>50.4% in Q1 2019</span> to <span style='color: #fbff00 ;'>59.4% in Q2 2024</span>, 
       showing that more young people are actively engaging in the job market.")),
                                        p(HTML("However, despite this growth, the <span style='color: #fbff00 ;'>employment-to-population ratio</span>, currently at <span style='color: #fbff00 ;'>47.7% in 2024</span>, highlights that
       many youths still face challenges securing stable employment.
       Issues of <span style='color: #fbff00 ;'>time-related underemployment</span> and fluctuating rates of <span style='color: #fbff00 ;'>labour underutilization</span> reflect concerns 
       regarding job quality and the availability of sufficient work opportunities for the youth."))
                                        
                                        ,
                                        div(style = "color: red;",
                                            selectInput("indicator", width = 700,
                                                        label = "Select Youth Labour Force Indicator", 
                                                        choices = indicator_columns, 
                                                        selected = indicator_columns[5])),
                                        
                                        # Placeholder for chart
                                        echarts4rOutput("lineChart"), 
                                        p(HTML("Although <span style='color: #fbff00 ;'>youth participation in the labor force</span> has improved, the persistently high levels of <span style='color: #fbff00 ;'>underemployment</span> and <span style='color: #fbff00 ;'>labour underutilization</span> are alarming.
       The <span style='color: #fbff00 ;'>labour underutilization rate</span> peaked at <span style='color: #fbff00 ;'>65.2% in Q3 2021</span>, indicating that a significant portion of young people are either unemployed or not fully utilizing their skills in the labor market.
       Furthermore, the <span style='color: #fbff00 ;'>NEET rate</span> (youth not in employment, education, or training) remains high, ranging between <span style='color: #fbff00 ;'>28.4%</span> and <span style='color: #fbff00 ;'>37.7%</span>, showing that many young Rwandans are disconnected from productive opportunities.")),
                                        
                                        p(HTML("To tackle this issue, immediate action is needed to focus on 
                                        creating more <span style='color: #fbff00 ;'>quality jobs</span> and #fbff00ucing <span style='color: #fbff00 ;'>underemployment</span>.
       It is crucial to invest in <span style='color: #fbff00 ;'>vocational training</span>, <span style='color: #fbff00 ;'>entrepreneurship support</span>, and <span style='color: #fbff00 ;'>skill development programs</span> that can 
                                               bridge the gap between education and employment, ensuring that youth are well-equipped to
                                               meet the demands of the evolving labor market.")), 
                                        
                                        
                                        div(
                                          HTML("<h4><strong>What Role Does Education Play in Youth Employment in Rwanda?</strong></h4>
         <p>Youth unemployment is a significant issue in Rwanda, and education is often seen as a critical factor influencing labor market outcomes. Using data science, we can analyze key <span class='highlight'>labor force indicators</span> like labor force participation, employment-to-population ratios, and unemployment rates to understand how education levels affect employment among youth. By visualizing this data, we uncover
         insights that help us identify patterns, gaps, and mismatches between education 
         and employment opportunities. Highlighting these discrepancies allows
         for <span class='highlight'>targeted interventions</span> that can solve the
         problem using a <span class='highlight'>data-driven approach</span>.</p>")),
                                        # Placeholder for map
                                        div(style = "color: red;",
                                            selectInput("indicator1", width = 700, 
                                                        label = "Select Labor Force Indicator:",
                                                        choices = list("Labor Force Participation Rate" = "Labor_Force",
                                                                       "Employment to Population Ratio" = "Employment",
                                                                       "Unemployment Rate" = "Unemployment"))),
                                        
                                        
                                        
                                        echarts4rOutput("pieChart"), 
         
                                        div( HTML(
         "<h5>Key Insights and Solution Focus:</h5>
         <ul>
           <li>University graduates have the <span class='highlight'>highest labor force participation</span> but still face significant unemployment, pointing to a <span class='highlight'>mismatch between education and market needs</span>.</li>
           <li>Those with <span class='highlight'>lower secondary education</span> are at the greatest risk of underemployment, highlighting the need for tailored programs.</li>
         </ul>
         <p>Using data science tools, we can model <span class='highlight'>career paths</span>, forecast labor trends, and provide <span class='highlight'>recommendation systems</span> that help align education with real-world job requirements. These insights guide policy actions to improve youth employment through <span class='highlight'>data-driven strategies</span>, ensuring that education equips young people with the <span class='highlight'>right skills</span> for the job market.</p>")
                                        ), 
         
         div(
           class = "distribution-box",
           
           # Title and introductory paragraph
           h2("Employment Trends by Economic Activity Over Time"),
           tags$div(
             style = "margin-bottom: 20px; font-size: 16px;",
             HTML(
               "<p><span style='color: #fbff00;'>Understanding Employment Trends by Economic Activity</span></p>
      <p>Analyzing employment trends across <span style='color: #fbff00;'>various economic activities</span> provides essential insights for developing effective data-driven solutions to tackle unemployment in Rwanda. For instance, <span style='color: #fbff00;'>agriculture</span> continues to be the largest employer, comprising approximately 40-50% of the workforce in recent years, though it has shown fluctuations from <span style='color: #fbff00;'>52.3%</span> in Q1 2021 down to <span style='color: #fbff00;'>32.6%</span> by Q3 2024. Similarly, the <span style='color: #fbff00;'>construction sector</span> has seen growth, peaking at <span style='color: #fbff00;'>15.7%</span> in Q3 2020, suggesting an area with potential for job creation.</p>
      <p>Understanding these shifts helps us <span style='color: #fbff00;'>identify sectors with potential for growth</span> and track how employment evolves across industries, allowing us to <span style='color: #fbff00;'>design targeted interventions</span> and support data-driven policy for economic resilience. For example, the <span style='color: #fbff00;'>wholesale and retail trade</span> sector has remained a stable source of employment, averaging around 13-15% of the workforce, indicating its importance for both skilled and semi-skilled labor markets. Examining these trends enables us to align job creation efforts with sectors that demonstrate strong, sustainable growth potential.</p>"
             )
           ),
           
           # Subtitle and description above the chart
           p("Visualize the employment trend across different economic activities over the years."),
           
           # Placeholder for the echarts4r line chart
           echarts4rOutput("employmentTrendChart"),
           
           # Concluding paragraph below the chart
           tags$div(
             style = "margin-top: 20px; font-size: 16px;",
             HTML(
               "<p><span style='color: #fbff00;'>Insights for Building Resilient Employment Solutions Across Sectors</span></p>
      <p>The data reveals considerable sectoral shifts, highlighting where strategic interventions could drive employment growth. For example, while <span style='color: #fbff00;'>manufacturing</span> represented only <span style='color: #fbff00;'>4-6%</span> of employment, its steady increase points to an emerging opportunity for workforce development in industrial skills. <span style='color: #fbff00;'>Transportation and storage</span> have grown in significance, reaching <span style='color: #fbff00;'>7.2%</span> by Q3 2024, underscoring the need for policies to support logistics and mobility infrastructure.</p>
      <p>Targeting these high-impact sectors, particularly <span style='color: #fbff00;'>agriculture</span> and <span style='color: #fbff00;'>trade</span>, with specialized training and resource allocation can address gaps in the labor market and enable sustainable employment pathways for Rwandan youth. Such data-driven sectoral analysis positions us to create <span style='color: #fbff00;'>tailored, scalable solutions</span> that not only address unemployment but also foster resilience, allowing Rwanda’s economy to adapt to labor market changes effectively.</p>"
             )
           )
         )
         
         ,
         
         
         div(
           class = "job-seeking-box",
           
           # Title and introductory paragraph
           h2("Youth Unemployment and Duration of Job Seeking"),
           tags$div(
             style = "margin-bottom: 20px; font-size: 16px;",
             HTML(
               "<p><span style='color: #fbff00;'>Understanding Job-Seeking Duration Among Youth</span></p>
      <p>Analyzing the duration that young people spend searching for jobs reveals crucial barriers in the job market. Almost half of young job seekers (<span style='color: #fbff00;'>47.21%</span>) find employment within <span style='color: #fbff00;'>three months</span>, indicating that a substantial portion of opportunities is accessible in the short term. However, <span style='color: #fbff00;'>23.5%</span> of youth continue their search for <span style='color: #fbff00;'>three to six months</span>, and <span style='color: #fbff00;'>11.96%</span> face delays up to a year, reflecting potential barriers such as skill mismatches or limited job availability in certain sectors.</p>"
             )
           ),
           
           # Placeholder for job-seeking duration chart
           echarts4rOutput("jobSeekingDurationChart"),
           
           # Concluding paragraph below the chart
           tags$div(
             style = "margin-top: 20px; font-size: 16px;",
             HTML(
               "<p>Notably, <span style='color: #fbff00;'>17.33%</span> of job seekers spend more than a year on their search, with <span style='color: #fbff00;'>9.27%</span> taking one to two years and <span style='color: #fbff00;'>8.06%</span> requiring two years or more. This prolonged search duration underscores a segment of the youth population facing significant challenges, likely due to economic conditions, lack of tailored opportunities, or gaps in relevant skills. Addressing these issues is essential for enhancing youth employability and reducing long-term unemployment among young people in Rwanda.</p>"
             )
           )
         )
         
         
                                        
                                    )
                                  )
                                )
                                
                      )
                     
                      ,
                     
                      
                      
                      navbarMenu("Job Matching & Applications", 
                                 tabPanel("AI-Powered Job Suggestions",
                                          fluidPage(
                                            # Main content area
                                            div(class = "ai-job-suggestions-container",
                                                
                                                # Section for filters
                                                div(class = "filter-section",
                                                    h3("Refine Your Job Search"),
                                                    
                                                    # Select industry input with "All" as default choice
                                                    selectInput("industry", "Industry", 
                                                                choices = c("All", unique(cleaned_jobs$job_category))),
                                                    
                                                    # Select location input with "All" as default choice
                                                    selectInput("location", "Preferred Location", 
                                                                choices = c("All", unique(cleaned_jobs$location))),
                                                    
                                                    actionButton("filter_jobs", "Filter Jobs", class = "btn-filter")
                                                ),
                                                
                                                # Section for job suggestions
                                                div(class = "job-suggestions",
                                                    h2("AI-Powered Job Matches"),
                                                    div(id = "job_cards",
                                                        uiOutput("job_cards_output")  # Dynamic job cards rendered here
                                                    )
                                                )
                                            )
                                          )     
                                          
                                 )
                                 ,
                                 tabPanel("Job Search Filters"
                                          
                                          
                                 ),
                                 tabPanel("Freelance & Gig Jobs"
                                                
                                          
                                 )
                      ), 
                      
                      
                      
        
         tabPanel("Career Tools",
                  fluidPage(
                    # External script and CSS links
                    tags$head(
                      tags$script(src = "https://cdn.jsdelivr.net/npm/@tensorflow/tfjs"),
                      tags$script(src = "https://cdn.jsdelivr.net/npm/@tensorflow-models/blazeface"),
                      tags$script(src = "audioRecorder.js"), 
                      tags$script(src = "Interview.js")
                    ),
                    
                    # Homepage Section
                    conditionalPanel(
                      condition = "input.start_button == 0",
                      div(
                        class = "homepage",
                        fluidRow(
                          column(12, h2("Welcome to the AI Interview Trainer", class = "header-text")),
                          column(12, p("Prepare for your interviews with real-time feedback on your answers, body language, and more!", class = "intro-text")),
                          column(12, actionButton("start_button", "Get Started", class = "btn btn-primary"))
                        ),
                        fluidRow(
                          column(4, icon("comments"), h4("Real-Time Feedback"), p("Get instant insights on your responses.")),
                          column(4, icon("video"), h4("Live Video Analysis"), p("Monitor your body language and expressions.")),
                          column(4, icon("tasks"), h4("Comprehensive Evaluation"), p("Receive feedback on both content and presentation."))
                        )
                      )
                    ),
                    
                    # Interview Dashboard Section
                    conditionalPanel(
                      condition = "input.start_button > 0 && input.start_interview == 0",
                      div(
                        class = "interview-dashboard",
                        h3("Prepare for Your Interview"),
                        fluidRow(
                          column(4, 
                                 selectInput("job_role", "Choose Job Role:", choices = unique(interview_questions$job_role)),
                                 actionButton("start_interview", "Next: Choose Interview Mode", class = "btn btn-success")
                          ),
                          column(8,
                                 h4("Instructions"),
                                 p("1. Choose your job role from the dropdown."),
                                 p("2. Click 'Next' to proceed to the mode selection."),
                                 p("3. You'll receive real-time feedback on your responses and presentation.")
                          )
                        ),
                        br()
                        
                      )
                    ),
                    
                    # Mode Selection Section
                    conditionalPanel(
                      condition = "input.start_interview > 0 && input.start_interview_mode == 0",
                      div(
                        class = "mode-select",
                        h2("Choose Your Interview Mode", class = "header-text"),
                        div(
                          id = "liveModeCard",
                          class = "mode-card",
                          onclick = "Shiny.setInputValue('selected_mode', 'live')",
                          h4("Live Interview Mode"),
                          p("Practice with real-time video and audio feedback.")
                        ),
                        div(
                          id = "textModeCard",
                          class = "mode-card",
                          onclick = "Shiny.setInputValue('selected_mode', 'text')",
                          h4("Text-Only Mode"),
                          p("Answer questions by typing your response and receive feedback.")
                        ),
                        br(),
                        actionButton("start_interview_mode", "Start Selected Mode", class = "btn btn-primary"),
                       
                      )
                    ),
                    
                    # Dynamic Panels Based on Mode Selection
                    conditionalPanel(
                      condition = "input.selected_mode == 'live' && input.start_interview_mode > 0",
                      div(
                        class = "live-interview",
                        h3("Live Interview Area"),
                        fluidRow(
                          column(8,
                                 tags$video(id = "videoElement", autoplay = "autoplay", width = "100%", height = "auto"),
                                 p("Your live video feed will appear here.")
                          ),
                          column(4,
                                 infoBoxOutput("confidenceScore", width = NULL),
                                 infoBoxOutput("answerQuality", width = NULL)
                          )
                        ),
                        fluidRow(
                          column(12,
                                 textOutput("question_output"),
                                 br(),
                                 fluidRow(
                                   column(12, actionButton("startRecording", "Start Recording", class = "btn btn-primary")),
                                   column(12, actionButton("stopRecording", "Stop Recording", class = "btn btn-danger")),
                                   column(12, actionButton("playRecording", "Play Recording", class = "btn btn-secondary")),
                                   column(12, actionButton("submitRecording", "Submit Audio", class = "btn btn-success")),
                                   column(12, textOutput("timer_display")),
                                   column(12, tags$audio(id = "audioPlayback", controls = NA))
                                 ),
                                 div(id = "recordingIndicator", "Recording in progress...", style = "display: none; color: red;"),
                                 br(),
                                 actionButton("next_question", "Next Question"),
                                 
                          )
                        )
                      )
                    )
                    ,
                    
                    # Text-Only Interview Mode Section
                    conditionalPanel(
                      condition = "input.selected_mode == 'text' && input.start_interview_mode > 0",
                      div(
                        class = "text-only-interview",  # Apply the custom CSS class here
                        
                        h3("Text-Only Interview Mode"),
                        fluidRow(
                          column(12, textOutput("question_output"), br()),
                          column(12, textAreaInput("text_answer", "Your Answer", "", width = "100%", height = "100px")),
                          column(12, actionButton("submit_text_answer", "Submit Answer", class = "btn btn-success")),
                          column(12, textOutput("text_feedback")),
                          br(),
                          actionButton("next_question", "Next Question"),
                          actionButton("go_back", "Go Back", class = "btn btn-secondary")
                        )
                      )
                    )
                    
                  )
         )
         
         



         
         
         
                     , 
         tabPanel(
           "Labor Market Insights",
           
           fluidPage(
             class = "overview-container",
             
             # Overlay layer
             tags$div(class = "background-overlay"),
             
             # Main content
             tags$div(
  class = "overview-content",
  tags$div(
    class = "overview-row",
    
    # Total Jobs
    tags$div(
      class = "overview-card",
      tags$div(icon("briefcase", class = "icon-style")),  # Icon changed to "briefcase"
      tags$h3(textOutput("totalJobs")),
      tags$div(
        class = "category-labels",
        tags$span("Total Job Postings (Year)")
      )
    ),
    
    # Active Jobs
    tags$div(
      class = "overview-card",
      tags$div(icon("play-circle", class = "icon-style")),  # Icon changed to "play-circle"
      tags$h3(textOutput("Active")),
      tags$div(
        class = "category-labels",
        tags$span("Active Job Listings")
      )
    ),
    
    # Tenders
    tags$div(
      class = "overview-card",
      tags$div(icon("file-contract", class = "icon-style")),  # Icon changed to "file-contract"
      tags$h3(textOutput("tenders")),
      tags$div(
        class = "category-labels",
        tags$span("Open Tenders in Rwanda")
      )
    ),
    
    # Academics (Internships, Education)
    tags$div(
      class = "overview-card",
      tags$div(icon("graduation-cap", class = "icon-style")),  # Icon changed to "graduation-cap"
      tags$h3(textOutput("Academics")),
      tags$div(
        class = "category-labels",
        tags$span("Academic & Internship Roles")
      )
    ),
    
    # Full-Time Jobs
    tags$div(
      class = "overview-card",
      tags$div(icon("clock", class = "icon-style")),  # Icon changed to "clock" for full-time
      tags$h3(textOutput("full_time")),
      tags$div(
        class = "category-labels",
        tags$span("Full-Time Jobs in Rwanda")
      )
    ),
    
    # Part-Time Jobs
    tags$div(
      class = "overview-card",
      tags$div(icon("clock", class = "icon-style")),  # Icon changed to "clock" for part-time
      tags$h3(textOutput("part_time")),
      tags$div(
        class = "category-labels",
        tags$span("Part-Time Jobs in Rwanda")
      )
    )
  )
)

           ), 
           
           
           
           fluidPage(
             class = "charts-page",
             
             fluidRow(
               column(
                 class = "charts",
                 width = 6,
                 box(
                   title = "Top Five Hiring Industries In Rwanda This Year ",
                   width = NULL,
                   echarts4rOutput("category_chart", width = 700)
                 )
               ),
               column(
                 class = "charts",
                 width = 6,
                 box(
                   title = "Location Distribution",
                   width = NULL,
                   echarts4rOutput("location_chart", width = 700)
                 )
               )
             ),
             
             fluidRow(
               column(
                 class = "charts",
                 width = 6,
                 box(
                   title = "Top Hiring Company in Rwanda This Year ",
                   width = NULL,
                   echarts4rOutput("company_chart", width = 700)
                 )
               ),
               column(
                 class = "charts",
                 width = 6,
                 box(
                   title = "Job Types",
                   width = NULL,
                   echarts4rOutput("job_type_chart", width = 700)
                 )
               )
             )
           ), 
           
           # Insights and Listings Section
div(class = "content-section",
    fluidRow(
      # Job Listing Cards Box
      column(12,
             div(class = "job-listings-box",
                 h3("Job Listings"),
                 uiOutput("job_cards")  # Dynamic UI for job cards
             )
      ),
      
      # Additional Insights Charts or other components can go here
    )
)

         ), 


tabPanel(
  "Mentorship & Networking",
  
  # Hero Section
  tags$div(
    class = "hero-section",
    h1("Welcome to Mentorship & Networking"),
    p("Empowering Rwanda's youth with connections, mentorship, and opportunities to build successful careers."),
    br(),
    actionButton("start_mentor_search", "Start Finding a Mentor", class = "btn-primary hero-btn")
  ),
  
  # Mentor Finder Section
  tags$div(
    class = "section-title",
    h2("Find a Mentor")
  ),
  tags$div(
    class = "mentor-finder",
    textInput("mentor_search", "Search for a Mentor", placeholder = "e.g., Data Science, Business"),
    uiOutput("mentor_cards") # Render dynamic mentor cards
  ),
  
  # Networking Opportunities Section
  tags$div(
    class = "section-title",
    h2("Networking Opportunities")
  ),
  tags$div(
    class = "networking-opportunities",
    dateRangeInput("event_date", "Filter by Date", start = Sys.Date(), end = Sys.Date() + 30),
    dataTableOutput("event_table") # Render dynamic events table
  ),
  
  # Peer Networking Section
  tags$div(
    class = "section-title",
    h2("Peer Networking")
  ),
  tags$div(
    class = "peer-networking",
    textAreaInput("peer_message", "Introduce Yourself", 
                  placeholder = "Share your goals, interests, and experiences...", rows = 5),
    actionButton("post_message", "Post to Networking Wall", class = "btn-primary"),
    uiOutput("peer_networking_wall") # Render dynamic peer posts
  ),
  
  # Scheduling Mentorship Section
  tags$div(
    class = "section-title",
    h2("Schedule Your Mentorship Session")
  ),
  tags$div(
    class = "mentorship-scheduling",
    uiOutput("mentor_schedule") # Render dynamic scheduling form
  )
)







, 
tabPanel(
  "Support & Resources",
  fluidPage(
    tags$div(
      class = "hero-section",
      tags$div(
        class = "hero-title",
        "Empowering Rwandan Youth with Resources"
      ),
      tags$div(
        class = "hero-subtitle",
        "Access tools and support to boost your career, education, and well-being."
      ),
      actionButton("get_started", "Explore Resources", class = "btn-hero")
    ),
    tags$div(
      class = "section resources-section",
      tags$div(
        class = "section-title",
        tags$h2("Resource Categories")
      ),
      fluidRow(
        column(4, 
               tags$div(
                 class = "resource-card",
                 tags$h3("Career Guidance"),
                 tags$p("Explore job application tips, resume templates, and interview preparation resources."),
                 actionButton("career_guidance", "Learn More", class = "btn-resource")
               )
        ),
        column(4, 
               tags$div(
                 class = "resource-card",
                 tags$h3("Funding Opportunities"),
                 tags$p("Discover scholarships, grants, and other financial aid programs."),
                 actionButton("funding_opportunities", "Explore Funding", class = "btn-resource")
               )
        ),
        column(4, 
               tags$div(
                 class = "resource-card",
                 tags$h3("Mental Health Support"),
                 tags$p("Access counseling services and mental health awareness programs."),
                 actionButton("mental_health_support", "Get Support", class = "btn-resource")
               )
        )
      )
    ),
    tags$div(
      class = "section tools-section",
      tags$div(
        class = "section-title",
        tags$h2("Interactive Tools")
      ),
      fluidRow(
        column(6, 
               tags$div(
                 class = "tool-card",
                 tags$h3("Resume Builder"),
                 tags$p("Create a professional resume in minutes."),
                 actionButton("resume_builder", "Build Resume", class = "btn-tool")
               )
        ),
        column(6, 
               tags$div(
                 class = "tool-card",
                 tags$h3("Skill Assessment"),
                 tags$p("Identify your strengths and get recommendations for career paths."),
                 actionButton("skill_assessment", "Take Assessment", class = "btn-tool")
               )
        )
      )
    ),
    tags$div(
      class = "section contact-support-section",
      tags$div(
        class = "section-title",
        tags$h2("Need Help?")
      ),
      tags$div(
        class = "contact-form",
        textInput("user_name", "Your Name"),
        textInput("user_email", "Your Email"),
        textAreaInput("user_message", "Message", ""),
        actionButton("send_message", "Send Message")
      )
    )
  )
)
, 
tabPanel("The Team",
    div(class = "team-section",
        # Introductory Section for the Team as a Whole
        div(class = "team-intro",
            h2("INGANJI: A Team United by Passion and Expertise", class = "team-intro-title"),
            p("The INGANJI team, comprised of talented students from the University of Rwanda specializing in Applied Statistics, brings together a unique blend of skills and expertise, 
            united by a shared mission to tackle youth unemployment in Rwanda through data-driven solutions. 
            Each team member contributes in areas such as machine learning, data pipeline development, 
            and UI/UX design, working together to transform labor market data into actionable insights. The dashboard provides real-time job recommendations, trend analysis, and AI-powered interview training, empowering Rwanda’s youth to make informed career decisions. 
              Through collaboration and innovation, the team is creating a data-driven solution to tackle youth unemployment in Rwanda.", 
              class = "team-intro-text")
        ),
        
        # Section Title for Individual Team Members
        h2("Meet Our Dedicated Team", class = "team-title"),
        
        # Individual Team Member Profiles
        fluidRow(
            # Team Member 1
            column(4, class = "team-member",
                div(class = "team-photo", img(src = "Ribert_iyimpaye.jpg", class = "profile-pic")),
                h4("Ribert Iyimpaye ", class = "team-name"),
                p("Machine Learning Model Developer", class = "team-role"),
                div(class = "social-icons",
                    a(href = "https://linkedin.com", icon("linkedin"), class = "social-icon"),
                    a(href = "https://twitter.com", icon("twitter"), class = "social-icon"),
                    a(href = "https://github.com/IYAMPAYE", icon("github"), class = "social-icon")
                ),
                p("Ribert Iyimpaye served as the Machine Learning Model Developer for the Labor Market Insights dashboard, focusing on advanced AI solutions to address youth unemployment in Rwanda. He developed predictive models to analyze labor market trends, forecast job availability, and identify skill gaps. Additionally, Ribert implemented speech-to-text processing using OpenAI's Whisper model to capture and analyze interview responses within the AI-powered Interview Trainer, providing real-time feedback on content quality and sentiment. His work on trend forecasting and job-matching algorithms enabled the platform to offer precise, data-driven career recommendations, directly supporting youth in making informed career decisions.", 
                  class = "team-description")
            ),
            
            # Team Member 2
            column(4, class = "team-member",
                div(class = "team-photo", img(src = "Nadine_Umutesi.jpeg", class = "profile-pic")),
                h4("Nadine Umutesi", class = "team-name"),
                p("Data Pipeline Architect", class = "team-role"),
                div(class = "social-icons",
                    a(href = "https://www.linkedin.com/in/umutesi-nadine-895063323?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app", icon("linkedin"), class = "social-icon"),
                    a(href = "https://twitter.com", icon("twitter"), class = "social-icon"),
                    a(href = "https://github.com/mushambokazi", icon("github"), class = "social-icon")
                ),
                p("Nadine Umutesi served as the Data Pipeline Architect for the Labor Market Insights project, designing and optimizing a data pipeline that integrates, cleans, and transforms real-time data from diverse sources, including automated web scraping of job postings and economic trends. Her work ensured accurate, up-to-date information for the dashboard’s KPIs and predictive models, as well as efficient data access for the AI-powered Interview Trainer. Nadine’s contributions provide a reliable foundation for delivering actionable, data-driven career insights to Rwanda’s youth.", 
                  class = "team-description")
            ),
            
            # Team Member 3
            column(4, class = "team-member",
                div(class = "team-photo", img(src = "Pascaline_Ufitinema.jpeg", class = "profile-pic")),
                h4("Pascaline Ufitinema", class = "team-name"),
                p("UI/UX Designer", class = "team-role"),
                div(class = "social-icons",
                    a(href = "https://www.linkedin.com/in/pascaline-ufitinema-b697491b9?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app", icon("linkedin"), class = "social-icon"),
                    a(href = "https://twitter.com", icon("twitter"), class = "social-icon"),
                    a(href = "https://github.com", icon("github"), class = "social-icon")
                ),
                p("Pascaline Ufitinema served as User Interface (UI) and User Experience (UX) Designer the  for the Labor Market Insights project, creating an intuitive and engaging interface that allows Rwanda’s youth to navigate job insights, trends, and tools with ease. She designed a responsive layout that highlights key metrics and incorporated a professional look for the AI-powered Interview Trainer. Pascaline’s work ensures a user-friendly experience, making complex data accessible and actionable for career guidance.", 
                  class = "team-description")
            )
        )
    )
)

,# Footer section
tags$footer(
  class = "footer",
  tags$div(
    class = "footer-content",
    tags$div(
      class = "footer-row",
      # Left section with about text
      tags$div(
        class = "footer-about",
        tags$h4("About INGANJI"),
        tags$p("INGANJI is dedicated to empowering individuals with data-driven insights for career success and addressing youth unemployment in Rwanda. Join us as we create impactful solutions for a better future.")
      ),
      # Middle section with navigation links
      tags$div(
        class = "footer-nav",
        tags$h4("Quick Links"),
        tags$a(href = "#home", "Home", class = "footer-link"),
        tags$a(href = "#analysis", "Analysis", class = "footer-link"),
        tags$a(href = "#job-matching", "Job Matching", class = "footer-link"),
        tags$a(href = "#career-tools", "Career Tools", class = "footer-link"),
        tags$a(href = "#labor-market", "Labor Market Insights", class = "footer-link")
      ),
      # Right section with social media icons
      tags$div(
        class = "footer-social",
        tags$h4("Follow Us"),
        tags$a(href = "https://linkedin.com", icon("linkedin"), class = "social-icon"),
        tags$a(href = "https://twitter.com", icon("twitter"), class = "social-icon"),
        tags$a(href = "https://github.com", icon("github"), class = "social-icon"),
        tags$a(href = "https://facebook.com", icon("facebook"), class = "social-icon")
      )
    )
  ),
  # Bottom copyright section
  tags$div(
    class = "footer-bottom",
    tags$p("© 2024 INGANJI - All rights reserved.")
  )
),
           
                     
                     useShinyjs(), 
                      
                      
                      
                      
                      
                      tags$head(
                        tags$script(src = "scripts.js"),
                        tags$link(rel="stylesheet", type="text/css", href="styles.css"),
                        tags$link(rel="stylesheet" ,href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css",integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA==",crossorigin="anonymous",referrerpolicy="no-referrer"),
                      )
           ))
)


server<- function(input, output, session){
  
  # Render the line chart based on selected indicator
  # Create the line chart
  output$lineChart <- renderEcharts4r({
    selected_data <- data[, c("Year", input$indicator)]
    
    selected_data %>% 
      e_charts(Year) %>% 
      e_line_(input$indicator, smooth = TRUE, symbol = "circle", symbolSize = 10) %>%
      e_color("red") %>%
      e_tooltip(
        trigger = "axis",
        backgroundColor = "#ffffff",
        textStyle = list(color = "#333333"),
        axisPointer = list(type = "shadow")
      )  %>%
      e_legend(left = "center") %>%
      e_x_axis(name = "Year") %>%
      e_y_axis(name = input$indicator) %>%
      e_theme("infographic") 
      
  })
  
  ############## Labor force indicator per education ##########
  labor_data <- data.frame(
    Education = c("None", "Primary", "Lower secondary", "Upper secondary", "University"),
    Labor_Force = c(65.1, 53.8, 35.6, 62.5, 80.3),
    Employment = c(53.8, 42.7, 27.7, 43.7, 62),
    Unemployment = c(17.3, 20.7, 22.1, 30, 22.7)
  )
  
  
  output$pieChart <- renderEcharts4r({
    labor_data %>%
      e_charts(Education) %>%
      e_pie_(input$indicator1, radius = c("40%", "70%")) %>%
      
      e_tooltip(trigger = "item", 
                formatter = htmlwidgets::JS("
                  function(params) {
                    return params.name + ': ' + params.value + ' (' + params.percent + '%)';
                  }
                ")) %>%
      e_legend(orient = "vertical", left = "left", top = "center",
               textStyle = list(color = "white"),
               data = labor_data$Education) %>%
      e_theme("infographic") %>%
      e_labels(show = TRUE, formatter = "{b}: {d}%", position = "outside",
               textStyle = list(fontWeight = "bold", fontSize = 14, color = "#fff")) %>%
      e_animation(duration = 1000, easing = "elasticOut") %>%
      e_color(c("#F39C12", "#E74C3C", "#3498DB", "#2ECC71", "#9B59B6")) 
    
  })
  
  
  
  ######## Economic Activity Distribution #######################
  output$employmentTrendChart <- renderEcharts4r({
    # Transform data to a long format suitable for plotting each activity over time
    trend_data <- employment_data %>%
      gather(key = "Economic_Activity", value = "Employment_Percentage", -Year)
    
    # Create the line chart with echarts4r
    trend_data %>%
      group_by(Economic_Activity) %>%
      e_charts(Year) %>%
      e_legend(FALSE) %>%
      e_tooltip(
        trigger = "item",
        backgroundColor = "#ffffff",
        textStyle = list(color = "#333333"),
        axisPointer = list(type = "shadow")
      )  %>%
      e_line(Employment_Percentage, symbol = "circle") %>%  # Add lines with circle markers
      e_grid(left = "8%", right = "8%", bottom = "12%") %>%  # Adjust grid for better layout
      e_theme("infographic")  # Apply an infographic theme for styling
      
      
      
  })
  
  ########### Duration Of Seeking Employment #############
  
  # Sample data based on provided table
  employment_wait_data <- data.frame(
    Duration = c("0 – less than 3 months", "3 – less than 6 months", 
                 "6 – less than 12 months", "1 – less than 2 years", 
                 "2 years or more"),
    Percentage = c(47.21, 23.50, 11.96, 9.27, 8.06)
  )
  
  output$jobSeekingDurationChart <- renderEcharts4r({
    employment_wait_data %>%
      e_charts(Duration) %>%  # Specify Duration as the x-axis dimension
      e_bar(Percentage, name = "Percentage of Youth") %>%  # Create a bar chart with Percentage as the measure
      e_color(c("#03A9F4", "#FF5722", "#8BC34A")) %>%  # Custom colors for each duration category
       # Add toolbox with save as image feature
      e_tooltip(
        trigger = "item",
        backgroundColor = "#ffffff",
        textStyle = list(color = "#333333"),
        axisPointer = list(type = "shadow")
      )  %>%  # Tooltip showing duration and percentage
      e_y_axis(name = "Percentage (%)", max = 50, axisLabel = list(formatter = "{value}%")) %>%  # Format y-axis
      e_x_axis(name = "Duration", axisLabel = list(rotate = 45)) %>%  # Rotate x-axis labels for better readability
      e_grid(left = "8%", right = "15%", bottom = "25%") %>% 
      e_theme("infographic")  # Apply infographic theme
        # Add title and subtitle
  })
  
  
  
  
  # GSAP Animation Trigger
  observe({
    session$sendCustomMessage(type = "initGSAP", message = NULL)
  })

  
  
  
  
  ##### Job Recommandation #####################
  
  # Reactive filter for job data
  filtered_jobs <- reactive({
    req(cleaned_jobs)  # Ensure cleaned_jobs is available
    data <- cleaned_jobs
    
    # Apply filters only if not "All"
    if (input$industry != "All") {
      data <- data %>% filter(job_category == input$industry)
    }
    if (input$location != "All") {
      data <- data %>% filter(location == input$location)
    }
    data
  })
  
  # Render all job cards initially
  output$job_cards_output <- renderUI({
    # Generate job cards for all jobs
    job_cards <- lapply(1:nrow(cleaned_jobs), function(i) {
      job <- cleaned_jobs[i, ]
      div(class = "job-card",
          h4(job$actual_job_title),
          p(paste("Company:", job$company)),
          p(paste("Location:", job$location)),
          
          div(class = "posted-deadline",
              p(paste("Posted on:", job$posted)),
              p(paste("Deadline:", job$deadline))
          ),
          
          a("Apply", href = job$job_link, class = "apply-button", target = "_blank")
      )
    })
    do.call(tagList, job_cards)
  })
  
  # Update job cards when the filter button is clicked
  observeEvent(input$filter_jobs, {
    output$job_cards_output <- renderUI({
      # Generate dynamic job cards based on filtered jobs
      job_cards <- lapply(1:nrow(filtered_jobs()), function(i) {
        job <- filtered_jobs()[i, ]
        div(class = "job-card",
            h4(job$actual_job_title),
            p(paste("Company:", job$company)),
            p(paste("Location:", job$location)),
            
            div(class = "posted-deadline",
                p(paste("Posted on:", job$posted)),
                p(paste("Deadline:", job$deadline))
            ),
            
            a("Apply", href = job$job_link, class = "apply-button", target = "_blank")
        )
      })
      do.call(tagList, job_cards)
    })
  })
  
  ##### Interview Trainer 
  # Load and prepare interview questions
  question_bank <- reactiveVal(NULL)
  current_question_index <- reactiveVal(1)
  
  # Load questions based on the selected job role
  observeEvent(input$start_interview, {
    job_role <- input$job_role
    questions <- interview_questions$question[interview_questions$job_role == job_role]
    
    question_bank(questions)
    current_question_index(1)
    
    output$question_output <- renderText({
      question_bank()[[current_question_index()]]
    })
  })
  
  # Handle mode selection and start interview based on mode
  observeEvent(input$start_interview_mode, {
    selected_mode <- input$selected_mode
    
    if (is.null(selected_mode) || selected_mode == "") {
      showNotification("Please select an interview mode to proceed.", type = "error")
    } else {
      showNotification(paste("You selected the mode:", selected_mode), type = "message")
    }
  })
  
  # Go Back to the previous question
  observeEvent(input$go_back, {
    if (current_question_index() > 1) {
      current_question_index(current_question_index() - 1)
      
      output$question_output <- renderText({
        question_bank()[[current_question_index()]]
      })
      
      # Reset audio and text input for previous question
      updateTextInput(session, "audio_base64", value = NULL)
      updateTextInput(session, "text_answer", value = "")
    } else {
      showNotification("This is the first question. Cannot go back further.", type = "error")
    }
  })
  
  # Process submitted audio in live interview mode and generate feedback
  observeEvent(input$audio_base64, {
    if (input$selected_mode == "live") {
      user_answer <- processAudio(input$audio_base64)
      
      if (is.null(user_answer) || user_answer == "") {
        showNotification("No answer detected in the audio. Please try again.", type = "error")
        return()
      }
      
      feedback <- getFeedback(user_answer)
      
      output$confidenceScore <- renderInfoBox({
        infoBox(
          "Confidence Score",
          value = paste0(feedback$confidence_score, "%"),
          color = "blue"
        )
      })
      
      output$answerQuality <- renderInfoBox({
        infoBox(
          "Answer Quality",
          value = feedback$answer_quality,
          color = ifelse(feedback$answer_quality == "Good", "green", "orange")
        )
      })
    }
  })
  
  # Process submitted text answer in text-only mode and generate feedback
  observeEvent(input$submit_text_answer, {
    if (input$selected_mode == "text") {
      user_answer <- input$text_answer
      
      if (is.null(user_answer) || user_answer == "") {
        showNotification("Please enter an answer before submitting.", type = "error")
        return()
      }
      
      feedback <- getFeedback(user_answer)
      
      output$text_feedback <- renderText({
        paste("Confidence Score:", feedback$confidence_score, "%",
              "| Answer Quality:", feedback$answer_quality)
      })
    }
  })
  
  # Advance to the next question on 'Next Question' click
  observeEvent(input$next_question, {
    if (input$selected_mode == "live" && is.null(input$audio_base64)) {
      showNotification("Please submit your answer before proceeding.", type = "error")
      return()
    } else if (input$selected_mode == "text" && is.null(input$text_answer)) {
      showNotification("Please enter an answer before proceeding.", type = "error")
      return()
    }
    
    new_index <- current_question_index() + 1
    if (new_index <= length(question_bank())) {
      current_question_index(new_index)
      
      output$question_output <- renderText({
        question_bank()[[current_question_index()]]
      })
      
      # Reset audio and text input for next question
      updateTextInput(session, "audio_base64", value = NULL)
      updateTextInput(session, "text_answer", value = "")
    } else {
      output$question_output <- renderText("End of questions. Thank you for completing the interview!")
      showNotification("Interview session completed. You can review your feedback.", type = "message")
    }
  })
  
  # Mock function for testing transcription
  processAudio <- function(audio_base64) {
    transcribed_text <- "This is a sample answer to the interview question. It should be assessed for feedback."
    return(transcribed_text)
  }
  
  # Simple function to simulate confidence calculation
  calculate_confidence <- function(transcribed_text) {
    confidence_score <- min(100, max(50, nchar(transcribed_text) * 2))
    return(confidence_score)
  }
  
  # Simple function to assess answer quality
  determine_answer_quality <- function(transcribed_text) {
    keywords <- c("skill", "experience", "challenge", "achieved", "learned")
    quality_score <- sum(sapply(keywords, function(keyword) grepl(keyword, transcribed_text, ignore.case = TRUE)))
    
    answer_quality <- if (quality_score >= 3) {
      "Good"
    } else if (quality_score == 2) {
      "Fair"
    } else {
      "Needs Improvement"
    }
    return(answer_quality)
  }
  
  # Function to generate feedback based on transcription
  getFeedback <- function(transcribed_text) {
    confidence_score <- calculate_confidence(transcribed_text)
    answer_quality <- determine_answer_quality(transcribed_text)
    
    return(list(
      confidence_score = confidence_score,
      answer_quality = answer_quality
    ))
  }
  
  
  
  ############ Labour Market Insight ###############################################
  
  
  # Job Listing Cards
  output$job_cards <- renderUI({
    lapply(1:nrow(cleaned_jobs), function(i) {
      div(class = "job-card",
          h4(cleaned_jobs$actual_job_title[i]),
          p(cleaned_jobs$company[i]),
          p(paste("Location:", cleaned_jobs$location[i])),
          p(paste("Category:", cleaned_jobs$job_category[i])),
          a("View Job", href = "#", class = "view-job-link")
      )
    })
  })
  
  # Charts
  # Enhanced Category Chart with Top 5 Industries and Professional Styling
  output$category_chart <- renderEcharts4r({
    cleaned_jobs %>%
      dplyr::count(job_category, sort = TRUE) %>%
      dplyr::slice_max(n, n = 5) %>%  # Select top 5 categories by count
      e_charts(job_category) %>%
      e_bar(n, 
            name = "Category", 
            itemStyle = list(
              color = list(
                type = 'linear',
                x = 0,
                y = 0,
                x2 = 1,
                y2 = 0,
                colorStops = list(
                  list(offset = 0, color = '#4A90E2'),  # Gradient start
                  list(offset = 1, color = '#2A3A8C')   # Gradient end
                )
              )
            )) %>%
      e_tooltip(trigger = "item", formatter = "{b}: {c} jobs") %>%
      e_legend(show = FALSE) %>%
      e_animation(duration = 1200, easing = "cubicOut") %>%
      e_x_axis(axisLabel = list(rotate = 45, color = "#555555", fontSize = 12),
               name = "Job Category",
               nameTextStyle = list(color = "#333333", fontWeight = "bold")) %>%
      e_y_axis(name = "Number of Jobs",
               nameTextStyle = list(color = "#333333", fontWeight = "bold"),
               axisLabel = list(color = "#555555", fontSize = 12),
               splitLine = list(lineStyle = list(color = "#e0e0e0", type = "dashed"))) %>%
      e_theme("infographic") %>%
      e_grid(right = "15%", bottom = "40%")
  })
  
  
  # Location Chart - Animated Donut Chart with Tooltip and Custom Colors
  output$location_chart <- renderEcharts4r({
    cleaned_jobs %>%
      dplyr::count(location) %>%
      e_charts(location) %>%
      e_pie(n, 
            radius = c("40%", "70%"),  # Donut shape
            roseType = "radius",       # Rose chart effect
            itemStyle = list(borderRadius = 10, borderColor = "#fff", borderWidth = 2),
            name = "Location") %>%
      e_tooltip(trigger = "item", formatter = "{b}: {c} ({d}%)") %>%
      e_title("Jobs by Location", left = "center") %>%
      e_legend(orient = "horizontal", top = "bottom") %>%
      e_theme("infographic") %>%
      e_animation(duration = 1200, easing = "cubicOut")
  })
  
  # Company Chart - Enhanced Bar Chart with Animation and Axis Customization
  # Enhanced Company Chart with Adjusted Bottom Padding to Avoid Label Cutting
output$company_chart <- renderEcharts4r({
  cleaned_jobs %>%
    dplyr::count(company, sort = TRUE) %>%
    dplyr::slice_max(n, n = 5) %>%  # Select top 5 companies by count
    e_charts(company) %>%
    e_bar(n, 
          name = "Company", 
          itemStyle = list(
            color = list(
              type = 'linear',
              x = 0,
              y = 0,
              x2 = 1,
              y2 = 0,
              colorStops = list(
                list(offset = 0, color = '#7E57C2'),  # Gradient start
                list(offset = 1, color = '#512DA8')   # Gradient end
              )
            )
          )) %>%
    e_tooltip(trigger = "item", formatter = "{b}: {c} jobs") %>%
    
    e_legend(show = FALSE) %>%
    e_animation(duration = 1200, easing = "cubicOut") %>%
    e_x_axis(axisLabel = list(rotate = 60, color = "#555555", fontSize = 10),  # Adjusted font size
             name = "Company",
             nameTextStyle = list(color = "#333333", fontWeight = "bold")) %>%
    e_y_axis(name = "Number of Jobs",
             nameTextStyle = list(color = "#333333", fontWeight = "bold"),
             axisLabel = list(color = "#555555", fontSize = 12),
             splitLine = list(lineStyle = list(color = "#e0e0e0", type = "dashed"))) %>%
    e_theme("westeros") %>%
    e_grid( right = "15%", bottom = "40%")  # Increased bottom padding
})

  
  # Job Type Chart - Histogram with Customized Bins and Animation
  output$job_type_chart <- renderEcharts4r({
    cleaned_jobs %>%
      dplyr::count(job_type) %>%
      e_charts(job_type) %>%
      e_bar(n, 
            name = "Job Type", 
            itemStyle = list(color = "#FF7043")) %>%
      e_tooltip(trigger = "item", formatter = "{b}: {c}") %>%
      e_title("Jobs by Job Type", left = "center") %>%
      e_legend(show = FALSE) %>%
      e_animation(duration = 1000, easing = "cubicOut") %>%
      e_theme("infographic")
  })
  
  
  
  
  
  
  
  # Total Jobs
  output$totalJobs <- renderText({
    nrow(cleaned_jobs)
  })
  
  # Active Jobs
  output$Active <- renderText({
    cleaned_jobs %>%
      dplyr::filter(job_status == "Active") %>%
      nrow()
  })
  
  # Tenders in Rwanda
  output$tenders <- renderText({
    cleaned_jobs %>%
      dplyr::filter(job_category == "Tenders in Rwanda") %>%
      nrow()
  })
  
  # Academic/Education Jobs
  output$Academics <- renderText({
    cleaned_jobs %>%
      dplyr::filter(job_category == "Â Education/ Academic/ Teaching") %>%
      nrow()
  })
  
  # Full-Time Jobs
  output$full_time <- renderText({
    cleaned_jobs %>%
      dplyr::filter(job_type == "Full-Time") %>%
      nrow()
  })
  
  # Part-Time Jobs
  output$part_time <- renderText({
    cleaned_jobs %>%
      dplyr::filter(job_type == "Part-Time") %>%
      nrow()
  })

  
  
  
  
  
  
  #### Mentolship 
  
  # Mock mentor data
  mentors <- data.frame(
    name = c(" Didier Ngamije", " Dr.Belle Fille Murorunkwere", "Theonest Ndayisenga", "Dr. Idrissa Kayijuka"),
    expertise = c("Proffessional Data Analyst", "PhD holder in Data Science (Data Mining)", "Data Scientist, Risk Analyst, Financial Engineer, and Higher Learning Educator.", "PhD in Applied Mathematics"),
    location = c("Kigali", "Musanze", "Huye ", "Rubavu"),
    role = c("Proffessional Data Analyst", "PhD holder in Data Science (Data Mining)", "Data Scientist, Risk Analyst, Financial Engineer, and Higher Learning Educator.", "PhD in Applied Mathematics"),
    photo = c("Didier.jpeg", "Belefile.jfif", "Theo.jfif", "Idrissa.jfif")
  )
  
  # Render Mentor Cards
  output$mentor_cards <- renderUI({
    filtered_mentors <- mentors %>%
      filter(
        grepl(input$mentor_search, expertise, ignore.case = TRUE) | 
          grepl(input$mentor_search, location, ignore.case = TRUE)
      )
    
    lapply(1:nrow(filtered_mentors), function(i) {
      tags$div(
        class = "mentor-card",
        tags$img(src = filtered_mentors$photo[i], alt = "Mentor Photo"),
        h3(filtered_mentors$name[i]),
        p(filtered_mentors$role[i]),
        p(filtered_mentors$location[i]),
        actionButton(paste0("request_", i), "Request Mentorship", class = "btn-primary")
      )
    })
  })
  
  # Sample Event Data
  events <- data.frame(
    name = c("Rwanda Job Fair 2024", "Tech Hackathon"),
    date = as.Date(c("2024-11-25", "2024-12-10")),
    location = c("Kigali", "Rubavu"),
    description = c("Connect with top employers in Rwanda.", "Compete in teams to solve tech challenges.")
  )
  
  # Render Event Table
  output$event_table <- renderDataTable({
    filtered_events <- events %>%
      filter(date >= input$event_date[1] & date <= input$event_date[2])
    datatable(filtered_events, options = list(pageLength = 5), rownames = FALSE)
  })
  
  # Peer Networking Wall
  messages <- reactiveVal(data.frame(user = character(0), message = character(0)))
  
  observeEvent(input$post_message, {
    new_message <- data.frame(user = "User", message = input$peer_message)
    messages(rbind(messages(), new_message))
  })
  
  output$peer_networking_wall <- renderUI({
    req(messages())
    tags$div(
      lapply(1:nrow(messages()), function(i) {
        tags$div(
          class = "networking-post",
          tags$strong(messages()$user[i]),
          p(messages()$message[i])
        )
      })
    )
  })
  
  # Mentor Scheduling
  output$mentor_schedule <- renderUI({
    tagList(
      selectInput("mentor_select", "Select Mentor", choices = mentors$name),
      actionButton("schedule_session", "Schedule Mentorship", class = "btn-primary")
    )
  })
  
  observeEvent(input$schedule_session, {
    showModal(modalDialog(
      title = "Mentorship Session Scheduled",
      paste("You have scheduled a session with", input$mentor_select),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  
  
  
  
  
  
  ######## Skills and Resources ################################################
  
  
  observeEvent(input$career_guidance, {
    showModal(
      modalDialog(
        title = "Career Guidance",
        "Here, you can find tailored tips for job applications, downloadable resume templates, and interview preparation guides.",
        footer = modalButton("Close")
      )
    )
  })
  
  observeEvent(input$funding_opportunities, {
    showModal(
      modalDialog(
        title = "Funding Opportunities",
        "We’ve curated a list of scholarships, grants, and other financial aid opportunities available to Rwandan youth.",
        footer = modalButton("Close")
      )
    )
  })
  
  observeEvent(input$mental_health_support, {
    showModal(
      modalDialog(
        title = "Mental Health Support",
        "Reach out to trusted counselors or participate in mental health workshops.",
        footer = modalButton("Close")
      )
    )
  })
  
  observeEvent(input$resume_builder, {
    showModal(
      modalDialog(
        title = "Resume Builder",
        "Our intuitive resume builder guides you step-by-step to create a professional CV.",
        footer = modalButton("Close")
      )
    )
  })
  
  observeEvent(input$skill_assessment, {
    showModal(
      modalDialog(
        title = "Skill Assessment",
        "Take a quick skill assessment to understand your strengths and receive career path suggestions.",
        footer = modalButton("Close")
      )
    )
  })
  
  observeEvent(input$send_message, {
    showNotification(
      paste("Thank you,", input$user_name, "for reaching out! We'll get back to you shortly."),
      type = "message"
    )
  })
  
}



shinyApp(ui, server)