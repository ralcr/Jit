package jit;
import jit.validator.*;

class Jit {
	
	static public function main() {
		
		var args = Sys.args();
		
		// Analize the arguments
		if (args.length == 0) {
			printUsage();
		}
		else if (args.length == 1) {
			var jira = new Jira(args);
				jira.displayIssueDetails();
		}
		else {
			switch (args[0]) {
				case "open":
					var jira = new Jira(args);
					jira.openIssue( args[1] );
					
				case "branch":
					var jira = new Jira([args[1]]);
					jira.getFormattedIssueForGit( function (branchName: String) {
						var git = new Git(args);
							git.createBranchNamed( branchName );
						Sys.println( "New branch created: " + branchName );
					} );
					
				case "checkout":
				case "co":
					var issueKey = new JiraIssueKeyValidator().validateIssueKey(args[1]);
					var git = new Git(args);
					var gitBranchName = git.searchInLocalBranches( issueKey );
					if (gitBranchName != null) {
						git.checkoutBranchNamed( gitBranchName );
					} else {
						Sys.println( "Switched to branch: " + gitBranchName );
					}
					
				case "commit":
				case "ci":
				
				case "setup":
				
			}

				/*var jirassic = new Jirassic(args);
					jirassic.run();*/
		}
	}

	static public function printUsage() {
		Sys.println( haxe.Resource.getString("usage") );
		Sys.println( "You are connected to" );
		Sys.println( haxe.Resource.getString("credentials") );
	}
}