Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy4-pub.bluehost.com ([69.89.21.11]:51055 "HELO
	oproxy4-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932435Ab2BJTma (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2012 14:42:30 -0500
Date: Fri, 10 Feb 2012 11:42:27 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-pci@vger.kernel.org, arjanvandeven@gmail.com
Subject: Re: pci: Annotate PCI quirks in initcall_debug style
Message-ID: <20120210114227.0b0679db@jbarnes-desktop>
In-Reply-To: <20120130205207.41636a23@infradead.org>
References: <20120130205207.41636a23@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/whBx5+E2RLSUpN2ormtUTjf"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/whBx5+E2RLSUpN2ormtUTjf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Jan 2012 20:52:07 -0800
Arjan van de Ven <arjan@infradead.org> wrote:

> From 77fcc610189853f9c8cf35f77bb8bcfc68833202 Mon Sep 17 00:00:00 2001
> From: Arjan van de Ven <arjan@linux.intel.com>
> Date: Mon, 30 Jan 2012 20:30:03 -0800
> Subject: [PATCH] pci: Annotate PCI quirks in initcall_debug style
>=20
> While diagnosing some boot time issues on a platform, all that I
> could see in the bootgraph/dmesg was that the system was spending
> a lot of time in applying one or more PCI quirks... which
> was virtually undebuggable.
>=20
> This patch adds printk's in "initcall_debug" style to the dmesg,
> which are added when the user asks for the initcall_debug
> (the nr one tool to use when debugging boot hangs or boot time issues)
> kernel command line option.
>=20
> CC: Jesse Barnes <jbarnes@virtuousgeek.org>
> CC: linux-pci@vger.kernel.org
>=20
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  drivers/pci/quirks.c |   21 ++++++++++++++++++++-
>  1 files changed, 20 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6476547..b3afa1c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2906,6 +2906,22 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65=
f8, quirk_intel_mc_errata);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f9, quirk_intel_mc_err=
ata);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65fa, quirk_intel_mc_err=
ata);
> =20
> +
> +static void do_one_fixup_debug(void (*fn)(struct pci_dev *dev), struct p=
ci_dev *dev)
> +{
> +	ktime_t calltime, delta, rettime;
> +	unsigned long long duration;
> +
> +	printk(KERN_DEBUG "calling  %pF @ %i\n", fn, task_pid_nr(current));
> +	calltime =3D ktime_get();
> +	fn(dev);
> +	rettime =3D ktime_get();
> +	delta =3D ktime_sub(rettime, calltime);
> +	duration =3D (unsigned long long) ktime_to_ns(delta) >> 10;
> +	printk(KERN_DEBUG "pci fixup %pF returned after %lld usecs\n", fn,
> +		duration);
> +}
> +
>  static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>  			  struct pci_fixup *end)
>  {
> @@ -2913,7 +2929,10 @@ static void pci_do_fixups(struct pci_dev *dev, str=
uct pci_fixup *f,
>  		if ((f->vendor =3D=3D dev->vendor || f->vendor =3D=3D (u16) PCI_ANY_ID=
) &&
>  		    (f->device =3D=3D dev->device || f->device =3D=3D (u16) PCI_ANY_ID=
)) {
>  			dev_dbg(&dev->dev, "calling %pF\n", f->hook);
> -			f->hook(dev);
> +			if (initcall_debug)
> +				do_one_fixup_debug(f->hook, dev);
> +			else
> +				f->hook(dev);
>  		}
>  		f++;
>  	}

Looks cool Arjan, thanks.  Applied to my -next branch.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/whBx5+E2RLSUpN2ormtUTjf
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPNXMjAAoJEIEoDkX4Qk9hIbsP/AsUA7OP15ypMDKc3SlvPXlA
Qr382nLydAhaO+xdRYsvPkycuz55M8KYZcYXmhFAMB2aabnMMqcmPcFgT4PZC8ku
+Xb4k8VYHXbJddLK2J6LNOu3zs6HQmKKHptT45ccejbjR/8nHvtiq7OxD66Isn4e
ZeQfwpiDRwrPU5mRNbJrEKtqPcuC6Mt8M2pVeL8MIMueoTjXkdhQVGaZFfoW/u76
3Xq6AfMxxVtbYEqi1riPxEItLPxLBqrU2EWHdMYsGs/1fhYX+6TQVuGMx1sYv/x8
1wrs43OSN7U3m8UXVKV4ggjRM/7NJrchkjQCdcBzj4ig86pxwpSZYaeLHDlUFKvu
QbRF+NB83Pock6Gd7HXXfzov2LF/9t4IfjSMw50VZFr+ynRBIn/YnBlIJOxtfU+s
LpGPIUReIX77BQdNkGZZbfT7zI+pxgx1Cg02Oq+W9QMjjxQlnL3sHBGHMyKvsPvH
HwKKI7Hw6ZeaEFD3/g9xWpKzAVP8GrrgRgOXgRXqVnShipFztHzn1OOLlzNgSNqM
8GI+e73JldVA9ltM1ib9Lc2nFR8kAQWuEPrv1b2hW3QnLMoQlKzIrQ5aKC/PamEd
qlmeElnKj4TBqftFCAryt/hRfph2f5zntJeC6UYYX6jTDWr225L/NjX4Apg7uaeG
0cWnGaZMnDNu66ctpTL5
=MFDq
-----END PGP SIGNATURE-----

--Sig_/whBx5+E2RLSUpN2ormtUTjf--
