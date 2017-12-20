Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:41296 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754428AbdLTUjN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Dec 2017 15:39:13 -0500
Date: Wed, 20 Dec 2017 21:39:10 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Saga <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: tegra: Configuration space mapping cleanups and
 fixes
Message-ID: <20171220203910.GG31757@ulmo>
References: <20171214134545.11143-1-thierry.reding@gmail.com>
 <20171214173745.GA17018@red-moon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
In-Reply-To: <20171214173745.GA17018@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 05:37:45PM +0000, Lorenzo Pieralisi wrote:
> Hi Thierry,
>=20
> On Thu, Dec 14, 2017 at 02:45:41PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Hi Lorenzo,
> >=20
> > This cleans up a few oddities that I found while reviewing and testing
> > the patch
> >=20
> > 	[PATCH V3 1/2] PCI: tegra: refactor config space mapping code
> >=20
> > that Vidya Sagar sent out earlier. The first three patches are mostly
> > cleanup and admittedly somewhat bikeshedding in nature. They could've
> > been just review comments, but I thought I'd just submit them as a
> > series of patches since I had already typed them up anyway.
> >=20
> > The last patch gets rid of an artificial restriction regarding the
> > mapping address and does a bit of simplification.
> >=20
> > These are technically incremental on top of the original patch, but if
> > you prefer, feel free to squash them into that patch.
>=20
> I took some time to have a look at all of them and actually I am happy
> with the end result, except that I would prefer if you squash them all
> in and rewrite the logs since I can easily miss something (eg I have no
> insights into the Tegra config space FPCI windowing mechanism) - I will
> merge the resulting patch(es).
>=20
> I have a question: after merging both series, are
>=20
> tegra_pcie_{add/remove}_bus()
>=20
> (and struct tegra_pcie_bus)
>=20
> still needed ? I do not think so.

Yes, you're right, those were only to track the quilt mappings that we
used to do. I've removed them in the patch I just sent (v4).

> > I've tested these on all of Tegra20, Tegra30, Tegra124, Tegra210 and
> > Tegra186.
>=20
> If the testing goes OK please send me unified series and will merge
> that one.
>=20
> This brings me to a question for you and Bjorn: how do you usually
> handle DT updates ? I assume we send them via the PCI tree but I am
> asking to prevent any issue upfront.

DT updates usually go through the ARM SoC tree. It's usually okay to do
that because the DT stability requirement nicely decouples DT and driver
updates already.

In this particular case, the driver will be presented with a 256 MiB
window from existing DTs and simply use the first 4 KiB of that window
for the configuration space mapping. We can apply the DT patches at any
later time to reduce the region from 256 MiB to 4 KiB. I plan to do that
during for v4.17.

Thierry

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlo6ymsACgkQ3SOs138+
s6FrAw/+PkIsN+yoLQv/Loqi+1kJPDxmSH8dToI2mLD9GDH3It0h/WSXaroeHHan
s0rKU3jNjyZS6+S2yAGIke9eHgrsmDwJznHswcUr71wkqegHTnZYA4j2+3tT8kku
4LxgcLnmkRQ9CATDnhodsn2yVh61654/n4HY/dPKk+KYbfxq+eBbfCO0WwV/YH/O
ZJyK2h0YW8wm9F4HHYET06VucXfT+gdpf6xViOrlEcvjUIaMoJLC0kGf6ZAiDnNZ
DCf3U7zs6J/EkdeqvPZXT98/KV7SmQfvAQaypTFs92/mQ+fqoqEDX/4sS3WgmYJG
4HxGSXxtTszRJgEhxshJZ2kpV+tyZv52JjHtzxccTwN4SMZoCpz+hE5ua4vNgDTv
31Yz2UXcS00JgsGJNTk1839ujM/FGXPIvJLyluQ1Xg+BB5k2VDUnHULm3U6DDMdy
0We0zqJzu6CDOYDmUccQRXVg/GkDUcigF6JiMBTyo3aMiGom+ta6h8qIN1Nxe9C+
2nM6RZdFWf2POJHoDj6JM8Bn5q10XO3JufmMKUt18NfzBh0c89fTLL7eYZal+eWj
1zL1GQ835PTUHdWYAniuiIFZq91QfL2uhHTvBp25ykou8UJGW5ULm4skJPJPBnPK
AXaKlmyNYiEbsXoynNJfUWznYFy/YtwicXdniMcZB1zL7gvp9qY=
=Auey
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
