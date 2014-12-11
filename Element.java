import java.util.Scanner;
import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;
import java.util.ArrayList;

public class Element
{
	private int charge;
	private int mass;
	private int electrons;
	public Element(int mass, int charge, int electrons)
	{
		this.mass = mass;
		this.charge = charge;
		this.electrons = electrons;
	}

	public int getMass()
	{
		return mass;
	}

	public int getCharge()
	{
		return charge;
	}

	public int getElectrons()
	{
		return electrons;
	}

	
}