#1/bin/bash/


#prompt user to enter two integers
#prompt users  to choose an operation
#Return calculated output
#put in some checks for some error handling (divide by zero, entering the right datatype "integers only"


# Function to perform addition
add() {
    echo "Result: $(($1 + $2))"
}

# Function to perform subtraction
subtract() {
    echo "Result: $(($1 - $2))"
}

# Function to perform multiplication
multiply() {
    echo "Result: $(($1 * $2))"
}

# Function to perform division with error handling
divide() {
    if [ $2 -eq 0 ]; then
        echo "Error: Division by zero is not allowed."
        exit 1
    else
        echo "Result: $(($1 / $2))"
    fi
}


# Function to check if input is an integer
is_integer() {
    if ! [[ $1 =~ ^-?[0-9]+$ ]]; then
        echo "Error: '$1' is not a valid integer."
        exit 1
    fi
}


# Prompt the user to enter two integers
read -p "Enter the first integer: " num1
is_integer $num1

read -p "Enter the second integer: " num2
is_integer $num2

# Prompt the user to choose an operation
echo "Choose an operation:"
echo "1. Addition (+)"
echo "2. Subtraction (-)"
echo "3. Multiplication (*)"
echo "4. Division (/)"
read -p "Enter your choice (1/2/3/4): " choice

# Perform the chosen operation using conditionals
case $choice in
    1)
        add $num1 $num2
        ;;
    2)
        subtract $num1 $num2
        ;;
    3)
        multiply $num1 $num2
        ;;
    4)
        divide $num1 $num2
        ;;
    *)
        echo "Error: Invalid choice. Please select 1, 2, 3, or 4."
        exit 1
        ;;
esac

exit 0

