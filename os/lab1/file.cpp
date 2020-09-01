#include <iostream>
#include<string>

using namespace std;

int main(int argc, char const *argv[])
{

	
	string command = "cp " + string(argv[1]) + " toUse.bin"; 
	system(command.c_str());  
	system("truncate -s 1474560 toUse.bin");
	command = "dd if=toUse.bin of="+ string(argv[2]);
	system(command.c_str());
	system("rm toUse.bin");

	return 0;
}
