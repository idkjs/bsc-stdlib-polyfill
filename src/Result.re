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
type t('a, 'e) = result('a, 'e) = | Ok('a) | Error('e);

let ok = v => Ok(v);
let error = e => Error(e);
let value = (r, ~default) =>
  switch (r) {
  | Ok(v) => v
  | Error(_) => default
  };
let get_ok =
  fun
  | Ok(v) => v
  | Error(_) => invalid_arg("result is Error _");
let get_error =
  fun
  | Error(e) => e
  | Ok(_) => invalid_arg("result is Ok _");
let bind = (r, f) =>
  switch (r) {
  | Ok(v) => f(v)
  | Error(_) as e => e
  };
let join =
  fun
  | Ok(r) => r
  | Error(_) as e => e;
let map = f =>
  fun
  | Ok(v) => Ok(f(v))
  | Error(_) as e => e;
let map_error = f =>
  fun
  | Error(e) => Error(f(e))
  | Ok(_) as v => v;
let fold = (~ok, ~error) =>
  fun
  | Ok(v) => ok(v)
  | Error(e) => error(e);
let iter = f =>
  fun
  | Ok(v) => f(v)
  | Error(_) => ();
let iter_error = f =>
  fun
  | Error(e) => f(e)
  | Ok(_) => ();
let is_ok =
  fun
  | Ok(_) => true
  | Error(_) => false;
let is_error =
  fun
  | Error(_) => true
  | Ok(_) => false;

let equal = (~ok, ~error, r0, r1) =>
  switch (r0, r1) {
  | (Ok(v0), Ok(v1)) => ok(v0, v1)
  | (Error(e0), Error(e1)) => error(e0, e1)
  | (_, _) => false
  };

let compare = (~ok, ~error, r0, r1) =>
  switch (r0, r1) {
  | (Ok(v0), Ok(v1)) => ok(v0, v1)
  | (Error(e0), Error(e1)) => error(e0, e1)
  | (Ok(_), Error(_)) => (-1)
  | (Error(_), Ok(_)) => 1
  };

let to_option =
  fun
  | Ok(v) => Some(v)
  | Error(_) => None;
let to_list =
  fun
  | Ok(v) => [v]
  | Error(_) => [];
let to_seq =
  fun
  | Ok(v) => Seq.return(v)
  | Error(_) => Seq.empty;
