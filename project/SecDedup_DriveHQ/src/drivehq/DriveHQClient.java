package drivehq;

import java.io.*;
import org.apache.commons.net.ftp.*;

public class DriveHQClient {

    private FTPClient ftpClient;

    public boolean connect(String host, int port, String user, String pass) {
        try {
            ftpClient = new FTPClient();
            ftpClient.connect(host, port);

            int replyCode = ftpClient.getReplyCode();
            if (!FTPReply.isPositiveCompletion(replyCode)) {
                ftpClient.disconnect();
                return false;
            }

            if (!ftpClient.login(user, pass)) {
                ftpClient.logout();
                return false;
            }

            ftpClient.enterLocalPassiveMode();
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean uploadFile(String localPath, String remotePath) {
        try (InputStream input = new BufferedInputStream(new FileInputStream(localPath))) {

            return ftpClient.storeFile(remotePath, input);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean downloadFile(String remotePath, String localPath) {

        try (OutputStream output =
                     new BufferedOutputStream(new FileOutputStream(localPath))) {

            return ftpClient.retrieveFile(remotePath, output);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void disconnect() {
        try {
            if (ftpClient != null && ftpClient.isConnected()) {
                ftpClient.logout();
                ftpClient.disconnect();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
