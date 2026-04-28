#!/usr/bin/env nu

# Financial Reporting Script in Nushell
# Replaces laporan.sh and provides enhanced visualization

def main [
    --generate (-g)      # Generate HTML and JSON reports
    --format (-f)        # Format all journal files
    --year: int          # Specific year to report on (defaults to all)
] {
    let journals = (ls *.journal | where name =~ '\d{4}.journal' | sort-by name)

    if ($journals | is-empty) {
        print ((ansi red_bold) + "No journal files found!")
        return
    }

    let active_journals = if ($year != null) {
        $journals | where name == $"($year).journal"
    } else {
        $journals
    }

    if ($active_journals | is-empty) {
        print ((ansi red) + $"No journal found for year ($year)")
        return
    }

    let files_args = ($active_journals.name | each {|it| [-f $it]} | flatten)

    print_header "FINANCIAL OVERVIEW"

    # Net Worth Calculation
    let assets_csv = (hledger ...$files_args bal assets --depth 1 --output-format csv | from csv)
    let assets = if ($assets_csv | is-empty) { 0.0 } else {
        let row = ($assets_csv | where account == "assets")
        if ($row | is-empty) { 0.0 } else { parse_hledger_amount $row.0.balance }
    }

    let liabilities_csv = (hledger ...$files_args bal liabilities --depth 1 --output-format csv | from csv)
    let liabilities = if ($liabilities_csv | is-empty) { 0.0 } else {
        let row = ($liabilities_csv | where account == "liabilities")
        if ($row | is-empty) { 
            # hledger might return "Total:" instead of "liabilities" if empty
            0.0 
        } else { parse_hledger_amount $row.0.balance }
    }
    
    let net_worth = ($assets + $liabilities)

    print_stat "Assets" $assets "green"
    print_stat "Liabilities" $liabilities "red"
    print_stat "Net Worth" $net_worth "cyan_bold"
    print ""

    # Account Breakdown
    print_header "ACCOUNT BREAKDOWN"
    hledger ...$files_args bal assets liabilities --depth 2 --output-format csv
    | from csv
    | where account != "Total:"
    | rename "Account" "Balance"
    | upsert Balance {|it|
        let val = (parse_hledger_amount $it.Balance)
        if $val < 0 {
            (ansi red) + $it.Balance + (ansi reset)
        } else {
            (ansi green) + $it.Balance + (ansi reset)
        }
    }
    | table -e
    | print

    if $generate {
        generate_reports $files_args
    }

    if $format {
        format_journals $active_journals.name
    }
}

def parse_hledger_amount [amount: string] {
    let parts = ($amount | split row ", " | where $it =~ "Rp")
    if ($parts | is-empty) {
        # Check if it has any numeric part
        let num_part = ($amount | split row " " | where ($it =~ '^\d') or ($it =~ '^-'))
        if ($num_part | is-empty) {
            return 0.0
        }
        return ($num_part.0 | str replace -a "." "" | str replace -a "," "." | into float)
    }
    $parts.0
    | str replace -a "Rp " ""
    | str replace -a "." ""
    | str replace -a "," "."
    | into float
}

def print_header [text: string] {
    let line = ("" | fill -a l -c "=" -w ($text | str length | $in + 4))
    print $"(ansi yellow_bold)($line)(ansi reset)"
    print $"(ansi yellow_bold)| ($text) |(ansi reset)"
    print $"(ansi yellow_bold)($line)(ansi reset)"
}

def print_stat [label: string, value: any, color: string] {
    let fmt_val = ($value | math round --precision 2 | into string)
    print $"($label | fill -w 15): (ansi $color)Rp ($fmt_val)(ansi reset)"
}

def generate_reports [files_args: list<string>] {
    print_header "GENERATING REPORTS"

    let targets = [
        [cmd, out, desc];
        [bal, "docs/balance.html", "Balance Sheet"]
        [is, "docs/income.html", "Income Statement"]
        [cf, "docs/cashflow.html", "Cash Flow"]
        [reg, "docs/register.html", "Register"]
    ]

    for t in $targets {
        print $"Creating ($t.desc)..."
        hledger ...$files_args ($t.cmd) -o ($t.out)
    }

    # Monthly reports
    print "Creating Monthly Reports..."
    hledger ...$files_args bal --monthly --row-total --average -o docs/balance-monthly.html
    hledger ...$files_args bal expenses --monthly --row-total --average -o docs/expenses-monthly.html
    hledger ...$files_args is --monthly --row-total --average -o docs/income-statement-monthly.html

    # JSON Data
    print "Exporting JSON data..."
    hledger ...$files_args bal assets -o docs/data/balance-assets.json
    hledger ...$files_args bal liabilities -o docs/data/balance-liabilities.json

    print ((ansi green_bold) + "Reports generated successfully!")
}

def format_journals [files: list<string>] {
    print_header "FORMATTING JOURNALS"
    for f in $files {
        print $"Formatting ($f)..."
        # We call the existing fmt-journal to preserve its header-preservation logic
        bash ./fmt-journal -o $f $f
    }
    print ((ansi green_bold) + "Formatting complete!")
}
