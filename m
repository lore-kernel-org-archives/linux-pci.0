Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:47254 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752947Ab2AFVtZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2012 16:49:25 -0500
Date: Fri, 6 Jan 2012 13:49:15 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
Message-ID: <20120106134915.705f5b47@jbarnes-desktop>
In-Reply-To: <1323247984-15281-3-git-send-email-yinghai@kernel.org>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-3-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/KRvlTNmBgtSZXSGVbEOQS3m"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/KRvlTNmBgtSZXSGVbEOQS3m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Linus, can you please check this out too?  It seems like we're just
piling on heuristics here with code that's already pretty unreadable...

In general I like the idea of improving the resource reassignment code,
even with more heuristics, but I think we need some refactoring to make
them easier to follow.  Right now we re-use all this logic even for
simple device which seems like overkill.

Overall in looking at all this again I regret not asking for more
cleanups before it went in:
  1) resource_list_x?  really?
  2) why aren't we using list_head?
  3) realloc/fail_head don't communicate much either

Other comments below.

On Wed,  7 Dec 2011 00:53:01 -0800
Yinghai Lu <yinghai@kernel.org> wrote:

> Found reassign can not find right range for one resource. even total rang=
e is enough.
>=20
> bridge b1:02.0 will need 2M+3M
> bridge b1:03.0 will need 2M+3M
>=20
> so bridge b0:00.0 will get assigned: 4M : [f8000000-f83fffff]
>    later is reassigned to 10M : [f8000000-f9ffffff]
>=20
> b1:02.0 is assigned to 2M : [f8000000-f81fffff]
> b1:03.0 is assigned to 2M : [f8200000-f83fffff]
>=20
> after that b1:03.0 get chance to be reassigned to [f8200000-f86fffff]
> but b1:02.0 will not have chance to expand, because b1:03.0 is using in m=
iddle one.
>=20
> [  187.911401] pci 0000:b1:02.0: bridge window [mem 0x00100000-0x002fffff=
] to [bus b2-b2] add_size 300000
> [  187.920764] pci 0000:b1:03.0: bridge window [mem 0x00100000-0x002fffff=
] to [bus b3-b3] add_size 300000
> [  187.930129] pci 0000:b1:02.0: [mem 0x00100000-0x002fffff] get_res_add_=
size  add_size 300000
> [  187.938500] pci 0000:b1:03.0: [mem 0x00100000-0x002fffff] get_res_add_=
size  add_size 300000
> [  187.946857] pci 0000:b0:00.0: bridge window [mem 0x00100000-0x004fffff=
] to [bus b1-b3] add_size 600000
> [  187.956206] pci 0000:b0:00.0: BAR 14: assigned [mem 0xf8000000-0xf83ff=
fff]
> [  187.963102] pci 0000:b0:00.0: BAR 15: assigned [mem 0xf5000000-0xf51ff=
fff pref]
> [  187.970434] pci 0000:b0:00.0: BAR 14: reassigned [mem 0xf8000000-0xf89=
fffff]
> [  187.977497] pci 0000:b1:02.0: BAR 14: assigned [mem 0xf8000000-0xf81ff=
fff]
> [  187.984383] pci 0000:b1:02.0: BAR 15: assigned [mem 0xf5000000-0xf50ff=
fff pref]
> [  187.991695] pci 0000:b1:03.0: BAR 14: assigned [mem 0xf8200000-0xf83ff=
fff]
> [  187.998576] pci 0000:b1:03.0: BAR 15: assigned [mem 0xf5100000-0xf51ff=
fff pref]
> [  188.005888] pci 0000:b1:03.0: BAR 14: reassigned [mem 0xf8200000-0xf86=
fffff]
> [  188.012939] pci 0000:b1:02.0: BAR 14: can't assign mem (size 0x200000)
> [  188.019471] pci 0000:b1:02.0: failed to add 300000 to res=3D[mem 0xf80=
00000-0xf81fffff]
> [  188.027326] pci 0000:b2:00.0: reg 184: [mem 0x00000000-0x00003fff 64bi=
t]
> [  188.034071] pci 0000:b2:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bi=
t]
> [  188.040795] pci 0000:b2:00.0: BAR 2: assigned [mem 0xf8000000-0xf80fff=
ff 64bit]
> [  188.048119] pci 0000:b2:00.0: BAR 2: set to [mem 0xf8000000-0xf80fffff=
 64bit] (PCI address [0xf8000000-0xf80fffff])
