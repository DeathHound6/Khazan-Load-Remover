
state("BBQ-Win64-Shipping"){
    byte isLoadingFlag : 0x7935E75;
}


start {
    return old.isLoadingFlag == 0 && current.isLoadingFlag != 0; 
}

isLoading {
    return current.isLoadingFlag == 0;
}

