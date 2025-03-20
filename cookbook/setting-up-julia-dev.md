# Setting up a Julia development environment

Assuming you already have Julia installed.

## Recipe

1. Identify which package you want to develop the source code of. In the REPL
   `pkg` mode, type

   ```julia
   pkg> dev PACKAGE_NAME
   ```

   E.g.

   ```julia
   pkg> dev SpectralFitting
   ```

   This will clone the `git` repo into `~/.julia/dev/` by default. It will also
   bind, within the environment that you ran `dev` in, the SpectralFitting
   module to the development version.

> [!NOTE]
> `dev` is a read-only action, it will not modify any existing files on the
> filesystem, only create new ones. If you `dev` from two different
> environment, they will use the same `~/.juli/dev/` directory.
>
> Also note that `dev` will only fetch the default (usually `main`) branch
> of a package, not the entire repository. You will need to `cd` to the
> `~/.julia/dev/PACKAGE_NAME` directory and manipulate the git state to match
> what you need.
>
> E.g., to fetch a new branch `git fetch origin BRANCH_NAME` and switch with
> `git switch BRANCH_NAME`.

2. You can now load the development version of the package:

   ```julia
   using PACKAGE_NAME
   ```

3. Since you'll probably want to be modifying the source code and testing out
   small incremental changes, the default mode for `dev` is still to cache
   compilation units. This means, you'd have to dump your REPL for changes to
   take place.

   To avoid this, you can use the
   [Revise.jl](https://github.com/timholy/Revise.jl). This will then
   automatically reload any changes that you make in the development source code
   without needing to reload your REPL. The usual caveat about constants and
   structs applies, however.

   To use

   ```julia
   using Revise
   using PACKAGE_NAME
   ```

   Note: `Revise` must be loaded before the package you are intending to develop.

4. When you're done, you'll likely want to unpin the package from the being in
   development mode. You can do that using `pkg> free PACKAGE_NAME`.

When using Revise.jl, if the prompt turns yellow (usually preceded by an error
message with a compiler stack trace), this means you need to fix a compiler
error in your code.

When you think you have done this, you can ask Revise.jl to reload the package
using:

```julia
Revise.retry()
```


