state("BBQ-Win64-Shipping", "18020287")
{
    byte isLoadingFlag: 0x7935E75;
}

startup
{
    Func<ProcessModuleWow64Safe, byte[]> CalcModuleHash = (module) => {
        byte[] checksum = new byte[32];
        using (var hashFunc = System.Security.Cryptography.SHA256.Create())
            using (var fs = new FileStream(module.FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite | FileShare.Delete))
                checksum = hashFunc.ComputeHash(fs);
        return checksum;
    };
    vars.CalcModuleHash = CalcModuleHash;

    // The SHA256 hash of the game exe used to detect game version
    vars.build_18020287 = new byte[32] {0xB3, 0x94, 0x72, 0x5F, 0xB1, 0xBF, 0x3E, 0xD4, 0xE0, 0xBC, 0xBD, 0xC1, 0x67, 0xA0, 0x68, 0x8C, 0x96, 0x9C, 0x38, 0xB9, 0x8D, 0xE4, 0x06, 0x6F, 0x4B, 0x00, 0xC8, 0x67, 0x24, 0x6E, 0x97, 0x98};
}

init
{
    byte[] checksum = vars.CalcModuleHash(current.MainModule);
    if (Enumerable.SequenceEqual(checksum, vars.build_18020287))
        version = "18020287";
}

start
{
    return old.isLoadingFlag == 0 && current.isLoadingFlag != 0; 
}

isLoading {
    return current.isLoadingFlag == 0;
}
