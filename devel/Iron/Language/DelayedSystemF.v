
(* Simply Typed Lambda Calculus (STLC) 
   Using named binders with delayed substitution. *)

(* Types, expressions, normal forms, values, lifting and substitution *)
Require Export Iron.Language.DelayedSystemF.Exp.

(* Typing judgement and environment weakening. *)
Require Export Iron.Language.DelayedSystemF.Ty.

(* Substitution of exps in exps preserves typing. *)
Require Export Iron.Language.DelayedSystemF.SubstXX.

(* Small step evaluation. *)
Require Export Iron.Language.DelayedSystemF.Step.

(* A well typed expression is either a value or can take a step. *)
Require Export Iron.Language.DelayedSystemF.Progress.

(* When an expression takes a step then the result has the same type. *)
Require Export Iron.Language.DelayedSystemF.Preservation.

(* Big step evaluation, and conversion between small step evaluation. *)
Require Export Iron.Language.DelayedSystemF.Eval.
