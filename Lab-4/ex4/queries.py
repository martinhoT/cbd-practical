from typing import Any, List, Tuple
from neo4j import Record, Result, Transaction
from connector import Connector



class Queries(Connector):

    def __init__(self):
        super().__init__()
        self._table_line = lambda l: '\t'.join(str(s) for s in l)

    def query_table(self, query_method, *args, **kwargs):
        with self.session() as s:
            headers, values = s.read_transaction( query_method, *args, **kwargs )

            header_line = self._table_line(headers)
            return \
                header_line + \
                '\n' + '-'*len(header_line.expandtabs()) + \
                ''.join('\n' + self._table_line(v) for v in values)

    @staticmethod
    def query1(tx: Transaction) -> Tuple[List[str], List[List[Any]]]:
        records = tx.run("""
            MATCH (f:Food)<-[:OF]-(v:Variation)
            WITH f, count(v) AS nVariations
            RETURN f.name AS food, nVariations
            ORDER BY nVariations DESC
            LIMIT 10
            """)
        
        return ( records.keys(), [ r.values() for r in records ] )
    
    @staticmethod
    def query2(tx: Transaction) -> Tuple[List[str], List[List[Any]]]:
        records = tx.run("""
            MATCH p = shortestPath( (f1:Food)-[*0..6]-(f2:Food) )
            WHERE f1 <> f2
            WITH min(length(p)) AS minDistance
            RETURN minDistance
            """)
        
        return ( records.keys(), [ r.values() for r in records ] )

    @staticmethod
    def query3(tx: Transaction, n_samples: int) -> Tuple[List[str], List[List[Any]]]:
        records = tx.run("""
            MATCH (v:Variation)
            WITH v, toIntegerOrNull( split(v.description, ' samples')[0] ) AS nSamples
            WHERE nSamples IS NOT null AND nSamples > $n_samples
            RETURN v.code AS variationCode, nSamples
            """, n_samples=n_samples)
        
        return ( records.keys(), [ r.values() for r in records ] )

    @staticmethod
    def query4(tx: Transaction, food: str) -> Tuple[List[str], List[List[Any]]]:
        records = tx.run("""
            MATCH (f:Food {name: $food})<-[:OF]-(v:Variation)
            WITH f, avg(v.lactose_g) AS avgLactose
            RETURN round(avgLactose, 2) AS avgLactose
            """, food=food)
        
        return ( records.keys(), [ r.values() for r in records ] )

    @staticmethod
    def query5(tx: Transaction, characteristic: str) -> Tuple[List[str], List[List[Any]]]:
        records = tx.run("""
            MATCH (:Food)<-[r:OF]-(v:Variation)-[:BELONGS_TO]->(:SubGroup)-[:PART_OF]->(g:Group)
            WHERE $characteristic IN r.characteristics
            WITH g, count(v) AS nVariations
            RETURN g.name AS group, nVariations
            """, characteristic=characteristic)
        
        return ( records.keys(), [ r.values() for r in records ] )

    @staticmethod
    def query6(tx: Transaction, group: str, grams: float) -> Tuple[List[str], List[List[Any]]]:
        records = tx.run("""
            MATCH (f:Food)<-[:OF]-(v:Variation)-[:BELONGS_TO]->(:SubGroup)-[:PART_OF]->(:Group {name: $group})
            WHERE v.alcohol_g > $grams
            RETURN f.name AS food, v.code AS variation
            """, group=group, grams=grams)
        
        return ( records.keys(), [ r.values() for r in records ] )

    @staticmethod
    def query7(tx: Transaction, group: str) -> Tuple[List[str], List[List[Any]]]:
        records = tx.run("""
            CALL {
                MATCH (v:Variation)-[:BELONGS_TO]->(:SubGroup)-[:PART_OF]->(:Group {name: $group})
                RETURN avg(v.energy_kcal) AS avgEnergy
            }
            WITH avgEnergy
            MATCH (f:Food)<-[:OF]-(v:Variation)-[:BELONGS_TO]->(:SubGroup)-[:PART_OF]->(:Group {name: $group})
            WHERE v.energy_kcal > 2*avgEnergy
            RETURN DISTINCT f.name AS food
            """, group=group)
        
        return ( records.keys(), [ r.values() for r in records ] )

    @staticmethod
    def query8(tx: Transaction) -> Tuple[List[str], List[List[Any]]]:
        records = tx.run("""
            MATCH (v:Variation)-[:OF]->(f:Food)
            WHERE NOT isEmpty(v.description_footnote)
            RETURN f.name AS food, v.code AS variation, v.description_footnote AS note
            """)
        
        return ( records.keys(), [ r.values() for r in records ] )

    @staticmethod
    def query9(tx: Transaction, grams: float) -> Tuple[List[str], List[List[Any]]]:
        records = tx.run("""
            MATCH (f:Food)<-[r:OF]-(v:Variation)
            WITH f, r, v
            WHERE isEmpty(r.characteristics) AND v.water_g > $grams
            WITH f, count(v) AS nVariations
            WHERE nVariations = 1
            RETURN f.name AS food
            """, grams=grams)
        
        return ( records.keys(), [ r.values() for r in records ] )

    @staticmethod
    def query10(tx: Transaction) -> Tuple[List[str], List[List[Any]]]:
        records = tx.run("""
            MATCH (g:Group)<-[:PART_OF]-(:SubGroup)<-[:BELONGS_TO]-(:Variation)-[:OF]->(f:Food)
            WITH g, count(f) AS nFoods
            RETURN g.name AS group, nFoods
            ORDER BY nFoods DESC
            LIMIT 1
            """)
        
        return ( records.keys(), [ r.values() for r in records ] )



if __name__ == '__main__':

    with Queries() as db:

        print("Query1:" , db.query_table(db.query1)                                       , sep='\n', end='\n\n')
        print("Query2:" , db.query_table(db.query2)                                       , sep='\n', end='\n\n')
        print("Query3:" , db.query_table(db.query3, n_samples=30)                         , sep='\n', end='\n\n')
        print("Query4:" , db.query_table(db.query4, food='Yogurt')                        , sep='\n', end='\n\n')
        print("Query5:" , db.query_table(db.query5, characteristic='fresh')               , sep='\n', end='\n\n')
        print("Query6:" , db.query_table(db.query6, group='Alcoholic beverages', grams=10), sep='\n', end='\n\n')
        print("Query7:" , db.query_table(db.query7, group='Fruit')                        , sep='\n', end='\n\n')
        print("Query8:" , db.query_table(db.query8)                                       , sep='\n', end='\n\n')
        print("Query9:" , db.query_table(db.query9, grams=80)                             , sep='\n', end='\n\n')
        print("Query10:", db.query_table(db.query10)                                      , sep='\n', end='\n\n')