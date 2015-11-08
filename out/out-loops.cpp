#include <iostream>
using namespace std;

int main() {
	int num_nodes = 18;
	int num_agents = 0;
	for (int i = 0; i < num_nodes; i++) {
		for (int j = 0; j < num_nodes; j++) {
			cout << i << " " << num_agents << endl;
			num_agents++;
		}
	}

	int ite = 0;
	int jStart = 0;
	for (int i = 0; i < 18; i++) {
		for (int j = jStart; j < 19; j++) {
			if (j == 18) {
				cout << ite + i + 1 << endl;
				continue;
			}

			cout << ite << " " << (18*j + i) << endl;
			ite++;
		}
		jStart++;
	}
}