module send_message::HelloWorld {
    use aptos_framework::signer;

    struct Greeting has key {
        message: vector<u8>,
    }

    /// Initialize the greeting resource for an account
    public entry fun initialize_greeting(account: &signer, initial_message: vector<u8>) {
        move_to(account, Greeting { message: initial_message });
    }

    /// Update the greeting message
    public entry fun set_message(account: &signer, new_message: vector<u8>) acquires Greeting {
        let greeting = borrow_global_mut<Greeting>(signer::address_of(account));
        greeting.message = new_message;
    }

    /// Get the current greeting message
    public fun get_message(account_addr: address): vector<u8> acquires Greeting {
        let greeting = borrow_global<Greeting>(account_addr);
        greeting.message
    }
}
