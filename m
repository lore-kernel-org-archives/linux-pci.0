Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C234D382;
	Wed, 17 Jun 2026 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729307; cv=none; b=jdEQlozCjRXoSr1xZ4XHEAynnI9ai3kZ1tgW20dQqQ3UK0UUARLn8BtApjGOEFBVN46Sh6D+KmPz1FTCdUIe+OMqiYc3J2b+Ljj0EgvE/K4MYJKf3qfyh1/m6J8tr3wmWHZWfmlAiI6UfjljSKAyRK7Z2EfbNW5h2JfkRIJvvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729307; c=relaxed/simple;
	bh=9jQNQRI4oCbNEMtZNIocuEleAKRnHh1+OlUkl89ZTwU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NHEWTxOuVJWAdWJeLdB3bVnr0iWevZqW79EWJz9fuZOwScj4+8FivVSXupM+MLYnmEe6FVjXd4RRE8lh1nLZXg9tZWYLCcyV6FReRueQI8cyQmwfiutWL94MFe5V08JdZFcCS5i0jNwGVriWpAyih5qVK4v3b+FDYFnQiCuUlWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2CdxE+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2CdxE+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2886A1F000E9;
	Wed, 17 Jun 2026 20:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729306;
	bh=grtFnER6HOCbleJko5OPkYILQ2PuNBHHFW9FbhttmZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b2CdxE+7ldptxLJraT3NTkdTAIkGgHNXkV1Yi7ZH4kNOuGMNAPRRxGOBy9jIrRnrj
	 4zOoqIYVmwH5FFSczXUo/pi3Gc6Leuc0Z6Enaa+DInTY4jdnfAzhAM2w35PwWyF+0I
	 8Ggdhn1/8ToCuzGJ3yL7keF/vqow0uG5MDmmK55WoK4dfgFfPVRQN5f0eTz/ssL68M
	 L9mjL0EjiOsjxWtr4qDLBSqShdcWmKey6JenQlEl7wmZgtkxNrnIIqazr0DgA5wQQ6
	 sCW1b3exCaH/Ku5S440HFF4yxIWryxiJfa0mCGhUsS9JXr6EiC3/0+OGrDKewpAPG9
	 EyyBp2nG81xMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] PCI: tegra: Add Tegra264 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260617-tegra264-pcie-v7-3-eae7ae964629@nvidia.com>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
 <20260617-tegra264-pcie-v7-3-eae7ae964629@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:48:25 +0000
Message-Id: <20260617204826.2886A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unbinding the driver causes a NULL pointer dereference crash if th=
e PCIe link was down during probe.
- [High] Kernel panic during system suspend if the PCIe link failed to come=
 up.
- [Medium] The runtime PM usage counter is leaked if `pm_runtime_get_sync()=
` fails.
--

commit 606e8e105f99594322aaccfdb36dcac03cb19d29
Author: Thierry Reding <treding@nvidia.com>

PCI: tegra: Add Tegra264 support

Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
driver is very small, with its main purpose being to set up the address
translation registers and then creating a standard PCI host using ECAM.

> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/control=
ler/pcie-tegra264.c
> new file mode 100644
> index 0000000000000..e2d295ea4403f
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

[Severity: Medium]
According to the runtime PM API, pm_runtime_get_sync() increments the usage
counter even if it returns an error. If it fails here, we jump to put_bpmp,
skipping the put_pm label which calls pm_runtime_put_sync(). Does this leak
the usage counter and prevent the device from ever entering runtime suspend?

> +	}
> +
> +	/* sanity check that programmed ranges match what's in DT */
> +	if (!tegra264_pcie_check_ranges(pdev)) {
> +		err =3D -EINVAL;
> +		goto put_pm;
> +	}

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
> +
> +free_ecam:
> +	pci_ecam_free(pcie->cfg);
> +put_pm:
> +	pm_runtime_put_sync(dev);
> +put_bpmp:
> +	tegra_bpmp_put(pcie->bpmp);
> +
> +	return err;
> +}
> +
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
If the link is down during probe, tegra264_pcie_probe() returns 0 without
calling pci_host_probe(), leaving pcie->bridge->bus as NULL. When the
driver is later unbound, tegra264_pcie_remove() unconditionally passes
pcie->bridge->bus to pci_stop_root_bus() and pci_remove_root_bus().=20

Will this cause a NULL pointer dereference? Is a check needed to ensure the
bus exists before tearing it down?

> +	pci_unlock_rescan_remove();
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	tegra_bpmp_put(pcie->bpmp);
> +	pci_ecam_free(pcie->cfg);
> +}
> +
> +static int tegra264_pcie_suspend(struct device *dev)
> +{
> +	struct tegra264_pcie *pcie =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	tegra264_pcie_deinit(pcie);

[Severity: High]
If the link fails to come up in tegra264_pcie_init() and the port isn't
hotplug-capable, the driver powers off the controller and sets
pcie->link_up =3D false.

If the system is later suspended, tegra264_pcie_suspend() unconditionally
calls tegra264_pcie_deinit(), which attempts to read from the xtl register
space:

static void tegra264_pcie_deinit(struct tegra264_pcie *pcie)
{
	...
	value =3D readl(pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);

Will this hardware access to a powered-off controller cause a kernel panic?
Should we check pcie->link_up before calling tegra264_pcie_deinit(),
similar to what is done in tegra264_pcie_resume()?

> +
> +	if (pcie->wake_gpio && device_may_wakeup(dev)) {
> +		err =3D enable_irq_wake(pcie->wake_irq);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-tegra264-p=
cie-v7-0-eae7ae964629@nvidia.com?part=3D3
