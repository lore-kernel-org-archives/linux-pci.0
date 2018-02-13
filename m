Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32833 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964797AbeBMNHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Feb 2018 08:07:24 -0500
Date: Tue, 13 Feb 2018 14:07:18 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com, kthota@nvidia.com
Subject: Re: [PATCH V7  2/4] PCI: tegra: Add loadable kernel module support
Message-ID: <20180213130718.GE6764@ulmo>
References: <1517289851-14111-1-git-send-email-mmaddireddy@nvidia.com>
 <1517289851-14111-3-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
In-Reply-To: <1517289851-14111-3-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 10:54:09AM +0530, Manikanta Maddireddy wrote:
> Implement remove callback function for Tegra PCIe driver to add
> loadable kernel module support. Change PCI_TEGRA config to tristate to
> allow pci-tegra driver to be build as a module.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V2:
> * no change in this patch
> V3:
> * use tegra_pcie_debugfs_exit() helper function in tegra_pcie_debugfs_ini=
t()
> V4:
> * no change in this patch
> V5:
> * Decoupled from https://patchwork.ozlabs.org/patch/832053/ and
> rebased on linux-next
> V6:
> * no change in this patch
> V7:
> * no change in this patch
>=20
>  drivers/pci/host/Kconfig     |  2 +-
>  drivers/pci/host/pci-tegra.c | 34 +++++++++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 4 deletions(-)

Trying to build this as a module I get a link failure because
irq_set_msi_desc() is not exported. I thought a patch to do that had
been part of an earlier version of this series. Has that not been merged
yet?

Thierry

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqC4wIACgkQ3SOs138+
s6Gf4hAAtBX+NQlHdt9lxmUEPEgeSjWlkzAsZLyWKMLZYRq+hS9PrAbcHr4Cpu4T
GhSTM/KDerZyaQ/5sB1lJ5ScGeQTXM6ocSQ5Abue70Eb7qptrQtx9twpF2hFPzwT
ipyJb4lS6OyZibl0blxGYvXfpolXNvp9oz+QfsEnuxY/V0schB/EfcC5QrlXBN46
rI8kvcpHLfL6CYwlwpykMU9tEEcFoGq0EtAYxGREfHoPtrxj6SXbqtlGie5tdVVm
ONSlsuaguvR+WO/FPq03d0+ZhA6jVbO/lL2orpyckGrNw4dnheAYpDAuuBfq/BzT
ZdQ5T8UWWSNm+PsE+CyQRf0G7IAOwgeh9P2prhtwpHclT91lo5/zSIdD3N+uN586
p+MsxMfNFmKAtuO0mA+TW6EAHnoiJ54kA2jOyU+1RBcAs/G71Q/76NTA+s6h+/Wy
AE61QtsVeh56+TMEFMs6+ZcCInT+Yn7Ancd3zUHHKhUMCG3wzEl/LsPX1wsxxlnG
nw1Vg11Uvely3BSuqEP25DrQfXNdPwybC6JeK585tyHGvRlw6VXGl/zjm/6if6rM
w5RrqSLqDT3TXhn3nX/QpEo4Q9DBqtV68eXUXg6RGTn+dakwV4lWY8RpfsRvHJxY
/ggPaxVbYnwKQCld6jalUxF7YXkeCck0464Gcvq3KkzXJME1yC0=
=0Arp
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
