---
title: Wireless All-to-All Analog Spiking Neural Networks
description: A modular design for in silico spiking neural networks
tags: Science, Neuroscience, AI
draft: true
---

# Abstract

Spiking neural networks offer a biologically inspired machine learning substrate that
operates in the analog domain and adjusts its connections via biologically plausible
learning rules. Brain-inspired neural networks may be more likely to capture features
of learning that are difficult to achieve in deep learning substrates hosting transformers-
based large language models, such as continual learning and memory consolidation. However,
spiking neural networks are difficult to scale due to the difficulty of densely connecting
member neurons. The scaling problem becomes more pronounced as the individual neurons become
more complex, incorporating features like spatial dendritic organization and synaptic plasticity.
This paper proposes a design for a modular spiking neuron that listens to all neurons in the
viscinity through analog radio impulses, separates the sources, and supplies the dendritic
arbor with plastic inputs from single upstream neurons. A tiling of such neurons creates a
large network in which nearby pairs are connected, while pairs outside of radio range
are effectively disconnected. Radio receiver configurations can be further tuned to
recaputulate useful features of biological networks, such as cortical column boundaries.
We offer a simulation of the technique and an analysis of the neural density achievable for
neurons of various levels of complexity.


# Introduction


One goal of neuromorphic computing is to incorporate features of biological brains into the
design of machine learning systems. There are two motivations that justify this approach:
the ability of the human brain to operate at much higher energy efficiency than comparable
large language models, and the ability of human brains to continuously learn from stimuli
experienced after the release of the model.

The goals and the motivations above can be considered as a continuum. At the far left side
is the current transformer architecture, and at the far right is the hyperrealistic simulation
of networks of biological neurons with many membrane segments and ion-specific voltage-gated
and ligand-gated channels. There are many points along this spectrum representing different
levels of abstraction and biological realism. It is unclear which level of realism unlocks
human-level learning abilities, and which features are simply evolutionary accidents or
are purely accommodations to the specific physical environment that biological neurons find
themselves in. Does a simulation that distributes its synapses over a large dendritic tree
perform qualitatively better than one where all synapses are onto a single-compartment
model dendrite? Does the ability for individual branches add a special form of learning?
Are spike bursts essential? Or are each of these features just an adaptation to the fact
that brains have to wire up through blind growth and pruning, or that post-synaptic potentials
fade with rapid use. If the latter case is true, it would be a waste of resources to explore
applying these factors to our in-silico models.

A major challenge in testing the variously realistic nearal networks is that it is difficult
to wire sufficient numbers of neurons together into circuits of similar complexity to those
found in real brains, especially if that wiring allows for the synaptic potentian that is
almost certainly necessary for learning. To achieve a fully post-von Neumann system that
stores synaptic weighs directly where they are used, rather than fetching them from a separate
memory system on each cycle, each synapse must somehow store both its weight and a mechanism
for adjusting that weight via local learining rules.

We propose a framework for taming this complexity, by separating the two forms of electrical
communication into two separate channels. We completely eliminate axons and the complexity
of routing axons through dendritic arbors by replacing the axon with a weak radio transmitter,
which emits a brief pulse analagous to an action potential when the neuron spikes.
Each neuron contains a small array of four antennae that independently sense the spikes of
nearby neurons, and differences in the amplitudes of the spikes at the antennae provide
a signal that can be used to perform source separation, analogous to the method of tetrode
recording for source separation in hippocampal and cortical recordings. Each receiving
neuron's source-separated signals are then faned out to tunable synapses on the neuron's
dendritic arbor. From this point, the neuron behaves as any other analog artificial
spiking neuron. In our framework, this single-neuron topology is a free variable, and
we can apply the same inter-neuron connection scheme to drive either simple LIF neurons,
or more complicated neurons with complex arbors and local learning rules.

The main challenges to our approach are (a) the implementation source separation in the
analog domain and (b) the fanout of sources to artificial synapses. The main contribution
of this paper is a characterization of the analog source separation process, and an
analysis of the spatial requirements of various types of single spiking neurons augmented
with a radio array and source separation components. These size constraints in turn
impact the number of neurons that can be in a locally connected network, and the packing
density of neurons onto a physical substrate.
