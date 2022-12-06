# PPP-Loan-Map
Interactive Map of PPP Loans in Pueblo, Colorado - Business Name, Jobs Retained, and Date of Loan Approval

During the COVID-19 Pandemic, over five million businesses in the United States received Paycheck Protection Program (PPP) Loans.
The intention of these loans was to help small businesses retain their employees during mandatory closures.

The link below is data used for creating this app. This data provides information on PPP Loans in Colorado:
https://data.colorado.gov/Business/Paycheck-Protection-Program-Loans-in-Colorado/73ay-2ues
A copy of the data is included in this repository - "Paycheck_Protection_Program_Loans_in_Colorado.csv".

The purpose of this app is to allow the user to view the locations of businesses in a community that received PPP Loans.
The app will generate an interactive map where the user can hover over and click on points to view the business name,
number of jobs retained by the loan, and the date the loan was approved. The user can also specify a date range for loan approval,
viewing the increase over the period from early April to the end of June in 2020. 

The data was cleaned to only include businesses in the Pueblo area. This was because geocode has a 2500 a day limit in generating 
latitude and longitude points from addresses. 
See included cleaning code: "PPP Data Cleaning.R"
Cleaned data: "puebloppp.csv"

A user interested in Colorado data could change the zip codes, clean the data, and generate a map of their chosen area. 
A user interested in data from another state could upload the appropriate file, input their desires zip codes, clean the data as needed, and generate a similar map.
