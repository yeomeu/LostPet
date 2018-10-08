package gmail.yeomeu.pet.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileService {
	@Value("${upfile.root}") String rootDir; ///Users/yeom/Documents/pets 
	
	public String save( MultipartFile file, String uniqueName ) {
		// 1. 유일한 파일 이름 생성하기
		
		File f = new File(rootDir, uniqueName); //  /Users/yeom/Documents/pets/2983ksd-3iuhsdjh-3kjsjd-dskd
		
		FileOutputStream fos  = null;
		try {
			InputStream in = file.getInputStream();
			fos = new FileOutputStream(f);
			
			// 2. rootDir + ufilename 으로 파일 저장하기
			// 네트워크로 도착한 파일 스트림을 디스크로 써넣습니다.
			IOUtils.copy(in, fos);
//			int ch ;
//			while ( (ch=in.read()) >= 0 ) {
//				fos.write(ch);
//			}
			fos.close();
			return uniqueName;
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
		
		// 3. end! 
	}
	/**
	 * 로컬 디스크에서 파일을 읽어들여서 바이트를 반환합니다.
	 * @param uniqueFile
	 * @return
	 */
	public byte[] read ( String uniqueFile ) {
		File path = new File(rootDir, uniqueFile);
		FileInputStream fin;
		try {
			fin = new FileInputStream(path);
			byte [] data = IOUtils.toByteArray( fin );
			return data;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
	}
}
