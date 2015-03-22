#!/bin/bash
COMBOS()
{
find vendor/moonlight/products -name moonlight_*.mk | while read FILE; do basename $FILE .mk | sed 's/moonlight\_//g'; done
}
for x in `COMBOS | sort -h`; do
  add_lunch_combo moonlight_$x-eng
  add_lunch_combo moonlight_$x-userdebug
  add_lunch_combo moonlight_$x-user
done

