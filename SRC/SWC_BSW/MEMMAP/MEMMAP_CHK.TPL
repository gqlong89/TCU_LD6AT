/*INSERTION_TRADOIL*/
/******************************************************************************/
/*                                                                            */
/* !Layer           : STD                                                     */
/*                                                                            */
/* !Component       : MEMMAP                                                  */
/* !Description     : MEMMAP Configuration                                    */
/*                                                                            */
/* !File            : MEMMAP_CHK.TPL                                          */
/*                                                                            */
/* !Scope           : Public                                                  */
/*                                                                            */
/* !Target          : Genecode Tool V2.0.0.0                                  */
/*                                                                            */
/* !Vendor          : Valeo                                                   */
/*                                                                            */
/* COPYRIGHT 2009 VALEO                                                       */
/* all rights reserved                                                        */
/*                                                                            */
/******************************************************************************/
/* PVCS Information                                                           */
/* $Archive::   I:/PROJETS/LIBEMB/LOG/DIVERS/MEMMAP/LOG/MEMMAP_CHK.TPv       $*/
/* $Revision::   1.4      $$Author::   lvoilmy        $$Date::   24 Jun 2011 $*/
/******************************************************************************/
'/******************************************************************************/
/*                                                                            */
/* !Layer           : NONE                                                    */
/*                                                                            */
/* !Component       : MEMMAP_CFG                                              */
/* !Description     : MEMMAP Configuration                                    */
/*                                                                            */
/* !File            : MEMMAP_CHK.TPL                                          */
/*                                                                            */
/* !Scope           : Public                                                  */
/*                                                                            */
/* !Target          : Genecode Tool                                           */
/*                                                                            */
/* !Vendor          : Valeo                                                   */
/*                                                                            */
/* Coding language  : C                                                       */
/*                                                                            */
/* COPYRIGHT 2009 VALEO                                                       */
/* all rights reserved                                                        */
/*                                                                            */
/******************************************************************************/
/* PVCS Information                                                           */
/* $Arc`'hive::                                                                $*/
/* $Rev`'ision::            $$Au`'thor::                  $$Da`'te::               $*/
/******************************************************************************/
/* `Date()': generated by Genecode  `Version()'                        */
/* From Source Template : MEMMAP_CHK.TPL                                      */
/******************************************************************************/

`
.TRADOIL WHERE (.MEMMAP_CFG COUNT != 1)
{
   Error(("MEMMAP-E001: There must be one and only one MEMMAP_CFG object defined"))
}


'
Some MEMMAP_MSN need to be updated as followed:

   e.g.:

|---------------------------|       |---------------------------|
| MEMMAP_MSN <COMP_NAME>    |       | MEMMAP_MSN <COMP_NAME>    |
| {                         |       | {                         |
|    SECTION = CODE;        |  ==>  |    SECTION = SEC_CODE;    |
|    SECTION = VAR_8BIT     |       |    SECTION = SEC_VAR_8BIT |
|    SECTOIN = XXX          |       |    SECTION = SEC_XXX      |
| };                        |       | };                        |
|---------------------------|       |---------------------------|

Here are the MEMMAP_MSN to update:

-----------------------------------------------------------------
`
MEMMAP_MSN AS msn
{
   WHERE (  (SECTION = CODE)
         or (SECTION = VAR_NOINIT_8BIT)
         or (SECTION = VAR_NOINIT_16BIT)
         or (SECTION = VAR_NOINIT_32BIT)
         or (SECTION = VAR_NOINIT_UNSPECIFIED)
         or (SECTION = VAR_POWER_ON_INIT_8BIT)
         or (SECTION = VAR_POWER_ON_INIT_16BIT)
         or (SECTION = VAR_POWER_ON_INIT_32BIT)
         or (SECTION = VAR_POWER_ON_INIT_UNSPECIFIED)
         or (SECTION = VAR_FAST_8BIT)
         or (SECTION = VAR_FAST_16BIT)
         or (SECTION = VAR_FAST_32BIT)
         or (SECTION = VAR_FAST_UNSPECIFIED)
         or (SECTION = VAR_8BIT)
         or (SECTION = VAR_16BIT)
         or (SECTION = VAR_32BIT)
         or (SECTION = VAR_UNSPECIFIED)
         or (SECTION = CONST_8BIT)
         or (SECTION = CONST_16BIT)
         or (SECTION = CONST_32BIT)
         or (SECTION = CONST_UNSPECIFIED)
         or (SECTION = CALIB_8BIT)
         or (SECTION = CALIB_16BIT)
         or (SECTION = CALIB_32BIT)
         or (SECTION = CALIB_UNSPECIFIED)
         )
   {
      {"SEC_" INTO PREFIX}
      {msn}
   }

   WHERE (SECTION == "")
   {
      Error(("MEMMAP-E002: "msn " should contain at least 1 SECTION"))
   }

   REALLOC AS realloc
   {
      WHERE (msn.SECTION AS memmap WHERE (realloc.SECTION == memmap) COUNT == 0)
      {
         Error(("MEMMAP-E003: The REALLOC field shall realloc an existing section in the object: "msn))
      }
   }
}

'
-----------------------------------------------------------------
`

MEMMAP_PARENT
{
   counter() INTO INDEX
}


MEMMAP_MSN
{
   counter() INTO INDEX
}
'
-----------------------------------------------------------------

For each MEMMAP_PARENT, if START is empty then STOP should be empty also.
`
MEMMAP_PARENT AS parent WHERE((START == "") and (STOP != ""))
{
   Error(("MEMMAP-E004: The MEMMAP_PARENT "parent" has its START field empty while the STOP field is not!, the STOP field should be empty"))
}
'

-----------------------------------------------------------------
Set the CODE_TO_INCLUDE field of each MEMMAP_PARENT
`
MEMMAP_PARENT AS parent WHERE(START != "")
{
   TRUE INTO CODE_TO_INCLUDE
}

MEMMAP_PARENT AS parent WHERE(START == "")
{
   FALSE INTO CODE_TO_INCLUDE
}
'


/*------------------------------- end of file --------------------------------*/
