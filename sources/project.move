module MyModule::MentorshipPlatform {

    use aptos_framework::signer;

    /// Struct representing a mentorship session request
    struct MentorshipSession has key, store {
        mentee: address,
        topic: vector<u8>,
        accepted: bool,
    }

    /// Mentee requests a mentorship session on a topic
    public fun request_session(mentee: &signer, topic: vector<u8>) {
        let session = MentorshipSession {
            mentee: signer::address_of(mentee),
            topic,
            accepted: false,
        };
        move_to(mentee, session);
    }

    /// Mentor accepts the mentorship session request of a given mentee
    public fun respond_to_session(_mentor: &signer, mentee_addr: address) acquires MentorshipSession {
        let session = borrow_global_mut<MentorshipSession>(mentee_addr);
        session.accepted = true;
    }
}
