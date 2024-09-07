from prettytable import PrettyTable

ORANGE = '\033[93m'
BLUE = '\033[34m'
GREEN = '\033[92m'
RED = '\033[91m'
RESET = '\033[0m'
YELLOW = '\033[33m'

def queries_by_files(cur, files):
    for file in files:
        try:
            print(f"{ORANGE}READING QUERIES FROM {file}.sql...\n{RESET}")
            with open(file + ".sql", 'r') as f:
                queries = f.read()
                queries = queries.split(';')
            
            queries = [i.strip('\n') for i in queries][:len(queries)-1]

            # query execution
            for query in queries:
                print(f"\n{BLUE}Executing query:{RESET} {query}")
                try:
                    cur.execute(query + ';')
                    results = cur.fetchall()
                    if cur.description:
                        headings = [i[0] for i in cur.description]
                    else:
                        headings = []
                    
                    if headings:
                        display_results(results, headings)
                    elif results:
                        print(f"{GREEN}{results}{RESET}")
                    print(f"{GREEN}Query executed successfully!{RESET}")
                except Exception as e:
                    print(f"\n{RED}An exception occurred!{RESET}")
                    print(f"{RED}{e}{RESET}\n")
        except Exception as e:
            print(f"\n{RED}An exception occurred!{RESET}")
            print(f"{RED}{e}{RESET}\n")

def run_queries(cur):
    # files = ["Assignment1/tables", "Assignment1/checkers", "Assignment1/questions"]
    files = ["Assignment1/tables", "Assignment1/checkers", "Assignment1/"]
    files = ["Assignment1/", "Assignment1/checkers", "Assignment1/questions"]
    queries_by_files(cur, files)
    
def display_results(res, headings):
    table = PrettyTable()
    table.field_names = headings
    table.align = 'l'

    for row in res:
        table.add_row(row)

    print(YELLOW)
    print(table)
    print(RESET)