from connector import Connector

class Loader(Connector):

    # Load CSV file with headers
    def load_file(self, fname: str):
        with open(fname, 'r') as f:
            headers = f.readline().split(',')
            


if __name__ == '__main__':

    with Loader() as db:
        db.load_file('Food_contents_2019.csv')


