import mysql.connector as myscon
import queries
import os

def main():
    try:
        credentials_file = "./credentials.txt"
        if os.path.isfile(credentials_file):
            with open("credentials.txt", "r") as file:
                creds = file.readlines()
                user_host = creds[0].rstrip('\n')
                user_port = creds[1].rstrip('\n')
                user_name = creds[2].rstrip('\n')
                user_pass = creds[3].rstrip('\n')
        else:
            with open("credentials.txt", "w") as file:
                user_host = input("Enter user host: ") + '\n'
                user_port = input("Enter user port: ") + '\n'
                user_name = input("Enter user name: ") + '\n'
                user_pass = input("Enter user pass: ")
                creds = file.writelines([user_host, user_port, user_name, user_pass])

        con = myscon.connect(user=user_name, passwd=user_pass, host=user_host, port=int(user_port)) 
        print("successfully established connection!")

        cur = con.cursor()
        print("calling queries...")
        queries.run_queries(cur)
        con.commit()
        print("commit made.")
        con.close()
        print("connection closed.")
    except Exception as e:
        print("\nAn exception occurred!")
        print(e, '\n')

if __name__ == "__main__":
    main()