#include <iostream>
#include <fstream>
#include <vector>
#include <stdlib.h>
#include <string>
#include <sstream>

using namespace std;

vector<int> read_file(fstream& f) {
    f.open("input.txt", ios::in);
    vector<int> folders, sizes;
    string current;
    while (!f.eof()) {
        getline(f, current);
        if (current.find("$ cd") != string::npos && current != "$ cd ..")
            folders.push_back(0);
        if (current == "$ cd ..") {
            sizes.push_back(folders.back());
            folders.pop_back();
        }
        if (isdigit(current[0])) {
            stringstream ss(current);
            string size;
            ss >> size;
            for (auto& i : folders)
                i += stoi(size);
        }
    }
    return sizes;
}

int main() {
    fstream f;
    vector<int> contents = read_file(f);
    int sum = 0;
    for (auto i : contents)
        if (i <= 100000)
            sum += i;
    cout << sum << endl;
    return 0;
}

