# PowerShell Lab Exercises

In these labs, try to work with PowerShell commands alone. 
Work along with the commands in your shell or read the entire section and go back; it’s up to you. I suggest that you try each of the commands shown and understand what it is doing before moving on.

> TIP: Download this file to your workstation, then paste your answers straight into it for reference.

## Lab 1 - Exploring the System

The first thing we always need to do is learn to interact with the operating system.
PowerShell provides some ways to use the ‘good old tools’ that you’re used to, but there are advantages to just working in PowerShell.

You’re on a Linux system running PowerShell Core. That means that certain Windows PowerShell commands are missing. You’re also missing standard Windows commands that might be there in the background.

> TIP: The CmdLets available will differ depending on the OS and PowerShell version. PowerShell Core CmdLets should be available on all versions.


|   Prefix | Purpose  |
|------------:|---|
| Get | Get a value or object |
| Set | Set/define a value |
| Start | Run a process or function |
| Stop | Stop a process or function|
| Out | Output an object |
| Write | Output an object |
| New | Create a new object |

A list of CmdLets can be found with `Get-Command`.

![Get-Command](https://github.com/daemonchild/lab-powershell/raw/master/docs/images/labnotes-getcommand.png)

You can use the following to get a complete list of CmdLets and their aliases.

`PS /> Get-Help -Category cmdlet`

![Get-Help CmdLet](https://github.com/daemonchild/lab-powershell/blob/master/docs/images/labnotes-gethelpcmdlet.png)

*(This may take some time, Ctrl-C to abort.)*

We will look at sorting and selecting output as we go.

> TIP: PowerShell provides command completion. Use the Tab key to display a list of valid options for each stage. For example:

![picture](https://github.com/daemonchild/lab-powershell/blob/master/docs/images/labnotes-tabcompletion.png)

Use this feature to explore some other commands and their options. Run the command once you’ve built a suitable command line using Tab completion. There are questions to answer below.

* Get-Process
* Get-ChildItem
* Get-Content

TIP: PowerShell internal help pages may be useful, such as `Get-Help Get-Process -Example`



### Questions

For each question, note the answer and the command line you used.

**Get-Process**

* How many processes are running on your system?

* Who owns the the ssh process(s)? 

* Why do you think that you see a very limited number of processes? 


> TIP: On a Windows machine, you can also use Get-Service...


**Get-ChildItem**

Exercise files are located in /pwsh-labs/exercises (read only).


* List the contents of the folder. 

* List the contents of the folder and subfolders.


> TIP: It is possible to chain CmdLets together using the | (pipe). This is useful for formatting and sorting output.


* How many files and folders are there under the folder?

* How many .txt files are there under the folder?


**Get-Content**

* Describe the contents of /pwsh-labs/exercises/forks/robots.txt

* Describe the contents of /pwsh-labs/exercises/forks/poem.txt 

* How many words are there in the poem?

* How many lines of poetry are there? 


## Lab 2 - Working with CSV Files

CSV support is built into PowerShell. First view the raw contents of the file.

For convenience, why not set a variable for the filename?

	PS /> $movies = '/pwsh-labs/exercises/spoons/movies.csv'
	PS /> Get-Content $movies

Reading a CSV file is really easy. Then display the data in raw format.

	PS /> $csvdata = Import-CSV $movies
	PS /> $csvdata

[picture]

### Activity

* Print the data in a table format

* Print the data in a list format

* What is the name of the fourth film?

* Sort the movie titles alphabetically

* List movie Titles with a score over 8.0

* What is the name of the moves with the highest score?

* Print the name of the movie with the lowest score?



## Lab 3 - Writing a Script

In this lab, you will create a script with two functions.
You should use the Linux program 'nano' to edit files within the PowerShell labs.

`PS /> nano script.ps1`

|   Command | Purpose  |
|------------|---|
| Ctrl-X | Exit, option to save file |
| Ctrl-O | Save file without exiting |


This may be useful if you get stuck in nano:
[https://www.howtogeek.com/howto/42980/the-beginners-guide-to-nano-the-linux-command-line-text-editor/](https://www.howtogeek.com/howto/42980/the-beginners-guide-to-nano-the-linux-command-line-text-editor/)

* Create a script file in your user folder.
* Enter a set of commands into the script. You could reuse some of your previous work?
* Save it and run it.

The commands should execute in order.
A PowerShell script with one command per line is functionally the same as chaining commands with a semi-colon.

### Activity

Here are some code snippets that you need to encode and decode base64.

Encode:
`[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("Plaintext"))`

Decode:
`[Text.Encoding]::Utf8.GetString([Convert]::FromBase64String("UGxhaW50ZXh0"))`

Your task is to create two functions which perform this task for any value of plaintext or base64.

	function FunctionName ( parameter definition ) { 
		function code 
	}

> TIP: Write down an algorithm for each function first. (How it should work).

* What is the content of /pwsh-labs/exercises/knives/core-program.txt?

# End of Labs













