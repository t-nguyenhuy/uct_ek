   * ******************************************************************** *
   * ******************************************************************** *
   *                                                                      *
   *               UCT_EK IMPORT MASTER DO_FILE                           *
   *               This master dofile calls all dofiles related           *
   *               to import in the uct_ek round.                         *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

   ** IDS VAR:          list_ID_var_here         // Uniquely identifies households (update for your project)
   ** NOTES:
   ** WRITTEN BY:       Tung Nguyen Huy
   ** Last date modified:  6 Sep 2021


   * ***************************************************** *
   *                                                       *
   * ***************************************************** *
   *
   *   Import_localities.do
   *
   *   The purpose of this dofiles is:
   *     (The ideas below are examples on what to include here)
   *      - what additional data sets does this file require
   *      - what variables are created
   *      - what corrections are made
   *
   * ***************************************************** *

       do "$uctek_doImp/import_localities.do" 	

   * ***************************************************** *
   *
   *   Import tree cover and forest loss data from Google Earth Engine
   *
   *   Raw data extracted from Google Earth Engine
   *     (The ideas below are examples on what to include here)
   *      - what additional data sets does this file require
   *      - what variables are created
   *      - what corrections are made
   *
   * ***************************************************** *

       do "$uctek_doImp/import_forestloss_treecover.do" //Give your dofile a more informative name, this is just a placeholder name

   * ***************************************************** *
   *
   *   import dofile 3
   *
   *   The purpose of this dofiles is:
   *     (The ideas below are examples on what to include here)
   *      - what additional data sets does this file require
   *      - what variables are created
   *      - what corrections are made
   *
   * ***************************************************** *

       *do "$uctek_doImp/dofile3.do" //Give your dofile a more informative name, this is just a placeholder name

   * ************************************
   *   Keep adding sections for all additional dofiles needed
