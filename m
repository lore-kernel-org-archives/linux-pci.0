Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:49501 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab3K2PBf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2013 10:01:35 -0500
Date: Fri, 29 Nov 2013 16:00:47 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Eric Brower <ebrower@nvidia.com>, linux-pci@vger.kernel.org,
	swarren@wwwdotorg.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: Disable Gen2 for Tegra20 and Tegra30
Message-ID: <20131129150046.GL9712@ulmo.nvidia.com>
References: <1384815306-3149-1-git-send-email-ebrower@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
In-Reply-To: <1384815306-3149-1-git-send-email-ebrower@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2013 at 02:55:06PM -0800, Eric Brower wrote:
> Tegra20 and Tegra30 do not support gen2 PCIe, so correct the
> register setting to disable it.
>=20
> Signed-off-by: Eric Brower <ebrower@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 0afbbbc..b8ba2f7 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -805,7 +805,7 @@ static int tegra_pcie_enable_controller(struct tegra_=
pcie *pcie)
>  	afi_writel(pcie, value, AFI_PCIE_CONFIG);
> =20
>  	value =3D afi_readl(pcie, AFI_FUSE);
> -	value &=3D ~AFI_FUSE_PCIE_T0_GEN2_DIS;
> +	value |=3D AFI_FUSE_PCIE_T0_GEN2_DIS;
>  	afi_writel(pcie, value, AFI_FUSE);
> =20
>  	/* initialize internal PHY, enable up to 16 PCIE lanes */

Bjorn: can you pick this up directly or would you rather have me prepare
a branch? It's the only one for Tegra so far, so a branch wouldn't be
all that useful. In case you want to pick it up directly:

Acked-by: Thierry Reding <treding@nvidia.com>

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmKweAAoJEN0jrNd/PrOhEsEQAJXHHFNKNHmUfx7ptV8ZWxjV
UUgsge38AIpPJw61EPcNSlRiCEW2g7UbnEZLGfIoKO4iRMZln7NyZMTpP2KmAXDa
/FIMcSr3J2L5Iml4gCMNqbdCPsfpEcGB+U5wcP2MlADFYhx8X2kn5tAveHzY0ztX
4kIynzCEJ0knfruMu4SBZeWBYdh7IjlMGeRw6nZXxzTZBDw6Y77mj4WHIDtcoOOr
MG0Dlnp2dDgNRGviRbCM/vsQPSEThXoNbAeLXJtlGYJnc9R6aY4u6BnveMM5dOYF
eGcT4WFuV7via/bBX/iNLN4MBQHQi0+gspt5MzHzap9vpg8bK1ZrL987ljJP/jVp
5MnkRZ1wpf1L66fHeR7+ax3bbPJ43KsLynQmECNLlEzabzf8YaUQ1qm/vS++3bdZ
uXP16ctkPzTLvtk06PNkAcJ/BxtQR11CQ48hjnMR78caMzUGBRKO+sSHQ3WH3GRq
z5KUpJbhno7W08mySwryOv8M0Pvi9OWJ4wCEeH73j04KeByQehApclrJfh7g5HXZ
Th+kH3GZz4l7Yv34GAHcGyb5rqH+P7BPthY2tKv0HS8XCXWrOLEJMMNjmvS54Aq/
iSHs71JbMJ7xoRSzFryIDSHtRVT6lsuGbapdtnt3NkJhow+dxeR0Q1j+4wsUr4y4
g3qXC8lgbSZe593fZI7D
=Aqts
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--
