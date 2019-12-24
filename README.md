# blog.greghale.io

The source code for my personal blog.

## Hacking

Some of the entries need haskell dependencies. Use `shells.nix` to set
these dependencies and to use them when editing a post.

For example, the `config-phases` post depends on `generic-lens`, so 
we have an entry in `shells.nix` to specify that:

```
 shellPkgs =
    { config-phases = ["generic-lens" "lens" "postgresql-simple" "katip"]; };
```

To work on the `config-phases` post, enter that shell by name:

```
> nix-shell ./shells.nix -A config-phases
```

Get all the way into a `ghcid` loop like this:

```
> nix-shell ./shells-nix -A config-phases --run 'ghcid --command "ghci posts/2019-10-17-config-phase.lhs"'
```

## Vertigo simulator

I don't expect vertigo simulator to change often, so I just build it manually
with reflex-platform, minify the javascript, and check the javascript into git.

``` sh
> ../reflex-platform/try-reflex
> ghcjs vertigo.hs -o vertigo-tmp -dedupe
```

``` sh
> nix-shell -p closure-compiler
> closure-compiler -js vertigo-tmp.jsexe/all.js js/vertigo-simulator.js
```
