Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9203B4E87;
	Mon, 27 Jul 2026 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167085; cv=none; b=S/FGhNZn/791BxlZhAfQFjxpwdPR9pqz440mIbEjQUcJR+/Lv6sgOoLqpgoVDt5zgtwaid+IYi7nr/XkIH76zbGaZh8NpQF5ih1Clm5+28WrISVy+izAjWHoCoO1FQ3LekKSA6rif5G8FibO74kKGfW3Ng4WHEB6ySXcTLDDNjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167085; c=relaxed/simple;
	bh=BkViHO46Bx16nJMpi+mHSdGnpQlyyYW8DV6pWwyq1wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN79jywZu6GBtAsvaJBmzB//292Cz7NCrTWFe3jd2TjZl3lYBlnA8Ri3ZaJws2Wg4FcJfv7txyHOJ6UMb4Rr1A1jSTGqSgb4CrozyxHDNPGsVRLypnK3S6UGIb0vjJBCeFUlqOFKTAG9IXEpm6+gbyNdL8iPtm2f8yFa6ZIIsXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+NbDUYy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+NbDUYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E321F000E9;
	Mon, 27 Jul 2026 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167083;
	bh=2XFj1A0MTCpEPpjG2fwzCGv45jpRHgPSYAzE1XaQ4Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L+NbDUYyyx8xCmqVE2KWG5duaenycIyVz7kRZu5n/FcbbgCwq+bdjD7XLpHx7DNKp
	 /ZfcFU9y7JjwUVlY6U1uKAazs+GpPp6ZjVqmIMVkDc7TnEBS/KlNIhyJtrCDYy+uHJ
	 XwCuCDb8AWh4r2Pb7ozAMtIr2ehnOl/6XfzIJGPRMQMHkDHbTavqoDDzMYON6F+AXD
	 p/WafVyxdhp2d7QT3wAX71++kV6oFe/Q4ssOyj8V6k0moQOy+mojB9UuQyeuCoO3Cd
	 4xx011KANspC8PqvXTOSqojnjRu85mW6NnefnQz8K3H0a9+c9hIekV0RNVmY3qel50
	 KMbUucvBWh/tQ==
Date: Mon, 27 Jul 2026 17:44:41 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>
Subject: Re: [PATCH v8 4/6] PCI: tegra: Add Tegra264 support
Message-ID: <amd8FoDqTNV2z2vM@orome>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
 <20260716-tegra264-pcie-v8-4-23e51589229b@nvidia.com>
 <063777d8-cd4d-43cc-8f65-102191848c9d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gycetsy4kq6i3v5u"
Content-Disposition: inline
In-Reply-To: <063777d8-cd4d-43cc-8f65-102191848c9d@nvidia.com>


--gycetsy4kq6i3v5u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 4/6] PCI: tegra: Add Tegra264 support
MIME-Version: 1.0

