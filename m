Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:59157 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755511Ab1LES3O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 13:29:14 -0500
Date: Mon, 5 Dec 2011 10:31:46 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: James Bottomley <jbottomley@parallels.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci: fix ats compile failure
Message-ID: <20111205103146.39cc9f2a@jbarnes-desktop>
In-Reply-To: <1322594422.11875.47.camel@dabdike.int.hansenpartnership.com>
References: <1322594422.11875.47.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Nkt_stZ7Zp4GxZT8qQNaPkI"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/Nkt_stZ7Zp4GxZT8qQNaPkI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Nov 2011 19:20:23 +0000
James Bottomley <jbottomley@parallels.com> wrote:

> I get this compile failure on parisc:
>=20
> drivers/pci/ats.c: In function 'ats_alloc_one':
> drivers/pci/ats.c:29: error: implicit declaration of function 'kzalloc'
> drivers/pci/ats.c:29: warning: assignment makes pointer from integer with=
out a cast
> drivers/pci/ats.c: In function 'ats_free_one':
> drivers/pci/ats.c:45: error: implicit declaration of function 'kfree'
>=20
> Because ats.c is missing linux/slab.h as an include.  This patch fixes it
>=20
> Signed-off-by: James Bottomley <JBottomley@Parallels.com>
>=20
> ---
>=20
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 7ec56fb..b0dd08e 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -13,6 +13,7 @@
>  #include <linux/export.h>
>  #include <linux/pci-ats.h>
>  #include <linux/pci.h>
> +#include <linux/slab.h>
> =20
>  #include "pci.h"

Applied to  my for-linus branch, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/Nkt_stZ7Zp4GxZT8qQNaPkI
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3Q4SAAoJEIEoDkX4Qk9hhLsP/1N/xfRygB3lYP9KRoDOWBb3
JE3JjDJb6QhJ4yurkP/vfh1VU8BDLo7Ep+ZpeVKcr02kgt67ASUNwR/WZ6jnQ+dg
jScHQwwtIUjp4+K/sJzZxuetharFBEmZf6EYmej3I+jIg7jC9PDfVpRb+Qjn564k
VfB27+cJwWyq7Kddjnt1bns6vm7+4nJMoimURHKEu5NUpYxKT1X665ZYn5ru6RMH
NLJ3MZAMh5rqJmIZ2uGdfdjfwAC8pKiCvCGu10A9Y1qjqo3MwcjXmOvmNuJRwoxD
BYA27sb1NDYhRnPYsG1pEJAWz/3e2SvQr3C/09ETI3xoFmFD/UAzIyvNpboQ38jH
sTRdZCeekuZQalKB3houi15zRJce5W6E0xUVQ0FxPCldjBKZrgg/gProqVpJj6A8
BrwKGjfWi7PjdDzB3hFbyTzmifSURhYN8p90I6xxZzOz8ZTXNSZ7O8SI8GY2SlVe
LMsS+6NSzp9IT4bqMuPviRARX9K3ixgD+0o6QTp9f+a2LA+LZ3i48Hd0/B6JV75O
kIN3lZUMUfQmbe58LtgLKzEa909QU/oqlqTxltOm5siaMjD5CV2M5xntWE6pL3o4
RSYq0uRgMJKZM2ZZ40M6E0RdMadzWljHLrDlQljhCGBfPzkce7GDNYngLyPnE5q7
TnDdCI/49vzblKAk4ZMK
=F9T2
-----END PGP SIGNATURE-----

--Sig_/Nkt_stZ7Zp4GxZT8qQNaPkI--
