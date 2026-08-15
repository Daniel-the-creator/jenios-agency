import '../models/project_model.dart';
import '../models/team_member_model.dart';
import '../models/testimonial_model.dart';

class MockData {
  static List<ProjectModel> get projects => [
    ProjectModel(
      id: '1',
      title: 'exeat management system',
      category: 'cross-platform App',
      imageUrl: 'assets/images/exeat.png',
      description: 'A system that manages exeat process in a university',
      technologies: ['Flutter', 'Firebase'],
      client: 'Dominion university',
      liveUrl: 'https://exeat-management-system-project.vercel.app/',
    ),
    ProjectModel(
      id: '2',
      title: 'Propel',
      category: 'web App',
      imageUrl: 'assets/images/Propel.jpeg',
      description: 'A mentorship app',
      technologies: ['react', 'Node.js', 'PostgreSQL'],
      client: 'AkinAkingbogun.com',
      liveUrl: 'https://propel-ten-nu.vercel.app/',
    ),
    ProjectModel(
      id: '3',
      title: 'DU alerts',
      category: 'cross-platform app',
      imageUrl: 'assets/images/du alert.png',
      description:
          'An app that alerts security officers about any emergencies around the university',
      technologies: ['Flutter', 'firebase'],
      client: 'Dominion university',
      liveUrl: 'https://agent-6a4c08c4be4002e2784ac20d--dualert.netlify.app/',
    ),
    ProjectModel(
      id: '4',
      title: 'TAF',
      category: 'media management',
      imageUrl: 'assets/images/taf.png',
      description:
          'Branding, media management, graphic design, and tournament coverage for TAF (Taiwo adelakun foundation).',
      technologies: ['Graphic Design', 'Media Management', 'Branding'],
      client: 'Dominion university',
      liveUrl: 'https://www.instagram.com/dus_pride',
    ),
  ];

