import 'package:flutter/material.dart';
import 'package:recipe_app/api/services.dart';
import 'package:recipe_app/model/recipes_model.dart';
import 'package:recipe_app/screen/details_screen.dart';

class RecipesHomeScreen extends StatefulWidget {
  const RecipesHomeScreen({super.key});

  @override
  State<RecipesHomeScreen> createState() => _RecipesHomeScreenState();
}

class _RecipesHomeScreenState extends State<RecipesHomeScreen> {
  List<Recipe> recipesModel = [];
  bool isLoading=false;

  myRecipes() {
    isLoading=true;
    recipesItem().then((value) {
      setState(() {
        recipesModel = value;
        isLoading=false;
      });
    });
  }
  @override
  void initState() {
    myRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe App"),
      ),
      body:isLoading
          ?const Center
        (child: CircularProgressIndicator(),)

      :ListView.builder(
          shrinkWrap: true,
          itemCount: recipesModel.length,
          itemBuilder: (context, index) {
            final recipes = recipesModel[index];
            return Padding(
              padding: EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(recipe:recipes),
                  ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: NetworkImage(recipes.image),
                            fit: BoxFit.fill),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(-5, 7),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 45,
                        decoration: const BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(30),
                            )),
                        child: Row(
                          children: [
                            Expanded(
                              child:
                                  Padding(padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      recipes.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                            ),
                            const Icon(Icons.star,color: Colors.orange,),
                            Text(
                              recipes.rating.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text(
                              recipes.cookTimeMinutes.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                            ),
                            Text(
                             "min",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                            ),
                           SizedBox(width: 15,),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
