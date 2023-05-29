#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int get_max(char* file_name) {
    fstream f;
    f.open(file_name, ios::in);

    string s;
    int sum = 0, mx = 0;
    while (getline(f, s)) {
        if (mx < sum)
            mx = sum;
        if (s != "")
            sum += stoi(s);
        else
            sum = 0;
    }

    f.close();
    return mx;
}       

struct Max {
    int a, b, c;

    Max(int a, int b, int c) : a(a), b(b), c(c) { }
};

int& get_min(int& mn1, int& mn2, int& mn3) {
    if (mn1 <= mn2)
        return mn1 <= mn3 ? mn1 : mn3;
    else if (mn2 <= mn1)
        return mn2 <= mn3 ? mn2 : mn3;
    else
        return mn3;
}

Max get_top_3(char* file_name) {
    fstream f;
    f.open(file_name, ios::in);

    string s;
    int sum = 0, mx1, mx2, mx3;
    mx1 = mx2 = mx3 = 0;
    while (getline(f, s)) {
        if (get_min(mx1, mx2, mx3) < sum)
            get_min(mx1, mx2, mx3) = sum;
        if (s != "")
            sum += stoi(s);
        else
            sum = 0;
    }

    f.close();
    return Max(mx1, mx2, mx3);
}

int main(int argc, char* argv[]) {
    auto [a, b, c] = get_top_3(argv[1]);

    cout << "part 1: " << get_max(argv[1]) << endl;
    cout << "part 2: " << a + b + c << endl;
    return 0;
}
