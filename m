Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E1137BE95
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570198; cv=none; b=H5Y25JfNRfa1K5QILFwMZGhe5yWUQhNetSFm03fuUyRMXfWjuXmQ2NX2RN+OWXinRDivrKJJBbeeLoDkGFi6aJoSwHDwzWdo4Drfkk20mI5X5Lk1JhtOEkoxu6/n6ec4AIb+6RM1iBxmSCpTAYWaWwnwKI7BHbsagk2Dphvat/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570198; c=relaxed/simple;
	bh=V7PAUZCawAEsA5zg5s67iEn+a/30pcCB4AOFGsYWPEk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nrcTreKItIdCK90aQq/m/wp1In9/ybrWS01o04be0e5IX6o45Sr4fZ/A4yQJofiRwLp0K29OOvzKwRTXCgxi20zb5B0FFrnl4jihKXwo/Y8rqHmbEfjvGogw3Xx9oDUmGGHdC96UKXDkleHdfDE/CE7MJuXmh4qxfXJ2GhFhG+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAqPKZpW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAqPKZpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1D01F00A3D;
	Sat,  5 Sep 2026 01:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570195;
	bh=4jHkYrIVsTA/LSIsRoo+6zSAlpYE/pOo23tfjxFtcYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QAqPKZpWzzRPpkpPlSENMXA5keL1OnF3tPWsKHL+Gn+YLbawr1sWojv0//4VFx0Gx
	 o5GJnOU+caYyRN0Wnun3RnVORdpNijQhzbrK297X7wzsFVt8mZznDX5pII7sGnU8s6
	 zLlzmj3b6P26jB+OI6/aoTKjep9Z7lcwkVrBbXuYI+0x4E0D/nRh1uXQg6YYWFkOFv
	 giqtizcaSib9knBZOQiNkfLwu+oUORCnxN3iD4O5I+VzoMnoSd/XVdOZ9H45WFkkzg
	 wHwABuTptYL30/wcpntrbQ8AsNkx1U3foApyTd2jeRlXWYls/xb64M5c6LTNNh7RHm
	 S7tZMh896SW4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] PCI: qcom: Implement shutdown() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905-shutdown-v5-3-f0c6bafa1d4f@oss.qualcomm.com>
References: <20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com>
 <20260905-shutdown-v5-3-f0c6bafa1d4f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:03:14 +0000
Message-Id: <20260905010315.4F1D01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Setting platform drvdata to `struct dw_pcie *` for `firmware_m=
anaged` devices introduces a fatal type confusion in system suspend/resume =
callbacks.
- [High] Calling dw_pcie_free_msi() during shutdown removes chained handler=
s without synchronization and destroys the non-empty MSI IRQ domain, causin=
g WARN_ON and potential system crashes.
--

commit 8fb4302517aeceeb9b7232585ce3188b6458e92d
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI: qcom: Implement shutdown() callback

PCIe host controllers should bring the link down cleanly before system
shutdown/reboot proceeds to remove power/clocks from the controller.
This commit reuses dw_pcie_suspend_noirq() in the shutdown path and
masks chained MSI and global IRQs before teardown.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index b58a607b713f5..38801830fb70f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1924,6 +1924,9 @@ static int qcom_pcie_ecam_host_init(struct pci_conf=
ig_window *cfg)
>  	pp->use_imsi_rx =3D true;
>  	dw_pcie_msi_init(pp);
> =20
> +	/* Stash pci so qcom_pcie_shutdown() can mask the MSI IRQ(s) later */
> +	platform_set_drvdata(to_platform_device(dev), pci);
> +
>  	return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
>  }

[Severity: Critical]
Does setting the platform device's drvdata to a struct dw_pcie pointer here
introduce a fatal type confusion in the system suspend/resume callbacks?

The PM suspend callback qcom_pcie_suspend_noirq() unconditionally retrieves
drvdata expecting a struct qcom_pcie pointer:

qcom_pcie_suspend_noirq() {
	pcie =3D dev_get_drvdata(dev);
	if (!pcie)
		return 0;

	ret =3D dw_pcie_suspend_noirq(pcie->pci);
	...
}

For firmware_managed devices, accessing pcie->pci will evaluate to the
first member of struct dw_pcie (which is struct device *dev), passing a
corrupted memory pointer to dw_pcie_suspend_noirq() and causing a guaranteed
kernel panic on sleep.

[ ... ]

> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> +{
> +	const struct qcom_pcie_cfg *pcie_cfg =3D of_device_get_match_data(&pdev=
->dev);
> +	struct qcom_pcie *pcie;
> +
> +	if (pcie_cfg && pcie_cfg->firmware_managed) {
> +		/*
> +		 * Firmware owns the link teardown and clock/PHY shutdown in
> +		 * this mode; Linux only owns the chained MSI IRQ(s), which
> +		 * still need to be masked off before shutdown proceeds.
> +		 */
> +		struct dw_pcie *pci =3D platform_get_drvdata(pdev);
> +
> +		if (pci->pp.use_imsi_rx)
> +			dw_pcie_free_msi(&pci->pp);
> +		return;
> +	}
> +
> +	pcie =3D platform_get_drvdata(pdev);
> +	if (pcie) {
> +		if (pcie->pci->pp.use_imsi_rx)
> +			dw_pcie_free_msi(&pcie->pci->pp);

[Severity: High]
Is it safe to call dw_pcie_free_msi() during the shutdown path while child
endpoint mappings still exist and interrupts might be in flight?

In dw_pcie_free_msi(), the code unhooks the chained handler and destroys the
IRQ domain:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_free_msi() {
	for (ctrl =3D 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
		if (pp->msi_irq[ctrl] > 0)
			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
	}

	irq_domain_remove(pp->irq_domain);
}

Removing the active IRQ domain triggers a WARN_ON because the domain is
not empty, as child PCI devices haven't freed their IRQs during shutdown.

Furthermore, removing the chained handler does not synchronize against
in-flight IRQs. If an interrupt executes on another CPU while the
controller's clocks and PHY are powered off later in this shutdown
sequence, it risks an SError (synchronous external abort) crashing the
system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-shutdown-v=
5-0-f0c6bafa1d4f@oss.qualcomm.com?part=3D3
