package com.graphics;
import java.util.ArrayList;

public class Molecule
{
	ArrayList<Element> elements = new ArrayList<Element>();
	public Molecule(ArrayList<Element> element_list)
	{
		elements = element_list;
	}
	public int Mass()
	{
		int sum = 0;
		for(int i = 0; i < elements.size(); i++)
		{
			sum += elements.get(i).mass();
		}
		return sum;
	}

	public int Charge()
	{
		int sum = 0;
		for(int i = 0; i < elements.size(); i++)
		{
			sum += elements.get(i).charge();
		}
		return sum;
	}

	public int Electrons()
	{
		int sum = 0;
		for(int i = 0; i < elements.size(); i++)
		{
			sum += elements.get(i).electrons();
		}
		return sum;
	}
}