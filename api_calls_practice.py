import requests
import json

url = "https://livescore6.p.rapidapi.com/matches/v2/list-live"

headers = {
    'x-rapidapi-key': "48961a044cmshfa2d8f35cb544a4p11aaa2jsn7c3494fa30f5",
    'x-rapidapi-host': "livescore6.p.rapidapi.com"
}

queryString = {
    "Category": "tennis",
    "Timezone": "-7"
}

response = requests.get(url, headers=headers, params=queryString)


if response.status_code == 200:
    # Parse the JSON content
    data = response.json()
    
    # Print the prettified JSON with indentation
    pretty_json = json.dumps(data, indent=4)
    print(pretty_json)
else:
    print(f"Failed to retrieve data: {response.status_code}")
