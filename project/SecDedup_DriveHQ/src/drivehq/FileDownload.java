package drivehq;

import java.io.File;

import Cloudme.CloudmeFolderNode;
import Cloudme.CloudmeUser;

public class FileDownload {

	public static synchronized boolean fileDownload(String filepath)
	{
		try
        {
			CloudmeUser user = new CloudmeUser("sarikasingh2902","cloud123");
			
			CloudmeFolderNode node = user.getFolderManager().getFolderTree();
			
			for(CloudmeFolderNode n : node.getChildren()){
				
				if(n.getFolder().getName().equals("deduplication"))
				{
					n.getFolder().getFile(new File(filepath).getName()).downloadFile(filepath);
					
					return true;
				}
			}
			
			user.killUser();
	    }
		catch(Exception e)
		{
			e.printStackTrace();
			
			return false;
		}
		
		return false;
	}
}