On Fri, Jul 24, 2026 at 01:58:15PM +0530, Manikanta Maddireddy wrote:
>=20
>=20
> On 16/07/26 10:37 pm, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> > driver is very small, with its main purpose being to set up the address
> > translation registers and then creating a standard PCI host using ECAM.
> >=20
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v8:
> > - remove controller deinitialization, firmware does this already
> > - separately track hotplug support and link up state for clarity
> > - select pinctrl sleep state on suspend for symmetry with resume
> > - fail probe if the link is down and not hotplug-capable
> > - remove WAKE# IRQ support
> > - add err_ prefix to gotos
> >=20
> > Changes in v7:
> > - select PCI_ECAM to satisfy the build dependency (Jonathan Hunter)
> > - remove pre-silicon support patch to avoid extra build dependency
> >=20
> > Changes in v6:
> > - remove unneeded pm_runtime_disable() call (Sashiko)
> > - do not use noirq suspend/resume callbacks (Sashiko)
> > - wrap PM ops in pm_ptr() macro (Sashiko)
> > - use standard wait times with msleep() (Lukas Wunner)
> > - properly check errors for wake IRQs
> > - fix build failures /o\
> >=20
> > Changes in v5:
> > - make PCIE_TEGRA264 symbol tristate
> > - drop dependency on PCI_MSI
> > - reorganize tegra264_pcie struct
> > - use standard wake-gpios property
> > - rename tegra264_pcie_bpmp_set_rp_state() to tegra264_pcie_power_off()
> > - use dev_err() instead of dev_info() for some error messages
> > - add clarifying comment as to why bandwidth requests aren't fatal
> > - address some compiler warnings on 32-bit physical address platforms
> > - drop needless comments
> > - explicitly deinitialize controller on suspend
> > - use devm_pm_runtime_active_enabled()
> > - rename "free" label to "free_ecam"
> > - use dev_err_probe() in more places
> > - reselect default pin state during resume, not probe
> > - return early on absence of wake GPIO
> > - simplify BW value calculation
> >=20
> > Changes in v2:
> > - specify generations applicable for PCI_TEGRA driver to avoid confusion
> > - drop SPDX-FileCopyrightText tag
> > - rename link_state to link_up to clarify meaning
> > - replace memset() by an empty initializer
> > - sanity-check only enable BAR regions
> > - bring PCI link out of reset in case firmware didn't
> > - use common wait times instead of defining our own
> > - use core helpers to parse and print PCI link speed
> > - fix multi-line comment
> > - use dev_err_probe() more ubiquitously
> > - fix probe sequence and error cleanup
> > - use DEFINE_NOIRQ_DEV_PM_OPS() to avoid warnings for !PM_SUSPEND
> > - reuse more standard registers and remove unused register definitions
> > - use %pe and ERR_PTR() to print symbolic errors
> > - add signed-off-by from Manikanta as the original author
> > - add myself as author after significantly modifying the driver
> > ---
> >   drivers/pci/controller/Kconfig         |  10 +-
> >   drivers/pci/controller/Makefile        |   1 +
> >   drivers/pci/controller/pcie-tegra264.c | 485 ++++++++++++++++++++++++=
+++++++++
> >   3 files changed, 495 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
> > index 2247709ef6d6..3045c8aecc7e 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -255,7 +255,15 @@ config PCI_TEGRA
> >   	select IRQ_MSI_LIB
> >   	help
> >   	  Say Y here if you want support for the PCIe host controller found
> > -	  on NVIDIA Tegra SoCs.
> > +	  on NVIDIA Tegra SoCs (Tegra20 through Tegra186).
> > +
> > +config PCIE_TEGRA264
> > +	tristate "NVIDIA Tegra264 PCIe controller"
> > +	depends on ARCH_TEGRA || COMPILE_TEST
> > +	select PCI_ECAM
> > +	help
> > +	  Say Y here if you want support for the PCIe host controller found
> > +	  on NVIDIA Tegra264 SoCs.
> >   config PCIE_RCAR_HOST
> >   	bool "Renesas R-Car PCIe controller (host mode)"
> > diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/M=
akefile
> > index ac8db283f0fe..d478743b5142 100644
> > --- a/drivers/pci/controller/Makefile
> > +++ b/drivers/pci/controller/Makefile
> > @@ -7,6 +7,7 @@ obj-$(CONFIG_PCI_HYPERV_INTERFACE) +=3D pci-hyperv-intf=
=2Eo
> >   obj-$(CONFIG_PCI_MVEBU) +=3D pci-mvebu.o
> >   obj-$(CONFIG_PCI_AARDVARK) +=3D pci-aardvark.o
> >   obj-$(CONFIG_PCI_TEGRA) +=3D pci-tegra.o
> > +obj-$(CONFIG_PCIE_TEGRA264) +=3D pcie-tegra264.o
> >   obj-$(CONFIG_PCI_RCAR_GEN2) +=3D pci-rcar-gen2.o
> >   obj-$(CONFIG_PCIE_RCAR_HOST) +=3D pcie-rcar.o pcie-rcar-host.o
> >   obj-$(CONFIG_PCIE_RCAR_EP) +=3D pcie-rcar.o pcie-rcar-ep.o
> > diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/contr=
oller/pcie-tegra264.c
> > new file mode 100644
> > index 000000000000..7071f4b3b97b
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-tegra264.c
> > @@ -0,0 +1,485 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PCIe host controller driver for Tegra264 SoC
> > + *
> > + * Copyright (c) 2022-2026, NVIDIA CORPORATION. All rights reserved.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
>=20
> GPIO header can be removed since WAKE gpio feature is removed.
>=20
> > +#include <linux/init.h>
> > +#include <linux/interconnect.h>
> > +#include <linux/interrupt.h>
>=20
> Interrupt header file can be removed.

