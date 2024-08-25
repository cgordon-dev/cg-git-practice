"""
Date Simulator
    
This Python script simulates a date scenario at a seafood restaurant. 
The user provides inputs for their budget, orders from a menu for themselves and their date, and manages their remaining budget. 
The script includes error handling for invalid inputs and budget constraints. 
After ordering, the user decides whether to pay the bill. 
The script then evaluates the success of the date based on factors like generosity, balance in ordering, and conversation topics. 
Depending on these factors, it determines if the user will get a second date.
    
    
"""

import sys

def get_float_input(prompt):
    while True:
        try:
            return float(input(prompt))
        except ValueError:
            print("Please enter a valid number.")

def print_menu(menu):
    print("\n--- Seafood Restaurant Menu ---")
    for category, items in menu.items():
        print(f"\n{category}:")
        for item, price in items.items():
            print(f"  {item}: ${price:.2f}")
    print("-------------------------------")

def take_order(menu, budget, person):
    print(f"\n{person}'s turn to order:")
    total_cost = 0
    while True:
        print("\nAvailable Categories:")
        for category in menu:
            print(f"  - {category}")
        category_choice = input("Enter the category or type 'done' to finish ordering: ").strip().title()
        
        if category_choice.lower() == 'done':
            break
        
        if category_choice not in menu:
            print("Invalid category. Please choose from the available categories.")
            continue
        
        print(f"\nAvailable items in {category_choice}:")
        for item, price in menu[category_choice].items():
            print(f"  {item}: ${price:.2f}")
        
        item_choice = input(f"Enter the item from {category_choice} you want to order: ").strip().title()
        
        if item_choice not in menu[category_choice]:
            print("Item not on the menu. Please choose again.")
            continue
        
        item_price = menu[category_choice][item_choice]
        
        if total_cost + item_price > budget:
            print("You don't have enough budget for this item. Try something else.")
            continue
        
        total_cost += item_price
        print(f"Ordered {item_choice} for ${item_price:.2f}. Remaining budget: ${budget - total_cost:.2f}")
    
    return total_cost

def get_user_confirmation(prompt):
    while True:
        response = input(prompt).strip().lower()
        if response in ['yes', 'no']:
            return response == 'yes'
        print("Please enter 'yes' or 'no'.")

def evaluate_date(your_order_cost, date_order_cost, total_cost, budget, date_name):
    # Logic based on multiple factors
    if total_cost > budget * 0.7:
        generosity_score = 1
    else:
        generosity_score = 0

    if date_order_cost > your_order_cost:
        balance_score = 1
    else:
        balance_score = 0
    
    conversation_topic = input(f"\nYou and {date_name} had a great conversation! What did you talk about? (movies, travel, work): ").strip().lower()
    if conversation_topic in ['movies', 'travel']:
        conversation_score = 1
    else:
        conversation_score = 0
    
    # Calculating final score
    final_score = generosity_score + balance_score + conversation_score
    
    if final_score >= 2:
        print(f"\nCongratulations! {date_name} enjoyed the date, and you got a second date!")
    else:
        print(f"\nSorry, {date_name} wasn't impressed. No second date.")

def main():
    print("Welcome to the Date Simulator!")
    date_name = input("Who is on the date with you? ").title()
    budget = get_float_input("Enter your budget for the date: $")

    menu = {
        "Appetizers": {
            "Clam Chowder": 7.50,
            "Shrimp Cocktail": 12.00,
            "Oysters Rockefeller": 15.00
        },
        "Main Course": {
            "Grilled Salmon": 22.00,
            "Lobster Tail": 35.00,
            "Seafood Paella": 28.00
        },
        "Desserts": {
            "Key Lime Pie": 8.00,
            "Chocolate Mousse": 9.00,
            "Cheesecake": 8.50
        },
        "Beverages": {
            "White Wine": 10.00,
            "Red Wine": 12.00,
            "Sparkling Water": 3.00
        }
    }

    print_menu(menu)
    
    your_order_cost = take_order(menu, budget, "Your")
    budget -= your_order_cost
    
    date_order_cost = take_order(menu, budget, f"{date_name}'s")
    budget -= date_order_cost

    total_cost = your_order_cost + date_order_cost

    print(f"\nThe total cost of the date is ${total_cost:.2f}.")
    print(f"Remaining budget: ${budget:.2f}")
    
    if not get_user_confirmation("Do you agree to pay the bill? (yes/no): "):
        print("You must agree to pay the bill. Exiting...")
        sys.exit(1)

    print(f"Thank you for your payment. Your final budget is ${budget:.2f}.")

    # Evaluate the date based on multiple factors
    evaluate_date(your_order_cost, date_order_cost, total_cost, budget, date_name)

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit(1)
