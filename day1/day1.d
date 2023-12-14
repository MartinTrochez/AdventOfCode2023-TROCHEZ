import std.stdio;
import std.file;
import std.array;

void main()
{
	string archivoNombre = "input.txt";
	File archivo = File(archivoNombre);
	int acumulador = 0;

	while (!archivo.eof())
	{
		string linea = archivo.readln();
		if (!linea)
		{
			break;
		}
		int primero = 0;
		int ultimo = 0;
		linea = reemplazarNombresANumero(linea);
		int tamanio = cast(int) linea.length;
		for (int i = 0; i < tamanio - 1; i++)
		{
			char ch = linea[i];
			if (ch >= '0' && ch <= '9')
			{
				if (primero == 0)
				{
					primero = ch - '0';
					writeln(primero);
				}
				else
				{
					ultimo = ch - '0';
					writeln(ultimo);
				}
			}
		}
		if (ultimo == 0)
		{
			ultimo = primero;
		}
		writeln(primero * 10 + ultimo);
		acumulador += primero * 10 + ultimo;
	}
	writeln("Total: ", acumulador);
}

string reemplazarNombresANumero(string linea)
{
	struct NombreNumero
	{
		string nombre;
		string numero;
	}

	NombreNumero[10] valores = [
		NombreNumero("zero", "z0o"),
		NombreNumero("one", "o1e"),
		NombreNumero("two", "t2o"),
		NombreNumero("three", "t3e"),
		NombreNumero("four", "f4r"),
		NombreNumero("five", "f5e"), NombreNumero("six", "s6x"),
		NombreNumero("seven", "s7n"), NombreNumero("eight", "e8t"),
		NombreNumero("nine", "n9e")
	];
	foreach (valor; valores)
	{
		linea = linea.replace(valor.nombre, valor.numero);
	}
	return linea;

	/* auto regexPrimero = regex(r"(?:one|two|three|four|five|six|seven|eight|nine)"); */
	/* auto regexUltimo = regex( */
	/* 	r"(?:one|two|three|four|six|seven|eight|nine)(?!.*(one|two|three|four|six|seven|eight|nine))"); */
	/* auto matchPrimero = matchFirst(linea, regexPrimero); */
	/* auto matchUltimo = matchFirst(linea, regexUltimo); */

}