Indeed.

[...]
> > +static int tegra264_pcie_probe(struct platform_device *pdev)
[...]
> > +	err =3D pm_runtime_get_sync(dev);
> > +	if (err < 0) {
> > +		dev_err_probe(dev, err, "failed to power on device\n");
> > +		goto err_put_bpmp;
> > +	}
>=20
> pm_runtime_get_sync() increments the runtime-PM usage counter even when i=
ts
> resume operation returns an error. The failure path does not call
> pm_runtime_put_noidle() and bypasses err_put_pm. Prefer
> pm_runtime_resume_and_get(), whose failure semantics avoid the usage-coun=
ter
> imbalance, or explicitly balance the failed pm_runtime_get_sync().

Good point. I'll replace this by pm_runtime_resume_and_get().

[...]
> > +static int tegra264_pcie_suspend(struct device *dev)
> > +{
> > +	/*
> > +	 * No need to do anything device-specific here, BPMP handles the
> > +	 * details of taking the link into L2.
> > +	 */
> > +
> > +	return pinctrl_pm_select_sleep_state(dev);
> > +}
> > +
> > +static int tegra264_pcie_resume(struct device *dev)
> > +{
> > +	struct tegra264_pcie *pcie =3D dev_get_drvdata(dev);
> > +	int err;
> > +
> > +	err =3D pinctrl_pm_select_default_state(dev);
> > +	if (err < 0) {
> > +		dev_err(dev, "failed to configure sideband pins: %pe\n",
> > +			ERR_PTR(err));
> > +		return err;
> > +	}
> > +
> > +	tegra264_pcie_init(pcie);
> > +
> > +	return 0;
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(tegra264_pcie_pm_ops,
> > +				tegra264_pcie_suspend,
> > +				tegra264_pcie_resume);
>=20
> PCI subsystem registered pm_noirq callbacks. So, controller should also
> register to pm_noirq callbacks.

Unfortunately that causes illegal uses of msleep() in no-IRQ context.
Sashiko complains about it and is right. I don't observe any runtime
issues with switching to the _noirq variants, but it doesn't seem right
to stick to it.

Is there any reason why this needs to be _noirq, or any benefits if it
was?

Thierry

--gycetsy4kq6i3v5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpnfOkACgkQ3SOs138+
s6GS5g/+LJ+Fx41NKrqgEU+g86ngDsHFlxBl8sQxA7WB2+7NYBLtnaSTq/BXb4gN
G86DJkYGEMtvaGIHR10qo0jbZi1glMTwytm3XIfkBrsBBm27kgPm0PN7Umci2L2U
GxEocaRD0hkU8BK9vLzHwiq7DeJuBsuQiRrLdkjmpCHtOivpnzH400dcEVUbLTh4
IozPJ9SZ1RXTc5bogvDb+hNvOATCCi+p+Q11wt7StjYtaNpU37znYQX54LTyC9ZR
35RBhW5iomKYihnGlJ6E6nmL8OPR3QiJv6pRMuk9pFBpD2cr0qCR0f2YP4PcP6+9
m1Q1ohfZXJDEsoZuFPbvECIaRQ2lkZhjVxVWrTUcy9skNFjtn+UjP9CFsP8ra9Up
cVfqCoONmzsXzL29NNozNoSJq9B/EA6E9BIigvhr/9KM5R7QD3UcCIleFpmKd835
Y7Aja91o+N6N/Sm2ddaA3bM6Zwfi2s7858n4emE2vKyaEAV2W34w+NPcMK6IHZEI
FG+iZ8ki7WFwwZiW0w2BzzxT2UzNY+K3QLrvfwqfyoEe7LMpnukhlBwpYZcRcn2O
ZhX92XdECmHd5rIZ7h08Aznz1cAHwO1CcgIT6kM//2y5qszXnCzAhMARyqxnaYbd
tucCKYmhs/jMxHwOkVJAUMtB17vQRAy8BV3D3AqCQ7bhg0oLwh4=
=z0EV
-----END PGP SIGNATURE-----

--gycetsy4kq6i3v5u--
