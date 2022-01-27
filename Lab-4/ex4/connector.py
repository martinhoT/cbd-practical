from neo4j import GraphDatabase, SessionConfig

class Connector:

    def __init__(self):
        self._driver = GraphDatabase.driver('bolt://localhost:7687', auth=('neo4j', 'cbd'))

    def session(self):
        return self._driver.session(database='lab44')

    def __enter__(self):
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        self._driver.close()