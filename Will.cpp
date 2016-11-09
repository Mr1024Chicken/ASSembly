#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct student_record
{
	int student_id_;
	int student_age_;
	char first_name_[21];
	char last_name_[21];	
};

struct student_record_node
{
                struct student_record* record_;
                struct student_record_node* next_;
};


struct student_record_node* temp1 = NULL;
struct student_record_node* temp2 = NULL;
struct student_record_node* first = NULL;
struct student_record_node* second = NULL;
struct student_record_node** headp = &first;
struct student_record_node** nextp = &second;
int nodeCount = 0;


void parseFile(char* filename, struct student_record_node** head);
void printNode(struct student_record_node* node);
struct student_record_node* student_record_allocate();
void student_record_node_deallocate(struct student_record_node* node);
void sortByAge(struct student_record_node** recordsHead);
void sortById(struct student_record_node** recordsHead);
void swap(struct student_record_node**node1,struct student_record_node** node2); 
void freeNodeList(struct student_record_node* head);
void appendNode(struct student_record_node* head, struct student_record_node* newNode);
void printNodeList(struct student_record_node* head);






int main (int argc, char* argv[])
{
       
	char *input = argv[1];
	
	struct student_record_node* ptr1 = NULL;
	


	parseFile(input,headp);	
	
	printNodeList(*headp);	
	sortByAge(headp);
	printf("After sorting by age:\n");
	printNodeList(*headp);



	freeNodeList(*headp);	
}


void parseFile(char* file, struct student_record_node** head)
{
	FILE* newfile;
        
		
	

	
        newfile = fopen(file, "r");

        if(newfile == NULL)
        {
                /* if newfile is NULL, the file is not found*/

                printf("This file could not be opened for reading.\n");
                exit(1);
        }

	
	

	while(fgets(file,BUFSIZ,newfile) != NULL)
	{
		

		if(nodeCount==0)
		{
		first = student_record_allocate();
		
		
		sscanf(file,"%s %s %d %d",first->record_->first_name_,first->record_->last_name_,&first->record_->student_id_,&first->record_->student_age_);
		nodeCount ++;
		continue;

		}

		if(nodeCount == 1)
		{
			second = student_record_allocate();


                	sscanf(file,"%s %s %d %d",second->record_->first_name_,second->record_->last_name_,&second->record_->student_id_,&second->record_->student_age_);

			appendNode(first,second);
			nodeCount++;
			continue;
			
		}

		if(nodeCount == 2)
		{

			temp1 = student_record_allocate();


                        sscanf(file,"%s %s %d %d",temp1->record_->first_name_,temp1->record_->last_name_,&temp1->record_->student_id_,&temp1->record_->student_age_);

			appendNode(second,temp1);

			nodeCount++;
			
			continue;

			

		}

		if(nodeCount%2 != 0)
                {

                        temp2 = student_record_allocate();


                        sscanf(file,"%s %s %d %d",temp2->record_->first_name_,temp2->record_->last_name_,&temp2->record_->student_id_,&temp2->record_->student_age_);


                        appendNode(temp1,temp2);
			nodeCount++;
			continue;

                        

                }

		if(nodeCount%2 == 0)
		{
			temp1 = student_record_allocate();


                        sscanf(file,"%s %s %d %d",temp1->record_->first_name_,temp1->record_->last_name_,&temp1->record_->student_id_,&temp1->record_->student_age_);

                        appendNode(temp2,temp1);

                        nodeCount++;

                        continue;



		}

		
	}
	

	
	
	fclose(newfile);
	return;	
}

void printNode(struct student_record_node* node)
{
	

	printf("struct student_record_node: \n");
	printf("student first name: %s\n", node->record_->first_name_);
	printf("student last name: %s\n", node->record_ ->last_name_ );
	printf("student id: %d\n",node->record_->student_id_ );
	printf("student age: %d \n",node->record_->student_age_ );
	


}

struct student_record_node* student_record_allocate()
{

	struct student_record_node* ret = calloc(1,sizeof(struct student_record_node));
	ret->record_=calloc(1,sizeof(struct student_record));
	ret->next_ = NULL;
	return ret;

}

void student_record_node_deallocate(struct student_record_node* node)
{
	free(node);

}

void sortByAge(struct student_record_node** recordsHead)
{
	int age1 = 0;
	int age2 = 0;
	int q = 0;
	struct student_record_node* num1 = *recordsHead;
        struct student_record_node* num2 = *nextp;

	for(q = 0;q<nodeCount; q++)
	{
		printf("\n%d\n",q);
		recordsHead = &first;
		nextp = &second;

	/*	while(nextp != NULL)
		{
			age1 = num1->record_->student_age_;
			age2 = num2->record_->student_age_;
			if(age1 > age2)
			{
				swap(recordsHead,nextp);


			}	
			
			num1 -> next_ = num1;
			num2 -> next_ = num2;
			recordsHead = &num1; 
			nextp = &num2;
	
		
		}end while loop*/


	}

 
}



void sortById(struct student_record_node** recordsHead)
{
	int id1 = 0;
	int id2 = 0;
	

        int q = 0;
        struct student_record_node* num1 = *recordsHead;
        struct student_record_node* num2 = *nextp;


	for(q = 0;q<nodeCount; q++)
        {
                printf("\n%d\n",q);
                recordsHead = &first;
                nextp = &second;

        /*      while(nextp != NULL)
                {
                        id1 = num1->record_->student_id_;
                        id2 = num2->record_->student_id_;
                        if(id1 > id2)
                        {
                                swap(recordsHead,nextp);


                        }

                        num1 -> next_ = num1;
                        num2 -> next_ = num2;

			recordsHead = &num1;
                        nextp = &num2;


                }end while loop*/

	}
}

void swap(struct student_record_node**node1,struct student_record_node** node2)
{
	int tempId = 0;
	int tempAge = 0;
	
	struct student_record_node* ptr = *node1;
	struct student_record_node* ptr2 = *node2;
	char tempFirst [21];
	char tempLast[21];
	


	


	/*temps are storing data of node1 */

	tempId = ptr-> record_-> student_id_;
	tempAge = ptr-> record_-> student_age_;
	strcpy(tempFirst,ptr->record_->first_name_);
	strcpy(tempLast,ptr->record_->last_name_);
	

	/*node 1 being swapped with node 2 data*/


	ptr-> record_-> student_id_ = ptr2-> record_-> student_id_; 
	ptr-> record_-> student_age_ = ptr2-> record_-> student_age_;
	strcpy(ptr->record_->first_name_,ptr2->record_->first_name_);
	strcpy(ptr->record_->last_name_,ptr2->record_->last_name_);

	/*node2 being swapped with temp (node1) data*/

	ptr2-> record_-> student_id_ = tempId;
	ptr2-> record_-> student_age_ = tempAge;
	strcpy(ptr2->record_->first_name_,tempFirst);
	strcpy(ptr2->record_->last_name_,tempLast);

	
}


void freeNodeList(struct student_record_node* head)
{
	while(head != NULL)
	{
		student_record_node_deallocate(head);
		head = head -> next_;

	}

}

void appendNode(struct student_record_node* head, struct student_record_node* newNode)
{
	head -> next_ = newNode;

}


void printNodeList(struct student_record_node* head)
{
	while( head != NULL)
	{
		printNode(head);
		head = head -> next_;

	}

}
