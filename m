Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2458 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbbKIQLZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2015 11:11:25 -0500
Date: Mon, 9 Nov 2015 17:11:16 +0100
From: Thierry Reding <treding@nvidia.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
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
Message-ID: <20151109161115.GA13870@ulmo.nvidia.com>
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
 <PS1PR06MB11804ED428472FC1FD776F6EF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PS1PR06MB11804ED428472FC1FD776F6EF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2015 at 03:20:24PM +0000, Phil Edworthy wrote:
> cc'ing others (Tegra, Altera, Designware) who may have the same bug
>=20
> On 03 November 2015 09:28, Phil Edworthy wrote:
> > The OF node passed to irq_domain_add_linear() should be a
> > pointer to interrupt controller's device tree node, or NULL,
> > but not the PCI controller's node.
> >=20
> > This fixes an oops in msi_domain_alloc_irqs() when it tries
> > to call msi_check().
> >=20
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >  drivers/pci/host/pcie-rcar.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > index 2377bf0..c6fa562 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -709,7 +709,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *p=
cie)
> >  	msi->chip.setup_irq =3D rcar_msi_setup_irq;
> >  	msi->chip.teardown_irq =3D rcar_msi_teardown_irq;
> >=20
> > -	msi->domain =3D irq_domain_add_linear(pcie->dev->of_node,
> > INT_PCI_MSI_NR,
> > +	msi->domain =3D irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
> >  					    &msi_domain_ops, &msi->chip);
> >  	if (!msi->domain) {
> >  		dev_err(&pdev->dev, "failed to create IRQ domain\n");

On Tegra the PCI controller is in fact the interrupt controller for
MSIs. And looking at the code here it seems like the same would apply to
RCAR.

I'm also slightly confused as to why this would cause ->msi_check() to
fail. The default implementation (msi_domain_ops_check()) doesn't do
anything.

Also, how is passing in NULL instead of a valid struct device_node *
going to prevent an oops? Perhaps this is one of those reference count
imbalance bugs that have recently been showing up?

Thierry

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWQMWgAAoJEN0jrNd/PrOhdD8QAKFkmOues/SUKXpCDYW9EQAP
gtTaw7G9M6+DnT86teARhJsUyAbWqZhURu4D/UjVeuf8o1DjsPfwCTaFaj/8Y45X
D3GMBV93M8NT/huLRFy9ABgxgByXRXoBYlvZ99MmKmE6Tbjlv72F/L37WURmyRSU
WbTVVyI1Vx8ykLzaLRLboCETu0djC8hp4utubIWF5y/rK1FxqJdFqygTq0cvRXE8
ARZUKkq6dfxh/HpHq3Fd5mHE/b5xJ4CPxtd/RWR0+1S3xHwrWmhmdnJw4NHwD0vK
K9VE+6zJs+wOgDlULTZVloeZ8NZtyQkKoMXe57Az/WhmtV2zPP+NN8y9nXTiykDj
5eeWu3D6XlMfXMwKHTJgWFeyG9uReGgRNVg4b2L4KDHdkpuBtuxdn6hNeEEZBtdz
p30Gc3Tn0LlTaQrUOGR4P3D2c/4XWt6CitE/VZ5GaAnm+PkJqGwEyG3tvXd9ABIp
3MV4SCj8F1eyU/EIdByJ50Vipdmg4cbxpl5N6+xbBbYwAoTPcLAlrc2h5sMFQ62W
fhYN5OYG+3EnDwoHL4up2A/FaMNIFzDdp4zcT7Tm9YyBRvWKyOYIzVS1jk8x6oA4
cpdfbxVsghQDRx4ohXbEGPSDZ8x7fKUF4CCrs5xSOeIzMMpaj9F8xzWDZCsW+3sS
9z2h/YKt2jxDNK3v3jGa
=OPe1
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
