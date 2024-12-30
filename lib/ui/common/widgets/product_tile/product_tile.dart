import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatefulWidget {
  const ProductTile({super.key});

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> with AutomaticKeepAliveClientMixin<ProductTile> {
  @override
  bool get wantKeepAlive => true; // Ensures the state is kept alive during rebuilds.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image with "Add" button, background, left-bottom veg/nonveg tag
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .20,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  color: CupertinoColors.systemGrey3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'assets/atta.png',
                  height: 80, // Ensures the image covers the area
                ),
              ),
              Positioned(
                right: -12, // Position the button outside of the container
                bottom: -12, // Position the button at the bottom-right
                child: AddButton(),
              ),
            ],
          ),

          /// Weight tag and Title
          SizedBox(height: 10),
          Text(
            "Product Title",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
          Spacer(),
          /// Rating, Time, Off, Price
          SizedBox(height: 2),
          Text("⭐⭐⭐⭐(562679)", style: TextStyle(fontSize: 9)),
          SizedBox(height: 2),
          Text("9mins", style: TextStyle(fontSize: 9)),
          SizedBox(height: 5),
          Text("25% OFF", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                "\$667", // Discounted price
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // For discounted price
                ),
              ),
              SizedBox(width: 10),
              Text(
                "\$999", // Original price
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.lineThrough, // Strikethrough original price
                  color: Colors.grey, // For original price
                ),
              ),
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}

class AddButton extends StatelessWidget {

  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    final addButtonViewModel = Provider.of<AddButtonViewModel>(context);
    return ListenableBuilder(
      listenable: addButtonViewModel,
      builder: (context,child) {
        return InkWell(onTap: (){
          addButtonViewModel.toggleIsClicked();
        },
          child: Container(

            decoration: BoxDecoration(border: Border.all(color: Colors.green),color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
              child: addButtonViewModel.isClicked?Row(children: [
                InkWell(onTap:()=>addButtonViewModel.decrement(),child: Icon(CupertinoIcons.minus,size: 10,)),
                SizedBox(width: 10,),
                Text(addButtonViewModel.value.toString(),style: TextStyle(fontSize: 10),),
                SizedBox(width: 10,),
                InkWell(onTap:()=>addButtonViewModel.increment(),child: Icon(CupertinoIcons.plus,size: 10,)),




              ],):Text("Add"),
            ),
          ),
        );
      },
    );
  }
}
class AddButtonViewModel extends ChangeNotifier{
  bool _isClicked=false;
  int _value=1;
  bool get isClicked => _isClicked;
  int get value => _value;

  void toggleIsClicked(){
   _isClicked=true;
   notifyListeners();
  }
  void increment(){
    _value++;
    notifyListeners();
  }
  void decrement(){
    if(_value>0)
      _value--;
    if(_value==0){
      _isClicked=false;
    }



    notifyListeners();

  }

}