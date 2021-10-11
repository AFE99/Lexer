/*----- Definiciones -----*/

%{
#include <stdio.h>

int palabra=0; 
int numero=0; 
int real=0;
char externo[30];
char answer[30];
%}
%option noyywrap
%option yylineno

Numero		-?[0-9]+
Reales		[0-9]+(","[0-9]+)?
Espacio		[ \t]+
Identificador   [a-zA-Z]+[a-zA-Z0-9]*
Error 		[0-9]+[a-zA-Z]+[a-zA-Z0-9]*
operador        AND|>|<=|!=|OR|<|>=|=
Reservada(SELECT|CREATE|TABLE|CHAR|NOT|NULL|PRIMARY|KEY|INTEGER|FROM|WHERE|NUMBER|STRING|AND)

/*----- Reglas -----*/

%%
"salir"         {return 0;}
{Reservada}	{printf("Se leyo la palabra Reservada: %s\n", yytext);palabra++;}
{Identificador} {printf("Se leyo un identificador, con el lexema: %s\n",yytext);}
{operador}      {printf("\nSe encontro un Token Operador: %s\n",yytext);}
"@"	{printf("\n Token SIMBOLO encontrado: @");}
"#"	{printf("\n Token SIMBOLO encontrado: #");}
"$"	{printf("\n Token SIMBOLO encontrado: $");}
"%"	{printf("\n Token SIMBOLO encontrado: %");}
"="	{printf("\n Token SIMBOLO encontrado: =");}

{Numero}	{printf("Se leyo el numero: %s\n",yytext);numero++;}
{Reales}	{printf("Se leyo el numero real: %s\n",yytext);real++;}
{Error}		{printf("Lexema no reconocido: %s\n",yytext);palabra++;}
{Espacio}	{}
.	        {printf("Lexema no reconocido: %s\n",yytext);palabra++;}


%%
/*----- Procedimientos -----*/

int WOLF()
{
printf("\n");
yylex();
}

int FOX()
{
printf("\nIngrese direccion del archivo .txt a testear, o escriba una sentencia manualmente\n");
gets(externo);
if ((yyin = fopen(externo, "r")) == NULL)
    {
        printf("\nNo se puedo abrir el archivo: %s, escriba una sentencia SQL manualmente:\n", externo); yylex(); WOLF();
    }
    else
    {
      yylex(); FOX();
}}


main (){
printf("Lenguaje SQL, escriba salir para terminar.\n");
printf("\nIngrese direccion del archivo .txt a testear, o escriba una sentencia manualmente.\n");
gets(externo);
if ((yyin = fopen(externo, "r")) == NULL)
    {
        printf("\nNo se puedo abrir el archivo: %s, escriba una sentencia SQL manualmente.:\n", externo); WOLF();
    }
    else
    {
      yylex(); FOX();
}
}


