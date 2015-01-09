Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:49206 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbbAILcS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jan 2015 06:32:18 -0500
Date: Fri, 9 Jan 2015 12:32:15 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: tegra: apply relaxed ordering fixup only on
 Tegra
Message-ID: <20150109113213.GE16465@ulmo>
References: <1418929903-8506-1-git-send-email-l.stach@pengutronix.de>
 <1418929903-8506-2-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
In-Reply-To: <1418929903-8506-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2014 at 08:11:43PM +0100, Lucas Stach wrote:
> The fixup to enable relaxed ordering on all PCI devices was
> executed unconditionally if the Tegra PCI host driver was
> built into the kernel. This doesn't play nice with a
> multiplatform kernel executed on other platforms which
> may not need this fixup.
>=20
> Make sure to only apply the fixup if the root port is
> a Tegra.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v2:
> - split out PCI hierarchy walk
> - separate code from data by moving PCI IDs into own structure
> ---
>  drivers/pci/host/pci-tegra.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 333a57afacc4..b77f417e1a3c 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -635,10 +635,42 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf=
1, tegra_pcie_fixup_class);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fixup_c=
lass);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fixup_c=
lass);
> =20
> +static const struct pci_device_id tegra_rootport_ids[] =3D {
> +	{
> +		/* Tegra20 4 lane root port */
> +		.vendor =3D PCI_VENDOR_ID_NVIDIA, .device =3D 0x0bf0,
> +		.subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID
> +	}, {
> +		/* Tegra20 2 lane root port */
> +		.vendor =3D PCI_VENDOR_ID_NVIDIA, .device =3D 0x0bf1,
> +		.subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID

The number of lanes is configurable, so I'm not sure exactly what this
comment is supposed to indicate. Are you saying that port 0 has 0x0bf0
and port 1 has 0x0bf1 as device IDs.

> +	}, {
> +		/* Tegra30 4 lane root port */
> +		.vendor =3D PCI_VENDOR_ID_NVIDIA, .device =3D 0x0e1c,
> +		.subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID
> +	}, {
> +		/* Tegra30 2 lane root port */
> +		.vendor =3D PCI_VENDOR_ID_NVIDIA, .device =3D 0x0e1d,
> +		.subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID

Tegra30 has three ports, so does this second entry (0x0e1d) apply to
ports 1 and 2, whereas the previous entry (0x0e1c) applies only to port
0?

> +	}, {
> +		/* Tegra124 4 lane root port */
> +		.vendor =3D PCI_VENDOR_ID_NVIDIA, .device =3D 0x0e12,
> +		.subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID
> +	}, {
> +		/* Tegra124 1 lane root port */
> +		.vendor =3D PCI_VENDOR_ID_NVIDIA, .device =3D 0x0e13,
> +		.subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID

Or perhaps what this signifies is that the first port is actually a
different device because it supports up to 4 lanes, whereas the others
support up to 2 lanes (or only 1 on Tegra124)? In that case:

Acked-by: Thierry Reding <treding@nvidia.com>

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUr7w9AAoJEN0jrNd/PrOhQWoQAJDufEC5lCKejxnYSufk6obS
MQETI63FibUAuB1GxhPhu1S9RT3w/26dQz3m084CWxnIQqIWS/Jwx3tCw586KRHF
J/NIbDU/xHkU/JuJ4/cxK7nZn3XshYl/g5O4/s7Kdxvf2wCtqBlA/a9Y1wKpHH1B
1svNAG4y3H6asJtmXccms+FNNP8yMKoCQMxY+VAguWGg+INGqNytgIvjDaRFQRd5
rirsoZ98XoEXEsA73D8ymdGYzsa+lYHnH7+iBZI1j5CvUAlPVCTjIKPTgUJPcMR8
OasxWwEcOVqZGmino5UJJKR0XnGo+aJSEJNzOKESBHOJwJWgIrutlsStBOmzL569
WmnbJSMU+L6tPtA9CPOIEk8u8ZmNqShIlB2STGqpT7qqJoraCPx+s/9YHXS1Tz15
03j8r/Y43A4qu2O3czUw97Ltau37coR1n73PZppxDQ0fq+0T3G7L9bvhnqJ09O2v
H2SSjSa3ZEvGsCmNidoscbKh9AUaZgX3+RBY7WSxfhfN5fdJPAcEdJh++jlO+MF2
YHbLoHGc9FBeFNziVervtcPgVBIH1eYGttiHiZVSYydOMqqXGMPLRlwY5XrhROCI
kqpUYI4QI5u/52Y5+xYys9ycHTJDtA4K+h4KCDGPbBUU5J18+pz73zBweJCqHTgq
6CMWACraWMjS923j3ph7
=qzu7
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--
