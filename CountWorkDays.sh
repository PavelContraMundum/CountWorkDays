#!/bin/zsh

# Kontrola, zda byly zadány správné parametry
if [ $# -ne 2 ]; then
  echo "Použití: $0 'DD. MM. YYYY' pocet_dni"
  exit 1
fi

# Přijetí parametrů
input_date=$1
days_to_add=$2

# Převod zadaného data do formátu YYYY-MM-DD pro jednodušší zpracování
formatted_date=$(date -j -f "%d. %m. %Y" "$input_date" "+%Y-%m-%d")

# Počítadlo přidaných pracovních dnů
workdays_added=0

# Přejdeme přes každý den, dokud nepřidáme požadovaný počet pracovních dnů
while [ $workdays_added -lt $days_to_add ]; do
  # Přidejte jeden den k datu
  formatted_date=$(date -j -v+1d -f "%Y-%m-%d" "$formatted_date" "+%Y-%m-%d")
  
  # Získat den v týdnu (1 = pondělí, ..., 7 = neděle)
  day_of_week=$(date -j -f "%Y-%m-%d" "$formatted_date" "+%u")
  
  # Pokud je to pracovní den (pondělí až pátek), zvýšíme počítadlo
  if [ $day_of_week -lt 6 ]; then
    workdays_added=$((workdays_added + 1))
  fi
done

# Zobrazení výsledného data ve formátu DD. MM. YYYY
new_date=$(date -j -f "%Y-%m-%d" "$formatted_date" "+%d. %m. %Y")
echo "Původní datum: $input_date"
echo "Po připočtení $days_to_add pracovních dnů: $new_date"

