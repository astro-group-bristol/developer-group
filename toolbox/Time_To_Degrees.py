import argparse
# If everything was in one format life would be much simplier. 

def hms_str_to_degrees(coord_str):
    """Converts an input of hh:mm:ss to decimal degrees"""
    parts = coord_str.split(':')
    hours = int(parts[0])
    minutes = int(parts[1])
    
    # Splits
    seconds_parts = parts[2].split('.')
    seconds = int(seconds_parts[0])
    subseconds = float('0.' + seconds_parts[1]) if len(seconds_parts) > 1 else 0.0
    
    # Converting to degrees
    total_hours = hours + minutes / 60 + (seconds + subseconds) / 3600
    degrees = total_hours * 15  
    return degrees


def ra_dec_str_to_degrees(ra_dec_str):
    """Converts a coordinare of RA, Dec given as:
    Hours:Minutes:Seconds, +-Degree:Minutes:Seconds
    to complete decimal degrees."""
    ra, dec = ra_dec_str.split(',')

    ra_degrees = hms_str_to_degrees(ra)

    # Split
    dec_parts = dec.split(':')
    dec_degrees = int(dec_parts[0])
    dec_minutes = int(dec_parts[1])
    
    # Banana Splits
    dec_seconds_parts = dec_parts[2].split('.')
    dec_seconds = int(dec_seconds_parts[0])
    dec_subseconds = float('0.' + dec_seconds_parts[1]) if len(dec_seconds_parts) > 1 else 0.0
    
    total_dec_degrees = dec_degrees + dec_minutes / 60 + (dec_seconds + dec_subseconds) / 3600

    return ra_degrees, total_dec_degrees

def degrees_to_hms_str(degrees):
    """Converts decimal degrees to Hours:Minutes:Seconds.
    This is mainly for RA which is, as standard, HH:MM:SS."""
    total_hours = degrees / 15  
    hours = int(total_hours)
    minutes = int((total_hours - hours) * 60)
    seconds = int((total_hours - hours - minutes / 60) * 3600)
    subseconds = int(((total_hours - hours - minutes / 60) * 3600 - seconds) * 1000)
    
    return "{}:{}:{}.{}".format(hours, minutes, seconds, subseconds)

def degrees_to_dms_str(degrees):
    """Converts decimal degrees to degrees+minutes breakdown.
    +-Degree:Mins:Seconds.
    This is mainly used for Declination which, as standard, is given in this format."""
    sign = '+' if degrees >= 0 else '-'
    degrees_abs = int(degrees)

    # Turns back [to] time
    total_minutes = (degrees-degrees_abs) * 60
    minutes = int(total_minutes)
    seconds = int((total_minutes - minutes) * 60)
    subseconds = int(((total_minutes - minutes) * 60 - seconds) * 1000)

    return "{}{}:{}:{}.{}".format(sign, degrees_abs, minutes, seconds, subseconds)

# Time_or_Dec=input("If you want to conver time to decimal degrees please type 'deg', if you want to convert degrees to time, please type 'time': ")

# if Time_or_Dec=='deg':
        
#     ra_input = input("Enter Right Ascension (RA) in Hrs:Mins:Sec format: ")
#     dec_input = input("Enter Declination (Dec) in Deg:Mins:Sec format: ")

#     # Combine RA and Dec into a single string
#     ra_dec_input = f"{ra_input},{dec_input}"

#     ra_degrees, dec_degrees = ra_dec_str_to_degrees(ra_dec_input)

#     print(f"{ra_dec_input} is approximately RA {ra_degrees:.6f} degrees, Dec {dec_degrees:.6f} degrees.")

# if Time_or_Dec=='time':

#     # Example usage:
#     ra_degrees_input = float(input("Enter Right Ascension (RA) in degrees: "))
#     dec_degrees_input = float(input("Enter Declination (Dec) in degrees: "))

#     ra_hms_str = degrees_to_hms_str(ra_degrees_input)
#     dec_dms_str = degrees_to_dms_str(dec_degrees_input)

#     print(f"{ra_degrees_input} degrees is approximately {ra_hms_str} (RA)")
#     print(f"{dec_degrees_input} degrees is approximately {dec_dms_str} (Dec)")

# Callable with arguments :)
def main():
    parser = argparse.ArgumentParser(description="Convert RA/Dec or decimal degrees.")
    
    parser.add_argument('--type', choices=['deg', 'time'], required=True, help="Choose conversion type: 'deg' for time to decimal degrees or 'time' for decimal degrees to time.")
    parser.add_argument('--ra', type=str, help="Right Ascension (RA) in HH:MM:SS format")
    parser.add_argument('--dec', type=str, help="Declination (Dec) in ±DD:MM:SS format")
    parser.add_argument('--ra_deg', type=float, help="Right Ascension (RA) in decimal degrees")
    parser.add_argument('--dec_deg', type=float, help="Declination (Dec) in decimal degrees")
    
    args = parser.parse_args()

    if args.type == 'deg':
        if not args.ra or not args.dec:
            print("Error: You must provide both RA and Dec when converting to decimal degrees.")
            return

        ra_dec_input = f"{args.ra},{args.dec}"
        ra_degrees, dec_degrees = ra_dec_str_to_degrees(ra_dec_input)

        print(f"{ra_dec_input} is approximately RA {ra_degrees:.6f} degrees, Dec {dec_degrees:.6f} degrees.")

    elif args.type == 'time':
        if args.ra_deg is None or args.dec_deg is None:
            print("Error: You must provide both RA and Dec in decimal degrees when converting to time.")
            return

        ra_hms_str = degrees_to_hms_str(args.ra_deg)
        dec_dms_str = degrees_to_dms_str(args.dec_deg)

        print(f"{args.ra_deg} degrees is approximately {ra_hms_str} (RA)")
        print(f"{args.dec_deg} degrees is approximately {dec_dms_str} (Dec)")

if __name__ == "__main__":
    main()