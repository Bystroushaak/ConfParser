/**
 * conf_parser.d
 *
 * Simple configuration parser.
 * 
 * Author:  Bystroushaak (bystrousak@kitakitsune.org)
 * Date:    20.11.2011
 * 
 * Copyright: 
 *     This work is licensed under a CC BY.
 *     http://creativecommons.org/licenses/by/3.0/
*/
import std.string;



/// Return associative array with configuration parsed from string
string[string] parseConfiguration(string conf, string[string] def_conf = null){
	string[string] parsed_conf;
	
	foreach(line; conf.splitLines()){
		if (line.indexOf("=") <= 0)
			continue;
		
		// comments
		if (line.indexOf("#") >= 0){
			if (line.indexOf("#") == 0)
				continue; 
				
			line = line[0 .. line.indexOf("#")];
			
			if (line.strip().length == 0)
				continue;
		}
		
		string[] tmp = line.split("=");
		
		// remove whitespaces from key & val
		tmp[0] = tmp[0].strip();
		tmp[1] = tmp[1].strip();
		
		parsed_conf[tmp[0].toUpper()] = tmp[1];
	}
	
	// set default configuration
	if (def_conf != null){
		foreach(key, val; def_conf){
			if (key !in parsed_conf)
				parsed_conf[key] = val;
		}
	}
	
	return parsed_conf;
}
