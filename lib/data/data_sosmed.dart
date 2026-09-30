// data_sosmed.dart

class PostData {
  final String content;
  final String timeAgo;
  final int likes;
  final int comments;

  const PostData({required this.content, required this.timeAgo, required this.likes, required this.comments});
}

class CommentData {
  final String username;
  final String content;
  final String timeAgo;
  final int likes;

  const CommentData({required this.username, required this.content, required this.timeAgo, required this.likes});
}

class DriverSocialData {
  final String driverName;
  final List<
    PostData
  >
  posts;
  final List<
    CommentData
  >
  comments;

  const DriverSocialData({required this.driverName, required this.posts, required this.comments});
}

const List<
  DriverSocialData
>
dataSosmedF1 = [
  // 1. Kimi Antonelli (Mercedes)
  DriverSocialData(
    driverName: 'Kimi Antonelli',
    posts: [
      PostData(
        content: "Unbelievable feeling! P1 today! Massive thanks to the team for an incredible car. The hard work is paying off! 🏆🇮🇹 #F1",
        timeAgo: "2 hours ago",
        likes: 215000,
        comments: 14200,
      ),
      PostData(
        content: "First pole position feels surreal. Let's convert this tomorrow! ⏱️🔥",
        timeAgo: "1 day ago",
        likes: 185000,
        comments: 8900,
      ),
    ],
    comments: [
      CommentData(
        username: "ForzaKimi",
        content: "The future is NOW! What a drive, Kimi!",
        timeAgo: "1h ago",
        likes: 1204,
      ),
      CommentData(
        username: "MercInsider",
        content: "Replacing Lewis wasn't easy, but you're showing exactly why Toto chose you. 👏",
        timeAgo: "2h ago",
        likes: 890,
      ),
    ],
  ),

  // 2. George Russell (Mercedes)
  DriverSocialData(
    driverName: 'George Russell',
    posts: [
      PostData(
        content: "Tough race out there, but we gathered a lot of important data. We'll bounce back stronger at the next one! 💪🏎️ #F1 #KeepPushing",
        timeAgo: "5 hours ago",
        likes: 124500,
        comments: 4205,
      ),
      PostData(
        content: "Great session today! The car feels amazing and the setup is perfectly dialed in. Ready to give it everything! 🔥🏁",
        timeAgo: "2 days ago",
        likes: 145200,
        comments: 3400,
      ),
    ],
    comments: [
      CommentData(
        username: "F1Fanatic99",
        content: "He's absolutely flying this season! Can't wait to see him on the top step of the podium.",
        timeAgo: "2h ago",
        likes: 324,
      ),
      CommentData(
        username: "SpeedDemon",
        content: "Always supporting you, George! Let's go grab that championship! 🏆",
        timeAgo: "1d ago",
        likes: 145,
      ),
    ],
  ),

  // 3. Lewis Hamilton (Ferrari)
  DriverSocialData(
    driverName: 'Lewis Hamilton',
    posts: [
      PostData(
        content: "Still we rise. Grateful for the amazing support from the Tifosi this weekend. We keep pushing forward together. 🔴✨",
        timeAgo: "1 day ago",
        likes: 890000,
        comments: 45000,
      ),
      PostData(
        content: "Monza in red is something I'll never forget. Thank you for the energy! 🇮🇹❤️",
        timeAgo: "1 week ago",
        likes: 1200000,
        comments: 62000,
      ),
    ],
    comments: [
      CommentData(
        username: "TeamLH44",
        content: "Sir Lewis in red still feels like a dream. We are with you all the way!",
        timeAgo: "5h ago",
        likes: 4500,
      ),
      CommentData(
        username: "Tifosi4Life",
        content: "FORZA LEWIS! Bring home the 8th! 🏆🔴",
        timeAgo: "10h ago",
        likes: 3200,
      ),
    ],
  ),

  // 4. Lando Norris (McLaren)
  DriverSocialData(
    driverName: 'Lando Norris',
    posts: [
      PostData(
        content: "P1 BABY!!! What a weekend! Massive thanks to the whole papaya family at MTC and at the track! 🏆🧡",
        timeAgo: "1 day ago",
        likes: 485000,
        comments: 22400,
      ),
      PostData(
        content: "Papaya rules! Let's keep this momentum going into the European leg. 🚀",
        timeAgo: "4 days ago",
        likes: 395000,
        comments: 14500,
      ),
    ],
    comments: [
      CommentData(
        username: "PapayaRules",
        content: "Defending World Champion showing them how it's done! 🧡",
        timeAgo: "1h ago",
        likes: 1540,
      ),
      CommentData(
        username: "LandoLog",
        content: "That overtake on the outside was pure class!",
        timeAgo: "3h ago",
        likes: 920,
      ),
    ],
  ),

  // 5. Charles Leclerc (Ferrari)
  DriverSocialData(
    driverName: 'Charles Leclerc',
    posts: [
      PostData(
        content: "FORZA FERRARI! 🔴 Winning in front of the Tifosi is a feeling I will never ever forget. Grazie mille!",
        timeAgo: "3 hours ago",
        likes: 750000,
        comments: 38000,
      ),
      PostData(
        content: "Qualifying was tricky, but P2 gives us a great fighting chance for tomorrow. Let's go! 🐎",
        timeAgo: "5 days ago",
        likes: 512000,
        comments: 16700,
      ),
    ],
    comments: [
      CommentData(
        username: "IlPredestinato",
        content: "What a drive Charles! You deserve this so much! 🔴🏎️",
        timeAgo: "1h ago",
        likes: 2890,
      ),
      CommentData(
        username: "ScuderiaFan",
        content: "THIS year is our year! No more heartbreaks!",
        timeAgo: "2h ago",
        likes: 1450,
      ),
    ],
  ),

  // 6. Max Verstappen (Red Bull)
  DriverSocialData(
    driverName: 'Max Verstappen',
    posts: [
      PostData(
        content: "Simply lovely! Max points this weekend. The car was on rails today. Great job team! ☝️🦁",
        timeAgo: "4 hours ago",
        likes: 620000,
        comments: 28000,
      ),
      PostData(
        content: "Tricky conditions out there but we maximized our chances. Let's keep the focus on the next one.",
        timeAgo: "3 days ago",
        likes: 450000,
        comments: 15000,
      ),
    ],
    comments: [
      CommentData(
        username: "OrangeArmy",
        content: "Unstoppable! Pure masterclass once again Max! 🇳🇱🦁",
        timeAgo: "1h ago",
        likes: 3100,
      ),
      CommentData(
        username: "RacingPurist",
        content: "His consistency over the years is just terrifying for the rest of the grid.",
        timeAgo: "2h ago",
        likes: 1250,
      ),
    ],
  ),

  // 7. Oscar Piastri (McLaren)
  DriverSocialData(
    driverName: 'Oscar Piastri',
    posts: [
      PostData(
        content: "Solid points today. We lacked a bit of ultimate pace but executed the strategy perfectly. On to the next one! 🧡🏎️",
        timeAgo: "12 hours ago",
        likes: 210000,
        comments: 7500,
      ),
      PostData(
        content: "Great feeling to be back racing in Albert Park. Thanks for the massive support at home! 🇦🇺🦘",
        timeAgo: "2 weeks ago",
        likes: 350000,
        comments: 12000,
      ),
    ],
    comments: [
      CommentData(
        username: "AussieGrit",
        content: "Ice cold as always, Oscar. Great drive! 🥶👏",
        timeAgo: "3h ago",
        likes: 980,
      ),
      CommentData(
        username: "McLarenFanboy",
        content: "Best driver pairing on the grid right now without a doubt.",
        timeAgo: "5h ago",
        likes: 760,
      ),
    ],
  ),

  // 8. Isack Hadjar (Red Bull)
  DriverSocialData(
    driverName: 'Isack Hadjar',
    posts: [
      PostData(
        content: "First podium with Red Bull Racing! What a crazy race. Thanks to the team for trusting me! 🇫🇷🐂",
        timeAgo: "1 day ago",
        likes: 185000,
        comments: 6400,
      ),
      PostData(
        content: "Learning every single session. The RB car is an absolute beast to drive.",
        timeAgo: "4 days ago",
        likes: 120000,
        comments: 3200,
      ),
    ],
    comments: [
      CommentData(
        username: "FrenchF1",
        content: "Allez Isack! You're proving you belong in that top seat! 🇫🇷",
        timeAgo: "4h ago",
        likes: 540,
      ),
      CommentData(
        username: "BullRacing",
        content: "Handling the pressure next to Max perfectly. Keep it up!",
        timeAgo: "6h ago",
        likes: 410,
      ),
    ],
  ),

  // 9. Liam Lawson (Racing Bulls)
  DriverSocialData(
    driverName: 'Liam Lawson',
    posts: [
      PostData(
        content: "Fought hard for every single point today. The Racing Bulls squad did a mega job with the pitstops! 🇳🇿🐃",
        timeAgo: "14 hours ago",
        likes: 145000,
        comments: 4800,
      ),
      PostData(
        content: "Quali didn't go our way, but tomorrow is where the points are scored. Full focus.",
        timeAgo: "2 days ago",
        likes: 95000,
        comments: 2100,
      ),
    ],
    comments: [
      CommentData(
        username: "KiwiRacer",
        content: "Doing NZ proud mate! Great overtakes today! 🇳🇿",
        timeAgo: "2h ago",
        likes: 670,
      ),
      CommentData(
        username: "LawsonF1",
        content: "You definitely deserve a top seat soon. Phenomenal defending.",
        timeAgo: "5h ago",
        likes: 450,
      ),
    ],
  ),

  // 10. Pierre Gasly (Alpine)
  DriverSocialData(
    driverName: 'Pierre Gasly',
    posts: [
      PostData(
        content: "Allez Alpine! A hard-fought P6 today. We are definitely making steps in the right direction. 💙🇫🇷",
        timeAgo: "1 day ago",
        likes: 110000,
        comments: 3400,
      ),
      PostData(
        content: "Tough luck with the safety car timing, but the pace was there. We'll regroup for the next race.",
        timeAgo: "1 week ago",
        likes: 85000,
        comments: 2200,
      ),
    ],
    comments: [
      CommentData(
        username: "Gasly10",
        content: "Extracting 110% out of that car as usual Pierre! 💪",
        timeAgo: "3h ago",
        likes: 430,
      ),
      CommentData(
        username: "AlpineNation",
        content: "Keep pushing! The upgrades are clearly working now.",
        timeAgo: "7h ago",
        likes: 310,
      ),
    ],
  ),

  // 11. Arvid Lindblad (Racing Bulls)
  DriverSocialData(
    driverName: 'Arvid Lindblad',
    posts: [
      PostData(
        content: "Double points finish for the team! Still can't believe I'm racing these guys. Huge thanks to VCARB for the amazing car today! 🇬🇧🤘",
        timeAgo: "10 hours ago",
        likes: 98000,
        comments: 2700,
      ),
      PostData(
        content: "Rookie season is all about learning. Some mistakes today, but we take the lessons and move forward.",
        timeAgo: "5 days ago",
        likes: 76000,
        comments: 1900,
      ),
    ],
    comments: [
      CommentData(
        username: "JuniorFormula",
        content: "From dominating F3 and F2 directly to scoring points in F1. Generational talent!",
        timeAgo: "1h ago",
        likes: 520,
      ),
      CommentData(
        username: "F1Scout",
        content: "The youngest on the grid but racing like a veteran. Impressive.",
        timeAgo: "3h ago",
        likes: 380,
      ),
    ],
  ),

  // 12. Franco Colapinto (Alpine)
  DriverSocialData(
    driverName: 'Franco Colapinto',
    posts: [
      PostData(
        content: "¡Vamos! Great strategy from the wall today. Happy to bring home some good points for Alpine! 🇦🇷💙",
        timeAgo: "18 hours ago",
        likes: 215000,
        comments: 8900,
      ),
      PostData(
        content: "Crazy race, but we survived the chaos. Thanks to all the Argentine fans for the crazy support! 🇦🇷🙌",
        timeAgo: "2 weeks ago",
        likes: 280000,
        comments: 11500,
      ),
    ],
    comments: [
      CommentData(
        username: "ArgF1",
        content: "¡Orgullo argentino! You drove brilliantly today Franco! 🇦🇷👏",
        timeAgo: "2h ago",
        likes: 1400,
      ),
      CommentData(
        username: "RacingSpirit",
        content: "Colapinto magic! Proving everyone wrong every single weekend.",
        timeAgo: "4h ago",
        likes: 890,
      ),
    ],
  ),

  // 13. Oliver Bearman (Haas)
  DriverSocialData(
    driverName: 'Oliver Bearman',
    posts: [
      PostData(
        content: "P8! The Haas was absolutely flying in the final stint. Massive effort from everyone in the garage! 🇬🇧🐻",
        timeAgo: "1 day ago",
        likes: 105000,
        comments: 3100,
      ),
      PostData(
        content: "Frustrating qualifying session, traffic ruined the final lap. We have work to do tomorrow.",
        timeAgo: "3 days ago",
        likes: 65000,
        comments: 1500,
      ),
    ],
    comments: [
      CommentData(
        username: "OllieFanClub",
        content: "Ollie putting that Haas where it doesn't belong! Huge drive! 🐻",
        timeAgo: "1h ago",
        likes: 450,
      ),
      CommentData(
        username: "F1Tifosi",
        content: "Ferrari is definitely watching your progress. Keep it up Ollie! 🔴",
        timeAgo: "5h ago",
        likes: 670,
      ),
    ],
  ),

  // 14. Carlos Sainz (Williams)
  DriverSocialData(
    driverName: 'Carlos Sainz',
    posts: [
      PostData(
        content: "Smooth Operator! Dragged the Williams into Q3 today. Let's see what we can do in the race! 🌶️💙",
        timeAgo: "2 days ago",
        likes: 175000,
        comments: 5200,
      ),
      PostData(
        content: "Tough Sunday, but the team's project is moving forward. We knew it would be a challenge, but I'm fully committed. Vamos!",
        timeAgo: "1 week ago",
        likes: 140000,
        comments: 4100,
      ),
    ],
    comments: [
      CommentData(
        username: "ChiliSainz",
        content: "That Q3 lap was pure magic Carlos! Smooth operator indeed! 🌶️",
        timeAgo: "4h ago",
        likes: 890,
      ),
      CommentData(
        username: "WilliamsRevival",
        content: "You're elevating the whole team. So glad to have you at Williams!",
        timeAgo: "8h ago",
        likes: 620,
      ),
    ],
  ),

  // 15. Fernando Alonso (Aston Martin)
  DriverSocialData(
    driverName: 'Fernando Alonso',
    posts: [
      PostData(
        content: "We never give up. Maximum attack until the last lap. Good points for the team today. 🇪🇸💚",
        timeAgo: "1 day ago",
        likes: 250000,
        comments: 8400,
      ),
      PostData(
        content: "El Plan continues. Upgrades are feeling good on track. Ready for Qualifying.",
        timeAgo: "4 days ago",
        likes: 195000,
        comments: 5600,
      ),
    ],
    comments: [
      CommentData(
        username: "MagicAlonso",
        content: "Age is literally just a number for this man. What a legend! 🇪🇸🐐",
        timeAgo: "1h ago",
        likes: 1800,
      ),
      CommentData(
        username: "AstonFan",
        content: "That defense against the Red Bull was vintage Fernando! Masterclass.",
        timeAgo: "3h ago",
        likes: 1100,
      ),
    ],
  ),
];
