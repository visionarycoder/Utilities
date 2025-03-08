using TextCopy;

List<string> exitOptions = ["X", "EXIT", "Q", "QUIT"];

while(true)
{

    var newGuid = Guid.NewGuid();
    ClipboardService.SetText(newGuid.ToString("D"));

    Console.WriteLine($"New GUID: {newGuid}");
    Console.WriteLine("Press Enter to generate another, or type 'X' to quit.");

    var input = Console.ReadLine() ?? string.Empty;
    if(! string.IsNullOrEmpty(input))
        continue;

    if(exitOptions.Contains(input.ToUpperInvariant().Trim()))
        break;
}