> [  188.058550] pci 0000:b2:00.0: BAR 6: assigned [mem 0xf5000000-0xf50fff=
ff pref]
> [  188.065802] pci 0000:b2:00.0: BAR 0: assigned [mem 0xf8100000-0xf8103f=
ff 64bit]
> [  188.073125] pci 0000:b2:00.0: BAR 0: set to [mem 0xf8100000-0xf8103fff=
 64bit] (PCI address [0xf8100000-0xf8103fff])
> [  188.083596] pci 0000:b2:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bi=
t]
> [  188.090310] pci 0000:b2:00.0: BAR 9: can't assign mem (size 0x300000)
> [  188.096773] pci 0000:b2:00.0: reg 184: [mem 0x00000000-0x00003fff 64bi=
t]
> [  188.103479] pci 0000:b2:00.0: BAR 7: assigned [mem 0xf8104000-0xf810ff=
ff 64bit]
> [  188.110801] pci 0000:b2:00.0: BAR 7: set to [mem 0xf8104000-0xf810ffff=
 64bit] (PCI address [0xf8104000-0xf810ffff])
> [  188.121256] pci 0000:b1:02.0: PCI bridge to [bus b2-b2]
> [  188.126512] pci 0000:b1:02.0:   bridge window [mem 0xf8000000-0xf81fff=
ff]
> [  188.133328] pci 0000:b1:02.0:   bridge window [mem 0xf5000000-0xf50fff=
ff pref]
> [  188.140608] pci 0000:b3:00.0: reg 184: [mem 0x00000000-0x00003fff 64bi=
t]
> [  188.147341] pci 0000:b3:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bi=
t]
> [  188.154076] pci 0000:b3:00.0: BAR 2: assigned [mem 0xf8200000-0xf82fff=
ff 64bit]
> [  188.161417] pci 0000:b3:00.0: BAR 2: set to [mem 0xf8200000-0xf82fffff=
 64bit] (PCI address [0xf8200000-0xf82fffff])
> [  188.171865] pci 0000:b3:00.0: BAR 6: assigned [mem 0xf5100000-0xf51fff=
ff pref]
> [  188.179090] pci 0000:b3:00.0: BAR 0: assigned [mem 0xf8300000-0xf8303f=
ff 64bit]
> [  188.186431] pci 0000:b3:00.0: BAR 0: set to [mem 0xf8300000-0xf8303fff=
 64bit] (PCI address [0xf8300000-0xf8303fff])
> [  188.196884] pci 0000:b3:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bi=
t]
> [  188.203591] pci 0000:b3:00.0: BAR 9: assigned [mem 0xf8400000-0xf86fff=
ff 64bit]
> [  188.210909] pci 0000:b3:00.0: BAR 9: set to [mem 0xf8400000-0xf86fffff=
 64bit] (PCI address [0xf8400000-0xf86fffff])
> [  188.221379] pci 0000:b3:00.0: reg 184: [mem 0x00000000-0x00003fff 64bi=
t]
> [  188.228089] pci 0000:b3:00.0: BAR 7: assigned [mem 0xf8304000-0xf830ff=
ff 64bit]
> [  188.235407] pci 0000:b3:00.0: BAR 7: set to [mem 0xf8304000-0xf830ffff=
 64bit] (PCI address [0xf8304000-0xf830ffff])
