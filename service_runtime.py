"""

This script Python function that calculates the uptime percentage of a service
based on the total number of hours and the number of hours the service was down.
The function takes 2 parameters(total hours and down hours, 
inputted when the function is run). 
Lastly, the function should return the uptime percentage rounded
to two decimal places.

"""

def service_runtime(total_hours, down_hours):
    try:
        # Check if total_hours is zero to avoid division by zero
        if total_hours == 0:
            return "Total hours cannot be zero."
        
        # Calculate uptime
        uptime_percentage = ((total_hours - down_hours) / total_hours) * 100
        
        # Round to two decimal places
        return round(uptime_percentage, 2)
    except Exception as e:
        return f"An error occurred: {e}"

# Example usage
total_hours = input("Enter the total hours of your service: ")
down_hours = input("Enter the amount of hours your service was down :")
result = service_runtime(int(total_hours), int(down_hours))
print(f"The uptime percentage for your service is {result} %")
