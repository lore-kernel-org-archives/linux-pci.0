Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C730FF2A;
	Tue,  2 Jun 2026 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401486; cv=none; b=d+MMA9pBgNRp6JlmsQDhj+0d0WdD6pmC6mJ/A7FxfFIPHvf+ztlGxR7yROauwEs/NNtGYKg1OEhzgvYvgswfZ4g+wgqw6k/dAXUPIAWKfr7YSic+Yfw4zDEKW307wFKXBZxHIysFLg9CXsyTf5vLi+C7BJnjj0FlOGMIB/Y8498=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401486; c=relaxed/simple;
	bh=vp4eUwXln+M8k1SOsKN2ACcB5l3KMAcwsrxAtGNSZ8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SXFRSUsbpWz0o8gbhJirPyH3aUZesKtdaWRKuVTM4fV1K1BRAiYQwFTOcHdMu5lpVOrWdHIWzRJFbaH2tl0upwyJjVFUhnjYV+0lX9kPaWnx0ZXDex3x0TAiIgvLT2p3tlY3NrkKfo34GaOJGTkYTEimO5/eOBpbjVrs8gO+crE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hITajqik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hITajqik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6411F00893;
	Tue,  2 Jun 2026 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780401485;
	bh=O2q2bZQABrDDvRHJcBt58vY6lK+y115s5rXk3WNZGBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hITajqikkaQRqwQFiUgl/Y15x14X6TSvDIQlZSPZ5MuXF4fEV+yCec+jxmlkj5oph
	 /GmA7c4IIsCdnWf1f88YlmYoBxvdJLVh4xWBx5khXFIaNEkZusQZBLvqyY3rLP32C8
	 ITi0dImff1YnxbVWcPyHk0I1a6SFiuwYh8NKbHbLmUEDTa/WUUIThQLNq+W9At1FuW
	 ZVzn7pPtzAk8C4YR7lH3XmMelU1XY7eKFqq6YDvDgIMZ1jcy2OouW2v3y0WQJbhdcs
	 OGoB2dZKCPUYTXv8PDn0NnocT04HvLeNUcMSLKJd6UBI7xzYjOVkE7MWNoSX3h90VD
	 WP7RcG0fgNm/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] PCI: tegra: Add Tegra264 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260602-tegra264-pcie-v6-3-edbcfa7a78fe@nvidia.com>
References: <20260602-tegra264-pcie-v6-3-edbcfa7a78fe@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:58:04 +0000
Message-Id: <20260602115804.CA6411F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] NULL pointer dereference in tegra264_pcie_remove() if PCIe link fa=
ils to come up
- [High] System suspend crashes due to MMIO access of a powered-off control=
ler
- [Medium] Runtime PM usage counter leak on pm_runtime_get_sync() error pat=
h in probe
- [Low] Missing Kconfig Dependency causing potential Link Failure
--

commit f7c63558c21039995bb013c2149a0292a9cfadb2
Author: Thierry Reding <treding@nvidia.com>

PCI: tegra: Add Tegra264 support

Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
driver is very small, with its main purpose being to set up the address
translation registers and then creating a standard PCI host using ECAM.

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -255,7 +255,14 @@ config PCI_TEGRA
>  	select IRQ_MSI_LIB
>  	help
>  	  Say Y here if you want support for the PCIe host controller found
> -	  on NVIDIA Tegra SoCs.
> +	  on NVIDIA Tegra SoCs (Tegra20 through Tegra186).
> +
> +config PCIE_TEGRA264
> +	tristate "NVIDIA Tegra264 PCIe controller"
> +	depends on ARCH_TEGRA || COMPILE_TEST

[Severity: Low]
If this driver is built with COMPILE_TEST and no other enabled driver
selects PCI_ECAM, will it cause link-time errors due to unresolved
references to pci_ecam_create and pci_generic_ecam_ops? Should this
entry select PCI_ECAM or PCI_HOST_COMMON?

> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/control=
ler/pcie-tegra264.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-tegra264.c
[ ... ]
> +static int tegra264_pcie_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	err =3D devm_pm_runtime_set_active_enabled(dev);
> +	if (err < 0) {
> +		dev_err_probe(dev, err, "failed to enable runtime PM\n");
> +		goto put_bpmp;
> +	}
> +
> +	err =3D pm_runtime_get_sync(dev);
> +	if (err < 0) {
> +		dev_err_probe(dev, err, "failed to power on device\n");
> +		goto put_bpmp;
> +	}

[Severity: Medium]
Does jumping to put_bpmp on failure here leak the runtime PM usage
counter? Since pm_runtime_get_sync() unconditionally increments the
counter even on failure, it seems a pm_runtime_put_noidle() might
be needed before returning.

[ ... ]
> +	tegra264_pcie_init(pcie);
> +
> +	if (!pcie->link_up)
> +		return 0;
> +
> +	err =3D pci_host_probe(bridge);
> +	if (err < 0) {
> +		dev_err_probe(dev, err, "failed to register host\n");
> +		goto free_ecam;
> +	}
> +
> +	return 0;
[ ... ]
> +static void tegra264_pcie_remove(struct platform_device *pdev)
> +{
> +	struct tegra264_pcie *pcie =3D platform_get_drvdata(pdev);
> +
> +	/*
> +	 * If we undo tegra264_pcie_init() then link goes down and need
> +	 * controller reset to bring up the link again. Remove intention is
> +	 * to clean up the root bridge and re-enumerate during bind.
> +	 */
> +	pci_lock_rescan_remove();
> +	pci_stop_root_bus(pcie->bridge->bus);
> +	pci_remove_root_bus(pcie->bridge->bus);

[Severity: High]
If the link fails to come up during probe, pci_host_probe() is
skipped and pcie->bridge->bus remains NULL. If the device is
subsequently unbound via sysfs, will tegra264_pcie_remove() pass
a NULL bus pointer to pci_stop_root_bus() and pci_remove_root_bus()
causing a kernel panic?

[ ... ]
> +static int tegra264_pcie_suspend(struct device *dev)
> +{
> +	struct tegra264_pcie *pcie =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	tegra264_pcie_deinit(pcie);

[Severity: High]
Can this cause a synchronous external abort during system suspend?

If the PCIe link is down and hot-plug is unsupported,
tegra264_pcie_init() powers off the controller via BPMP firmware.
During suspend, tegra264_pcie_suspend() unconditionally calls
tegra264_pcie_deinit() which attempts to read MMIO registers:

tegra264_pcie_deinit()
    value =3D readl(pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);

Will accessing these registers on a powered-off controller crash
the kernel? Should the suspend function check if the controller
is active before touching the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tegra264-p=
cie-v6-0-edbcfa7a78fe@nvidia.com?part=3D3
