import std.stdio;
import std.file;
import std.string;
import std.conv;
import std.array;
import std.range.primitives;

struct CubosColores
{
	int red = 0;
	int green = 0;
	int blue = 0;
}

void main()
{
	string archivoNombre = "input.txt";
	File archivo = File(archivoNombre, "r");
	auto rango = archivo.byLine();
	int acumuladorParteUno = 0;
	int acumuladorParteDos = 0;
	foreach (linea; rango)
	{
		if (!linea)
		{
			break;
		}

		char[] gameId = linea.split(":")[0];
		gameId.popFrontExactly(5);
		char[] grupoBolsas = linea.split(": ")[1];
		char[][] cubos = grupoBolsas.split("; ");
		if (parteUno(cubos))
		{
			writeln(gameId);
			acumuladorParteUno += gameId.to!int();
			writeln("acumulador ", acumuladorParteUno);
		}
		acumuladorParteDos += parteDos(cubos);
	}

	writeln("Total de la suma de id: ", acumuladorParteUno);
	writeln("Total de la suma de id: ", acumuladorParteDos);
}

int parteUno(char[][] cubos)
{
	int[string] limiteCubos = [
		"red": 12,
		"green": 13,
		"blue": 14
	];
	for (int i = 0; i < cubos.length; i++)
	{
		string cubo = cubos[i].to!string();
		string[] auxCubo = cubo.split(", ");
		for (int j = 0; j < auxCubo.length; j++)
		{
			string aux = auxCubo[j];
			int cantidad = aux.split(" ")[0].to!int();
			string color = aux.split(" ")[1];
			if (cantidad > limiteCubos[color])
			{
				return 0;
			}
		}
	}
	return 1;
}

int parteDos(char[][] cubos)
{
	int[string] maxCubos = [
		"red": 0,
		"green": 0,
		"blue": 0
	];

	for (int i = 0; i < cubos.length; i++)
	{
		string cubo = cubos[i].to!string();
		string[] auxCubo = cubo.split(", ");
		for (int j = 0; j < auxCubo.length; j++)
		{
			string aux = auxCubo[j];
			int cantidad = aux.split(" ")[0].to!int();
			string color = aux.split(" ")[1];
			if (cantidad > maxCubos[color])
			{
				maxCubos[color] = cantidad;
			}
		}
	}

	return maxCubos["red"] * maxCubos["green"] * maxCubos["blue"];
}
