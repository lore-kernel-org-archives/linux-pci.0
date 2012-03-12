Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:65233 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab2CLIAa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2012 04:00:30 -0400
Date: Mon, 12 Mar 2012 09:00:23 +0100
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
	Olof Johansson <olof@lixom.net>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/11] ARM: tegra: pcie: Add MSI support
Message-ID: <20120312080023.GA13788@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-11-git-send-email-thierry.reding@avionic-design.de>
 <4F59213F.6070107@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
In-Reply-To: <4F59213F.6070107@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 03/08/2012 07:51 AM, Thierry Reding wrote:
> > diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
>=20
> > +static int tegra_pcie_enable_msi(struct platform_device *pdev)
> > +{
> > +	struct tegra_pcie_info *pcie =3D platform_get_drvdata(pdev);
> > +	volatile void *pages;
> > +	unsigned long base;
> > +	unsigned int msi;
> > +	int msi_base;
> > +	int err;
> > +	u32 reg;
> > +
> > +	mutex_init(&pcie->msi_lock);
> > +
> > +	msi_base =3D irq_alloc_descs(-1, 0, INT_PCI_MSI_NR, 0);
> > +	if (msi_base < 0) {
> > +		dev_err(&pdev->dev, "failed to allocate IRQs\n");
> > +		return msi_base;
> > +	}
> > +
> > +	pcie->msi_domain =3D irq_domain_add_legacy(pcie->dev->of_node,
> > +						 INT_PCI_MSI_NR, msi_base,
> > +						 0, &irq_domain_simple_ops,
> > +						 NULL);
> > +	if (!pcie->msi_domain) {
> > +		dev_err(&pdev->dev, "failed to create IRQ domain\n");
>=20
> Free the IRQ descriptors in the error paths?
>=20
> > +		return -ENOMEM;
> > +	}
> > +
> > +	pcie->msi_chip.name =3D "PCIe-MSI";
> > +	pcie->msi_chip.irq_enable =3D unmask_msi_irq;
> > +	pcie->msi_chip.irq_disable =3D mask_msi_irq;
> > +	pcie->msi_chip.irq_mask =3D mask_msi_irq;
> > +	pcie->msi_chip.irq_unmask =3D unmask_msi_irq;
> > +
> > +	for (msi =3D 0; msi < INT_PCI_MSI_NR; msi++) {
> > +		unsigned int irq =3D irq_find_mapping(pcie->msi_domain, msi);
> > +
> > +		irq_set_chip_data(irq, pcie);
> > +		irq_set_chip_and_handler(irq, &pcie->msi_chip,
> > +					 handle_simple_irq);
> > +		set_irq_flags(irq, IRQF_VALID);
> > +	}
> > +
> > +	err =3D platform_get_irq(pdev, 1);
> > +	if (err < 0) {
> > +		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
>=20
> Same here, and undo setting IRQF_VALID?

Does it make sense to explicitly unset the IRQF_VALID flag when the IRQ
descriptors are free'd afterwards anyway? I also think it would be necessary
to free the struct irq_domain, but I wasn't able to find any function that
does this other than just calling kfree(), which obviously wouldn't be
enough. Maybe Grant can shed some light onto this. I'm also Cc'ing Thomas
Gleixner as maintainer of the IRQ subsystem, he probably knows best how
dynamically allocated interrupts should be cleaned up.

Thierry

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9drRcACgkQZ+BJyKLjJp/AZgCeIDUD27UF8iH7y5YnSyzVP2yz
aF0AoKetLTaFLoBmwOsdBx+s8FE0yb6D
=IuDf
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
