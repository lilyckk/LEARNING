#include<stdio.h>
#include<stdlib.h>
#include<math.h> 

#define LEN sizeof(Poly)
#define COMPARE(x, y) (((x) < (y))? -1 : ((x) == (y)) ? 0 : 1 )  


typedef struct term{
	float coef;	
	int expn;		
	term *next;
}Poly,*Link;


//int LocateElem(Link p, Link s, Link &q); 
void CreatePolyn(Link &p,int m);	
void PrintPolyn(Link p);					
Link AddPolyn(Link pa, Link pb);	


int main()
{	
    Link P1,P2,P3;	
	int L1,L2;	
	

	scanf("%d %d",&L1,&L2);    
	CreatePolyn(P1,L1);
    printf("a(x)= ");
	PrintPolyn(P1);
	CreatePolyn(P2,L2);
    printf("b(x)= ");
	PrintPolyn(P2); 
	
	printf("d(x)=");
	P3=AddPolyn(P1, P2);
	PrintPolyn(P3);
	
	return 0;
}


int LocateElem(Link p, Link s, Link &q){
	Link p1 = p->next;
	Link p2 = p;
	while(p1){
		if(s->expn < p1->expn){
			p1 = p1->next;
			p2 = p2->next;
		}else if(s->expn == p1->expn){
			q = p1; 
			return 1;
		}else{
			q = p2;
			return 0;
		}
	}
	if(!p1){
		q = p2;
		return 0;
	}
}

void CreatePolyn(Link &p,int m) 
{
	Link s,q;
	int i;
	p=(Link)malloc(LEN);
	p->next=NULL;
	for(i=0;i<m;i++)
	{
		s=(Link)malloc(LEN);
		scanf("%f %d", &s->coef, &s->expn);
		if(!LocateElem(p, s, q)){
			s->next = q->next;
			q->next = s;
		}else{									
			q->coef+=s->coef;
		}
	}
}


void PrintPolyn(Link p)

{
	Link s;
	s = p->next;
	while(s)
	{
	        printf(" %.2f X^%d", s->coef, s->expn);
            s = s->next;
            if(s!=NULL)  
                if(s->coef>=0) printf(" +");
	}
	printf("\n");
}

Link AddPolyn(Link pa, Link pb)
{
	Link newp, p, q, s, pc;
	float sum;
	p = pa->next; 
	q = pb->next;
	newp=(Link)malloc(LEN);
	pc = newp;
	while(p&&q){
		switch(COMPARE(q->expn,p->expn))
		{
			case -1:  
				s = (Link)malloc(LEN); 
				s->coef = p->coef;
				s->expn = p->expn;
				pc->next = s;
				pc = s;
				p = p->next;
				break;
			case 0:
				sum = p->coef+q->coef; 
				if(sum!=0.0)
				{
					s = (Link)malloc(LEN);
					s->coef = sum;
					s->expn = p->expn;
					pc->next = s;
					pc = s;
				}
				p = p->next;
				q = q->next;
				break;
			case 1:
				s = (Link)malloc(LEN);
				s->coef = q->coef;
				s->expn = q->expn;
				pc->next = s;
				pc = s;
				q = q->next;
				break;
		}
	}
	pc->next=p?p:q;
	return newp;
}
