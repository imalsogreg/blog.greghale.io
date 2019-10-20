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
