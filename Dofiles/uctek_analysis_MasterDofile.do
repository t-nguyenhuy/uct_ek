   * ******************************************************************** *
   * ******************************************************************** *
   *                                                                      *
   *               UCT_EK ANALYSIS MASTER DO_FILE                         *
   *               This master dofile calls all dofiles related           *
   *               to analysis in the uct_ek round.                       *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

   ** IDS VAR:          list_ID_var_here         // Uniquely identifies households (update for your project)
   ** NOTES:
   ** WRITTEN BY:       names_of_contributors
   ** Last date modified:  6 Sep 2021


   * ***************************************************** *
   *                                                       *
   * ***************************************************** *
   *
   *   Exploratory analysis, built on row data
   *
   *   The purpose of this dofiles is:
   *     (The ideas below are examples on what to include here)
   *      - what additional data sets does this file require
   *      - what variables are created
   *      - what corrections are made
   *
   * ***************************************************** *

       do "$uctek_doAnl/uct_ek_Exploratory_Analysis.do" //Give your dofile a more informative name, this is just a placeholder name

   * ***************************************************** *
   *
   *   analysis dofile 2
   *
   *   The purpose of this dofiles is:
   *     (The ideas below are examples on what to include here)
   *      - what additional data sets does this file require
   *      - what variables are created
   *      - what corrections are made
   *
   * ***************************************************** *

       *do "$uctek_doAnl/dofile2.do" //Give your dofile a more informative name, this is just a placeholder name

   * ***************************************************** *
   *
   *   analysis dofile 3
   *
   *   The purpose of this dofiles is:
   *     (The ideas below are examples on what to include here)
   *      - what additional data sets does this file require
   *      - what variables are created
   *      - what corrections are made
   *
   * ***************************************************** *

       *do "$uctek_doAnl/dofile3.do" //Give your dofile a more informative name, this is just a placeholder name

   * ************************************
   *   Keep adding sections for all additional dofiles needed
