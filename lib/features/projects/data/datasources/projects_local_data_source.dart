import 'package:flutter/material.dart';
import 'package:sudalaimani_portfolio/core/constants/app_constants.dart';
import '../models/project_model.dart';

abstract class ProjectsLocalDataSource {
  List<ProjectModel> getProjects();
}

class ProjectsLocalDataSourceImpl implements ProjectsLocalDataSource {
  @override
  List<ProjectModel> getProjects() {
    return const [
      ProjectModel(
        id: '1',
        title: 'Selco Foundation',
        slug: 'selco-foundation',
        description:
            'A field survey application supporting data collection, production metrics, and expense-related survey workflows with reliable offline synchronization.',
        fullDescription:
            'Selco Foundation is an enterprise-grade survey application designed for remote field operations. It enables field surveyors to collect large volumes of qualitative and quantitative data across energy access, production metrics, and expenses even without network connectivity. Built using clean architecture and robust local persistence, the app queues changes and safely synchronizes data in the background once internet connectivity is restored.',
        category: 'Field Operations',
        technologies: [
          'Flutter',
          'Dart',
          'REST APIs',
          'Offline Storage',
          'Background Sync',
          'SQLite',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.selcofoundation&hl=en_IN',
        githubUrl: null, // Keep null until verified repo is supplied
        localScreenshotAsset: AppConstants.selcoBanner,
        iconData: Icons.fact_check_rounded,
        gradientColors: [Color(0xFF0D9488), Color(0xFF14B8A6)],
        highlights: [
          'Offline-first architecture supporting rural field data collection',
          'Automated background data synchronization on network recovery',
          'Dynamic multi-step forms with strict validation rules',
          'Local caching and SQLite data encryption for data privacy',
        ],
      ),
      ProjectModel(
        id: '2',
        title: 'Go1 HelpDesk',
        slug: 'go1-helpdesk',
        description:
            'A comprehensive help desk application supporting real-time ticket management, role-based workflows, live chat, and push notifications.',
        fullDescription:
            'Go1 HelpDesk streamlines support workflows by connecting customers and support teams. It features comprehensive ticket tracking, role-based access control, real-time ticket lifecycle updates, and deep linking that immediately directs agents or users to relevant conversation threads. The application uses Firebase Cloud Messaging to ensure urgent ticket updates are delivered reliably.',
        category: 'Productivity & Support',
        technologies: [
          'Flutter',
          'Dart',
          'REST APIs',
          'Push Notifications',
          'Deep Links',
          'FCM',
          'Chat Integration',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.go1desk&hl=en_IN',
        githubUrl: null,
        localScreenshotAsset: AppConstants.go1deskBanner,
        iconData: Icons.support_agent_rounded,
        gradientColors: [Color(0xFF2563EB), Color(0xFF6366F1)],
        highlights: [
          'Real-time ticket status updates and notification triggers',
          'Deep link routing directly into active conversation threads',
          'Role-based authorization flows for managers, agents, and clients',
          'Interactive messaging interface with attachment support',
        ],
      ),
      ProjectModel(
        id: '3',
        title: 'Torque Partner',
        slug: 'torque-partner',
        description:
            'A partner-focused mobile application facilitating seamless business process management, order tracking, and operational communications.',
        fullDescription:
            'Torque Partner is a dedicated partner application designed to bridge operational gaps between business partners and the core management platform. The app provides intuitive dashboard metrics, order tracking, transaction history, and direct communication channels built with a scalable Clean Architecture foundation.',
        category: 'Business & Operations',
        technologies: [
          'Flutter',
          'Dart',
          'REST APIs',
          'BLoC Pattern',
          'Clean Architecture',
          'Secure Storage',
        ],
        playStoreUrl:
            'https://play.google.com/store/search?q=torque+partner+app&c=apps&hl=en_IN',
        githubUrl: null,
        localScreenshotAsset: AppConstants.torqueBanner,
        iconData: Icons.handshake_rounded,
        gradientColors: [Color(0xFFEA580C), Color(0xFFF97316)],
        highlights: [
          'Modular feature-first code organization for long-term scalability',
          'State management with flutter_bloc for predictable UI updates',
          'Responsive charts and key operational metrics dashboard',
          'Centralized API client with automatic token refreshing',
        ],
      ),
      ProjectModel(
        id: '4',
        title: 'Redsun Travel Driver',
        slug: 'redsun-travel-driver',
        description:
            'A high-performance driver application for cab and transportation services, featuring live location tracking and navigation workflows.',
        fullDescription:
            'Redsun Travel Driver powers on-demand cab and transportation workflows. Designed for continuous driver usability, it incorporates Google Maps integration, real-time GPS location streaming, background location tracking, and optimized route calculations to guarantee smooth dispatching and passenger trip fulfillment.',
        category: 'Logistics & Travel',
        technologies: [
          'Flutter',
          'Dart',
          'Google Maps',
          'GPS Tracking',
          'Background Location',
          'Streams',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.redsunavel.driver&hl=en_IN',
        githubUrl: null,
        localScreenshotAsset: AppConstants.redsunBanner,
        iconData: Icons.local_taxi_rounded,
        gradientColors: [Color(0xFFDC2626), Color(0xFFEF4444)],
        highlights: [
          'Continuous background location tracking with battery optimization',
          'Custom Google Maps overlays, markers, and live polyline routing',
          'Real-time trip dispatch, acceptance, and status state machine',
          'Native Android/iOS background service platform channel integration',
        ],
      ),
      ProjectModel(
        id: '5',
        title: 'Orbee Insurance',
        slug: 'orbee-insurance',
        description:
            'A modern insurance platform enabling users to explore policy coverage, submit claims, and manage insurance portfolios securely.',
        fullDescription:
            'Orbee Insurance delivers a secure, user-centric mobile insurance experience. Users can inspect detailed policy breakdowns, simulate premium quotes, upload claim documentation, and receive instant policy status notifications through a clean, intuitive interface.',
        category: 'Fintech & Insurance',
        technologies: [
          'Flutter',
          'Dart',
          'REST APIs',
          'Secure Storage',
          'Form Validation',
          'Clean Architecture',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.orbeeinsurance&hl=en_IN',
        githubUrl: null,
        localScreenshotAsset: AppConstants.orbeeBanner,
        iconData: Icons.shield_rounded,
        gradientColors: [Color(0xFF7C3AED), Color(0xFF8B5CF6)],
        highlights: [
          'Dynamic multi-step insurance claim submission workflow',
          'Secure storage of sensitive user documents and credentials',
          'Interactive premium estimation calculators with instant feedback',
          'Accessible, legible typography and high-contrast forms',
        ],
      ),
    ];
  }
}
