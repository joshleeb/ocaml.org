type version = Latest | Specific of string
type documentation_status = Success | Failure | Unknown

type package = {
  name : string;
  synopsis : string;
  description : string;
  license : string;
  version : version;
  versions : string list;
  latest_version : string;
  tags : string list;
  rev_deps : string list;
  authors : Ood.Opam_user.t list;
  maintainers : Ood.Opam_user.t list;
  publication : float;
  homepages : string list;
  source : (string * string list) option;
      (* TODO: these should be part of package.json coming from voodoo, but they
         currently aren't

         documentation_status : documentation_status; readme_filename : string
         option; changes_filename : string option; license_filename : string
         option;*)
}

let specific_version package =
  match package.version with
  | Latest -> package.latest_version
  | Specific v -> v

let render_version package =
  match package.version with
  | Latest -> Fmt.str "%s (latest)" package.latest_version
  | Specific v -> v

let url_version package =
  match package.version with Latest -> None | Specific v -> Some v

type stats = {
  nb_packages : int;
  nb_update_week : int;
  nb_packages_month : int;
  newest_packages : (package * string) list;
  recently_updated : package list;
  most_revdeps : (package * int) list;
}
(** See {!Ocamlorg_package.Statistics.t}. *)