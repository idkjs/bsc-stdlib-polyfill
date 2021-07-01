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

/** Option values.
    Option values explicitly indicate the presence or absence of a value.
    @since 4.08 */;

/** {1:options Options} */;

/** The type for option values. Either [None] or a value [Some v]. */

type t('a) = option('a) = | None | Some('a); /***/

/** [none] is [None]. */

let none: option('a);

/** [some v] is [Some v]. */

let some: 'a => option('a);

/** [value o ~default] is [v] if [o] is [Some v] and [default] otherwise. */

let value: (option('a), ~default: 'a) => 'a;

/** [get o] is [v] if [o] is [Some v] and @raise Invalid_argument otherwise. */

let get: option('a) => 'a;

/** [bind o f] is [f v] if [o] is [Some v] and [None] if [o] is [None]. */

let bind: (option('a), 'a => option('b)) => option('b);

/** [join oo] is [Some v] if [oo] is [Some (Some v)] and [None] otherwise. */

let join: option(option('a)) => option('a);

/** [map f o] is [None] if [o] is [None] and [Some (f v)] is [o] is [Some v]. */

let map: ('a => 'b, option('a)) => option('b);

/** [fold ~none ~some o] is [none] if [o] is [None] and [some v] if [o] is
    [Some v]. */

let fold: (~none: 'a, ~some: 'b => 'a, option('b)) => 'a;

/** [iter f o] is [f v] if [o] is [Some v] and [()] otherwise. */

let iter: ('a => unit, option('a)) => unit;

/** {1:preds Predicates and comparisons} */;

/** [is_none o] is [true] iff [o] is [None]. */

let is_none: option('a) => bool;

/** [is_some o] is [true] iff [o] is [Some o]. */

let is_some: option('a) => bool;

/** [equal eq o0 o1] is [true] iff [o0] and [o1] are both [None] or if
    they are [Some v0] and [Some v1] and [eq v0 v1] is [true]. */

let equal: (('a, 'a) => bool, option('a), option('a)) => bool;

/** [compare cmp o0 o1] is a total order on options using [cmp] to compare
    values wrapped by [Some _]. [None] is smaller than [Some _] values. */

let compare: (('a, 'a) => int, option('a), option('a)) => int;

/** {1:convert Converting} */;

/** [to_result ~none o] is [Ok v] if [o] is [Some v] and [Error none]
    otherwise. */

let to_result: (~none: 'e, option('a)) => result('a, 'e);

/** [to_list o] is [[]] if [o] is [None] and [[v]] if [o] is [Some v]. */

let to_list: option('a) => list('a);

/** [to_seq o] is [o] as a sequence. [None] is the empty sequence and
    [Some v] is the singleton sequence containing [v]. */

let to_seq: option('a) => Seq.t('a);
