# Things to find and their XPath
## Values are for German Songs

#### Should we be dividing by the number of lines or by the total number of that type of element. 
#### For example: `count(//NatUnity[@cat='brotherhood']) div count(//NatUnity)`
- NatUnity
  - total: `count(//NatUnity)` : 21
  - `count(//NatUnity[@cat='brotherhood'])`:  2
  - `count(//NatUnity[@cat='solidarity'])`: 2
  - `count(//NatUnity[@cat='loyalty'])`: 9
  - `count(//NatUnity[@cat='pride'])`: 1
  - `count(//NatUnity[@cat='patriotism'])`: 5
  - - counts are off, some have two attribute values
  - per line: `count(//NatUnity) div count(//line)`: 0.22826
  - `count(//NatUnity[@cat='brotherhood']) div count(//line)`: 0.021739
  - `count(//NatUnity[@cat='solidarity']) div count(//line)`: 0.021739
  - `count(//NatuUnity[@cat='loyalty']) div count(//line)`: 0
  - `count(//NatUnity[@cat='pride']) div count(//line)`: 0.01086956
  - `count(//NatUnity[@cat='patriotism']) div count(//line)`: 0.054348s
- Violence
  - total violence: `count(//violence)` : 3
  - nat to set: `count(//violence[@perp='native' and @victim='settler'])` : 0
  - set to nat: `count(//violence[@perp='settler' and @victim='native'])`: 0
  - ambiguous (both or either): `count(//violence[@perp='ambiguous' or @victim='ambiguous'])`: 3
  - total per line: `count(//violence) div count(//line)`: 0.0326087
  - nat to set: `count(//violence[@perp='native' and @victim='settler']) div count(//line)` : 0
  - set to nat: `count(//violence[@perp='settler' and @victim='settler']) div count(//line)`: 0
  - ambiguous (both or either): `count(//violence[@perp='ambiguous' or @victim='ambiguous']) div count(//line)`: 0.0326087
- Possess
  - total: `count(//possess)` : 5
  - `count(//possess[@kind='land'])`: 3
  - `count(//possess[@kind='people'])`: 1
  - `count(//possess[@kind='labor'])`: 0
  - `count(//possess[@kind='resource'])`: 1
  - total per live `count(//possess) div count(//line)`: 0.05434783
  -  `count(//possess[@kind='land']) div count(//line)`: 0.03260896
  - `count(//possess[@kind='people']) div count(//line)`: 0.01089657
  - `count(//possess[@kind='labor']) div count(//line)`: 0
  - `count(//possess[@kind='resource']) div count(//line)`: 0.01089657
- Sig (by mood)
  - positive:  `count(//sig[@mood='positive'])` : 3
  - negative: `count(//sig[@mood='negative'])`: 2
  - ambiguous: `count(//sig[@mood='ambiguous'])`: 5
  - positive:  `count(//sig[@mood='positive']) div count(//line)`: 0.032608696
  - negative: `count(//sig[@mood='negative']) div count(//line)`: 0.0217391
  - ambiguous: `count(//sig[@mood='ambiguous']) div count(//line)`: 0.05434783
- Homeland?
  - do we want to track this? by mood?
  - total `count(//homeland)` : 5
  - positive:  `count(//homeland[@mood='positive'])` : 5
  - negative: `count(//homeland[@mood='negative'])`: 0
  - ambiguous: `count(//homeland[@mood='ambiguous'])`: 0
  - per line: `count(//homeland) div count(//line)`  : 0.05434783
  - positive:  `count(//homeland[@mood='positive']) div count(//line)`  : 0.05434783
  - negative: `count(//homeland[@mood='negative']) div count(//line)` : 0
  - ambiguous: `count(//homeland[@mood='ambiguous']) div count(//line)` : 0
- should we pick some interest values of `@type` to track? Which ones?

