import 'package:amazon/Constant/global_variable.dart';
import 'package:amazon/features/home/Screen/category_details.dart';
import 'package:flutter/material.dart';


class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigatetocategorypage(BuildContext context,String category){
      Navigator.pushNamed(context, Categorydealscreen.routeName,arguments: category);
    }
    return  SizedBox(
      height: 60,
     
      child:ListView.builder(
        itemExtent: 70,
        scrollDirection: Axis.horizontal,
          itemCount: Globalariables.categoryImages.length,
          itemBuilder: (context,index){
        return Column(
          children: [
            GestureDetector(
              onTap: (){
                navigatetocategorypage(context,Globalariables.categoryImages[index]['title']!,);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(Globalariables.categoryImages[index]['image']!,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,),
                ),
              ),
            ),
            Text(Globalariables.categoryImages[index]['title']!,style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400
            ),)
          ],
        );
          })
    );
  }
}
