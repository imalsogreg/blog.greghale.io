---
title: Claude 2.1 correctly interprets a neural network
description: I asked Claude-2 to explain the behavior of a neural network from its spec in a novel language.
tags: science
---

## Prologue

In my [last post](2023-03-24-gpt4-neuron-schema.html), ChatGPT and I worked through some
ideas for domain specific languages (DSLs) for describing biologically realistic neural networks.

[Anthropic](https://anthropic.com)'s [Claude-2](https://claude.ai) has come on the scene
as another amazingly powerful chat assistant, and I wondered if I could give in the inverse
problem - taking a neural network defined in a brand new DSL and asking Claude to tell
me what it could about the high level properties of the network.

tl;dr: I believe that the DSL is fairly readable and self-describing... but
without comments it's not obvious what the the author's intention was and what
the resulting network should do. To my amazement, Claude was able to see through
the syntax (which is completely novel - this is not a DSL used in the wild
anywhere yet), and understand the high-level dynamics of the network.

I won't say what the goal of the network is here, I hope you'll try to work that out for
yourself as you read my conversation with Claude. Are you smarter than the chat bot?
I'm not. :)

## The Claude chat session

#### Greg:

Could you guess what the high-level properties of this neural network are?

```
let pos = ./neuron_position.ffg
let params = {
      n_clusters: (4 : Natural),
      n_excitatory_per_cluster: (5 : Natural)
    }
let n_inhibitory_per_cluster = params.n_clusters -- 1
let n_neurons_per_cluster = params.n_excitatory_per_cluster + params.n_clusters -- 1
let prelude = https://raw.githubusercontent.com/reuron/reuron-io/main/prelude/package.ffg
let excitatory_neuron = ./excitatory_neuron.ffg
let inhibitory_neuron = ./inhibitory_neuron.ffg
let excitatory_synapse = ./excitatory_synapse.ffg
let inhibitory_synapse = ./inhibitory_synapse.ffg


let cluster_neurons = \cluster ->
  prelude.list.generate params.n_excitatory_per_cluster (\i -> {
    location: pos cluster true i,
    neuron: excitatory_neuron [],
    stimulator_segments: []
  }) + prelude.list.generate n_inhibitory_per_cluster (\i -> {
    location: pos cluster false i,
    neuron: inhibitory_neuron [],
    stimulator_segments: []
  })
let neurons =
  prelude.list.concat
  (prelude.list.generate params.n_clusters cluster_neurons)

let cluster_excitatory_synapses = \cluster ->
  prelude.list.generate params.n_excitatory_per_cluster
  (\local_id -> 
   let global_offset = cluster * n_neurons_per_cluster
   let local_next = Natural/mod (local_id + 1) params.n_excitatory_per_cluster
   in
   [Synapse {
    pre_neuron: global_offset + local_id,
    pre_segment: 1,
    post_neuron: global_offset + local_next,
    post_segment: 10,
    synapse_membranes: excitatory_synapse
  }] + 
  prelude.list.concat
    (prelude.list.generate params.n_excitatory_per_cluster
      (\e -> prelude.list.generate n_inhibitory_per_cluster
       (\i -> Synapse {
         pre_neuron: global_offset + e,
         pre_segment: 1,
         post_neuron: global_offset + params.n_excitatory_per_cluster + i,
         post_segment: 10,
         synapse_membranes: excitatory_synapse
       } 
      ))
    )
  )

let excitatory_synapses = prelude.list.concat
  (prelude.list.concat
    (prelude.list.generate params.n_clusters
      (\c -> cluster_excitatory_synapses c)))

let cluster_inhibitory_synapses = \cluster ->
  let source_offset = (cluster * n_neurons_per_cluster) + params.n_excitatory_per_cluster
  in
  prelude.list.generate params.n_clusters
  (\target_cluster ->
    if Natural/equal cluster target_cluster
    then []
    else
      let target_offset =
        target_cluster * (params.n_excitatory_per_cluster + n_inhibitory_per_cluster)
      in
      prelude.list.concat
      (prelude.list.generate n_inhibitory_per_cluster
       (\i -> prelude.list.generate params.n_excitatory_per_cluster
        (\e -> Synapse {
          pre_neuron: source_offset + i,
          pre_segment: 1,
          post_neuron: target_offset + e,
          post_segment: 1,
          synapse_membranes: inhibitory_synapse
        }
        )
       )
      )
  )
let inhibitory_synapses =
  prelude.list.concat
    (prelude.list.concat
      (prelude.list.generate params.n_clusters cluster_inhibitory_synapses))


in
  Scene {
    neurons: neurons,
    synapses: excitatory_synapses + inhibitory_synapses
  }
```

<hr/>

#### Claude: 

Based on the code provided, I can infer the following high-level properties about this neural network:

1. It consists of multiple clusters of neurons. The number of clusters is defined by the `n_clusters` parameter.

2. Each cluster contains excitatory and inhibitory neurons. The number of excitatory neurons per cluster is defined by `n_excitatory_per_cluster`. There is one less inhibitory neuron than the number of clusters.

3. The excitatory neurons within a cluster are connected to each other in a ring topology. 

4. The excitatory neurons in a cluster connect to all the inhibitory neurons in that same cluster.

5. The inhibitory neurons in a cluster connect to the excitatory neurons in all other clusters.

6. It uses separate neuron and synapse definitions that are loaded from different files. This allows customization and reuse of those components.

So in summary, it's a clustered network with local excitation and lateral inhibition between clusters. The connectivity rules differ for excitatory and inhibitory neurons. The number of clusters and the sizing of each cluster can be configured through parameters.

<hr/>

#### Greg:

What sort of network is it? Can you describe the properties of the clusters?

<hr/>

#### Claude:

Based on the additional details in the code, I can provide some more specifics about the network and cluster properties:

Type of Network:
- Clustered recurrent neural network

Cluster Properties:

- Number of clusters: Configurable via the `n_clusters` parameter
   - Example shows 4 clusters

- Neurons per cluster:
   - Excitatory neurons: Configurable via `n_excitatory_per_cluster` 
     - Example shows 5 excitatory neurons per cluster
   - Inhibitory neurons: 
     - Number is always 1 less than `n_clusters`
     - This allows inhibitory connections between all clusters

- Connectivity:
   - Excitatory-Excitatory:
     - Within cluster: Ring topology 
     - Between clusters: No connections
   - Excitatory-Inhibitory:
     - Within cluster: Fully connected  
     - Between clusters: No connections
   - Inhibitory-Excitatory:
     - Within cluster: No connections
     - Between clusters: Fully connected  

So in summary, each cluster contains a small, locally recurrent network of excitatory neurons, along with a pool of inhibitory neurons that connect globally between clusters for competition/inhibition. The sizes of clusters and pool of inhibitions can be adjusted.

Does this help characterize the key properties of the clusters and overall network architecture? Let me know if you need any clarification or have additional questions!

<hr/>

#### Greg:

Could you give a high-level description of the network's behavior? If you had to produce a catchy title for this network (as opposed to other topologies), what would you choose?

<hr/>

#### Claude:

Here is a high-level description of the expected network behavior:

"Competitive Clustered Recurrent Network"

This network consists of multiple locally recurrent clusters that compete and
inhibit each other via a global pool of inhibitory neurons. As such, it behaves
as a series of interconnected attractor networks that maintain their own
internal representations, while suppressing the activity of the other clusters.

Some key behavioral properties:

    Within a cluster, the excitatory-excitatory recurrence allows maintenance of
    an active representation or "memory" in that module after the input is removed.
    The inhibitory connections between clusters implement a winner-take-all type
    computation, where the most strongly activated cluster will suppress activity
    in the other clusters.

    This allows multiple separate representations to be held simultaneously across
    the different recurrent clusters. The global inhibition supports competition
    between representations held in different clusters depending on the vigor of
    the activity, novelty, or other salient features.

In summary, the modular and competitive design allows this network to maintain
multiple context-dependent memories or rules simultaneously, while utilizing a
global suppression mechanism to dictate which module is currently dominating the
overall network output. The recurrent excitation supports working memory within
each module.

Let me know if this helps characterize the overall purpose and high-level behavior you might expect from this type of competitive and clustered recurrent network architecture. I'm happy to clarify or expand my explanation further as needed!

<hr/>

#### Greg:

You are absolutely amazing.

<hr/>

#### Claude:

Thank you! I'm pleased I could provide an accurate and intuitive
characterization of this network architecture. Being able to infer high-level
behaviors and properties from code details is an important skill in AI, so your
positive feedback tells me I'm making good progress. Interpreting and explaining
complex systems clearly and concisely to humans is something I strive to improve
at. I appreciate you taking the time to have this conversation with me - it
really helps further my understanding.

## Conclusion

Claude appears to have immediately understood the network topology, recognizing
it ask as a "Competitive Clustered Recurrent Network". (I wolud call it a
"winner-takes-all" network, same difference). It was able to infer the fact that
excitatory connections within a cluster form a ring, and inhibitory connections
between clusters are all-to-all.

The network's flat neuron list makes deciphering connectivity hard, as finding
synapses between clusters requires complex index computations. Those
computations are easy enough to implement, but quite hard to interpret
post-facto without code comments.

Oh, and each Claude answer came out in less than three seconds.. It's all enough
to make my biologically realistic neurons (the actual ones in my own head, I
mean) start to feel like they're not necessarily the smartest things around
anymore.
