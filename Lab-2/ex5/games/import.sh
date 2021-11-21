#!/bin/bash

mongoimport -d cbd -c games --type csv --headerline --file steam.csv
mongoimport -d cbd -c games --type csv --headerline --mode merge --ignoreBlanks --upsertFields=appid --file steam_description_data.csv
mongoimport -d cbd -c games --type csv --headerline --mode merge --ignoreBlanks --upsertFields=appid --file steam_media_data.csv
mongoimport -d cbd -c games --type csv --headerline --mode merge --ignoreBlanks --upsertFields=appid --file steam_requirements_data.csv
mongoimport -d cbd -c games --type csv --headerline --mode merge --ignoreBlanks --upsertFields=appid --file steam_support_info.csv
#mongoimport -d cbd -c games --type csv --headerline --mode merge --ignoreBlanks --upsertFields=name --file games_reviews/steam_reviews.csv