#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFERSIZE 400

int count_answers_pt1(char *s)
{	
	int i;
	int count = 0;
	size_t len = strlen(s);
	int letters[26] = {0};

	for (i = 0; i < len; i++) {
        //printf("S[%i]: %i\n",i, s[i]);
		if (s[i] >= 97 && s[i] <= 122){
            //printf("answer[%i]: %i `\n",s[i], answer[s[i]]);
            if (letters[s[i] - 97] == 0) {
                letters[s[i] - 97] = 1;
                count++;
                //printf("Count ++ = %i s[i]=%c  \n", count, s[i]);

            }
        } 
	}
	printf("%d\n", count);
	return count;
}

int count_answers_pt2(char *s)
{	
	int i;
    int j;
	int count = 0;
	size_t len = strlen(s);
	int letters[26] = {0};
    int persons = 0; 

	for (i = 0; i < len; i++) {
        //printf("S[%i]: %i\n",i, s[i]);
        if(s[i] == '\n'){
            persons++;
            //printf("Person in group: %i \n", persons);
        }
		if (s[i] >= 97 && s[i] <= 122){
            letters[s[i] - 97] += 1;
        } 
	}

    if(persons == 0){
        persons = 1;
    }

    for(j = 0; j<26; j++){
        if(letters[j] > 0 & letters[j] == persons){
            count++;
        }
    }
	printf("%d\n", count);
	return count;
}

int main(void){
    FILE * fp;

	int c;
	int i = 0;
	int total_pt1 = 0;
	int total_pt2 = 0;

	char buffer[BUFFERSIZE];

    fp = fopen("input", "r");
    if (fp == NULL){
        exit(EXIT_FAILURE);
    }

	while ((c = fgetc(fp))) {
        if (c == '\n' && buffer[i-1] == '\n') {
			total_pt1 += count_answers_pt1(buffer);
			total_pt2 += count_answers_pt2(buffer);
			printf("%s\n", buffer);
			memset(buffer, 0, BUFFERSIZE);
			i = 0;
		} else if (feof(fp)) {
			total_pt1 += count_answers_pt1(buffer);
			total_pt2 += count_answers_pt2(buffer);
			printf("%s\n", buffer);
			break;
        } else {
            buffer[i++] = (char)c;
        }
	}
	printf("total_pt1: %d\n", total_pt1);
    printf("total_pt2: %d\n", total_pt2);
    fclose(fp);

    exit(EXIT_SUCCESS);
}