> [  188.245843] pci 0000:b1:03.0: PCI bridge to [bus b3-b3]
> [  188.251107] pci 0000:b1:03.0:   bridge window [mem 0xf8200000-0xf86fff=
ff]
> [  188.257922] pci 0000:b1:03.0:   bridge window [mem 0xf5100000-0xf51fff=
ff pref]
> [  188.265180] pci 0000:b0:00.0: PCI bridge to [bus b1-b3]
> [  188.270443] pci 0000:b0:00.0:   bridge window [mem 0xf8000000-0xf89fff=
ff]
> [  188.277250] pci 0000:b0:00.0:   bridge window [mem 0xf5000000-0xf51fff=
ff pref]
> [  188.284512] pcieport 0000:80:02.2: PCI bridge to [bus b0-bf]
> [  188.290184] pcieport 0000:80:02.2:   bridge window [io  0xa000-0xbfff]
> [  188.296735] pcieport 0000:80:02.2:   bridge window [mem 0xf8000000-0xf=
8ffffff]
> [  188.303963] pcieport 0000:80:02.2:   bridge window [mem 0xf5000000-0xf=
5ffffff 64bit pref]
>=20
> b2:00.0 BAR 9 has not get assigned...
>=20
> root cause:
> b1:02.0 can not be added more range, because b1:03.0 is just after it.
> not space between required ranges.
>=20
> Solution:
> Try to assign required + optional all together at first, and if it fails,=
 go with required then reassign path.
