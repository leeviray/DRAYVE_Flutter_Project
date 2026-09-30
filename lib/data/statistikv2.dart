// Statistik F1 2026 dari halaman driver resmi Formula 1.
// Snapshot: 28 September 2026.

class DriverSeasonStats {
  final int seasonPoints, seasonPosition, grandPrixRaces, grandPrixPoints, grandPrixWins, grandPrixPodiums, grandPrixPoles, grandPrixTop10s, fastestLaps, dnfs, sprintRaces, sprintPoints, sprintWins, sprintPodiums, sprintPoles, sprintTop10s;
  const DriverSeasonStats({required this.seasonPoints, required this.seasonPosition, required this.grandPrixRaces, required this.grandPrixPoints, required this.grandPrixWins, required this.grandPrixPodiums, required this.grandPrixPoles, required this.grandPrixTop10s, required this.fastestLaps, required this.dnfs, required this.sprintRaces, required this.sprintPoints, required this.sprintWins, required this.sprintPodiums, required this.sprintPoles, required this.sprintTop10s});
}

class DriverCareerStats {
  final int grandsPrixEntered, highestRaceFinish, highestRaceFinishCount, podiums, highestGridPosition, highestGridPositionCount, polePositions, worldChampionships, dnfs;
  final double careerPoints;
  const DriverCareerStats({required this.grandsPrixEntered, required this.careerPoints, required this.highestRaceFinish, required this.highestRaceFinishCount, required this.podiums, required this.highestGridPosition, required this.highestGridPositionCount, required this.polePositions, required this.worldChampionships, required this.dnfs});
}

class DriverStatistics {
  final String id, name, team;
  final int number;
  final DriverSeasonStats season2026;
  final DriverCareerStats career;
  const DriverStatistics({required this.id, required this.name, required this.team, required this.number, required this.season2026, required this.career});
}