  static List<TeamMemberModel> get teamMembers => [
    TeamMemberModel(
      id: '1',
      name: 'Christopher Akingbogun',
      role: 'Project Manager',
      avatarUrl: '',
      bio:
          'engineer passionate about building scalable web and mobile applications. Expert in Software Engineering Principles And Software Architecture, Passionate about bringing Software systems to life.',
      skills: [
        'Project Planning',
        'Agile',
        'Team Leadership',
        'Risk Management',
        'Python',
        'React',
        'Node.js',
        'Flask',
      ],
      linkedInUrl:
          'https://www.linkedin.com/in/akigbogun-christopher-6a55b3422?utm_source=share_via&utm_content=profile&utm_medium=member_android',
    ),
    TeamMemberModel(
      id: '2',
      name: 'David Odigie',
      role: 'Media Manager',
      avatarUrl: '',
      bio:
          'creative photographer and media manager with a passion for visual storytelling and creating content that leaves a lasting impression.With a strong eye for detail and aesthetics, I strive to transform ideas into compelling visuals that are both engaging and impactful.',
      skills: [
        'Creative Photography',
        'Media Management',
        'Content Creation',
        'Social Media Management',
        'Video Editing',
        'Visual Storytelling',
        'Brand Content Strategy',
      ],
      linkedInUrl:
          'https://www.linkedin.com/in/david-odigie-37b628307?utm_source=share_via&utm_content=profile&utm_medium=member_ios',
    ),
    TeamMemberModel(
      id: '3',
      name: 'Daniel Ilesanmi Oluwamayowa',
      role: 'Full-Stack Web | Mobile Developer',
      avatarUrl: '',
      bio:
          'Full-stack engineer passionate about building scalable web and mobile applications.',
      skills: [
        'Flutter',
        'React',
        'Node.js',
        'Django',
        'Firebase',
        'html',
        'css',
        'javascript',
      ],
      linkedInUrl:
          'https://www.linkedin.com/in/daniel-ilesanmi-2745a1322/?trk=public-profile-join-page',
    ),
    TeamMemberModel(
      id: '4',
      name: 'Ademola Victor Oluokun',
      role: 'Graphic Designer | Mobile Developer',
      avatarUrl: '',
      bio:
          'Graphic designer and mobile developer with a growing interest in creating innovative digital solutions and blending creativity with technology to build impactful and engaging user experiences.',
      skills: [
        'Dart',
        'Flutter',
        'Mobile App Development',
        'Adobe Photoshop',
        'Graphic Design',
        'WordPress',
      ],
      linkedInUrl:
          'https://www.linkedin.com/in/ademola-victor-17b5b4276?utm_source=share_via&utm_content=profile&utm_medium=member_android',
    ),
    TeamMemberModel(
      id: '5',
      name: 'Akintayo Isreal',
      role: 'Graphics Designer | 3D animator and Cyber Security Analyst ',
      avatarUrl: '',
      bio:
          'Multi-disciplinary professional with expertise across Graphics Design, 3D Animation, and Cyber Security. Proficient in Blender, UE5, Maya, Illustrator, Photoshop, plus hands-on experience with Cyber Security tools. I design, animate, and defend, bringing both creative vision and security-first thinking to every project.',
      skills: ['Pen Testing', 'SIEM', 'Network Security', 'ISO 27001'],
      linkedInUrl: 'http://linkedin.com/in/israel-akintayo-7b8b84269/details',
    ),
    TeamMemberModel(
      id: '6',
      name: 'Emmanuel Oluwatimileyin',
      role: 'UI/UX Designer',
      avatarUrl: '',
      bio:
          'Award-winning designer who transforms complex problems into intuitive, beautiful interfaces. Passionate about user research and design systems.',
      skills: ['Figma', 'User Research', 'Prototyping', 'Design Systems'],
      linkedInUrl: 'https://linkedin.com',
    ),
    TeamMemberModel(
      id: '7',
      name: 'Olasupo francis',
      role: 'Motion Graphics Designer',
      avatarUrl: '',
      bio:
          'A multidisciplinary visual creative specializing in Motion Design, Video Editing, Cinematography, and Photography. He creates engaging visual content for brands, businesses, creators, and digital products, combining strong storytelling with creative and technical execution..',
      skills: [
        'Motion Design & 2D Animation',
        'Video Editing & Post-Production',
        'Cinematography & Videography',
        'Photography',
        'Short-form & Social Media Content',
        'Promotional & Explainer Videos',
        'Branding',
        'Visual Storytelling',
      ],
      linkedInUrl: 'https://www.linkedin.com/in/francis-olasupo',
    ),
    TeamMemberModel(
      id: '8',
      name: 'Ifelola Adeyolanu.',
      role: 'Product Manager',
      avatarUrl: '',
      bio:
          'A strategic Product Manager who transforms chaotic concepts into user-centric solutions for fast-paced startups, forward-thinking teams, and scaling tech enterprises. specialize in providing 95% clearer direction to stalled initiatives, turning scattered momentum into active user acquisition and retention. Driven by rigorous market research and deep user empathy, build products that precisely target core pain points. Rejecting rigid frameworks, intentionally utilize the exact product tools tailored to a product specific scale, nature, and lifecycle. Ultimately, focus is on bridging visionary strategy with agile execution to ensure flawless, high-value delivery.',
      skills: [
        'Product Strategy and Discovery',
        'User Research, UX Design Thinking, and User Flow Mapping',
        'Product Road mapping and Feature Prioritization',
        'Agile Product Delivery and Timely End-to-End Execution',
        'Data-Driven Decision Making, Product Analytics, and A/B Testing',
        'Growth and Product Metrics',
        'Go-to-Market Strategy',
        'People Management, Cross-Functional Leadership, and Stakeholder',
        'Alignment',
      ],
      linkedInUrl: 'https://www.linkedin.com/in/ifelola-adeyolanu-3b387b267',
    ),
    TeamMemberModel(
      id: '9',
      name: 'Adesola Adebayo',
      role: 'Software Tester & Cyber Security Officer',
      avatarUrl: '',
      bio:
          'Cybersecurity professional passionate about building secure and reliable systems, with experience across software testing, security operations, risk management, and intelligent threat detection.',
      skills: [
        'Software Testing',
        'SIEM / Wazuh',
        'Vulnerability Assessment',
        'Risk & Compliance',
        'Network Security',
        'Machine Learning',
        'Threat Detection',
      ],
      linkedInUrl: 'linkedin.com/in/adebayo-adesola-337158367',
    ),
    TeamMemberModel(
      id: '10',
      name: 'Ilesanmi Emmanuel',
      role: 'Backend Developer | Social Media & Marketing Officer',
      avatarUrl: '',
      bio:
          'Versatile technology professional passionate about building reliable digital solutions and growing brands through effective technology, social media, and marketing strategies. Experienced in backend development, digital content, social media management, and creating engaging strategies that connect brands with their audiences.',
      skills: [
        'Backend Development',
        'Database Management',
        'Social Media Management',
        'Digital Marketing',
        'Content Strategy',
        'Brand Communication',
        'Software & Web Technologies',
        'Data Management'
            'Community Engagement',
      ],
      linkedInUrl: 'https://ng.linkedin.com/in/emmanuel-ilesanmi-8a717b42a',
    ),
  ];

