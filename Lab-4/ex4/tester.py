from connector import Connector

class Tester(Connector):

    def print_greeting(self, message):
        with self.session() as session:
            greeting = session.write_transaction(self._create_and_return_greeting, message)
            print(greeting)

    @staticmethod
    def _create_and_return_greeting(tx, message):
        result = tx.run("""
            CREATE (a:TestNode)
            SET a.message = $message
            RETURN 'Created new node with message ' + a.message + ' and id ' + id(a)
            """, message=message)
        return result.single()[0]
    
if __name__ == '__main__':
    with Tester() as db:
        db.print_greeting('Boa Tarde!')