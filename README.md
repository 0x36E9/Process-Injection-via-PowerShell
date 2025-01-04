## Introduction
Process hollowing is yet another tool in the kit of those who seek to hide the presence of a process. The idea is rather straight forward: a bootstrap application creates a seemingly innocent process in a suspended state. The legitimate image is then unmapped and replaced with the image that is to be hidden. If the preferred image base of the new image does not match that of the old image, the new image must be rebased. Once the new image is loaded in memory the EAX register of the suspended thread is set to the entry point. The process is then resumed and the entry point of the new image is executed.

## Overview
The Loader.cs is a C# implementation of a RunPE process hollowing technique. This technique is used to inject and execute a PE (Portable Executable) payload into a legitimate process's memory space, effectively hiding its presence.
The script.ps1 likely acts as the initiating script, which either:
Downloads the compiled Loader binary.
Executes the Loader with the required parameters (e.g., URLs or paths to payloads).

## Building The Source Executable

