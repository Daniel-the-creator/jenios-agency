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
      title: 'King fill',
      category: 'cross-platform app',
      imageUrl: 'assets/images/king fill.png',
      description: 'An app to order fueland other car services.',
      technologies: ['Flutter', 'firebase'],
      client: 'kingfill.com',
      liveUrl: 'https://example.com',
    ),
    ProjectModel(
      id: '4',
      title: 'DU sports',
      category: 'media management',
      imageUrl: '',
      description: 'managing DU pride on instagram',
      technologies: [],
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
      name: 'David Odige',
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
      role: 'Full-Stack web/mobile Developer',
      avatarUrl: '',
      bio:
          'Full-stack engineer passionate about building scalable web and mobile applications.',
      skills: [
        'Flutter',
        'React',
        'Node.js',
        'Firebase',
        'html',
        'css',
        'javascript',
      ],
      linkedInUrl:
          'https://www.linkedin.com/in/daniel-ilesanmi-2745a1322/?trk=public-profile-join-page',
    ),
    TeamMemberModel(
      id: '3',
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
      id: '4',
      name: 'Akintayo Isreal',
      role: 'Cyber Security Analyst',
      avatarUrl: '',
      bio:
          'Dedicated security professional protecting digital assets. Specializes in penetration testing, vulnerability assessments, and security audits.',
      skills: ['Pen Testing', 'SIEM', 'Network Security', 'ISO 27001'],
      linkedInUrl: 'https://linkedin.com',
    ),
    TeamMemberModel(
      id: '5',
      name: 'Emmanuel Oluwatimileyin',
      role: 'UI/UX Designer',
      avatarUrl: '',
      bio:
          'Award-winning designer who transforms complex problems into intuitive, beautiful interfaces. Passionate about user research and design systems.',
      skills: ['Figma', 'User Research', 'Prototyping', 'Design Systems'],
      linkedInUrl: 'https://linkedin.com',
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