  static List<TestimonialModel> get testimonials => [
    TestimonialModel(
      id: '1',
      name: 'David Carter',
      avatarUrl: '',
      rating: 5.0,
      review:
          'Working with Jenios was an absolute pleasure. They delivered our dashboard ahead of schedule and the quality exceeded all expectations. Our team productivity has skyrocketed!',
      position: 'CEO, FinTrack Inc.',
    ),
    TestimonialModel(
      id: '2',
      name: 'Sarah Johnson',
      avatarUrl: '',
      rating: 5.0,
      review:
          'I was blown away by the attention to detail and the level of creativity the Jenios team brought to our project. They listened, iterated, and delivered something truly remarkable.',
      position: 'Marketing Director, BizFlow Ltd.',
    ),
    TestimonialModel(
      id: '3',
      name: 'Michael Osei',
      avatarUrl: '',
      rating: 4.5,
      review:
          'The app they built for us has completely transformed how we operate. The UI is clean, the performance is flawless, and the support after launch has been outstanding.',
      position: 'Founder, CreativeHub',
    ),
    TestimonialModel(
      id: '4',
      name: 'Amara Diallo',
      avatarUrl: '',
      rating: 5.0,
      review:
          'Jenios delivered a world-class e-commerce platform that scaled from day one. Their technical expertise and communication made the whole process stress-free.',
      position: 'CTO, MarketKing',
    ),
  ];

  static List<JourneyMilestone> get journeyMilestones => [
    JourneyMilestone(
      year: '2024',
      title: 'The Beginning',
      description:
          'Jenios was founded with a bold vision — to empower businesses with cutting-edge digital solutions. We started with a small but passionate team of 3.',
    ),
    JourneyMilestone(
      year: '2025',
      title: 'Growth & Recognition',
      description:
          'Delivered 5+ successful projects, expanded our team, and established our reputation for quality, creativity, and reliability in the digital space.',
    ),
    JourneyMilestone(
      year: '2026',
      title: 'Today',
      description:
          'Now a thriving agency with 10+ completed projects, a diverse portfolio, and a growing base of satisfied clients across multiple industries.',
    ),
    JourneyMilestone(
      year: '2026+',
      title: 'Tomorrow',
      description:
          'We\'re expanding our service offerings, growing our team, and setting our sights on becoming the most trusted digital agency in West Africa and beyond.',
    ),
  ];

  static List<StatItem> get stats => [
    StatItem(value: '7+', label: 'Projects Completed', targetNumber: 8),
    StatItem(value: '2+', label: 'Years Experience', targetNumber: 2),
    StatItem(value: '24/7', label: 'Support', targetNumber: 24),
  ];
}
