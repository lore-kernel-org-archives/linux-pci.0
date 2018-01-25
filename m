Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42331 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeAYO2D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jan 2018 09:28:03 -0500
Date: Thu, 25 Jan 2018 15:27:59 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, robh+dt@kernel.org, frowand.list@gmail.com,
        rjw@rjwysocki.net, tglx@linutronix.de, vidyas@nvidia.com,
        kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V6 5/7] PCI: tegra: Add loadable kernel module support
Message-ID: <20180125142759.GG27888@ulmo>
References: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
 <1515650888-9459-6-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
In-Reply-To: <1515650888-9459-6-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2018 at 11:38:06AM +0530, Manikanta Maddireddy wrote:
> Implement remove callback function for Tegra PCIe driver to add
> loadable kernel module support. Change PCI_TEGRA config to tristate to
> allow pci-tegra driver to be build as a module.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
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
>=20
>  drivers/pci/host/Kconfig     |  2 +-
>  drivers/pci/host/pci-tegra.c | 34 +++++++++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlpp6W8ACgkQ3SOs138+
s6Fc7w/3dNRRNw4XT4DU/vHGkt3/ajK4yWAXdyX8aI/+cJcNXQVwRQGBDI2ukbO1
IMTW1FwNwnzq3vSgl6Hk6OCz8lQaV6ohlq81++k4Ruw99JUJjTl8uQytXO8GOyDE
OFzMSSQS+Mdod3oiKH7IMlZ/y5uB8m4IIzkPXghMDw0GzWtT5q3ss+iywYzEu4jU
KtkTXeIC+ju/xVuNLVV2v/u1K5aPei2PLOReteDc5qd5FWl2UBibbUzWHSZoMDwK
Eqdp5/2s0NlOA+WyZN2qjUVENXJLqZkl/07G0o6LqTjT1VM2N5fbQ2472WCku2WO
qHGtqN5IqAg2CHBbmaYjCBF52ymiHOax2X2x1jpZFlHR9MxQq8MC6HSlBFR+KxaM
G9wKwqudVZP7K3TGwEyrH38JX5CP+DdwQOFjjGmJgWMv0VYkCIG39fp9rax9SRcC
/VRQC9NkpjkBTtVSIygT1PWGrLGn8emsvbM4ghLpm5XbSIs/wsLKS/yglQLbxsG+
iNxMsBE8VNQfbiY8Rrm7jUfVl8pO8/7/1t5d3ihmR9UsGTGK4rZMcvePsxWVYTe8
OxmEVEMAoq7CXmP2bFgOK8u8DdwCaLB2G1rFtYMlwCf05pdJyIFEZuv6FCN3KxSZ
jYrzDB/YYg+LZQua3f4dyEdYKYW5b/fohNY54DGfavKk/NUQQw==
=u2+G
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
