/*

	 _____  __ _____________ _______  ______ ___________
	/     \|  |  \____ \__  \\_  __ \/  ___// __ \_  __ \
   |  Y Y  \  |  /  |_> > __ \|  | \/\___ \\  ___/|  | \/
   |__|_|  /____/|   __(____  /__|  /____  >\___  >__|
		 \/      |__|       \/           \/     \/
   Copyright (C) 2004 - 2020 Ingo Berg

	Redistribution and use in source and binary forms, with or without modification, are permitted
	provided that the following conditions are met:

	  * Redistributions of source code must retain the above copyright notice, this list of
		conditions and the following disclaimer.
	  * Redistributions in binary form must reproduce the above copyright notice, this list of
		conditions and the following disclaimer in the documentation and/or other materials provided
		with the distribution.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
	IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
	FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
	CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
	DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
	IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

extern (C):

/** \file
		\brief This file contains the DLL interface of muparser.
	*/

// Basic types
alias muParserHandle_t = void*; // parser handle

alias muChar_t = char; // character type

// character type

alias muBool_t = int; // boolean type
alias muInt_t = int; // integer type 
alias muFloat_t = double; // floating point type

// function types for calculation
alias muFun0_t = double function ();
alias muFun1_t = double function (muFloat_t);
alias muFun2_t = double function (muFloat_t, muFloat_t);
alias muFun3_t = double function (muFloat_t, muFloat_t, muFloat_t);
alias muFun4_t = double function (muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muFun5_t = double function (muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muFun6_t = double function (muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muFun7_t = double function (muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muFun8_t = double function (muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muFun9_t = double function (muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muFun10_t = double function (muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);

// Function prototypes for bulkmode functions
alias muBulkFun0_t = double function (int, int);
alias muBulkFun1_t = double function (int, int, muFloat_t);
alias muBulkFun2_t = double function (int, int, muFloat_t, muFloat_t);
alias muBulkFun3_t = double function (int, int, muFloat_t, muFloat_t, muFloat_t);
alias muBulkFun4_t = double function (int, int, muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muBulkFun5_t = double function (int, int, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muBulkFun6_t = double function (int, int, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muBulkFun7_t = double function (int, int, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muBulkFun8_t = double function (int, int, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muBulkFun9_t = double function (int, int, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);
alias muBulkFun10_t = double function (int, int, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t, muFloat_t);

alias muMultFun_t = double function (const(muFloat_t)*, muInt_t);
alias muStrFun1_t = double function (const(muChar_t)*);
alias muStrFun2_t = double function (const(muChar_t)*, muFloat_t);
alias muStrFun3_t = double function (const(muChar_t)*, muFloat_t, muFloat_t);

// Functions for parser management
alias muErrorHandler_t = void function (muParserHandle_t a_hParser); // [optional] callback to an error handler
alias muFacFun_t = double* function (const(muChar_t)*, void*); // [optional] callback for creating new variables
alias muIdentFun_t = int function (const(muChar_t)*, muInt_t*, muFloat_t*); // [optional] value identification callbacks

//-----------------------------------------------------------------------------------------------------
// Constants
extern __gshared const int muOPRT_ASCT_LEFT;
extern __gshared const int muOPRT_ASCT_RIGHT;

extern __gshared const int muBASETYPE_FLOAT;
extern __gshared const int muBASETYPE_INT;

//-----------------------------------------------------------------------------------------------------
//
//
// muParser C compatible bindings
//
//
//-----------------------------------------------------------------------------------------------------

// Basic operations / initialization  
muParserHandle_t mupCreate (int nBaseType);
void mupRelease (muParserHandle_t a_hParser);
const(muChar_t)* mupGetExpr (muParserHandle_t a_hParser);
void mupSetExpr (muParserHandle_t a_hParser, const(muChar_t)* a_szExpr);
void mupSetVarFactory (muParserHandle_t a_hParser, muFacFun_t a_pFactory, void* pUserData);
const(muChar_t)* mupGetVersion (muParserHandle_t a_hParser);
muFloat_t mupEval (muParserHandle_t a_hParser);
muFloat_t* mupEvalMulti (muParserHandle_t a_hParser, int* nNum);
void mupEvalBulk (muParserHandle_t a_hParser, muFloat_t* a_fResult, int nSize);

// Defining callbacks / variables / constants
void mupDefineFun0 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muFun0_t a_pFun, muBool_t a_bOptimize);
void mupDefineFun1 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muFun1_t a_pFun, muBool_t a_bOptimize);
void mupDefineFun2 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muFun2_t a_pFun, muBool_t a_bOptimize);
void mupDefineFun3 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muFun3_t a_pFun, muBool_t a_bOptimize);
void mupDefineFun4 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muFun4_t a_pFun, muBool_t a_bOptimize);
void mupDefineFun5 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muFun5_t a_pFun, muBool_t a_bOptimize);
void mupDefineFun6 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muFun6_t a_pFun, muBool_t a_bOptimize);
void mupDefineFun7 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muFun7_t a_pFun, muBool_t a_bOptimize);
void mupDefineFun8 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muFun8_t a_pFun, muBool_t a_bOptimize);
void mupDefineFun9 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muFun9_t a_pFun, muBool_t a_bOptimize);
void mupDefineFun10 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muFun10_t a_pFun, muBool_t a_bOptimize);

