namespace FreddyK.BingMaps;

using Microsoft.Sales.Customer;
using Microsoft.Foundation.Address;

/// <summary>
/// Geocode an address using PirateMaps
/// </summary>
codeunit 74160 "PirateMaps Geocode"
{
    ObsoleteState = Pending;
    ObsoleteReason = 'Use BingMaps Geocode instead. Pirates are not supported in the future';
    ObsoleteTag = '5.0';


    trigger OnRun();
    var
        Cust: Record Customer;
    begin
        if Cust.FindSet() then
            repeat
                GeocodePirate(Cust);
                Commit();
            until Cust.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', true, true)]
    local procedure ModifyCustomer(VAR Rec: Record Customer)
    begin
        GeocodePirate(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterDeleteEvent', '', true, true)]
    local procedure DeleteCustomer(VAR Rec: Record Customer)
    var
        Pirate: Record Pirate;
    begin
        if Pirate.Get(Rec."No.") then
            Pirate.Delete(true);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterRenameEvent', '', true, true)]
    local procedure RenameCustomer(VAR Rec: Record Customer; VAR xRec: Record Customer)
    var
        Pirate: Record Pirate;
    begin
        if Pirate.Get(xRec."No.") then
            Pirate.Rename(Rec."No.");
    end;

    procedure GeocodePirate(Customer: Record Customer)
    var
        Pirate: Record Pirate;
        ErrorText: Text;
    begin
        if not Pirate.Get(Customer."No.") then begin
            Pirate.Init();
            Pirate."No." := Customer."No.";
            Pirate.Insert();
        end;
        GeocodePirate(Customer, Pirate, ErrorText);
        Pirate.Modify();
    end;

    procedure GeocodePirate(Customer: Record Customer; var Pirate: Record Pirate; var ErrorText: Text): Boolean
    var
        Country: Record "Country/Region";
        PirateMapsGeocode: Codeunit "PirateMaps Geocode";
        CountryName: Text;
        Address: Text;
    begin
        CountryName := Customer."Country/Region Code";
        if Country.GET(CountryName) then
            CountryName := Country.Name;
        Address := Customer.Address + ' ' + Customer."Address 2" + ' ' + Customer.City + ' ' + CountryName;
        if Pirate.Address <> Address then begin
            Pirate.Geocoded := 0;
            if PirateMapsGeocode.Geocode(Address, Pirate.Latitude, Pirate.Longitude, ErrorText) then begin
                // Full address geocoded
                Pirate.Zoom := 15;
                Pirate.Geocoded := 1;
                Pirate.Address := Address;
                exit(true);
            end else begin
                if PirateMapsGeocode.Geocode(Customer.City + ' ' + CountryName, Pirate.Latitude, Pirate.Longitude, ErrorText) then begin
                    // City and country geocoded
                    Pirate.Zoom := 9;
                    Pirate.Geocoded := 1;
                    Pirate.Address := Address;
                    exit(true);
                end else begin
                    // Geocoding not possible
                    Pirate.Latitude := 0;
                    Pirate.Longitude := 0;
                    Pirate.Zoom := 0;
                    Pirate.Geocoded := -1;
                    Pirate.Address := '';
                    exit(false);
                end;
            end;
        end;
        exit(false);
    end;

    /// <summary>
    /// Geocode an address using BingMaps
    /// </summary>
    /// <param name="PirateMapsQuery">The address to encode</param>
    /// <param name="Latitude">The resulting latitude</param>
    /// <param name="Longitude">The resulting longitude</param>
    /// <param name="ErrorText">Error code if encoding failed</param>
    /// <returns>true if address is encoded succesfully</returns>
    procedure Geocode(PirateMapsQuery: Text; var Latitude: Decimal; var Longitude: Decimal; var ErrorText: Text): Boolean
    begin
        EXIT(false);
    end;
}