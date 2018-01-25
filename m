Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44703 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeAYOsS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jan 2018 09:48:18 -0500
Date: Thu, 25 Jan 2018 15:48:14 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, robh+dt@kernel.org, frowand.list@gmail.com,
        rjw@rjwysocki.net, tglx@linutronix.de, vidyas@nvidia.com,
        kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V6 7/7] PCI: tegra: Add power management support
Message-ID: <20180125144814.GI27888@ulmo>
References: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
 <1515650888-9459-8-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
In-Reply-To: <1515650888-9459-8-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2018 at 11:38:08AM +0530, Manikanta Maddireddy wrote:
> Tegra186 powergate driver is implemented as power domain driver, power
> partition ungate/gate are registered as power_on/power_off callback
> functions. There are no direct functions to power gate/ungate host
> controller in Tegra186. Host controller driver should add "power-domains"
> property in device tree and implement runtime suspend and resume
> callback functons. Power gate and ungate is taken care by power domain
> driver when host controller driver calls pm_runtime_put_sync and
> pm_runtime_get_sync respectively.
>=20
> Register suspend_noirq & resume_noirq callback functions to allow PCIe to
> come up after resume from RAM. Both runtime and noirq pm ops share same
> callback functions.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * no change in this patch
> V3:
> * no change in this patch
> V4:
> * no change in this patch
> V5:
> * Decoupled from https://patchwork.ozlabs.org/patch/832053/ and
> rebased on linux-next
> V6:
> * no change in this patch
>=20
>  drivers/pci/host/pci-tegra.c | 181 ++++++++++++++++++++++++++-----------=
------
>  1 file changed, 110 insertions(+), 71 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
[...]
> @@ -1536,37 +1526,41 @@ static int tegra_pcie_enable_msi(struct tegra_pci=
e *pcie)
>  	int err;
>  	u32 reg;
> =20
> -	mutex_init(&msi->lock);
> +	if (!msi->phys) {
> +		mutex_init(&msi->lock);
> =20
> -	msi->chip.dev =3D dev;
> -	msi->chip.setup_irq =3D tegra_msi_setup_irq;
> -	msi->chip.teardown_irq =3D tegra_msi_teardown_irq;
> +		msi->chip.dev =3D dev;
> +		msi->chip.setup_irq =3D tegra_msi_setup_irq;
> +		msi->chip.teardown_irq =3D tegra_msi_teardown_irq;
> =20
> -	msi->domain =3D irq_domain_add_linear(dev->of_node, INT_PCI_MSI_NR,
> -					    &msi_domain_ops, &msi->chip);
> -	if (!msi->domain) {
> -		dev_err(dev, "failed to create IRQ domain\n");
> -		return -ENOMEM;
> -	}
> +		msi->domain =3D irq_domain_add_linear(dev->of_node,
> +						    INT_PCI_MSI_NR,
> +						    &msi_domain_ops,
> +						    &msi->chip);
> +		if (!msi->domain) {
> +			dev_err(dev, "failed to create IRQ domain\n");
> +			return -ENOMEM;
> +		}
> =20
> -	err =3D platform_get_irq_byname(pdev, "msi");
> -	if (err < 0) {
> -		dev_err(dev, "failed to get IRQ: %d\n", err);
> -		goto err;
> -	}
> +		err =3D platform_get_irq_byname(pdev, "msi");
> +		if (err < 0) {
> +			dev_err(dev, "failed to get IRQ: %d\n", err);
> +			goto err;
> +		}
> =20
> -	msi->irq =3D err;
> +		msi->irq =3D err;
> =20
> -	err =3D request_irq(msi->irq, tegra_pcie_msi_irq, IRQF_NO_THREAD,
> -			  tegra_msi_irq_chip.name, pcie);
> -	if (err < 0) {
> -		dev_err(dev, "failed to request IRQ: %d\n", err);
> -		goto err;
> -	}
> +		err =3D request_irq(msi->irq, tegra_pcie_msi_irq, IRQF_NO_THREAD,
> +				  tegra_msi_irq_chip.name, pcie);
> +		if (err < 0) {
> +			dev_err(dev, "failed to request IRQ: %d\n", err);
> +			goto err;
> +		}
> =20
> -	/* setup AFI/FPCI range */
> -	msi->pages =3D __get_free_pages(GFP_KERNEL, 0);
> -	msi->phys =3D virt_to_phys((void *)msi->pages);
> +		/* setup AFI/FPCI range */
> +		msi->pages =3D __get_free_pages(GFP_KERNEL, 0);
> +		msi->phys =3D virt_to_phys((void *)msi->pages);
> +	}

I think it'd be better to split this off into a separate function so
that we can get rid of the confusing if (!msi->phys) conditional. It
looks as though this would work, but it's confusing to have that code
in a resume handler.

It also becomes very asymmetric when you set up the MSIs in the resume
handler, but then don't call tegra_pcie_msi_disable() from the suspend
handler.

I'd suggest just pulling out all of the allocations and such into a
separate function, perhaps tegra_pcie_msi_setup(), and similarily split
off the resource part of tegra_pcie_disable_msi() into a separate
function, perhaps tegra_pcie_msi_teardown().

That way, suspend/resume will do only what they need (write registers)
and everything will look more symmetric again. That in turn makes the
code a lot easier to follow and maintain.

Thierry

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlpp7isACgkQ3SOs138+
s6FGoxAAiU31WTiQrK76XnmBX9b3eFENjATA92FZFBMaagYy2Ms7Vecgo6BDFA4q
Fh10fqFAfjBKjYrj8LhzXehhdN02J82ZHueNZXHaN4S/tlRJegU82fDQt7hQWz8z
eROTk28Za28nikZhsxjVpfdkRLxqKTT7aK5cKWnohylJZ77ag3p3vli8dOu4zYqp
Hxy+IXJJvFLnK3ZU7h31/sZmxg5Dh1GM4ZubyniJzeRyxPwTxS8DTE2BIGrZC+Sw
pjNxsmYk1XB8Dz2u2fcBRP0HprUxWpqJn/2hYNkUnf2bkHj8nBQXN+XWjuyMgiXA
kZzYqEC+/rGJpBJyl3loyGbu6aaB0mN/VYxRNDvfUt06WJdDXf0Rph+JbHXog4ti
yzwVylsN92VRPk39n+TzdHhU73128+J0H4rCy2rHOCVXYutp+RK3nN61h/6hZBAQ
V/u5ETHXpNxmqTFUS+dvT435i+4yQ76BSO/xwNCYb6cM5xLZMjAVCkcIC6M9EDTP
TvGK7/hjfwZFXmJrB1Ze4M5BNS8VzAh4PkhgkI8kru+77WrGJ/LkyYtQ7GVOBu1h
P8F5I8LBiIf97gcLuDEQxun5XK/O5ZfEeKmagqKkIn9eOpoPnFZtU6uhPSDm+HL8
00pIp6opO6CwWUJjnmZVZd7VcFxI8lOsePB5A11WHx2jlW13WEg=
=f0HV
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
