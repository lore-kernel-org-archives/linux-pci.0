Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793248772;
	b=j2P7kG4xP309g6nRzKSnFRA4s29DrWFaWeMXxrW/BXbT+tJQLJK0U+i0vh28StaOoTtM
	 e8USUQyhlvoFzPXjkhYEDZ4Fx1MrgNN5Vzcn98hiMO3nD0aAQMvpQcEOZVN1nBovR7V1g
	 pGxO0Ayw+dRlMEt5nziPF1cwboZLbvkxnGSLFLZlYsoE9mnGCCClVWs7m6iL6HSFuVABe
	 FNgm6FFT9eyueWJpZtC66rrOmf95aUClEiDr8pwQkKmg0q+eXzes/BCOCmjB9TfNaAUnu
	 DWluErVApbsuIOSpbKzzF7N4lpxryrouKVkETm4awud1VcJCQpwnKtnI67I/g7EYUmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793248772;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gaj9wrZGqNg5YQ2lOVwmn12LVf295AOV2ibFq3jW2VA=;
	b=snaWcbQoiP5HtwZ5o99+PiD42MH7ELq8X4r43plzrFuxyjPu1QGXojaZnfVelFm64eBU
	 yzoWnPWYoPDm4gUytAFsfzbH5nvhlLmf/3MRMvtNzw41UAv9L8ZBbZZCm4rrdrrRFdpPA
	 4vtEmD/h3gxjh9sKrt3RMwOtxxkxz9F1uYaHsLV2jgrgQaluKgI+lDi2AcFxzAidE+5tQ
	 +bTZgiEsa0sCTnusOjAf8W658WEzmBHzNcXf7gvC5ze4UFnbhV4zvrTc1SP9iGcrk2v6X
	 XqLDku6tBJ6b3xoAC7RLUuvUE6xoEylV4vwLbEIQpVzTpfsZZ2n21xLmakuPaV6Bz8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwIbejZV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E349606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwIbejZV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960DD1F01825;
	Thu, 29 Oct 2026 04:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793248771;
	bh=gaj9wrZGqNg5YQ2lOVwmn12LVf295AOV2ibFq3jW2VA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CwIbejZV7tphH0HGV+YqQud0mHIEADg9glRWbYovGU6dGEddekfsdWJT6NreRwsQx
	 rZ+s+TSMILmCmvc7EPzheXAMTFtTTaiS295yvB0V+gdvuUQyvq2/2Sp67gUkhdVUE9
	 pqTjPx3kUJlwWICbphM2NoESrXobi9H8cyKZjIuSMzy20FagNupvT288Jlnw78guzL
	 NjqmAX1ecZQ52sZt4o8Ki5m72Xly4dqGHVCWwkqPTAhZI5WaHr29kYph5+Z60VKc/8
	 7Ks/JHhxv0A8jhpK4u+LCzr5bsHp6/yyDfr9QgwbMn5I1xLsPSotSFDXAdzNYKYqIU
	 yqxy7Q+zOmgLg==
Message-ID: <sashiko-outbox-188707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] PCI: qcom: Implement shutdown() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-shutdown-v7-3-3fd7a76a6991@oss.qualcomm.com>
References: <20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com>
 <20261029-shutdown-v7-3-3fd7a76a6991@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:39:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] PCI: qcom: uninitialized pcie pointer in qcom_pcie_shutdown()
- [High] PCI: qcom: premature MSI domain removal in qcom_pcie_shutdown()
- [Medium] PCI: qcom: unclocked DBI access in qcom_pcie_shutdown() if alrea=
dy suspended
--

commit 6dda2390c78b4d6a37d9cd056de73eff45df08e7
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI: qcom: Implement shutdown() callback

