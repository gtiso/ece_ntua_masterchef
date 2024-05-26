import mysql.connector
from tabulate import tabulate

db_config = {
    'user': 'root',
    'password': '',
    'host': '127.0.0.1', 
    'database': 'masterchef'
}

try:
    connection = mysql.connector.connect(**db_config)

    if connection.is_connected():
        cursor = connection.cursor()

    def printFun():
        connection.commit()
        for result in cursor.stored_results():
            columns = result.column_names
            rows = result.fetchall()
            if rows:
                print(tabulate(rows, headers=columns, tablefmt='grid'))
            else: print("No values returned.")
# --------------------------------------------------------------------------
# 3.* QUESTIONS / RUN NEW SEASONS / CREATE NEW COOK USER

    print("Input Options : 'x' (Executing 3.x Question), 'x seasons' (Creating x new seasons), 'x create_user' (Creating user cookx), 'exit' (Exiting..)")

    while True:
            user_input = input()
            
            if user_input.lower() == "exit":
                print("Exiting the program.")
                break
            
            if user_input.isdigit():
                number = int(user_input)
                match number:
                    case 1:
                        cursor.callproc('Question_1')
                        printFun()
                    case 2:
                        cuisine_id = input("Input the Cuisine ID: ")
                        year = input("Input the Year number: ")
                        if (cuisine_id.isdigit() and year.isdigit()):
                            cursor.callproc('Question_2', (cuisine_id,year,))
                            printFun()
                    case 3:
                        cursor.callproc('Question_3')
                        printFun()
                    case 4:
                        cursor.callproc('Question_4')
                        printFun()
                    case 5:
                        cursor.callproc('Question_5')
                        printFun()
                    case 6:
                        cursor.callproc('Question_6')
                        printFun()
                    case 7:
                        cursor.callproc('Question_7')
                        printFun()
                    case 8:
                        cursor.callproc('Question_8')
                        printFun()
                    case 9:
                        cursor.callproc('Question_9')
                        printFun()
                    case 10:
                        cursor.callproc('Question_10')
                        printFun()
                    case 11:
                        cursor.callproc('Question_11')
                        printFun()
                    case 12:
                        cursor.callproc('Question_12')
                        printFun()
                    case 13:
                        cursor.callproc('Question_13')
                        printFun()
                    case 14:
                        cursor.callproc('Question_14')
                        printFun()
                    case 15:
                        cursor.callproc('Question_15')
                        printFun()
                    case default:
                        print(f"There is no 3.{default} Question")
            else:
                parts = user_input.split()

                if len(parts) == 2 and parts[0].isdigit() and parts[1].lower() == "seasons":
                    number = int(parts[0])
                    cursor.callproc('RunSeasons', (number,))
                    printFun()
                
                elif len(parts) == 2 and parts[0].isdigit() and parts[1].lower() == "create_user":
                    number = int(parts[0])
                    cursor.callproc('CreateCookUser', (number,))
                    connection.commit()
                    print(f"User {number} created.")

                else:
                    print("Please enter valid input.")

# --------------------------------------------------------------------------

except mysql.connector.Error as err:
    print(f"Error: {err}")

finally:
    if connection.is_connected():
        cursor.close()
        connection.close()