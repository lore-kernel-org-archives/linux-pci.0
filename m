Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044A302146
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729612; cv=none; b=luW8x1leSxgNW3k/a5uV7gzQSWr/+FViYtkC6jEDf2AHxARDKHQRJMhdXIIn1fI0Ig6wvrMiSVceKgG4BN7xBsWBJtZbvDx18t26KLpfiYy6c/ZMFBdHs1TPiZCiUW4B7xJJfNSpA3xztBXJqHMa3c22nUQipljpXDxVDA9aJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729612; c=relaxed/simple;
	bh=/GHpWOONtAQ1vdI996IEs75YeKjSQ+zl7blJsH+s3jM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lB+ybzFZp0fzZ5vz7odGVdlgw2szPMmpuNzwQSkwIkd1Hiagz+xvNxO6EYaP89bssS7mgNfz7He6tQEP8wnPfMVRk+c9yNMlyzFMcyntGZwgdhRZWGKZKaCUxulEqZARD9EH4Az3SGPly6LVMqqUIE+FhBH7UvHVTtAC7X8c89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT+uvNMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT+uvNMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB551F000E9;
	Wed, 26 Aug 2026 07:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787729610;
	bh=ZT+dcBX/WzN5gg8Bj5TsKqlDsfc+q8x7M/t//XV5Bp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iT+uvNMIlnsOzK+1tHiZrogSJdR2Laqk0gYIyn604t+lyOjjWaWzbonZ5d2Ev9Ayr
	 x34NqVGB5JuwKVrX0rdTDKGMSrDCt1QCJ92IdlpVhP7lWmiYsMXeSYhQ8nSKAPhvdI
	 IHYdYH4pFXNHCGflCUiHvA6hTlKAkLlSLEcUPe1p+bIa7vHHtAsqQQD9yDR91K3QXy
	 IAFI6mRVh73ehCuFQ7wz894eDuo4QwCeu5LgW3HcB2ilOFuaxJnwSQYvC28U27vuda
	 4l42d6k8fIr2P6sxcWXnnQP9y5BaJF6TBvh1g+NlgEw3cvR9QJvbaYBaKrT85cSk7M
	 0mvlof1QDiNqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] PCI: qcom: Implement shutdown() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260826-shutdown-v4-2-eb5fe9d454ae@oss.qualcomm.com>
References: <20260826-shutdown-v4-0-eb5fe9d454ae@oss.qualcomm.com>
 <20260826-shutdown-v4-2-eb5fe9d454ae@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 07:33:30 +0000
Message-Id: <20260826073330.8BB551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The newly added platform_set_drvdata() in qcom_pcie_ecam_host_=
init() overwrites drvdata with a struct dw_pcie* for firmware-managed platf=
orms, causing catastrophic type confusion and invalid memory dereferences i=
n PM callbacks that expect a struct qcom_pcie*.
- [High] Using disable_irq() on chained MSI interrupts in qcom_pcie_shutdow=
n() fails to synchronize with currently executing handlers, leaving a race =
condition that can crash the system.

Pre-existing issues:
- [High] Unconditional dereference of optional elbi_base in qcom_pcie_host_=
pme_turn_off() triggers a crash on platforms where ELBI is not present.
--

commit cb528be41a06ef2211c8efca75a786c37e95604e
Author: Manivannan Sadhasivam <mani@kernel.org>
Date:   Wed Aug 26 07:16:31 2026 +0000

    PCI: qcom: Implement shutdown() callback

This commit implements the shutdown() callback for the Qualcomm PCIe host
controller driver. It tears down the link by reusing the suspend_noirq logi=
c,
forcing the link into L2. It also masks chained MSI IRQs to prevent
late or spurious interrupts after hardware clocks and power are removed.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index b58a607b713f5..fad2f4e2d6be5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1924,6 +1924,9 @@ static int qcom_pcie_ecam_host_init(struct pci_conf=
ig_window *cfg)
>  	pp->use_imsi_rx =3D true;
>  	dw_pcie_msi_init(pp);
> =20
> +	/* Stash pci so qcom_pcie_shutdown() can mask the MSI IRQ(s) later */
> +	platform_set_drvdata(to_platform_device(dev), pci);

[Severity: Critical]
Will this overwrite the platform driver data with a divergent structure typ=
e?

PM callbacks like qcom_pcie_suspend_noirq() unconditionally cast the fetched
drvdata to a struct qcom_pcie pointer. Since a struct dw_pcie pointer is st=
ashed
here instead for firmware-managed platforms, won't accessing pcie->pci in t=
he
suspend path resolve to the first field of struct dw_pcie (which is a struct
device pointer)?=20

Could this cause an invalid pointer dereference when that corrupted pointer
is passed into dw_pcie_suspend_noirq()?

> =20
>  	return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
>  }
> =20
[ ... ]
> +static void qcom_pcie_mask_msi_irqs(struct dw_pcie_rp *pp)
> +{
> +	u32 ctrl;
> +
> +	/*
> +	 * Mask the chained MSI IRQ(s) before tearing down the link and
> +	 * clocks/PHY. Unlike suspend_noirq(), device_shutdown() runs with
> +	 * interrupts enabled, so a late/spurious MSI could otherwise hit
> +	 * dw_chained_msi_isr() and touch DBI registers after the controller
> +	 * is powered off.
> +	 */
> +	for (ctrl =3D 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
> +		if (pp->msi_irq[ctrl] > 0)
> +			disable_irq(pp->msi_irq[ctrl]);

[Severity: High]
Does disable_irq() successfully block for chained handlers here?

Chained IRQ handlers (like dw_chained_msi_isr) act as flow handlers and do =
not
have the IRQD_IRQ_INPROGRESS flag set on the parent IRQ descriptor. Because=
 of
this, won't the synchronize_irq() call hidden inside disable_irq() return
immediately without waiting for the chained handler to finish?

If an MSI interrupt fires concurrently on another CPU exactly as the system
initiates shutdown, couldn't this leave a race condition where the shutdown
sequence cuts the DBI clocks and power while the chained handler is still
actively reading registers?

> +	}
> +}
> +
> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> +{
[ ... ]
> +	pcie =3D platform_get_drvdata(pdev);
> +	if (pcie) {
> +		qcom_pcie_mask_msi_irqs(&pcie->pci->pp);
> +
> +		if (pcie->global_irq)
> +			disable_irq(pcie->global_irq);
> +
> +		dw_pcie_suspend_noirq(pcie->pci);

[Severity: High]
This is a pre-existing issue, but does calling the core suspend logic here
unconditionally trigger a crash on platforms without an ELBI region?

In qcom_pcie_host_pme_turn_off(), which is called during the suspend sequen=
ce,
there is an unconditional write to elbi_base:

drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_host_pme_turn_off() {
    ...
    writel(ELBI_SYS_CTRL_PME_TURNOFF_MSG, pci->elbi_base + ELBI_SYS_CTRL);
    ...
}

Because the new shutdown path unconditionally executes this suspend callback
on all platform resets, won't this guarantee a NULL pointer dereference on
platforms where ELBI is not present (such as Qcom IP rev 2.1.0 APQ8064/IPQ8=
064)
when they attempt to write to offset 0x04 of a NULL pointer?

> +	}
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-shutdown-v=
4-0-eb5fe9d454ae@oss.qualcomm.com?part=3D2
