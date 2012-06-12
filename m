Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50714 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab2FLRXM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 13:23:12 -0400
Date: Tue, 12 Jun 2012 19:23:01 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 06/10] ARM: tegra: pcie: Add MSI support
Message-ID: <20120612172301.GB28010@avionic-0098.adnet.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
 <4FD660F9.7030807@wwwdotorg.org>
 <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
 <20120612061003.GC4040@avionic-0098.adnet.avionic-design.de>
 <4FD762E6.2080906@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
In-Reply-To: <4FD762E6.2080906@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 06/12/2012 12:10 AM, Thierry Reding wrote:
> > * Thierry Reding wrote:
> >> * Stephen Warren wrote:
> >>> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > [...]
> >>>> +static int tegra_pcie_disable_msi(struct platform_device
> >>>> *pdev)
> >>>=20
> >>> Should this free pcie->msi->pages?
> >>=20
> >> Yes it should. I actually mention making that change in the
> >> changelog but in fact didn't.
> >=20
> > This is really moot because the driver cannot be built as a module
> > currently because arch_setup_msi_irq() and arch_teardown_msi_irq()
> > need to be built-in so tegra_pcie_disable_msi() will be called only
> > just before the machine is shut down.
> >=20
> > Perhaps this is something that should be addressed? Or is it just
> > not worth the effort?
>=20
> Well, if the driver provides a shutdown/removal path at all, it seems
> like it should be complete. I assume it's trivial to free those pages?

Yes, it's trivial and I'll definitely add it. What I was saying is that
it doesn't matter really, unless something is done to allow the driver
to be built as a module. It is also tedious to test the shutdown/removal
for built-in drivers.

Thierry

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/XevUACgkQZ+BJyKLjJp/CuQCfYKsY1J1PQg6CsSzfUslv6raG
IngAnjZ1sLDH0vNAQcy9uCStqQZKRzOF
=sHu1
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