This commit implements the platform driver shutdown callback for Qualcomm
PCIe host controllers to mask the Global and chained MSI interrupts, bring
the PCIe link down into L2 via dw_pcie_suspend_noirq(), and disable runtime
PM before system shutdown or reboot cuts clocks and power.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index a7835e8a51e02..423a90d6adfb4 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -2451,6 +2454,37 @@ static int qcom_pcie_probe(struct platform_device =
*pdev)
>  	return ret;
>  }
> =20
> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> +{
> +	const struct qcom_pcie_cfg *pcie_cfg =3D of_device_get_match_data(&pdev=
->dev);
> +	struct qcom_pcie *pcie;
> +	struct dw_pcie *pci;
> +
> +	if (pcie_cfg && pcie_cfg->firmware_managed) {
> +		/*
> +		 * Firmware owns the link teardown and clock/PHY shutdown in
> +		 * this mode; Linux only owns the chained MSI IRQ(s), which
> +		 * still need to be masked off before shutdown proceeds.
> +		 */
> +		pci =3D platform_get_drvdata(pdev);
> +	} else {
> +		pcie =3D platform_get_drvdata(pdev);
> +		pci =3D pcie->pci;
> +
> +		if (pcie->global_irq)
> +			disable_irq(pcie->global_irq);
> +	}

[Severity: High]
Should pcie be initialized to NULL in qcom_pcie_shutdown() in
drivers/pci/controller/dwc/pcie-qcom.c?

When pcie_cfg && pcie_cfg->firmware_managed is true, the first branch only
assigns pci =3D platform_get_drvdata(pdev) and leaves pcie uninitialized on
the stack.

Later in qcom_pcie_shutdown():

	if (pcie)
		dw_pcie_suspend_noirq(pcie->pci, true);

evaluating if (pcie) reads the uninitialized stack variable and dereferences
pcie->pci on firmware-managed platforms.

> +
> +	if (pci->pp.use_imsi_rx)
> +		dw_pcie_free_msi(&pci->pp);

[Severity: High]
Is it safe for qcom_pcie_shutdown() in drivers/pci/controller/dwc/pcie-qcom=
.c
to call dw_pcie_free_msi() while downstream PCI devices and their MSI
mappings are still active?

In drivers/pci/controller/dwc/pcie-designware-host.c, dw_pcie_free_msi()
does not just detach the chained handler, it also destroys the MSI domain:

	for (ctrl =3D 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
		if (pp->msi_irq[ctrl] > 0)
			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
	}

	irq_domain_remove(pp->msi_irq_domain);

Unlike dw_pcie_host_deinit(), device_shutdown() does not remove PCI devices
or tear down per-device child MSI domains, and endpoint drivers that do not
implement a shutdown callback (or do not call pci_free_irq_vectors() in
shutdown) leave active MSI mappings and child domains referencing
pp->msi_irq_domain after irq_domain_remove() frees it.

During a kexec reboot, after device_shutdown() completes and
qcom_pcie_shutdown() has disabled controller clocks and runtime PM,
kernel_kexec() takes down non-boot CPUs via:

  machine_shutdown()
    smp_shutdown_nonboot_cpus()
      irq_migrate_all_off_this_cpu()
        migrate_one_irq()

In migrate_one_irq(), managed-affinity MSI interrupts call
irq_shutdown_and_deactivate() -> irq_domain_deactivate_irq() ->
__irq_domain_deactivate_irq() in kernel/irq/irqdomain.c, which walks
irq_data->parent_data and dereferences the freed pp->msi_irq_domain. For
other active MSI interrupts, migrate_one_irq() masks and unmasks the IRQ via
dw_pci_bottom_mask() and dw_pci_bottom_unmask(), which call
dw_pcie_writel_dbi() on DBI registers after the controller clocks and power
have been turned off.

Would detaching only the chained MSI handler (or disabling the parent MSI
IRQs) without removing pp->msi_irq_domain avoid both the use-after-free and
oraning active MSI descriptors?

> +
> +	if (pcie)
> +		dw_pcie_suspend_noirq(pcie->pci, true);

[Severity: Medium]
What happens here in qcom_pcie_shutdown() in
drivers/pci/controller/dwc/pcie-qcom.c if the controller is already
suspended when system shutdown or reboot runs?

If a previous system suspend succeeded via qcom_pcie_suspend_noirq() ->
dw_pcie_suspend_noirq(), and a subsequent qcom_pcie_resume_noirq() failed
(for example, if dw_pcie_resume_noirq() or icc_enable() returned an error),
pcie->pci->suspended remains true while the controller clocks, PHY,
regulators, and icc_cpu/icc_mem interconnects are disabled.

When qcom_pcie_shutdown() then calls dw_pcie_suspend_noirq(pcie->pci, true)
without checking pcie->pci->suspended, dw_pcie_suspend_noirq() in
drivers/pci/controller/dwc/pcie-designware-host.c immediately accesses DBI
registers via dw_pcie_link_up() -> qcom_pcie_link_up() while clocks and
interconnects are off, and then runs qcom_pcie_host_deinit() a second time.

Should this check if (!pcie->pci->suspended) before calling
dw_pcie_suspend_noirq()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-shutdown-v=
7-0-3fd7a76a6991@oss.qualcomm.com?part=3D3
