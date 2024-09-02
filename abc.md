void wishMe() {
    final DateTime now = DateTime.now();
    final int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      speak("Good Morning, Welcome to Adhikaar");
    } else if (hour == 12) {
      speak("Good noon, Welcome to Adhikaar");
    } else if (hour > 12 && hour <= 17) {
      speak("Good Afternoon, Welcome to Adhikaar");
    } else if (hour > 17 && hour <= 21) {
      speak("Good Evening, Welcome to Adhikaar");
    } else {
      speak("Good Night, Welcome to Adhikaar");
    }
  }

void speakThis(String message) {
    // Implement your logic for handling different commands
    // based on the user's speech input.
    // You can open URLs, perform searches, etc.
    // Remember to use platform channels or other plugins
    // to interact with native features.

    // Example:
    if (message.contains('hey') || message.contains('hello') || message.contains('hi') || message.contains('hii')) {
      setResponseText("Hello, How can I help you?");
    } else if (message.contains('how are you')) {
      setResponseText("I am fine. Tell me how can I help you?");
    } else if (message.contains('name')) {
      setResponseText("My name is Adhikaar");
    } else if (message.contains('purpose')) {
      setResponseText("The BNSS aims to consolidate and amend the law related to Criminal Procedure in India.");
    } else if (message.contains('bnss')  || message.contains('BNSS') || message.contains('Bharatiya Nagarik Suraksha Sanhita')  || message.contains('bharatiya nagarik suraksha sanhita')) {
      setResponseText("The Bharatiya Nagarik Suraksha Sanhita(BNSS), also known as the Indian Citizen Safety Code, is a significant piece of legislation in India.");
    } else if (message.contains('article 370')  || message.contains('Article 370')) {
      setResponseText("Article 370 in the Indian constitution gave special status to Jammu and Kashmir, a region disputed by India, Pakistan and China. It was drafted by N Gopalaswami Ayyangar, a member of the Constituent Assembly of India, and was added to the constitution as a 'temporary provision' in 1949.");
    } else if (message.contains('article 14') || message.contains('Article 14') || message.contains('Right to Equality')) {
      setResponseText("Article 14 of the Constitution of India guarantees equality before the law and equal protection of the law to all people within the country. It states that the state cannot deny any person these rights. This right applies to citizens, foreigners, and legal entities like companies.");
    } else if (message.contains('article 19')  || message.contains('Article 19') || message.contains('Right to Freedom of Speech and Expression')) {
      setResponseText("Article 19 grants citizens the right to freely express their thoughts, opinions, and ideas. This includes the freedom to express oneself through speech, writing, printing, visual representations, or any other means. However, reasonable restrictions can be imposed on this right for the interests of sovereignty and integrity of India, security of the State, friendly relations with foreign nations, public order, decency or morality, contempt of court, defamation, incitement to an offense, or the sovereignty and integrity of Parliament.");
    } else if (message.contains('article 21') || message.contains('Article 21') || message.contains('Right to Protection of Life and Personal Liberty')) {
      setResponseText("Article 21 of the Constitution of India states that no person can be deprived of their life or personal liberty unless it is in accordance with the procedure established by law.");
    } else if (message.contains('article 32') || message.contains('Article 32') || message.contains('Right to Constitutional Remedies')) {
      setResponseText("Article 32 of the Indian Constitution is the Right to Constitutional Remedies, which gives citizens the right to directly approach the Supreme Court if their fundamental rights are violated. This article is considered a fundamental right, and is unique in the Constitution.");
    } else if (message.contains('article 136') || message.contains('Article 136') || message.contains('Right to Special Leave Petition')) {
      setResponseText("Article 136 of the Constitution of India states that the Supreme Court can grant special leave to appeal from any judgment, decree, determination, sentence, or order passed by any court or tribunal in India. The Supreme Court can exercise this power in its discretion, and in exceptional circumstances, such as when a question of law of general public importance arises.");
    } else if (message.contains('article 226') || message.contains('Article 226') || message.contains('Right to Power of High Courts to Issue Writs')) {
      setResponseText("Article 226 of the Constitution of India states that High Courts can issue writs, orders, or directives to any person or authority, including the government, to enforce fundamental rights and for other purposes. This is true even if the person or authority is not within the High Court's territorial jurisdiction.");
    } else if (message.contains('article 141') || message.contains('Article 141') || message.contains('Right to Law Declared by Supreme Court to be Binding on All Courts')) {
      setResponseText("Article 141 states that the law declared by the Supreme Court shall be binding on all courts within the territory of India. The law declared has to be construed as a principle of law that emanates from a judgment, or an interpretation of law or judgment by the Supreme Court, upon which the case is decided.");
    } else if (message.contains('article 142') || message.contains('Article 142') || message.contains('Right to Enforcement of Decrees and Orders of Supreme Court')) {
      setResponseText("Article 142 empowers the Supreme Court to pass any decree or order necessary for doing complete justice in any case or matter pending before it. These decrees or orders are enforceable across India's territory, making them significant tools for judicial intervention.");
    } else if (message.contains('article 300A') || message.contains('Article 300A') || message.contains('Right to Property')) {
      setResponseText("Article 300A of the Constitution of India states that no one can be deprived of their property without the authority of law. This article was added to the Constitution by the 44th Constitutional Amendment Act in 1978. The amendment also expanded the state's power to appropriate property for social welfare purposes.");
    } else if (message.contains('article 256') || message.contains('Article 256') || message.contains('Right to Obligation of States and Union')) {
      setResponseText("Article 256 of the Constitution of India states that the executive power of every state must be exercised in accordance with the laws made by Parliament and any existing laws that apply to that state. The article also states that the executive power of the Union can extend to giving directions to a state as may be necessary.");
    } else {
      // Handle other cases (e.g., open URLs, search, etc.)
      // ...
      setResponseText("I'm only able to guide you regarding law.");
    }
  }
