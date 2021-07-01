/**************************************************************************/
/*                                                                        */
/*                                 OCaml                                  */
/*                                                                        */
/*                         The OCaml programmers                          */
/*                                                                        */
/*   Copyright 2018 Institut National de Recherche en Informatique et     */
/*     en Automatique.                                                    */
/*                                                                        */
/*   All rights reserved.  This file is distributed under the terms of    */
/*   the GNU Lesser General Public License version 2.1, with the          */
/*   special exception on linking described in the file LICENSE.          */
/*                                                                        */
/**************************************************************************/
type t('a) = option('a) = | None | Some('a);

let none = None;
let some = v => Some(v);
let value = (o, ~default) =>
  switch (o) {
  | Some(v) => v
  | None => default
  };
let get =
  fun
  | Some(v) => v
  | None => invalid_arg("option is None");
let bind = (o, f) =>
  switch (o) {
  | None => None
  | Some(v) => f(v)
  };
let join =
  fun
  | Some(Some(_) as o) => o
  | _ => None;
let map = (f, o) =>
  switch (o) {
  | None => None
  | Some(v) => Some(f(v))
  };
let fold = (~none, ~some) =>
  fun
  | Some(v) => some(v)
  | None => none;
let iter = f =>
  fun
  | Some(v) => f(v)
  | None => ();
let is_none =
  fun
  | None => true
  | Some(_) => false;
let is_some =
  fun
  | None => false
  | Some(_) => true;

let equal = (eq, o0, o1) =>
  switch (o0, o1) {
  | (Some(v0), Some(v1)) => eq(v0, v1)
  | (None, None) => true
  | _ => false
  };

let compare = (cmp, o0, o1) =>
  switch (o0, o1) {
  | (Some(v0), Some(v1)) => cmp(v0, v1)
  | (None, None) => 0
  | (None, Some(_)) => (-1)
  | (Some(_), None) => 1
  };

let to_result = (~none) =>
  fun
  | None => Error(none)
  | Some(v) => Ok(v);
let to_list =
  fun
  | None => []
  | Some(v) => [v];
let to_seq =
  fun
  | None => Seq.empty
  | Some(v) => Seq.return(v);
