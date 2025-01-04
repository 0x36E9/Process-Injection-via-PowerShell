## Introduction
Process hollowing is yet another tool in the kit of those who seek to hide the presence of a process. The idea is rather straight forward: a bootstrap application creates a seemingly innocent process in a suspended state. The legitimate image is then unmapped and replaced with the image that is to be hidden. If the preferred image base of the new image does not match that of the old image, the new image must be rebased. Once the new image is loaded in memory the EAX register of the suspended thread is set to the entry point. The process is then resumed and the entry point of the new image is executed.

## Overview
The Loader.cs is a C# implementation of a RunPE process hollowing technique. This technique is used to inject and execute a PE (Portable Executable) payload into a legitimate process's memory space, effectively hiding its presence.
The script.ps1 likely acts as the initiating script, which either:
Downloads the compiled Loader binary.
Executes the Loader with the required parameters (e.g., URLs or paths to payloads).

## Technical Details of Loader.cs

Key Functions in Loader.cs:

    ```C#
      RunPe(byte[] payloadBuffer, string host, string args):
    ```
        Core function that handles process hollowing.
        Uses low-level Windows API calls (e.g., CreateProcess, VirtualAllocEx, WriteProcessMemory) to:
            Create a new suspended process.
            Replace the legitimate process image with the payload.
            Adjust the thread context and resume execution from the payload's entry point.
    Launch(string appurl, string path):
        Downloads a PE payload from appurl.
        Calls RunPe to execute the payload using the specified path.

Low-Level Process Hollowing Steps:

    A target process is created in a suspended state (CreateProcess).
    The memory image of the target process is unmapped (ZwUnmapViewOfSection).
    Memory is allocated in the target process (VirtualAllocEx) for the payload.
    The payload is written into the target process memory (WriteProcessMemory).
    The thread context is modified to point to the entry point of the payload (SetThreadContext).
    The process thread is resumed (ResumeThread), executing the payload.

