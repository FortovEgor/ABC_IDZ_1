#include <stdio.h>

void get_array_size(int* size) {
	scanf("%d", size);
}

void get_array(int* a, int size) {
	for (int i = 0; i < size; ++i) {
		scanf("%d", &(a[i]));
	}
}

void create_new_arr(int* a, int* b, int size_a) {
	int j = 0;
	for (int i = 1; i < size_a; ++i) {
		if (a[i] != a[0] && a[i] != a[size_a-1]) {
			b[j] = a[i];
			++j;
		}
	}
}

void print_array(int* a, int size) {
	for (int i = 0; i < size; ++i) {
		printf("%d ", a[i]);
	}
}

int main(int argc, char** argv) {

	int n;
	get_array_size(&n);
	int a[n];
	get_array(a, n);
	
	int needed_arguements_quality = 0;
	for (int i = 1; i < n-1; ++i) {
		if (a[i] != a[0] && a[i] != a[n-1]) {
			++needed_arguements_quality;
		}
	}
	
	int b[needed_arguements_quality];
	create_new_arr(a, b, n);
	print_array(b, needed_arguements_quality);
	return 0;
}
