package jit.command;
import jit.validator.*;

class Jira {
	
	var args: Array<String>;

	public function new (args: Array<String>) {
		this.args = args;
	}

	public function getFormattedIssueForGit (completion: String->Void) {
		
		var issueKey = new JiraIssueKeyValidator().validateIssueKey(args[0]);
		var requestUser = new JiraRequest();
		requestUser.getIssue (issueKey, function (response: Dynamic) {
			if (response != null) {
				completion (response.key + "_" + issueSummaryToGitBranch(response.fields.summary));
			} else {
				completion (null);
			}
		});
	}
	
	public function displayIssueDetails() {
		
		var issueKey = new JiraIssueKeyValidator().validateIssueKey(args[0]);
		var request = new JiraRequest();
		request.getIssue (issueKey, function (response: Dynamic) {
			if (response == null) {
				Sys.println( "Server error" );
			} else {
				Sys.println( "Issue id: \033[1m"+response.key+"\033[0m" );
				Sys.println( "Issue title: \033[1m"+response.fields.summary+"\033[0m" );
				Sys.println( "Branch name: \033[1m"+response.key + "_" + issueSummaryToGitBranch(response.fields.summary)+"\033[0m" );
			}
		});
	}
	
	public function openIssue (issueKey: String) {
		
		issueKey = new JiraIssueKeyValidator().validateIssueKey(issueKey);
		var request = new JiraRequest();
		request.getIssue (issueKey, function (response: Dynamic) {
			if (response == null) {
				Sys.println( "Server error" );
			} else {
				// Open the url
				var config = new Config();
				var baseUrl = config.getJiraUrl();
				var issueUrl = baseUrl + "/jira/browse/" + response.key;
				Sys.command("osascript", ["-e", "tell application \"Safari\" to activate"]);
				Sys.command("osascript", ["-e", "tell application \"Safari\" to open location \"" + issueUrl + "\""]);
			}
		});
	}
	
	function issueSummaryToGitBranch (string: String) : String {
		
		string = (~/\[(\w+)\]/g).replace(string, "");
		string = (~/[^a-zA-Z\d-]+/g).replace(string, "_");
		string = (~/_-_/g).replace(string, "_");
		string = (~/__/g).replace(string, "_");
		
	    return string;
	}
	
}