Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33501 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756304AbdLTTaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Dec 2017 14:30:15 -0500
Date: Wed, 20 Dec 2017 20:30:11 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>, cyndis@kapsi.fi,
        bhelgaas@google.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, rjw@rjwysocki.net, tglx@linutronix.de,
        vidyas@nvidia.com, kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 3/7] PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for
 Tegra PCIe
Message-ID: <20171220193011.GA31757@ulmo>
References: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
 <1512723493-865-4-git-send-email-mmaddireddy@nvidia.com>
 <20171215173643.GA1050@red-moon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
In-Reply-To: <20171215173643.GA1050@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 05:36:43PM +0000, Lorenzo Pieralisi wrote:
> On Fri, Dec 08, 2017 at 02:28:09PM +0530, Manikanta Maddireddy wrote:
> > Primary, secondary and subordinate default bus numbers are 0 in Tegra a=
nd
> > it is expecting SW to program these numbers in configration space.
> >=20
> > pci_scan_bridge_extend() function programs these numbers in configurati=
on
> > space if secondary & subordinate bus numbers are 0 or PCI_REASSIGN_ALL_=
BUS
> > flag is set. Since secondary & subordinate default bus numbers are 0,
> > PCI_REASSIGN_ALL_BUS flag can be removed for Tegra PCIe.
> >=20
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > ---
> > V3:
> > * new patch in V3
> > V4:
> > * no change in this patch
> >=20
> >  drivers/pci/host/pci-tegra.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> > index a549c5899e26..0d91f1a3a6b4 100644
> > --- a/drivers/pci/host/pci-tegra.c
> > +++ b/drivers/pci/host/pci-tegra.c
> > @@ -2604,7 +2604,6 @@ static int tegra_pcie_probe(struct platform_devic=
e *pdev)
> > =20
> >  	tegra_pcie_enable_ports(pcie);
> > =20
> > -	pci_add_flags(PCI_REASSIGN_ALL_BUS);
>=20
> This looks obviously OK to me but I need Thierry's ACK to queue it.

Just as an additional note: I think the real reason why this is okay to
do is because we reset the PCI host controller in the kernel driver, so
any bus assignments done by the firmware are reset as well.

Acked-by: Thierry Reding <treding@nvidia.com>

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlo6ukAACgkQ3SOs138+
s6Ew+g/+PHBkSe3TxzC9Pdrm/EKZiam0Z1GYXX4vjAymJ8BgLhwOl8EwsCsuuWRa
Xvj+SKHvuZcUcUmb7/laPNzKP9rQ2yRwBwTuojfgUVmA5+mMa/ymL/k+qnDfKcm8
vKRf5gg1ZGxBw71EbrqbOh0nsjRX7LkZ/IeN/wL3pXNPv4gmfEQLxh5TP6D0MyOi
jPD80JAxNsHmOVfVj6zLcQmSR3F7c3TGR59k0jMlIa94+nzcPw1cWV4f3dYd38C0
D/GC8HUxdEx2GTD/DSFLjoIy4b86VSTwJEBaMQfIzXPt9TVGKcEqJqvfTZr5qQKl
0byniN9Uyoz6JIO21YxWmV0S70c36vWImR2A0TwvmBnCjAAhDfJ0NnOE3HLWaw48
2h6CdYM8AXPKAd5vNmdX6fEodU7WIzKUPBPiTRqnqv/ZkHY8hchSYdV2QrCWtT2e
hX+o2K0bxpJWXkoS1ScPr7QKfesrG9CoVeZUj3sNPaF5sEdIAjb/7/xeGbf5gkJO
H49O/BeIdIGu1IBe6fLe9PzadUsVPvNMTE0jPIjLwDU1pOZTo7ED1vAJ4tAf+ajI
VRiTv/QhQgyJr1jp+s2FPRQWxhzu6vTHvoOh3/eo+XY58Fydb1RxxrM83mYRH5+7
3tZheKD6MYxVqNYs8PzyRICphlb3vqrToZiEo/+NKms/Q2lXjNM=
=f6iP
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
