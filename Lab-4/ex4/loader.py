from neo4j import Transaction
from connector import Connector
from food import FoodStats, Food, Variation, Group, SubGroup
from csv import reader



class Loader(Connector):

    # Load CSV file with headers
    def load_file(self, fname: str):
        food_stats = []
        with open(fname, 'r', newline='') as f:
            # Skip header
            f.readline()
            for line in reader(f):
                food_stats.append( FoodStats(*line) )
        
        variations = { Variation(s) for s in food_stats }
        # Reuse created references for the Variations
        foods = { v.food() for v in variations }
        sub_groups = { v.sub_group() for v in variations }
        groups = { sg.group() for sg in sub_groups }

        with self.session() as s:
            
            # GROUP insertion
            pct = 0
            ln = len(groups)
            self.report_progress('GROUP', pct)

            for group in groups:
                s.write_transaction(self.create_group, group)

                pct += 1
                self.report_progress('GROUP', 100*pct//ln)
            print()

            # SUB_GROUP insertion
            pct = 0
            ln = len(sub_groups)
            self.report_progress('SUB_GROUP', pct)

            for sub_group in sub_groups:
                s.write_transaction(self.create_sub_group, sub_group)

                pct += 1
                self.report_progress('SUB_GROUP', 100*pct//ln)
            print()

            # FOOD insertion
            pct = 0
            ln = len(foods)
            self.report_progress('FOOD', pct)

            for food in foods:
                s.write_transaction(self.create_food, food)

                pct += 1
                self.report_progress('FOOD', 100*pct//ln)
            print()

            # VARIATION insertion
            pct = 0
            ln = len(variations)
            self.report_progress('VARIATION', pct)

            for variation in variations:
                s.write_transaction(self.create_variation, variation)
                
                pct += 1
                self.report_progress('VARIATION', 100*pct//ln)
            print()

        
            
    def create_group(self, tx: Transaction, group: Group):
        tx.run("""
            MERGE (g:Group {name: $name})
            """, name=group.name)
    
    def create_sub_group(self, tx: Transaction, sub_group: SubGroup):
        tx.run("""
            MATCH (g:Group {name: $group_name})
            MERGE (sg:SubGroup {code: $subgroup_code})-[:PART_OF]->(g)
            """, group_name=sub_group.group().name, subgroup_code=sub_group.code)

    def create_food(self, tx: Transaction, food: Food):
        tx.run("""
            MERGE (f:Food {name: $name})
            """, name=food.name)

    def create_variation(self, tx: Transaction, variation: Variation):
        tx.run("""
            MATCH (sg:SubGroup {code: $subgroup_code})
            MATCH (f:Food {name: $food_name})
            MERGE (f)<-[:OF {characteristics: $characteristics}]-(v:Variation {
                code: $code,
                description: $description,
                description_footnote: $description_footnote,
                comments: $comments,
                energy_kcal: $energy_kcal,
                protein_g: $protein_g,
                total_sugars_g: $total_sugars_g,
                water_g: $water_g,
                fat_g: $fat_g,
                lactose_g: $lactose_g,
                alcohol_g: $alcohol_g,
                cholesterol_mg: $cholesterol_mg
                })-[:BELONGS_TO]->(sg)
            """,
            food_name=variation.food().name,
            subgroup_code=variation.sub_group().code,
            code=variation.code,
            description=variation.description,
            description_footnote=variation.description_footnote,
            comments=variation.comments,
            energy_kcal=variation.energy_kcal,
            protein_g=variation.protein_g,
            total_sugars_g=variation.total_sugars_g,
            water_g=variation.water_g,
            fat_g=variation.fat_g,
            lactose_g=variation.lactose_g,
            alcohol_g=variation.alcohol_g,
            cholesterol_mg=variation.cholesterol_mg,
            characteristics=variation.characteristics)

    def report_progress(self, entity, pct):
        print('\rInserting {0}s: {1}%'.format(entity, pct), end='')



if __name__ == '__main__':

    with Loader() as db:
        db.load_file('Food_contents_2019.csv')


