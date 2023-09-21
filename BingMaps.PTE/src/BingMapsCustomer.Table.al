namespace FreddyK.BingMaps;

/// <summary>
/// The BingMaps Customer table. It contains the geocoded addresses for a Customer.
/// </summary>
table 74120 "BingMaps Customer"
{
    fields
    {
        /// <summary>
        /// The Customer No.
        /// </summary>
        field(74120; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        /// <summary>
        /// Contains the status for the geocoding of the address.
        /// <list type="table">
        ///   <listheader>
        ///     <term>Value</term>
        ///     <description>Status</description>
        ///   </listheader>
        ///   <item>
        ///     <term>-1</term>
        ///     <description>Unsuccessful</description>
        ///   </item>
        ///   <item>
        ///     <term>0</term>
        ///     <description>Unsuccessful</description>
        ///   </item>
        ///   <item>
        ///     <term>1</term>
        ///     <description>Unsuccessful</description>
        ///   </item>
        ///   <item>
        ///     <term>2</term>
        ///     <description>Unsuccessful</description>
        ///   </item>
        /// </list>
        /// </summary>
        field(74121; "Geocoded"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(74122; "Latitude"; Decimal)
        {
            DecimalPlaces = 3 : 5;
            DataClassification = EndUserIdentifiableInformation;
        }

        field(74123; "Longitude"; Decimal)
        {
            DecimalPlaces = 3 : 5;
            DataClassification = EndUserIdentifiableInformation;
        }

        field(74124; "Zoom"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(74125; "Address"; Text[200])
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key("No."; "No.")
        {
        }

        key("Latitude"; "Latitude")
        {

        }

        key("Longitude"; "Longitude")
        {
        }
    }
}