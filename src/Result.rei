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

/** Result values.
    Result values handle computation results and errors in an explicit
    and declarative manner without resorting to exceptions.
    @since 4.08 */;

/** {1:results Results} */;

/** The type for result values. Either a value [Ok v] or an error [Error e]. */

type t('a, 'e) = result('a, 'e) = | Ok('a) | Error('e); /***/

/** [ok v] is [Ok v]. */

let ok: 'a => result('a, 'e);

/** [error e] is [Error e]. */

let error: 'e => result('a, 'e);

/** [value r ~default] is [v] if [r] is [Ok v] and [default] otherwise. */

let value: (result('a, 'e), ~default: 'a) => 'a;

/** [get_ok r] is [v] if [r] is [Ok v] and @raise Invalid_argument
    otherwise. */

let get_ok: result('a, 'e) => 'a;

/** [get_error r] is [e] if [r] is [Error e] and @raise Invalid_argument
    otherwise. */

let get_error: result('a, 'e) => 'e;

/** [bind r f] is [f v] if [r] is [Ok v] and [r] if [r] is [Error _]. */

let bind: (result('a, 'e), 'a => result('b, 'e)) => result('b, 'e);

/** [join rr] is [r] if [rr] is [Ok r] and [rr] if [rr] is [Error _]. */

let join: result(result('a, 'e), 'e) => result('a, 'e);

/** [map f r] is [Ok (f v)] if [r] is [Ok v] and [r] if [r] is [Error _]. */

let map: ('a => 'b, result('a, 'e)) => result('b, 'e);

/** [map_error f r] is [Error (f e)] if [r] is [Error e] and [r] if
    [r] is [Ok _]. */

let map_error: ('e => 'f, result('a, 'e)) => result('a, 'f);

/** [fold ~ok ~error r] is [ok v] if [r] is [Ok v] and [error e] if [r]
    is [Error e]. */

let fold: (~ok: 'a => 'c, ~error: 'e => 'c, result('a, 'e)) => 'c;

/** [iter f r] is [f v] if [r] is [Ok v] and [()] otherwise. */

let iter: ('a => unit, result('a, 'e)) => unit;

/** [iter_error f r] is [f e] if [r] is [Error e] and [()] otherwise. */

let iter_error: ('e => unit, result('a, 'e)) => unit;

/** {1:preds Predicates and comparisons} */;

/** [is_ok r] is [true] iff [r] is [Ok _]. */

let is_ok: result('a, 'e) => bool;

/** [is_error r] is [true] iff [r] is [Error _]. */

let is_error: result('a, 'e) => bool;

/** [equal ~ok ~error r0 r1] tests equality of [r0] and [r1] using [ok]
    and [error] to respectively compare values wrapped by [Ok _] and
    [Error _]. */

let equal:
  (
    ~ok: ('a, 'a) => bool,
    ~error: ('e, 'e) => bool,
    result('a, 'e),
    result('a, 'e)
  ) =>
  bool;

/** [compare ~ok ~error r0 r1] totally orders [r0] and [r1] using [ok] and
    [error] to respectively compare values wrapped by [Ok _ ] and [Error _].
    [Ok _] values are smaller than [Error _] values. */

let compare:
  (
    ~ok: ('a, 'a) => int,
    ~error: ('e, 'e) => int,
    result('a, 'e),
    result('a, 'e)
  ) =>
  int;

/** {1:convert Converting} */;

/** [to_option r] is [r] as an option, mapping [Ok v] to [Some v] and
    [Error _] to [None]. */

let to_option: result('a, 'e) => option('a);

/** [to_list r] is [[v]] if [r] is [Ok v] and [[]] otherwise. */

let to_list: result('a, 'e) => list('a);

/** [to_seq r] is [r] as a sequence. [Ok v] is the singleton sequence
    containing [v] and [Error _] is the empty sequence. */

let to_seq: result('a, 'e) => Seq.t('a);
