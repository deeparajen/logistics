
Given a CSV file that contains a list of parcels and their respective weight and client name. You'll need to write a program that will efficiently group these parcels into shipments. The conditions are:
  1.  a shipment has a maximum weight of 2311 kg;
  2. one client's parcels may not be in multiple shipments;
  3. a shipment may contain parcels from multiple clients;
  4. a single parcel may not be split between shipments;
  5. the code must be written in Ruby;

units of weight don't matter, since there's no need for conversion or split, but for the sake of the exercise, all weight units can be assumed to be in kilograms. 

Assume, no client's total weight of parcels will be bigger than the maximum weight of a shipment

