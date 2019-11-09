package;

import sys.io.File;

class Morse {
	static function main() {
		var morse_data = File.getContent("morse.csv");
		var morse : Map<String, String> = new Map<String,String>();
		
		try {
			morse = (new CsvParser(morse_data, ":")).parseMap();
		} catch (msg:Dynamic) {
			Sys.println(msg);
			Sys.exit(1);
		}
		var c : Null<Int>;
		while (true) {
			c = Sys.getChar(false);
			if (c == 4 || c == null || c == 0)
				break;
			Sys.print(morse.get(String.fromCharCode(c).toLowerCase()));
		}
	}
} 

class CsvParser {
	var data : String;
	public var elementSep : String;
	public var lineSep : String;
	
	public function new(data:String, elementSep:String=",", lineSep:String="\n") {
		this.data = data;
		this.elementSep = elementSep;
		this.lineSep = lineSep;
	}
	
	public function parseMap() : Map<String, String> {
		var table = parseTable();
		var map = new Map<String, String>();
		for (line in table) {
			if (line.length != 2)
				throw new InputFormatException("some lines have more than two elements");
			
			map.set(line[0], line[1]);
		}
		return map;
	}
	
	public function parseTable() : Array<Array<String>> {
		var lines = data.split(lineSep);
		var elements = new Array<Array<String>>();
		for (line in lines) {
			elements.push(line.split(elementSep));
		}
		
		return elements;
	}
}

class InputFormatException {
	var msg : String;
	
	public function new(msg:String) {
		this.msg = msg;
	}
	
	public function toString() : String {
		return msg;
	}
}