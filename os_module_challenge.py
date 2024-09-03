import os

# script that counts the number of items within a directory
def directory_count():
    directory = input("Enter the directory that you want to count: ")
    
    try:
        items = os.listdir(directory)
        file_count = 0
        dir_count = 0
        for item in items:
            path = os.path.join(directory, item)
            if os.path.isfile(path):
                file_count += 1
            elif os.path.isdir(path):
                dir_count += 1
        return print(f"Total number of files in '{directory}': {file_count}\n"
                    f"Total number of directories in '{directory}': {dir_count}")
    except FileNotFoundError:
        print(f"{directory} does not exist.")
    except Exception as e:
        print("An error occured at {e}")

# Call function
directory_count()
