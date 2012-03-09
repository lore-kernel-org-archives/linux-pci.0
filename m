Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55703 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab2CIGh5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Mar 2012 01:37:57 -0500
Date: Fri, 9 Mar 2012 07:37:40 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 09/11] ARM: tegra: Rewrite PCIe support as a driver
Message-ID: <20120309063739.GC25208@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-10-git-send-email-thierry.reding@avionic-design.de>
 <4F5911E0.6060802@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
In-Reply-To: <4F5911E0.6060802@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 03/08/2012 07:51 AM, Thierry Reding wrote:
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> Patch description?

I actually sat in front of the editor for a couple of minutes and I just
couldn't think of anything. I'll try harder for the next version.

> > diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-t=
egra/board-harmony-pcie.c
> ...
> > -static int __init harmony_pcie_init(void)
> > +static int tegra_pcie_init(struct platform_device *pdev)
>=20
> That name should probably still be called harmony_something() since it's
> still board-specific.

Okay, I'll rename it to harmony_pcie_init().

> I wonder how having a per-board callback will integrate with device
> tree. I guess I'll find out when I review patch 11:-)
>=20
> > diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegr=
a/board-trimslice.c
>=20
> > +static int __init trimslice_pci_init(void)
> >  {
> >  	if (!machine_is_trimslice())
> >  		return 0;
>=20
> You can remove that test now.

Okay.

> > diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
>=20
> > +#define TEGRA_PCIE_MAX_PORTS 2
> > +
> > +struct tegra_pcie_pdata {
> > +	int (*init)(struct platform_device *pdev);
> > +	int (*exit)(struct platform_device *pdev);
> > +	bool enable_ports[TEGRA_PCIE_MAX_PORTS];
> > +};
>=20
> That's a somewhat odd place to put the header; a dedicated
> mach-tegra/include/mach/tegra_pcie_pdata.h or
> include/linux/platform_data/tegra_pcie.h might make more sense.

mach-tegra/include/mach/pcie.h perhaps? That would be less redundant.

Thierry

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9ZpTMACgkQZ+BJyKLjJp/pSwCfdVVc3xBYZSgaFzcanO8KldvB
K1oAoI0BXl/hmtAwRf8YgxPKSxKK+Gf9
=F9LR
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
