import requests
import json

# This script uses the RapidAPI LinkedIn web scraper to pull specified job search results
# using the /search-jobs-v2 end point
# Then, I do the following search

""" 
Job Search : Hybrid Entry-level DevOps Engineer Contract jobs in the United States paying at least an
$120k salary, posted with the past week and sorted by most relevant.

"""

# I use a try-except block for error handling while doing the API call.
# Within the try-except block, I use a conditional statement to check if the HTTP GET request is successful
# and the results are not empty. Then I use a for loop to extract the information I want from the json data in a structured,
# readable format.

url = "https://linkedin-data-api.p.rapidapi.com/search-jobs-v2"

querystring = {
    "keywords":"Cloud Infrastructure",
    "locationId":"103644278", # this is the geoId for United States
    "datePosted":"pastWeek",
    "salary":"120k+",
    "jobType":"contract",
    "experienceLevel":"entryLevel",
    "titleIds":"25764", # this is the titleId for "DevOps Engineer"
    "onsiteRemote":"hybrid",
    "sort":"mostRelevant"
    
}

headers = {
	"x-rapidapi-key": "48961a044cmshfa2d8f35cb544a4p11aaa2jsn7c3494fa30f5",
	"x-rapidapi-host": "linkedin-data-api.p.rapidapi.com"
}

try:
    response = requests.get(url,headers=headers, params=querystring)

    if response.status_code == 200:
        # Parse the JSON content
        data = response.json()
        
        # Print the prettified JSON with indentation
        pretty_json = json.dumps(data, indent=4)
        print(pretty_json)
        
        # Check if 'data' key exists and contains job listings
        if 'data' in data and len(data['data']) > 0:
            # Loop through each job listing and extract specific details
            for job in data['data']:
                # Extracting specific details
                job_title = job.get('title', 'No title available')
                location = job.get('location', 'No location available')
                job_type = job.get('type', 'No type available')
                benefits = job.get('benefits', 'No benefits available')
                job_url = job.get('url', 'No URL available')

                # Print extracted information
                print(f"Job Title: {job_title}")
                print(f"Location: {location}")
                print(f"Type: {job_type}")
                print(f"Benefits: {benefits}")
                print(f"URL: {job_url}")
                print("-" * 40)
        else:
            print("No jobs found in the response.")
        
        
    else:
        print(f"Failed to retrieve data: {response.status_code}")
        
except requests.exceptions.ConnectionError as e:
    print(f"Network error occurred: {e}")
