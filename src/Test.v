Require Import SMTCoq.SMTCoq ZArith.

Local Open Scope Z_scope.


Section group.
  Variable e : Z.
  Variable inv : Z -> Z.
  Variable op : Z -> Z -> Z.

  Hypothesis associative :
    forall a b c, op a (op b c) =? op (op a b) c.
  Hypothesis identity : forall a, (op e a =? a).
  Hypothesis inverse : forall a, (op (inv a) a =? e).

  Add_lemmas associative identity inverse.

  Lemma inverse' :
    forall a : Z, (op a (inv a) =? e).
  Proof. verit. Qed.

  Lemma identity' :
    forall a : Z, (op a e =? a).
  Proof. smt inverse'. Qed.

  Lemma unique_identity e':
    (forall z, op e' z =? z) -> e' =? e.
  Proof. intros pe'; smt pe'. Qed.

  Clear_lemmas.
End group.
