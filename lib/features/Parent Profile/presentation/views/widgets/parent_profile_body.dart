
import 'package:edunourish/core/widgets/base_scaffold.dart';
import 'package:edunourish/features/Parent%20Profile/data/models/Profile.dart';
import 'package:flutter/material.dart';
import 'profile_detail.dart';

class ParentProfileBody extends StatelessWidget {
  const ParentProfileBody({super.key,required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBartTitle: 'Profile',
      child: Column(
        children: [
          // Profile header with avatar
          Container(
            padding: const EdgeInsets.only(bottom: 24),
            child:  Column(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 52,
                    backgroundImage:
                        NetworkImage(profile.photo),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  profile.username,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Profile details section
          profileDetailsSection(),
        ],
      ),
    );
  }

  Expanded profileDetailsSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: ListView(
              children:  [
                const SectionHeader(title: "Personal Information"),
                ProfileDetail(
                  label: "ID",
                  value: profile.id,
                  icon: Icons.phone,
                ),
                ProfileDetail(
                  label: "Full Name",
                  value: profile.username,
                  icon: Icons.person,
                ),
                ProfileDetail(
                  label: "Email Address",
                  value: profile.email,
                  icon: Icons.email,
                ),
                ProfileDetail(
                  label: "Phone Number",
                  value: profile.phoneNumber,
                  icon: Icons.phone,
                ),
                 ProfileDetail(
                  label: "Age",
                  value: profile.age.toString(),
                  icon: Icons.phone,
                ),
                ProfileDetail(
                  label: "Gender",
                  value: profile.gender ,
                  icon: Icons.phone,
                ),
                ProfileDetail(
                  label: "Address",
                  value: profile.address,
                  icon: Icons.phone,
                ),
                const SizedBox(height: 16),
                // const SectionHeader(title: "Child Information"),
                // const ProfileDetail(
                //   label: "Child's Name",
                //   value: "Piple",
                //   icon: Icons.child_care,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// A helper widget for section headers
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
