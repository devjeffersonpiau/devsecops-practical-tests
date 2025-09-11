import re
import sys
from pathlib import Path

log_path = Path('../02-seguranca-containers/app.log')
if not log_path.exists():
    print('Arquivo de log não encontrado:', log_path)
    sys.exit(1)

text = log_path.read_text()
patterns = [
    r"('|")\s*or\s*('|")?1('|")?\s*=\s*('|")?1('|")?",
    r"\bUNION\b|\bSELECT\b|\bDROP\b",
    r"(\%27)|(' OR '1'='1)"
]

alerts = []
for p in patterns:
    if re.search(p, text, flags=re.IGNORECASE):
        alerts.append(p)

if alerts:
    print('POSSÍVEIS ALERTAS DETECTADOS. Padrões encontrados:')
    for a in alerts:
        print(' -', a)
    sys.exit(2)
else:
    print('Nenhuma evidência de SQLi detectada nos logs.')
