Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945BA27453;
	Thu, 14 May 2026 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792501; cv=none; b=nE/zeSIEinYj90y84ImaMe/PZBm+7HDk89B4hEPOo+YrSu+ilTiKa7zqhE13IbmDcNmLNTqkDVWk3hCiYdtx7cx3/YaXfAmOhiHGbDw+bHRlCq3b2Ne7CptRTW+QzhDLEJAeJo9AtIUSKGo52+J3xzMbG7UBZ2YUACwbEvHKpsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792501; c=relaxed/simple;
	bh=9gn8b0288uw4DowLPqaMIPhpuVchlU0c2NFVhZbWg2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kESRgieOs5NT5ko80/3OCi8h3qU2tYB1Rz/ZejM5rXQinCUwuVWRpWKxyWCN4TOxg8p+0CQWZa0+Uz/a3Of2/xnc83OMoI6ATI4a3+w1gQ6dAW6jZkJ6RYkc8yaIyOQG2HhyhhfzTfsKI0dYzR3XvvAfbg4UTmNRTES2ADEekLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikJrmZ/y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikJrmZ/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEF2C2BCB3;
	Thu, 14 May 2026 21:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792501;
	bh=9gn8b0288uw4DowLPqaMIPhpuVchlU0c2NFVhZbWg2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ikJrmZ/yastcL9wWffu1mRXFaB9k4LScGTLtEJbgCUetrI7o57SXhTq9LfTuw7Tp/
	 xs1htg4mLGS1EG2087RagiVlAKPhy6Q2Djx4ekgUS4WO4uyZxeQIw314A9Z75nmZGM
	 HnsaozPeXDHFSriOLwGehOzm96OsCsPIOxarK3U3ev0VuTiFu4Ac0pha7IeSk0UIZB
	 xKZouPOzSBEvXcMndwycRTP5e9arohkG7cvGLd05O8WGvIRpnYWKxJH4rcmks+4wJ1
	 F7FOt2N5CwWG/g55gNngnBGdcicnq17IDytAQkw887XcPLmFv1jKho4buL1caNWJo2
	 /mtw/HSorKLSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] PCI: mediatek: Add support for EcoNet EN7528 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Caleb James DeLisle" <cjd@cjdns.fr>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260514151318.3444959-3-cjd@cjdns.fr>
References: <20260514151318.3444959-3-cjd@cjdns.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 21:01:40 +0000
Message-Id: <20260514210141.2DEF2C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] mtk_pcie_retrain() iterates the PCI bus without locks and holds an=
 unreferenced device pointer, leading to a Use-After-Free.
- [High] mtk_pcie_retrain() only retrains the first root port, silently ign=
oring any other ports on the same host.
- [High] Link retraining occurs after downstream endpoint drivers are probe=
d, causing a race condition that can lead to system crashes.
- [High] Calling virt_to_phys() on an __iomem pointer causes undefined beha=
vior and potential memory corruption.
- [Medium] The IS_BUILTIN() workaround silently degrades hardware capabilit=
ies when the driver is compiled as a module.
--

commit 08338fe344200ef55148194108ab3b65616af7c7
Author: Caleb James DeLisle <cjd@cjdns.fr>
Subject: PCI: mediatek: Add support for EcoNet EN7528 SoC

This commit adds support for the PCIe controller found on EcoNet EN7528 SoC=
s.
It introduces a hardware quirk to retrain the link after startup, as some
ports capable of Gen2 operation will initially start at Gen1 speeds.

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
[ ... ]
> @@ -753,6 +764,135 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie=
_port *port)
[ ... ]
> +	/* Activate INTx interrupts */
> +	val =3D readl(port->base + PCIE_INT_MASK);
> +	val &=3D ~INTX_MASK;
> +	writel(val, port->base + PCIE_INT_MASK);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		mtk_pcie_enable_msi(port);

Is it safe to call mtk_pcie_enable_msi() here? Looking at
mtk_pcie_enable_msi(), it calculates the message address using:

    virt_to_phys(port->base + PCIE_MSI_VECTOR)

Since port->base is an ioremapped __iomem pointer, passing it to
virt_to_phys() produces undefined behavior and could return a garbage
physical address. If this address overlaps with valid physical RAM mapped
for DMA, could memory writes from the PCIe endpoint corrupt random system
memory?

> +
> +	/* Set AHB to PCIe translation windows */
[ ... ]
> +static int mtk_pcie_retrain(struct device *dev, struct pci_host_bridge *=
host)
> +{
> +	struct pci_dev *rp;
> +	int ret =3D -ENOENT;
> +	u16 lnksta =3D 0;
> +	u32 speed;
> +
> +	/* Should already have been warned about during startup_port */
> +	if (!IS_BUILTIN(CONFIG_PCIE_MEDIATEK))
> +		return 0;
> +
> +	for_each_pci_bridge(rp, host->bus) {
> +		if (pci_pcie_type(rp) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +			goto found_port;
> +	}
> +
> +	/* Should not happen */
> +	return dev_err_probe(dev, ret, "root port not found\n");
> +
> +found_port:

The commit message mentions that it is most convenient to retrain every port
after startup. Does the goto found_port here unintentionally skip all
subsequent root ports by breaking out of the loop after the first match?

Also, is it safe to traverse host->bus->devices via for_each_pci_bridge()
without holding the pci_bus_sem read lock? If a device is concurrently added
or removed, this might lead to list corruption.

Finally, pcie_retrain_link() is a sleepable function. Because the code does
not acquire a reference to the root port via pci_dev_get() before sleeping,
could a concurrent removal event free the pci_dev structure and result in a
use-after-free?

> +
> +#if IS_BUILTIN(CONFIG_PCIE_MEDIATEK)
> +	ret =3D pcie_retrain_link(rp, true);
> +#endif

Does this silently degrade hardware capabilities when the driver is compiled
as a loadable module? The Kconfig definition allows CONFIG_PCIE_MEDIATEK to
be a tristate module, so users compiling it as a module might find their PC=
Ie
devices permanently stuck at Gen1 speeds.

> +
> +	if (ret)
[ ... ]
> @@ -1149,6 +1289,13 @@ static int mtk_pcie_probe(struct platform_device *=
pdev)
>  	if (err)
>  		goto put_resources;
> =20
> +	/*
> +	 * Ignore error because pci_host_probe() was already called, and in any
> +	 * case it is possible that the port will still work as Gen1.
> +	 */
> +	if (pcie->soc->quirks & MTK_PCIE_RETRAIN)
> +		mtk_pcie_retrain(dev, host);
> +
>  	return 0;

Does retraining the link at this stage introduce a race condition with
downstream endpoints?

By the time pci_host_probe() completes successfully, the PCIe bus is fully
enumerated and downstream endpoint drivers (such as NVMe or WiFi) have been
probed. If those drivers are actively issuing MMIO or DMA requests, forcing
the physical link into the Recovery state could cause PCIe completion timeo=
uts
and potentially lead to fatal kernel crashes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514151318.3444=
959-1-cjd@cjdns.fr?part=3D2
