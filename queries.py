from prettytable import PrettyTable

def run_queries(cur):
    try:
        with open("queries.sql", 'r') as f:
            queries = f.read()
            queries = queries.split(';')
        queries = [i.strip('\n') for i in queries][:len(queries)-1]

        print(queries)
        for query in queries:
            print(f"\nExecuted query: {query}")
            cur.execute(query + ';')
            results = cur.fetchall()
            # print(results)
            headings = [i[0] for i in cur.description]
            # print(headings)
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