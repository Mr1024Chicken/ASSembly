#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//if code fail to compile on omega please try visual studio. Omega have cause issue in previous lab.
void info();
void print();
int quit(int num);
void search_zip(int num);
void search_score(int max, int min);
void pop(char array[]);
void sort();
void median(int target);
void sort_score(int array[]);
typedef struct student{

	int score;
	int zip;
	char Lname[21];
	char Fname[21];
	struct student *next;
};

struct student *head;
struct student *tail;
int size,mid;

void main(){
	int i,flag=10;
	size=5;
	head=NULL;
	for(i=0;i<5;i++){                                                                            
	info();
	}

	while(flag){
	printf("Press:\n 0 quit \n 1 print\n 2 add\n 3 search_zip\n 4 search score\n 5 median\n 6 delete");
	scanf("%d",&flag);
	
	if(flag==0){
			flag= quit(flag);
			}
	if(flag==1){
				print();
				}
	if(flag==2){
			int temp;
			printf("How many would you like to add? :");
			scanf("%d",&temp);
			for(i=0;i<temp;i++) {info();}
			size+=temp;
			}
	if(flag==3){
		int temp;
		printf("Enter Zip Code: ");
		scanf("%d",&temp);
		search_zip(temp);
				
	}
	if(flag==4){
		int max,min;
		printf("Set your range for student score. \nWhat is the max of your range:");
		scanf("%d",&max);
		printf("What is the min of your range: ");
		scanf("%d",&min);
		search_score(max,min);
		}
	if(flag==5){
		
	median(20);
	}
	if(flag==6){
	char target[21];
	printf("Enter Last Name to be delete: ");
	scanf("%s",&target);
	pop(target);}
	}

	
}

void info(){
	struct student *temp = (struct student*) malloc(sizeof(struct student));

	printf("Enter First Name: ");
	scanf("%s",&temp->Fname);
	
	printf("Enter Last Name: ");
	scanf("%s", &temp->Lname);
	
	printf("Enter Score: ");
	scanf("%d", &temp->score);
	
	printf("Enter Zip code: ");
	scanf("%d",&temp->zip);

	temp->next=head;
	head=temp;
}

void print(){
struct student *temp=head;
while(temp !=NULL){
	printf("First Name: %s  Last Name:  %s  Score: %d  Zip-Code:  %d\n",temp->Fname,temp->Lname,temp->score,temp->zip);

	temp=temp->next;
	}
	
}

void search_zip(int num){

	struct student *temp= head;
	int i=0;
	while(temp !=NULL){
		if (temp->zip == num){
		printf("First Name: %s  Last Name:  %s  Score: %d  Zip-Code:  %d\n",temp->Fname,temp->Lname,temp->score,temp->zip);
		i++;
		}
		temp= temp->next;
	}
	if(i==0){
		printf("Cannot find student with the given zip code.");
		}
}

void search_score(int max, int min){
		struct student *temp =head;
		int i=0;
		while(temp!=NULL){
			if(temp->score <=max && temp->score>= min){
			printf("First Name: %s  Last Name:  %s  Score: %d  Zip-Code:  %d\n",temp->Fname,temp->Lname,temp->score,temp->zip);
			i++;
			}
			temp=temp->next;
		}	
		if(i==0){
		printf("Cannot find student score within the given range.");
		}
}
void pop(char array[]){
struct student *temp=head, *temp2=head;
 int flag=1;

 if(!strcmp(array,head->Lname)){
head=temp2->next;
free(temp2);
}
 temp=head;
while(temp !=NULL){
	if(temp->next==NULL){return;}

	if(!strcmp(array,(temp->next)->Lname)){
	 temp2=temp->next;
		temp->next=temp2->next;
		free(temp2);
	size--;
		}
	else{
		temp=temp->next;}
}
}
int quit(int num){printf("GoodBye\n"); return num;}

void median(int target){
	struct student *temp=head;
	struct student *temp2,*temp3;
	int *arr = (int*) malloc(size*sizeof(int));
	int i=0;
	while(temp !=NULL){
		int num=temp->score;
		arr[i]=num;
		i++;
		temp=temp->next;
	}
	sort_score(arr);
	mid=arr[(size+1)/2];
	printf("The median score is: %d\n",mid);
	search_score(100000,mid);
	
	
}
void sort_score(int array[]){

	int a, i, num;
		for(i=0;i <size; i++){
			for( a=0; a<size;a++){
	
			if(array[a] > array[a+1]){

		num= array[a];
		array[a]= array[a+1];
		array[a+1]=num;

		
					}
		
			}	
		}
}

