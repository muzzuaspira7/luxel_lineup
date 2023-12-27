import 'package:flutter/material.dart';

class reusableWidget {
  ReusableRowColumn(String Bannerimage, String Bannername) {
    return Column(
      children: [
        CircleAvatar(radius: 40, backgroundImage: AssetImage(Bannerimage)),
        Text(
          Bannername,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  ReusableCursoleContainer(String img, String name, String subName) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'BannerFont',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subName,
                    style: TextStyle(
                        // fontSize: 16,
                        fontFamily: 'BannerFont',
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Image(
            image: AssetImage(
              img,
            ),
            fit: BoxFit.contain,
          )),
        ],
      ),
    );
  }
}
