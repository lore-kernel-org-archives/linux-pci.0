Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54922 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab2FLGKP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 02:10:15 -0400
Date: Tue, 12 Jun 2012 08:10:03 +0200
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
Message-ID: <20120612061003.GC4040@avionic-0098.adnet.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
 <4FD660F9.7030807@wwwdotorg.org>
 <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
In-Reply-To: <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thierry Reding wrote:
> * Stephen Warren wrote:
> > On 06/11/2012 09:05 AM, Thierry Reding wrote:
[...]
> > > +static int tegra_pcie_disable_msi(struct platform_device *pdev)
> >=20
> > Should this free pcie->msi->pages?
>=20
> Yes it should. I actually mention making that change in the changelog but
> in fact didn't.

This is really moot because the driver cannot be built as a module currently
because arch_setup_msi_irq() and arch_teardown_msi_irq() need to be built-in
so tegra_pcie_disable_msi() will be called only just before the machine is
shut down.

Perhaps this is something that should be addressed? Or is it just not worth
the effort?

Thierry

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/W3TsACgkQZ+BJyKLjJp9/VgCfZm9qMDCV84zV85C/EAYGH8zu
M7EAnifJC7pp+0zesScrgYsH5wz+aVX9
=8cnZ
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
