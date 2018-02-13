Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44072 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934086AbeBMLkI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Feb 2018 06:40:08 -0500
Date: Tue, 13 Feb 2018 12:39:53 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com, kthota@nvidia.com
Subject: Re: [PATCH V7  2/4] PCI: tegra: Add loadable kernel module support
Message-ID: <20180213113953.GD6764@ulmo>
References: <1517289851-14111-1-git-send-email-mmaddireddy@nvidia.com>
 <1517289851-14111-3-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
In-Reply-To: <1517289851-14111-3-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--3Pql8miugIZX0722
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
>=20
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 38d12980db0f..6fd2a5937804 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -34,7 +34,7 @@ config PCI_FTPCI100
>  	default ARCH_GEMINI
> =20
>  config PCI_TEGRA
> -	bool "NVIDIA Tegra PCIe controller"
> +	tristate "NVIDIA Tegra PCIe controller"
>  	depends on ARCH_TEGRA
>  	help
>  	  Say Y here if you want support for the PCIe host controller found
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index e68507f658d8..981f126b14d6 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -35,6 +35,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> @@ -2276,6 +2277,12 @@ static const struct file_operations tegra_pcie_por=
ts_ops =3D {
>  	.release =3D seq_release,
>  };
> =20
> +static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
> +{
> +	debugfs_remove_recursive(pcie->debugfs);
> +	pcie->debugfs =3D NULL;
> +}
> +
>  static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
>  {
>  	struct dentry *file;
> @@ -2292,8 +2299,7 @@ static int tegra_pcie_debugfs_init(struct tegra_pci=
e *pcie)
>  	return 0;
> =20
>  remove:
> -	debugfs_remove_recursive(pcie->debugfs);
> -	pcie->debugfs =3D NULL;
> +	tegra_pcie_debugfs_exit(pcie);
>  	return -ENOMEM;
>  }
> =20
> @@ -2311,6 +2317,7 @@ static int tegra_pcie_probe(struct platform_device =
*pdev)
> =20
>  	pcie =3D pci_host_bridge_priv(host);
>  	host->sysdata =3D pcie;
> +	platform_set_drvdata(pdev, pcie);
> =20
>  	pcie->soc =3D of_device_get_match_data(dev);
>  	INIT_LIST_HEAD(&pcie->ports);
> @@ -2388,6 +2395,25 @@ static int tegra_pcie_probe(struct platform_device=
 *pdev)
>  	return err;
>  }
> =20
> +static int tegra_pcie_remove(struct platform_device *pdev)
> +{
> +	struct tegra_pcie *pcie =3D platform_get_drvdata(pdev);
> +	struct pci_host_bridge *host =3D pci_host_bridge_from_priv(pcie);
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_FS))
> +		tegra_pcie_debugfs_exit(pcie);
> +	pci_stop_root_bus(host->bus);
> +	pci_remove_root_bus(host->bus);
> +	tegra_pcie_disable_ports(pcie);
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		tegra_pcie_disable_msi(pcie);
> +	tegra_pcie_free_resources(pcie);
> +	tegra_pcie_disable_controller(pcie);
> +	tegra_pcie_put_resources(pcie);

I prefer blank lines around conditional blocks for readability, so the
above would be:

	if (IS_ENABLED(CONFIG_DEBUG_FS))
		tegra_pcie_debugfs_exit(pcie);

	pci_stop_root_bus(host->bus);
	pci_remove_root_bus(host->bus);
	tegra_pcie_disable_ports(pcie);

	if (IS_ENABLED(CONFIG_PCI_MSI))
		tegra_pcie_disable_msi(pcie);

	tegra_pcie_free_resources(pcie);
	tegra_pcie_disable_controller(pcie);
	tegra_pcie_put_resources(pcie);

Not sure if Lorenzo or Bjorn have any specific preferences, though. My
Acked-by remains valid, though, since this is nitpicky.

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqCzokACgkQ3SOs138+
s6HPAxAAv8oFy2b4PF04DBqejoalfEuC/Pi63s/wBqqb1duYkPLuCfGIN9kSHw7v
/11xx4qsPUiW9MzxJ05ADn7kdhxmK1aLRJPG5c0F5q4QQqTS3WCmpx+vlrYo/wDU
pAYvf3atRm8ZWwLAU5AMirn0sdn3uu5bb+rYWTTmJTga7Yr1hAr3hKeTNPrDB0wm
gL7BpuTMGocwN9CbrVEAAH4RXjGwtnTij0t5nveKmjN59vm5EvZ9HkhArZPfCkrL
L5/IG/GTDazigteok632p01GyRU/TVLQDU1s6tptaZstfA+j+8Aslu87OukoOG4m
kF//g9yTMW1s97Tb1y6yzWBUoVJHaXb45HUAHK2/Fdy4/pLb01QxSpy+AMpbncOk
Ggcz5kqG94XJKOG8mI2xGn/eSDuKRyERaS88OcyDhF3P+toj+LGYO9OlRmQc3+w8
/wlJWmHauZm1tU0vpYobBafTdEyLRcnoKlh1Nb2ypFeIAaA5Eg3Y6DkglzvyggSw
ohvxJnuFhET/HMcUL+NkI95SQ4Qb1ExFMDUdWfrso3t+kaVkzFcdBap+rlI1n++2
DmRHXhQbDvTFXdCv7qV+6KyQ100y5B1Cojn/fIL/BrSTOfC2xPCTSGEEemHoxPz8
omjBgE6CkIaJ+biYUM+IlSjEn2hu2tCgor7ITtPtrmVipIyy31M=
=xAsq
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
