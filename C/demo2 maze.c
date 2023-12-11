#include<stdio.h>

#include "mzStackA.c"




struct	{                                       
	int off_x;                                  
	int off_y;                             
} offsets[4] = {                                
	{ -1,  0 },	             
	{  0,  1 },	
	{  1,  0 },	
	{  0, -1 }	
};

                 
#define	DIRS	(sizeof(offsets)/sizeof(offsets[0]))  
#define	ENDPT	(DIRS+0)      
#define	SPACE	(DIRS+1)      
#define	WALL	(DIRS+2)      


char *display[] = { "^", ">", "v", "<", "*", " ", "H" };

#define	VISITED	'Y'                          
#define	NON_VISITED	'N'                     
#define	MAX_MAZE_SIZE	100                  
#define	MAX_ARRAY_SIZE	(MAX_MAZE_SIZE + 2)   

int	mm;                                       
int	nn;                                       
int	maze[MAX_MAZE_SIZE][MAX_MAZE_SIZE];     
char	mark[MAX_ARRAY_SIZE][MAX_ARRAY_SIZE]; 


void mazeInit();                             
int mazeIsSpace(int xx, int yy);           
int mazeIsVisited(int xx, int yy);           
int mazeMarkVisited(int xx, int yy);      
int mazeMarkPath(int xx, int yy, int dir);  

mazeStack_t	myStack;    

#define	stack_init()	mazeStack_init(&myStack)              
#define	stack_full()	mazeStack_full(&myStack)              
#define	stack_empty()	mazeStack_empty(&myStack)             
#define	push(element)	mazeStack_insert(&myStack, (element)) 
#define	pop(element)	mazeStack_delete(&myStack, (element)) 


void ShowMaze();                
int	ReadFile(FILE *file);       
int	FindPath();                 
int	Rollback();                 
int
main(int argc, char *argv[])
{
	FILE *input = NULL;                    
	if (argc < 1) {                      
		input = stdin;
	} 
	else {
		int data;
		printf("請輸入想要開啟的檔案(ex. 1 or 2 or 3)\n");
		scanf("%d",&data);
		if(data == 1){
			input = fopen("data1.txt", "rt");        
		if (input == NULL) {
			printf("file [%s] not found\n", argv[1]);
			return 1;
		}
		}
		else if(data == 2){
			input = fopen("data2.txt", "rt");        
		if (input == NULL) {
			printf("file [%s] not found\n", argv[1]);
			return 1;
		}
		}
		else{
			input = fopen("data3.txt", "rt");        
		if (input == NULL) {
			printf("file [%s] not found\n", argv[1]);
			return 1;
		}
		}

	}
	mazeInit();                     
	if (ReadFile(input) == 0) {      
		printf("read file [%s] error\n", argv[1]);
		return 1;
	}
	ShowMaze();                 
	printf("search a path from (1,1) to (%d,%d)...\n", mm, nn);
	if (FindPath() == 0) {    
		printf("path is not found\n\n");
		return 1;
	}
	printf("path is found\n\n");
	printf("MAZW Size: %dx%d\n",mm,nn);
	ShowMaze();                    
	return 0;
}

int
FindPath()
{
	mazeStackElement_t now, next;          
	now.xx=1;                               
	now.yy=1;                             
	now.dir=0;                             
	stack_init();                         
	push(&now);
	while (! stack_empty()) {             
		pop(&now);
	
		for (;now.dir<4; now.dir++) {
			if(mazeIsSpace(now.xx+offsets[now.dir].off_x,now.yy+offsets[now.dir].off_y))  
			{  
				next.xx=now.xx+offsets[now.dir].off_x;            
				next.yy=now.yy+offsets[now.dir].off_y;           
			}
	
			if (mazeIsSpace(next.xx, next.yy)                     
			&&  (!mazeIsVisited(next.xx, next.yy)) ) {          
				mazeMarkVisited(next.xx, next.yy);               
				push(&now);                                       
		
		
				now.xx=next.xx;                                   
				now.yy=next.yy;                              
				now.dir = -1;                                  
				if ((now.xx == mm) && (now.yy == nn)) {         
					mazeMarkPath(now.xx, now.yy, ENDPT);         
					Rollback();                                
					return 1;
				}
			}
		}
	}
	return 0;
}

int
Rollback()                                                    
{
	mazeStackElement_t stop;                                
  
	while (! stack_empty()) {                                
		pop(&stop);                                      
	
		mazeMarkPath(stop.xx, stop.yy, stop.dir);             
	}
	return 1;
}

int
ReadFile(FILE *file)                         
{
	int ii, jj;
	if (fscanf(file, "%d,%d", &mm, &nn) < 2) {   
		return 0;
	}
	for (ii=1; ii<=mm; ii++) {                
		for (jj=1; jj<=nn; jj++) {
			int digit;
			if (fscanf(file, "%d", &digit) < 1) {  
				return 0;
			}
			if (digit == 0) {                 
				maze[ii][jj] = SPACE;           
			}
		}
	}
	return 1;
}

void
ShowMaze()
{
	int ii,jj;
	for(ii=0;ii<=mm+1;ii++){                           
		for(jj=0;jj<=nn+1;jj++){                   
			printf("%s",display[maze[ii][jj]]);       
		}
		printf("\n");
	}
}

void
mazeInit()                                   
{
	int ii, jj;
	for (ii=0; ii<MAX_ARRAY_SIZE; ii++) {         
		for (jj=0; jj<MAX_ARRAY_SIZE; jj++) {
			maze[ii][jj] = WALL;                
			mark[ii][jj] = NON_VISITED;       
		}
	}
}

int mazeIsSpace(int xx, int yy)
{
	if(maze[xx][yy]==SPACE)                  
	return 1;
	else 
	return 0;
}

int mazeIsVisited(int xx, int yy)
{
	if(mark[xx][yy]!=NON_VISITED)            
	return 1;
	else
	return 0;
}

int mazeMarkVisited(int xx, int yy)	
{
	mark[xx][yy]=VISITED;                     
}

int mazeMarkPath(int xx, int yy, int dir)
{
	maze[xx][yy]=dir;                         
}