// Defining bulkmode functions
void mupDefineBulkFun0 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muBulkFun0_t a_pFun);
void mupDefineBulkFun1 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muBulkFun1_t a_pFun);
void mupDefineBulkFun2 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muBulkFun2_t a_pFun);
void mupDefineBulkFun3 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muBulkFun3_t a_pFun);
void mupDefineBulkFun4 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muBulkFun4_t a_pFun);
void mupDefineBulkFun5 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muBulkFun5_t a_pFun);
void mupDefineBulkFun6 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muBulkFun6_t a_pFun);
void mupDefineBulkFun7 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muBulkFun7_t a_pFun);
void mupDefineBulkFun8 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muBulkFun8_t a_pFun);
void mupDefineBulkFun9 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muBulkFun9_t a_pFun);
void mupDefineBulkFun10 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muBulkFun10_t a_pFun);

// string functions
void mupDefineStrFun1 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muStrFun1_t a_pFun);
void mupDefineStrFun2 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muStrFun2_t a_pFun);
void mupDefineStrFun3 (muParserHandle_t a_hParser, const(muChar_t)* a_szName, muStrFun3_t a_pFun);

void mupDefineMultFun (
    muParserHandle_t a_hParser,
    const(muChar_t)* a_szName,
    muMultFun_t a_pFun,
    muBool_t a_bOptimize);

void mupDefineOprt (
    muParserHandle_t a_hParser,
    const(muChar_t)* a_szName,
    muFun2_t a_pFun,
    muInt_t a_nPrec,
    muInt_t a_nOprtAsct,
    muBool_t a_bOptimize);

void mupDefineConst (
    muParserHandle_t a_hParser,
    const(muChar_t)* a_szName,
    muFloat_t a_fVal);

void mupDefineStrConst (
    muParserHandle_t a_hParser,
    const(muChar_t)* a_szName,
    const(muChar_t)* a_sVal);

void mupDefineVar (
    muParserHandle_t a_hParser,
    const(muChar_t)* a_szName,
    muFloat_t* a_fVar);

void mupDefineBulkVar (
    muParserHandle_t a_hParser,
    const(muChar_t)* a_szName,
    muFloat_t* a_fVar);

void mupDefinePostfixOprt (
    muParserHandle_t a_hParser,
    const(muChar_t)* a_szName,
    muFun1_t a_pOprt,
    muBool_t a_bOptimize);

void mupDefineInfixOprt (
    muParserHandle_t a_hParser,
    const(muChar_t)* a_szName,
    muFun1_t a_pOprt,
    muBool_t a_bOptimize);

// Define character sets for identifiers
void mupDefineNameChars (muParserHandle_t a_hParser, const(muChar_t)* a_szCharset);
void mupDefineOprtChars (muParserHandle_t a_hParser, const(muChar_t)* a_szCharset);
void mupDefineInfixOprtChars (muParserHandle_t a_hParser, const(muChar_t)* a_szCharset);

// Remove all / single variables
void mupRemoveVar (muParserHandle_t a_hParser, const(muChar_t)* a_szName);
void mupClearVar (muParserHandle_t a_hParser);
void mupClearConst (muParserHandle_t a_hParser);
void mupClearOprt (muParserHandle_t a_hParser);
void mupClearFun (muParserHandle_t a_hParser);

// Querying variables / expression variables / constants
int mupGetExprVarNum (muParserHandle_t a_hParser);
int mupGetVarNum (muParserHandle_t a_hParser);
int mupGetConstNum (muParserHandle_t a_hParser);
void mupGetExprVar (muParserHandle_t a_hParser, uint a_iVar, const(muChar_t*)* a_pszName, muFloat_t** a_pVar);
void mupGetVar (muParserHandle_t a_hParser, uint a_iVar, const(muChar_t*)* a_pszName, muFloat_t** a_pVar);
void mupGetConst (muParserHandle_t a_hParser, uint a_iVar, const(muChar_t*)* a_pszName, muFloat_t* a_pVar);
void mupSetArgSep (muParserHandle_t a_hParser, const muChar_t cArgSep);
void mupSetDecSep (muParserHandle_t a_hParser, const muChar_t cArgSep);
void mupSetThousandsSep (muParserHandle_t a_hParser, const muChar_t cArgSep);
void mupResetLocale (muParserHandle_t a_hParser);

// Add value recognition callbacks
void mupAddValIdent (muParserHandle_t a_hParser, muIdentFun_t);

// Error handling
muBool_t mupError (muParserHandle_t a_hParser);
void mupErrorReset (muParserHandle_t a_hParser);
void mupSetErrorHandler (muParserHandle_t a_hParser, muErrorHandler_t a_pErrHandler);
const(muChar_t)* mupGetErrorMsg (muParserHandle_t a_hParser);
muInt_t mupGetErrorCode (muParserHandle_t a_hParser);
muInt_t mupGetErrorPos (muParserHandle_t a_hParser);
const(muChar_t)* mupGetErrorToken (muParserHandle_t a_hParser);
//API_EXPORT(const muChar_t*) mupGetErrorExpr(muParserHandle_t a_hParser);

// This is used for .NET only. It creates a new variable allowing the dll to
// manage the variable rather than the .NET garbage collector.
muFloat_t* mupCreateVar ();
void mupReleaseVar (muFloat_t*);

// include guard
