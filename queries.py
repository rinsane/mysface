from prettytable import PrettyTable

def run_queries(cur):
    try:
        queries = [
            ("SELECT user, host, plugin FROM mysql.user WHERE user = 'root';", ["User", "Host", "Plugin"]),
            ("SHOW DATABASES;", ["Database"]),
            ("CREATE DATABASE students;", [])
        ]

        for query, headings in queries:
            print(f"\nExecuted query: {query}")
            cur.execute(query)
            if headings:
                results = cur.fetchall()
                display_results(results, headings)
    except Exception as e:
        print("\nAn exception occurred!")
        print(e, '\n')
    
def display_results(res, headings):
    table = PrettyTable()
    table.field_names = headings
    table.align = 'l'

    for row in res:
        table.add_row(row)

    print(table)