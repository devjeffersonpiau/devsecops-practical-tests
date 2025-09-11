import sys, pathlib
# garante que a pasta 02-seguranca-containers (pai de tests/) está no sys.path
sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[1]))

from app import app

def test_index():
    client = app.test_client()
    r = client.get('/')
    assert r.status_code == 200
    assert b'DevSecOps' in r.data
