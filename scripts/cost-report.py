#!/usr/bin/env python3
import json
import subprocess

def main():
    print("Generating cost report...")
    # Mocking cost report fetching
    try:
        # Example of fetching cost from azure CLI
        # result = subprocess.run(['az', 'consumption', 'usage', 'list'], capture_output=True, text=True)
        print("Cost report: Total spent $150 this month.")
    except Exception as e:
        print(f"Error fetching cost: {e}")

if __name__ == "__main__":
    main()
