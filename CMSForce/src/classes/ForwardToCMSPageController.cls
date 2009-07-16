//  Copyright (c) 2009, David Van Puyvelde, Sales Engineering, Salesforce.com Inc.
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. 
//  Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  Neither the name of the salesforce.com nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission. 
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
//  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
//  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

public class ForwardToCMSPageController {


	//in your 'file not found' template add this controller as an extension
	//and point the action attribute to the gotoPage method.
	//This will make your CMS Pages accessible by name (useful for marketing mails etc ...)
	//<apex:page showHeader="false" title="{!$Label.site.file_not_found}" controller="ForwardToCMSPageController" action="{!gotoPage}">
	public PageReference gotoPage() {
		//check out the page the user is trying to access
		
		//commented out : only works in an org with Sites enabled. Let's wait for Summer 09 ? ...
		String origUrl = 'notyetimplemented';
		//String origUrl = EncodingUtil.urlDecode(Site.getOriginalUrl(), 'UTF-8') ;
		//try to find a page with that name
		try {
			Page__c p = [select Id from Page__c where Name =:origUrl];
			//now forward the request to the CMS page with that Id
			ApexPages.Pagereference pr = new ApexPages.Pagereference('/page?pageid='+p.Id);
			return pr;
		}
		catch(Exception ex) {
			return null;	
		}
	}
	
	
	
	public static testMethod void t1() {
		//dummy test
		ForwardToCMSPageController fc = new ForwardToCMSPageController();
		System.assertEquals(fc.gotoPage(), null);
	}

}