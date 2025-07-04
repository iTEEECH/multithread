# Multithread

## Summary
- 🚀 Platforms
- 📃 Description
- ⚙️ Setup
- 💻 Use case

## Platforms
| Android | iOS | Web |
|:-------:|:---:|:---:|
|    ✅    |  ✅  |  ❌  |

## Description

This Flutter project presents some examples of how multithreading can be implemented in a Flutter application, using 3 different approaches (main thread, calculation method, separate isolates).

### Concurrency

Concurrency focuses on managing multiple tasks within overlapping time periods, though not necessarily executing them simultaneously. This concept differs from parallelism, where tasks truly run at the same time.

***Example***

Think of it as an air traffic controller managing multiple aircraft with a single radio. The controller communicates with one plane at a time giving landing instructions to aircraft A, then departure clearance to aircraft B, then weather updates to aircraft C, but all planes receive timely guidance through rapid task switching, creating the impression of continuous, simultaneous communication. 

In programming, this translates to an environment where multiple processes share a single CPU core, with the system rapidly switching between tasks to create the illusion of simultaneous execution.

### Parallelism

Parallelism involves multiple tasks executing simultaneously using multiple resources (CPU cores, threads, or processes). Unlike concurrency, tasks truly run at the same time.

***Example***

Imagine multiple air traffic control towers operating simultaneously at different airports. Tower A manages flights at Airport 1, Tower B handles traffic at Airport 2, and Tower C controls airspace at Airport 3. Each controller works independently with their own radio and radar system, managing their aircraft at exactly the same time without any coordination needed between towers.

In programming, this means having multiple CPU cores or separate processes working on different parts of a problem simultaneously.

For further information, please refer to [Dart documentation](https://dart.dev/language/concurrency).