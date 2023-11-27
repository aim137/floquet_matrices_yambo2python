# Floquet matrices as produced by Yambo

I'm sharing here some of the matrices required to evaluate whether the Floquet quasi-energy operator is ill conditioned in the presence of many-body effects.
I'm also presenting a way to generate them.
 
## Generate matrices

Use the devel-fl branch of the develop repository. Uncomment the lines under

```
DEBUG EXPORT QE OPERATOR<
...
DEBUG EXPORT QE OPERATOR>
```
in `./src/floquet/FL_diagonalization.F` and recompile the code.
Then use the bash scripts named fly.sh inside each directory for the different levels of theory (IPA, TDH, H+SEX).

## Use already generated matrices

Use the function `read_H_file(<fullpath>)` in the file `functions.py` to load a single matrix.

Alternatively, use the script `process.py`, where I use a namedtuple with (Matrix, iteration, k-point, path). In this script, I load all matrices of a given simulation (IPA case) at once, and it can be easily adapted for the other levels of theory.

Finally, the function `read_H_file(<fullpath>)` is from the class FLegeneracy in my Floquet module NLFLeigenvectors (https://github.com/aim137/NLFLeigenvectors). You can use this class and take advantage of other methods written there for degeneracies.

## Contributions

Contributions are welcome. Feel free to take these scripts and treat them as your own.
