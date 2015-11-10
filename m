Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18295 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbbKJPwn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2015 10:52:43 -0500
Date: Tue, 10 Nov 2015 16:52:33 +0100
From: Thierry Reding <treding@nvidia.com>
To: Phil Edworthy <phil.edworthy@renesas.com>,
	Marc Zyngier <marc.zyngier@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>,
	Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] PCI: pcie-rcar: Fix OF node passed to MSI irq domain
Message-ID: <20151110155232.GA25368@ulmo.nvidia.com>
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
 <PS1PR06MB11804ED428472FC1FD776F6EF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151109161115.GA13870@ulmo.nvidia.com>
 <PS1PR06MB1180111D6423287273B64B0FF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PS1PR06MB1180111D6423287273B64B0FF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2015 at 06:01:49PM +0000, Phil Edworthy wrote:
> Hi Thierry,
>=20
> On 09 November 2015 17:24, Phil wrote:
> > On 09 November 2015 16:11, Thierry wrote:
> > > On Mon, Nov 09, 2015 at 03:20:24PM +0000, Phil Edworthy wrote:
> > > > cc'ing others (Tegra, Altera, Designware) who may have the same bug
> > > >
> > > > On 03 November 2015 09:28, Phil Edworthy wrote:
> > > > > The OF node passed to irq_domain_add_linear() should be a
> > > > > pointer to interrupt controller's device tree node, or NULL,
> > > > > but not the PCI controller's node.
> > > > >
> > > > > This fixes an oops in msi_domain_alloc_irqs() when it tries
> > > > > to call msi_check().
> > > > >
> > > > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > > > ---
> > > > >  drivers/pci/host/pcie-rcar.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie=
-rcar.c
> > > > > index 2377bf0..c6fa562 100644
> > > > > --- a/drivers/pci/host/pcie-rcar.c
> > > > > +++ b/drivers/pci/host/pcie-rcar.c
> > > > > @@ -709,7 +709,7 @@ static int rcar_pcie_enable_msi(struct rcar_p=
cie
> > *pcie)
> > > > >  	msi->chip.setup_irq =3D rcar_msi_setup_irq;
> > > > >  	msi->chip.teardown_irq =3D rcar_msi_teardown_irq;
> > > > >
> > > > > -	msi->domain =3D irq_domain_add_linear(pcie->dev->of_node,
> > > > > INT_PCI_MSI_NR,
> > > > > +	msi->domain =3D irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
> > > > >  					    &msi_domain_ops, &msi->chip);
> > > > >  	if (!msi->domain) {
> > > > >  		dev_err(&pdev->dev, "failed to create IRQ domain\n");
> > >
> > > On Tegra the PCI controller is in fact the interrupt controller for
> > > MSIs. And looking at the code here it seems like the same would apply=
 to
> > > RCAR.
> > Yes you are correct here.
> >=20
> > > I'm also slightly confused as to why this would cause ->msi_check() to
> > > fail. The default implementation (msi_domain_ops_check()) doesn't do
> > > anything.
> > >
> > > Also, how is passing in NULL instead of a valid struct device_node *
> > > going to prevent an oops? Perhaps this is one of those reference count
> > > imbalance bugs that have recently been showing up?
> > On arm64 (previously I didn't realise this just affects arm64, not arm),
> > the changes in commit f075915ac0b11 ("PCI/MSI: Drop domain field from
> > msi_controller") and d8a1cb757550 ("PCI/MSI: Let pci_msi_get_domain use
> > struct device::msi_domain") return an uninitialized msi domain that lea=
ds
> > to the oops. It appears that these changes assume that msi interrupt
> > controller is separate from the PCI controller.
> More accurately, when CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled,
> pci_msi_get_domain() calls dev_get_msi_domain() and at this point
> dev->msi_domain is uninitialized.

Marc, any idea what's going on here?

Thierry

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWQhK9AAoJEN0jrNd/PrOhsn0P/Ao6ATgKz8HwakJZIF9fNTo3
yc+zFz8D6aIxc0IpnWpfe6072KNrKxBBW4filUUqYj50vPIS4KJlXfxOUtRLAuN5
JbMaIeLdxhas8BApZvmFjKhu/FoOxunr/4v8q5o7bZgE1ctGX0i1uumc3Db8MHVk
Go9vJLO+4h047BhfapxzwmhfD/GM2NdcB8WCGxPvIFAVbxBmSZNDblXx4P/osonA
u3AAf+BZntKIoKOwqVjyK2yfob+b491rNnJ2oSNQf1GPqEAD2kJeDz+NbcZimF/a
vwJjDGJekxDmBRgh4XI0x1skgx5NALXPmZ7S2tcBUg+ffLbDex5Yy5aFpvB4un5G
HxFLa/DksUcXwDL5IyVHezuLJ9xGTpwlvKHLOrfcMaGHrlko6358vjl08kI1J6EC
8Hn8vgYU+HWlAkyPKAn0uo8My9veVK5TUhEBBqQOcD/+HWbyOH6kFyAzgPW4pLUs
CfatDQdx7ubJuN7Qvk2xVqcLVMgwY05zoWbvccaVQCFXxha9Mtcl8fxae/2OlTNq
tKvTh0VnWtSFGeV40R/PuZ0sHa+oqyR/+f0ZHoRJFRHXYSgCS+uQX8qNq+mUpBuA
+o93g5dVu4CbRcx66aC+OsbPbPmc3G7YNgSU/LOl1XcOyftXNWdu9RioQAbFnvyo
7RIvi7qmEk5yqx+HvoQf
=u1ij
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
