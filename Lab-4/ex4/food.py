class FoodStats:

    def __init__(self,
food_name,
food_code,
description,
group,
group__sub_class_,
comments,
description_footnote,
energy__kcal_,
protein__g_,
carbohydrate__g_,
total_sugars__g_,
starch__g_,
citric_acid__g_,
malic_acid__g_,
total_phytosterols__mg_,
other_cholesterol_and_phytosterols__mg_,
phytosterol__mg_,
beta_sitosterol__mg_,
brassicasterol__mg_,
campesterol__mg_,
delta_5_avenasterol__mg_,
delta_7_avenasterol__mg_,
delta_7_stigmastenol__mg_,
stigmasterol__mg_,
all_trans_retinol__µg_,
_13_cis_retinol__µg_,
dehydroretinol__µg_,
retinaldehyde__µg_,
alpha_carotene__µg_,
beta_carotene__µg_,
cryptoxanthins__µg_,
lutein__µg_,
lycopene__µg_,
_25_hydroxy_vitamin_d3__µg_,
cholecalciferol__µg_,
_5_mehtyl_folate__µg_,
alpha_tocopherol__mg_,
beta_tocopherol__mg_,
delta_tocopherol__mg_,
gamma_tocopherol__mg_,
alpha_tocotrienol__mg_,
delta_tocotrienol__mg_,
gamma_tocotrienol__mg_,
water__g_,
total_nitrogen__g_,
protein__g__dupe,
fat__g_,
carbohydrate__g_dupe,
energy__kcal_dupe,
starch__g_dupe,
oligosaccharide__g_,
total_sugars__g_dupe,
glucose__g_,
galactose__g_,
fructose__g_,
sucrose__g_,
maltose__g_,
lactose__g_,
alcohol__g_,
nsp__g_,
aoac_fibre__g_,
satd_fa__by_100g_fa_g_,
satd_fa_by_100g_fd__g_,
n_6_poly__by_100g_fa_g_,
n_6_poly__by_100g_food_g_,
n_3_poly__by_100g_fa_g_,
n_3_poly__by_100g_food_g_,
cis_mono_fa__by_100g_fa_g_,
cis_mono_fa__by_100g_food_g_,
mono_fa__by_100g_fa_g_,
mono_fa__by_100g_food_g_,
cis_polyu_fa__by_100g_fa_g_,
cis_poly_fa__by_100g_food_g_,
poly_fa__by_100g_fa_g_,
poly_fa__by_100g_food_g_,
sat_fa_excl_br__by_100g_fa_g_,
sat_fa_excl_br__by_100g_food_g_,
branched_chain_fa__by_100g_fa_g_,
branched_chain_fa__by_100g_food_g_,
ans_fas__by_100g_fa_g_,
ans_fas__by_100g_food_g_,
cholesterol__mg_,
retinol__µg_,
carotene__µg_,
retinol_equivalent__µg_,
vitamin_d__µg_,
vitamin_e__mg_,
vitamin_k1__µg_,
thiamin__mg_,
riboflavin__mg_,
niacin__mg_,
tryptophanby_60__mg_,
niacin_equivalent__mg_,
vitamin_b6__mg_,
vitamin_b12__µg_,
folate__µg_,
pantothenate__mg_,
biotin__µg_,
vitamin_c__mg_,
sodium__mg_,
potassium__mg_,
calcium__mg_,
magnesium__mg_,
phosphorus__mg_,
iron__mg_,
copper__mg_,
zinc__mg_,
chloride__mg_,
manganese__mg_,
selenium__µg_,
iodine__µg_
):
        food_all = [ s.strip() for s in food_name.split(',') ]
        name = food_all[0]
        characteristics = food_all[1:]

        # Food node
        self.name = name

        # Variation node
        self.characteristics = characteristics              # as RELATIONSHIP attributes to FOOD
        self.code = food_code
        self.description = description
        self.description_footnote = description_footnote
        self.comments = comments
        self.energy_kcal = float(energy__kcal_)
        self.protein_g = float(protein__g_)
        self.total_sugars_g = float(total_sugars__g_)
        self.water_g = float(water__g_)
        self.fat_g = float(fat__g_)
        self.lactose_g = float(lactose__g_)
        self.alcohol_g = float(alcohol__g_)
        self.cholesterol_mg = float(cholesterol__mg_)

        # Group node
        self.group = group.strip()

        # Sub-group node
        self.sub_group = group__sub_class_

class Food:

    def __init__(self, stats: FoodStats):
        self.name = stats.name
    
    def __hash__(self):
        return hash(self.name)

class Variation:

    def __init__(self, stats: FoodStats):
        self.characteristics = stats.characteristics
        self.code = stats.code
        self.description = stats.description
        self.description_footnote = stats.description_footnote
        self.comments = stats.comments
        self.energy_kcal = stats.energy_kcal
        self.protein_g = stats.protein_g
        self.total_sugars_g = stats.total_sugars_g
        self.water_g = stats.water_g
        self.fat_g = stats.fat_g
        self.lactose_g = stats.lactose_g
        self.alcohol_g = stats.alcohol_g
        self.cholesterol_mg = stats.cholesterol_mg

        self._food = Food(stats)
        self._sub_group = SubGroup(stats)

    def __hash__(self):
        return hash(self.code)
    
    def food(self) -> Food:
        return self._food

    def sub_group(self) -> 'SubGroup':
        return self._sub_group

class Group:

    def __init__(self, stats: FoodStats):
        self.name = stats.group

    def __hash__(self):
        return hash(self.name)

class SubGroup:

    def __init__(self, stats: FoodStats):
        self.code = stats.sub_group
        
        self._group = Group(stats)
    
    def __hash__(self):
        return hash(self.code)
    
    def group(self) -> Group:
        return self._group