const List<DriverStatistics> statistikF1 = [
  DriverStatistics(id: 'george_russell', name: 'George Russell', team: 'Mercedes', number: 63,
    season2026: DriverSeasonStats(seasonPoints: 236, seasonPosition: 2, grandPrixRaces: 202, grandPrixPoints: 3, grandPrixWins: 8, grandPrixPodiums: 5, grandPrixPoles: 12, grandPrixTop10s: 2, fastestLaps: 2, dnfs: 5, sprintRaces: 5, sprintPoints: 34, sprintWins: 3, sprintPodiums: 3, sprintPoles: 3, sprintTop10s: 5),
    career: DriverCareerStats(grandsPrixEntered: 167, careerPoints: 1269, highestRaceFinish: 1, highestRaceFinishCount: 8, podiums: 32, highestGridPosition: 1, highestGridPositionCount: 13, polePositions: 13, worldChampionships: 0, dnfs: 21),
  ),
  DriverStatistics(id: 'kimi_antonelli', name: 'Kimi Antonelli', team: 'Mercedes', number: 12,
    season2026: DriverSeasonStats(seasonPoints: 302, seasonPosition: 1, grandPrixRaces: 276, grandPrixPoints: 8, grandPrixWins: 12, grandPrixPodiums: 6, grandPrixPoles: 13, grandPrixTop10s: 7, fastestLaps: 1, dnfs: 5, sprintRaces: 5, sprintPoints: 26, sprintWins: 1, sprintPodiums: 2, sprintPoles: 0, sprintTop10s: 5),
    career: DriverCareerStats(grandsPrixEntered: 39, careerPoints: 452, highestRaceFinish: 1, highestRaceFinishCount: 8, podiums: 15, highestGridPosition: 1, highestGridPositionCount: 6, polePositions: 6, worldChampionships: 0, dnfs: 5),
  ),
  DriverStatistics(id: 'charles_leclerc', name: 'Charles Leclerc', team: 'Ferrari', number: 16,
    season2026: DriverSeasonStats(seasonPoints: 179, seasonPosition: 5, grandPrixRaces: 151, grandPrixPoints: 1, grandPrixWins: 4, grandPrixPodiums: 0, grandPrixPoles: 12, grandPrixTop10s: 2, fastestLaps: 3, dnfs: 5, sprintRaces: 5, sprintPoints: 28, sprintWins: 0, sprintPodiums: 3, sprintPoles: 0, sprintTop10s: 5),
    career: DriverCareerStats(grandsPrixEntered: 186, careerPoints: 1851, highestRaceFinish: 1, highestRaceFinishCount: 9, podiums: 54, highestGridPosition: 1, highestGridPositionCount: 27, polePositions: 27, worldChampionships: 0, dnfs: 26),
  ),
  DriverStatistics(id: 'lewis_hamilton', name: 'Lewis Hamilton', team: 'Ferrari', number: 44,
    season2026: DriverSeasonStats(seasonPoints: 199, seasonPosition: 3, grandPrixRaces: 179, grandPrixPoints: 1, grandPrixWins: 5, grandPrixPodiums: 0, grandPrixPoles: 14, grandPrixTop10s: 1, fastestLaps: 1, dnfs: 5, sprintRaces: 5, sprintPoints: 20, sprintWins: 0, sprintPodiums: 2, sprintPoles: 1, sprintTop10s: 5),
    career: DriverCareerStats(grandsPrixEntered: 395, careerPoints: 5217.5, highestRaceFinish: 1, highestRaceFinishCount: 106, podiums: 207, highestGridPosition: 1, highestGridPositionCount: 104, polePositions: 104, worldChampionships: 7, dnfs: 35),
  ),
  DriverStatistics(id: 'lando_norris', name: 'Lando Norris', team: 'McLaren', number: 1,
    season2026: DriverSeasonStats(seasonPoints: 186, seasonPosition: 4, grandPrixRaces: 154, grandPrixPoints: 2, grandPrixWins: 5, grandPrixPodiums: 3, grandPrixPoles: 11, grandPrixTop10s: 2, fastestLaps: 3, dnfs: 5, sprintRaces: 5, sprintPoints: 32, sprintWins: 1, sprintPodiums: 4, sprintPoles: 1, sprintTop10s: 5),
    career: DriverCareerStats(grandsPrixEntered: 166, careerPoints: 1616, highestRaceFinish: 1, highestRaceFinishCount: 13, podiums: 49, highestGridPosition: 1, highestGridPositionCount: 19, polePositions: 19, worldChampionships: 1, dnfs: 18),
  ),
  DriverStatistics(id: 'oscar_piastri', name: 'Oscar Piastri', team: 'McLaren', number: 81,
    season2026: DriverSeasonStats(seasonPoints: 120, seasonPosition: 7, grandPrixRaces: 99, grandPrixPoints: 0, grandPrixWins: 2, grandPrixPodiums: 0, grandPrixPoles: 9, grandPrixTop10s: 0, fastestLaps: 1, dnfs: 5, sprintRaces: 5, sprintPoints: 21, sprintWins: 0, sprintPodiums: 1, sprintPoles: 0, sprintTop10s: 5),
    career: DriverCareerStats(grandsPrixEntered: 83, careerPoints: 919, highestRaceFinish: 1, highestRaceFinishCount: 9, podiums: 28, highestGridPosition: 1, highestGridPositionCount: 6, polePositions: 6, worldChampionships: 0, dnfs: 7),
  ),
  DriverStatistics(id: 'max_verstappen', name: 'Max Verstappen', team: 'Red Bull Racing', number: 3,
    season2026: DriverSeasonStats(seasonPoints: 163, seasonPosition: 6, grandPrixRaces: 151, grandPrixPoints: 0, grandPrixWins: 7, grandPrixPodiums: 0, grandPrixPoles: 11, grandPrixTop10s: 1, fastestLaps: 4, dnfs: 5, sprintRaces: 5, sprintPoints: 12, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 5),
    career: DriverCareerStats(grandsPrixEntered: 248, careerPoints: 3607.5, highestRaceFinish: 1, highestRaceFinishCount: 71, podiums: 134, highestGridPosition: 1, highestGridPositionCount: 48, polePositions: 48, worldChampionships: 4, dnfs: 37),
  ),
  DriverStatistics(id: 'isack_hadjar', name: 'Isack Hadjar', team: 'Red Bull Racing', number: 6,
    season2026: DriverSeasonStats(seasonPoints: 86, seasonPosition: 8, grandPrixRaces: 86, grandPrixPoints: 0, grandPrixWins: 2, grandPrixPodiums: 0, grandPrixPoles: 9, grandPrixTop10s: 0, fastestLaps: 2, dnfs: 4, sprintRaces: 5, sprintPoints: 0, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 2),
    career: DriverCareerStats(grandsPrixEntered: 35, careerPoints: 137, highestRaceFinish: 3, highestRaceFinishCount: 3, podiums: 3, highestGridPosition: 3, highestGridPositionCount: 0, polePositions: 0, worldChampionships: 0, dnfs: 4),
  ),
  DriverStatistics(id: 'liam_lawson', name: 'Liam Lawson', team: 'Racing Bulls', number: 30,
    season2026: DriverSeasonStats(seasonPoints: 59, seasonPosition: 9, grandPrixRaces: 56, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 10, grandPrixTop10s: 0, fastestLaps: 1, dnfs: 5, sprintRaces: 5, sprintPoints: 3, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 2),
    career: DriverCareerStats(grandsPrixEntered: 50, careerPoints: 103, highestRaceFinish: 5, highestRaceFinishCount: 2, podiums: 0, highestGridPosition: 3, highestGridPositionCount: 0, polePositions: 0, worldChampionships: 0, dnfs: 8),
  ),
  DriverStatistics(id: 'arvid_lindblad', name: 'Arvid Lindblad', team: 'Racing Bulls', number: 41,
    season2026: DriverSeasonStats(seasonPoints: 37, seasonPosition: 11, grandPrixRaces: 36, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 10, grandPrixTop10s: 0, fastestLaps: 0, dnfs: 5, sprintRaces: 5, sprintPoints: 1, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 3),
    career: DriverCareerStats(grandsPrixEntered: 14, careerPoints: 37, highestRaceFinish: 6, highestRaceFinishCount: 1, podiums: 0, highestGridPosition: 7, highestGridPositionCount: 0, polePositions: 0, worldChampionships: 0, dnfs: 1),
  ),
  DriverStatistics(id: 'pierre_gasly', name: 'Pierre Gasly', team: 'Alpine', number: 10,
    season2026: DriverSeasonStats(seasonPoints: 41, seasonPosition: 10, grandPrixRaces: 39, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 1, grandPrixPoles: 9, grandPrixTop10s: 0, fastestLaps: 2, dnfs: 5, sprintRaces: 5, sprintPoints: 2, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 2),
    career: DriverCareerStats(grandsPrixEntered: 192, careerPoints: 499, highestRaceFinish: 1, highestRaceFinishCount: 1, podiums: 5, highestGridPosition: 1, highestGridPositionCount: 1, polePositions: 1, worldChampionships: 0, dnfs: 30),
  ),
  DriverStatistics(id: 'franco_colapinto', name: 'Franco Colapinto', team: 'Alpine', number: 43,
    season2026: DriverSeasonStats(seasonPoints: 27, seasonPosition: 12, grandPrixRaces: 27, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 8, grandPrixTop10s: 0, fastestLaps: 1, dnfs: 5, sprintRaces: 5, sprintPoints: 0, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 2),
    career: DriverCareerStats(grandsPrixEntered: 41, careerPoints: 32, highestRaceFinish: 6, highestRaceFinishCount: 1, podiums: 0, highestGridPosition: 7, highestGridPositionCount: 0, polePositions: 0, worldChampionships: 0, dnfs: 5),
  ),
  DriverStatistics(id: 'esteban_ocon', name: 'Esteban Ocon', team: 'Haas F1 Team', number: 31,
    season2026: DriverSeasonStats(seasonPoints: 7, seasonPosition: 16, grandPrixRaces: 7, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 3, grandPrixTop10s: 0, fastestLaps: 1, dnfs: 5, sprintRaces: 5, sprintPoints: 0, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 1),
    career: DriverCareerStats(grandsPrixEntered: 195, careerPoints: 490, highestRaceFinish: 1, highestRaceFinishCount: 1, podiums: 4, highestGridPosition: 3, highestGridPositionCount: 0, polePositions: 0, worldChampionships: 0, dnfs: 28),
  ),
  DriverStatistics(id: 'oliver_bearman', name: 'Oliver Bearman', team: 'Haas F1 Team', number: 87,
    season2026: DriverSeasonStats(seasonPoints: 20, seasonPosition: 13, grandPrixRaces: 19, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 4, grandPrixTop10s: 0, fastestLaps: 4, dnfs: 5, sprintRaces: 5, sprintPoints: 1, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 1),
    career: DriverCareerStats(grandsPrixEntered: 42, careerPoints: 68, highestRaceFinish: 4, highestRaceFinishCount: 1, podiums: 0, highestGridPosition: 8, highestGridPositionCount: 0, polePositions: 0, worldChampionships: 0, dnfs: 7),
  ),
  DriverStatistics(id: 'nico_hulkenberg', name: 'Nico Hulkenberg', team: 'Audi', number: 27,
    season2026: DriverSeasonStats(seasonPoints: 7, seasonPosition: 15, grandPrixRaces: 7, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 3, grandPrixTop10s: 0, fastestLaps: 3, dnfs: 5, sprintRaces: 5, sprintPoints: 0, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 0),
    career: DriverCareerStats(grandsPrixEntered: 264, careerPoints: 629, highestRaceFinish: 3, highestRaceFinishCount: 1, podiums: 1, highestGridPosition: 1, highestGridPositionCount: 1, polePositions: 1, worldChampionships: 0, dnfs: 50),
  ),
  DriverStatistics(id: 'gabriel_bortoleto', name: 'Gabriel Bortoleto', team: 'Audi', number: 5,
    season2026: DriverSeasonStats(seasonPoints: 10, seasonPosition: 14, grandPrixRaces: 10, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 3, grandPrixTop10s: 0, fastestLaps: 0, dnfs: 5, sprintRaces: 5, sprintPoints: 0, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 1),
    career: DriverCareerStats(grandsPrixEntered: 38, careerPoints: 29, highestRaceFinish: 6, highestRaceFinishCount: 1, podiums: 0, highestGridPosition: 7, highestGridPositionCount: 0, polePositions: 0, worldChampionships: 0, dnfs: 6),
  ),
  DriverStatistics(id: 'carlos_sainz', name: 'Carlos Sainz', team: 'Williams', number: 55,
    season2026: DriverSeasonStats(seasonPoints: 7, seasonPosition: 17, grandPrixRaces: 7, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 4, grandPrixTop10s: 0, fastestLaps: 3, dnfs: 5, sprintRaces: 5, sprintPoints: 0, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 1),
    career: DriverCareerStats(grandsPrixEntered: 244, careerPoints: 1343.5, highestRaceFinish: 1, highestRaceFinishCount: 4, podiums: 29, highestGridPosition: 1, highestGridPositionCount: 6, polePositions: 6, worldChampionships: 0, dnfs: 46),
  ),
  DriverStatistics(id: 'alexander_albon', name: 'Alexander Albon', team: 'Williams', number: 23,
    season2026: DriverSeasonStats(seasonPoints: 5, seasonPosition: 18, grandPrixRaces: 5, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 2, grandPrixTop10s: 0, fastestLaps: 4, dnfs: 5, sprintRaces: 5, sprintPoints: 0, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 0),
    career: DriverCareerStats(grandsPrixEntered: 142, careerPoints: 318, highestRaceFinish: 3, highestRaceFinishCount: 2, podiums: 2, highestGridPosition: 4, highestGridPositionCount: 0, polePositions: 0, worldChampionships: 0, dnfs: 27),
  ),
  DriverStatistics(id: 'fernando_alonso', name: 'Fernando Alonso', team: 'Aston Martin', number: 14,
    season2026: DriverSeasonStats(seasonPoints: 3, seasonPosition: 19, grandPrixRaces: 3, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 2, grandPrixTop10s: 0, fastestLaps: 6, dnfs: 5, sprintRaces: 5, sprintPoints: 0, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 0),
    career: DriverCareerStats(grandsPrixEntered: 442, careerPoints: 2396, highestRaceFinish: 1, highestRaceFinishCount: 32, podiums: 106, highestGridPosition: 1, highestGridPositionCount: 22, polePositions: 22, worldChampionships: 2, dnfs: 94),
  ),
  DriverStatistics(id: 'lance_stroll', name: 'Lance Stroll', team: 'Aston Martin', number: 18,
    season2026: DriverSeasonStats(seasonPoints: 0, seasonPosition: 21, grandPrixRaces: 0, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 0, grandPrixTop10s: 0, fastestLaps: 10, dnfs: 5, sprintRaces: 5, sprintPoints: 0, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 0),
    career: DriverCareerStats(grandsPrixEntered: 204, careerPoints: 325, highestRaceFinish: 3, highestRaceFinishCount: 3, podiums: 3, highestGridPosition: 1, highestGridPositionCount: 1, polePositions: 1, worldChampionships: 0, dnfs: 44),
  ),
  DriverStatistics(id: 'sergio_perez', name: 'Sergio Perez', team: 'Cadillac', number: 11,
    season2026: DriverSeasonStats(seasonPoints: 0, seasonPosition: 23, grandPrixRaces: 0, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 0, grandPrixTop10s: 0, fastestLaps: 5, dnfs: 5, sprintRaces: 5, sprintPoints: 0, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 0),
    career: DriverCareerStats(grandsPrixEntered: 296, careerPoints: 1638, highestRaceFinish: 1, highestRaceFinishCount: 6, podiums: 39, highestGridPosition: 1, highestGridPositionCount: 3, polePositions: 3, worldChampionships: 0, dnfs: 47),
  ),
  DriverStatistics(id: 'valtteri_bottas', name: 'Valtteri Bottas', team: 'Cadillac', number: 77,
    season2026: DriverSeasonStats(seasonPoints: 0, seasonPosition: 22, grandPrixRaces: 0, grandPrixPoints: 0, grandPrixWins: 0, grandPrixPodiums: 0, grandPrixPoles: 0, grandPrixTop10s: 0, fastestLaps: 7, dnfs: 5, sprintRaces: 5, sprintPoints: 0, sprintWins: 0, sprintPodiums: 0, sprintPoles: 0, sprintTop10s: 0),
    career: DriverCareerStats(grandsPrixEntered: 261, careerPoints: 1797, highestRaceFinish: 1, highestRaceFinishCount: 10, podiums: 67, highestGridPosition: 1, highestGridPositionCount: 20, polePositions: 20, worldChampionships: 0, dnfs: 36),
  ),
];
