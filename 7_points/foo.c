#include <stdio.h>

// ПРОГРАММА ЗАПУСКАЕТСЯ И ИСПОЛНЯЕТСЯ КОРРЕКТНО ПРИ НАЛИЧИИ ФАЙЛА input.txt
void get_array_size(int* size, FILE *input) {
	// scanf("%d", size);
	fscanf(input, "%d", size);
}

void get_array(int* a, int size, FILE *input) {
	for (int i = 0; i < size; ++i) {
		// scanf("%d", &(a[i]));
		fscanf(input, "%d", &(a[i]));
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

void print_array(int* a, int size, FILE* output) {
	for (int i = 0; i < size; ++i) {
		fprintf(output, "%d ", a[i]);
		printf("%d ", a[i]);
	}
}

int main(int argc, char** argv) {
	if (argc != 3) {  // argv[0] is the name of executed file
        	printf("Command line must have 2 arguements - names of files input/output\n");
        	return 1;
        }
        
	int n;
	FILE *input, *output;
	input = fopen(argv[1], "r");
	get_array_size(&n, input);
	int a[n];
	get_array(a, n, input);
	fclose(input);
        
	
	int needed_arguements_quality = 0;
	for (int i = 1; i < n-1; ++i) {
		if (a[i] != a[0] && a[i] != a[n-1]) {
			++needed_arguements_quality;
		}
	}
	
	int b[needed_arguements_quality];
	create_new_arr(a, b, n);
	
	output = fopen(argv[2], "w");
	print_array(b, needed_arguements_quality, output);
	fclose(output);
	
	return 0;
}
