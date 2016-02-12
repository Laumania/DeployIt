# DeployMe
Often you find your self deploying your .NET web or console applications in the same stupid, manual way.
The (stupid) process often goes something like this:
- Manually build/publish your project in Visual Studio (in the right configuration!)
- Manually navigating to the destination folder on some share on a Test/Prod server.
- Manually copy all the right files into a "Backup" folder, with the date and time as a name, or something similar.
- Manually delete all the files in the folder (and maybe not all, if it's really bad, you have a custom app.config or web.config, that you *cannot* delete, as it only lives there and not in your source control).
- Manually go back to your the folder your build/published your project to.
- Manually copy over all files from it, to the destination share on the Test/Prod server.
- Hope you didn't make any mistake in any of the above...

Yes, we should all work with CI, Github deploy on Azure etc. etc., but sometimes that's not immediately possible - and this is where the "DeployMe" script templates comes in handy.