>=20
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>=20
> ---
>  drivers/pci/setup-bus.c |  113 +++++++++++++++++++++++++++++++++++++++++=
-------
>  1 file changed, 97 insertions(+), 16 deletions(-)
>=20
> Index: linux-2.6/drivers/pci/setup-bus.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -64,7 +64,7 @@ void pci_realloc(void)
>   * @add_size:	additional size to be optionally added
>   *              to the resource
>   */
> -static void add_to_list(struct resource_list_x *head,
> +static int add_to_list(struct resource_list_x *head,
>  		 struct pci_dev *dev, struct resource *res,
>  		 resource_size_t add_size, resource_size_t min_align)
>  {
> @@ -75,7 +75,7 @@ static void add_to_list(struct resource_
>  	tmp =3D kmalloc(sizeof(*tmp), GFP_KERNEL);
>  	if (!tmp) {
>  		pr_warning("add_to_list: kmalloc() failed!\n");
> -		return;
> +		return -ENOMEM;
>  	}
> =20
>  	tmp->next =3D ln;
> @@ -87,6 +87,8 @@ static void add_to_list(struct resource_
>  	tmp->add_size =3D add_size;
>  	tmp->min_align =3D min_align;
>  	list->next =3D tmp;
> +
> +	return 0;
>  }

This looks like a separate bug fix; can you separate it out?  I assume
you ran into it at least once as you were adding more recursion and
occasionally not exiting it quickly. :)

At least a couple of the callers could use the return value...

> @@ -221,6 +259,63 @@ static void __assign_resources_sorted(st
>  				 struct resource_list_x *realloc_head,
>  				 struct resource_list_x *fail_head)
>  {
> +	/*
> +	 * Should not assign requested resources at first.
> +	 *   they could be adjacent, so later reassign can not reallocate
> +	 *   them one by one in parent resource window.
> +	 * Try to assign requested + add_size at begining
> +	 *  if could do that, could get out early.
> +	 *  if could not do that, we still try to assign requested at first,
> +	 *    then try to reassign add_size for some resources.
> +	 */
> +	struct resource_list_x save_head, local_fail_head, *list;
> +	struct resource_list *l;
> +
> +	if (!realloc_head)
> +		goto requested_and_reassign;

Should this also check for realloc_head existing but being empty?  Or
do we never get that case by the time we get here?

> +	/* Save original start, end, flags etc */
> +	save_head.next =3D NULL;
> +	for (l =3D head->next; l; l =3D l->next)
> +		if (add_to_list(&save_head, l->dev, l->res, 0, 0)) {
> +			free_list(resource_list_x, &save_head);
> +			goto requested_and_reassign;
> +		}

Maybe a small helper: copy_resource_list_x(struct resource_list_x *to,
struct resource_list *from)?  (Yay more helpful 'x' usage.)  Generally
a few small helpers would make this function a lot easier to follow...

> +
> +	/* Update res in head list with add_size in realloc_head list */
> +	for (l =3D head->next; l; l =3D l->next)
> +		l->res->end +=3D get_res_add_size(realloc_head, l->res);

These loops might benefit from a for_each_resource_list macro (we have
lots of similar onese elsewhere in the kernel).

I also like the new get_res_add_size function better, but you moved it
and changed it at the same time and lumped it into this patch, so it
should be broken out.

> +
> +	/* Try updated head list with add_size added */
> +	local_fail_head.next =3D NULL;
> +	assign_requested_resources_sorted(head, &local_fail_head);
> +
> +	/* all assigned with add_size ? */
> +	if (!local_fail_head.next) {

list_empty would be slightly more readable.

> +		/* Remove head list from realloc_head list */
> +		for (l =3D head->next; l; l =3D l->next)
> +			remove_from_list(realloc_head, l->res);
> +		free_list(resource_list_x, &save_head);
> +		free_list(resource_list, head);
> +		return;
> +	}
> +
> +	free_list(resource_list_x, &local_fail_head);
> +	/* Release assigned resource */
> +	for (l =3D head->next; l; l =3D l->next)
> +		if (l->res->parent)
> +			release_resource(l->res);
> +	/* Restore start/end/flags from save list */
> +	for (list =3D save_head.next; list; list =3D list->next) {
> +		struct resource *res =3D list->res;
> +
> +		res->start =3D list->start;
> +		res->end =3D list->end;
> +		res->flags =3D list->flags;
> +	}
> +	free_list(resource_list_x, &save_head);
> +
> +requested_and_reassign:
>  	/* Satisfy the must-have resource requests */
>  	assign_requested_resources_sorted(head, fail_head);
> =20
> @@ -548,20 +643,6 @@ static resource_size_t calculate_memsize
>  	return size;
>  }

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/KRvlTNmBgtSZXSGVbEOQS3m
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPB2xbAAoJEIEoDkX4Qk9hmacP/2vtjAjrNcPjhCLwc1LY9o8F
ibThF7q5GihHv0h9cUGsZSf4NRJcxdB39BgGOcdct8M+ASmim2pJhhzWRKVSRu+V
3KiXjkvc3AMHa0csUFgqMbCnEknMfRktpPr9nfPriEOn+aeHVpKypU3+M4TFHb4Y
ZSdUM08CmfH3sX3W2isgt/lD7CApAa8oEHFJjy06a2Q3B17YRizgkjvVstlcD5yb
trRwq8A9rLQW479ZuQTM9Q/ddwKsTrBkmEQFvQWqIt9jl4N/v4jzcJMpJnX7M7Qf
qXWwwBevCKtkeJOwpZ9NSEOzQDjiT4UqaYNrlCw3xU18Lp37zbYfGNBu6mpGEykV
UanlilvSIgBKZxSrlS1XF28kcbxUqCMIju0J8vQNzoOylYDFb5OPJlrLIZBgKZ0o
6ROa9JHu+4wZ4NOxfWTZNv7Vkot3v0Fxa4dzloFO1wPCVP281SMcFKzcPBZtsUR2
h6xL9kjrV/oUN800jvGW4qHDlDNSUoADMcSn5vqXxRXXgTaZE5mb/W/JLanU3bRE
MAgHNXIRob+i24cFYsMnCOHTJORg2tpLPBUmubpEceNAiX1cCfBL1Sx8J79z/InQ
RFJN+e9wnPJ/PVLfzEcpBxaBD2pDdvMACMurTSebhry9QvVjpR4IOjUF72WNCEQG
ZcGJdMqurEGLURbFMorq
=6NgK
-----END PGP SIGNATURE-----

--Sig_/KRvlTNmBgtSZXSGVbEOQS3m--
