Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49222 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab2FLFHh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 01:07:37 -0400
Date: Tue, 12 Jun 2012 07:07:13 +0200
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
Message-ID: <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
 <4FD660F9.7030807@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
In-Reply-To: <4FD660F9.7030807@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > This commit adds support for message signaled interrupts to the Tegra
> > PCIe controller. Based on code by Krishna Kishore <kthota@nvidia.com>.
>=20
> > diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
>=20
> > +static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
> ...
> > +			irq =3D irq_find_mapping(pcie->msi->domain, index);
> > +			if (irq) {
> > +				if (test_bit(index, pcie->msi->used))
> > +					generic_handle_irq(irq);
>=20
> This invokes the handler first ...
>=20
> ...
> > +			/* clear the interrupt */
> > +			afi_writel(pcie, 1 << offset, AFI_MSI_VEC0 + i * 4);
> > +			/* see if there's any more pending in this vector */
> > +			reg =3D afi_readl(pcie, AFI_MSI_VEC0 + i * 4);
>=20
> ... then clears the interrupt status in the PCIe controller. Won't that
> lose interrupts if one is raised between when the handler clears the
> root-cause, and when this code clears the received interrupt status?

It certainly doesn't follow the conventional way of clearing the interrupt
first. I carried this from the original MSI patch, but I'll move the
interrupt clearing up and retest.

> > +static int tegra_pcie_disable_msi(struct platform_device *pdev)
>=20
> Should this free pcie->msi->pages?

Yes it should. I actually mention making that change in the changelog but
in fact didn't.

> Why allocate pcie->msi separately; why not include the fields directly
> into struct tegra_pcie_info *pcie?

For one I find this easier to read. If this wasn't a separate structure, ea=
ch
of the individual fields would get an msi_ prefix anyway so there isn't much
to be gained from keeping them directly in tegra_pcie_info.

Second, and more importantly, this will keep the size of struct
tegra_pcie_info smaller if PCI_MSI is not selected because there is just one
unused pointer instead of five unused fields.

Thierry

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/WzoEACgkQZ+BJyKLjJp+OqQCfVInBPASxy3NpkrYYAN3uL4tW
BFsAoILbZcwvoU2Rw+WEEzu7jYkguONm
=MH6Q
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
