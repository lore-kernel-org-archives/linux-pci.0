Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B33471271
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957261; cv=none; b=XPRHvwRtlub9tQQZTARnkkm/07Og0Ivd/d4QJyksYHcf0+lZg/UdOALh0xAbvWUdNcjuQ5KAKNEteOazyKecIrIfEkv0UA8yJmLzqsj+CiyBb8VmVNzbfQyX6jmIdgpndx7CmvGVmgn+HJFWFYAcq/0o8uITw3KyT2JecuqrhYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957261; c=relaxed/simple;
	bh=9V1eKs5Pp25W1ppqm+B2ItoMvBG7XwtnhRpl2mgghrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LirPdxzF0hDssZg1nhGLMpdQ0+RxkHLd5VsvhTSbW/L5wUIs9reQyqOL8bRqfSD5LjVtn4MRg8nbByRxq1vXI9TDkRIM/RZgWob6jB6QloChsxB6+rbKsm177F/OB9+R5beoYcjq4kWdR8GHMj/IhLbzwbMZogHKKjeFss9i45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMceNvSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMceNvSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750A61F00A3A;
	Wed,  9 Sep 2026 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957259;
	bh=KcvyHdDIsDvePYBs3oGCCgj4Xjmgy977DRVv9KZnOPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMceNvSvF85c8nbr0pI4LGoHuw9qdmg6dAZQYyxktIWqZXPC6Cl4ZXUs/cUr5aMSD
	 e91TtxsZsXc0h8pyvayErQ2otVrvh2uzz+3N1lNMMSAljnKd8Som/kkwKnS+0Zx6vR
	 qCT3X5kBupXJZ0faFbYdX4d5CAaMeTiblgIwq81d1Z0uNxDbhUP2TF6c9QjxQVYuhN
	 BDoHKn2Nvi0iQMbOWRVmMVT9qA13NmYn2tfklB2XtC2qjUV6ruklm56y8dAbwe6Cgb
	 Ahc4c+JYABl7/jCXx93aVtNlLDljBRpJWtB3tVuVCKHrYC2EcoriTnV194h6mHMMZa
	 LtqN9RLj3gDUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] PCI: qcom: Implement shutdown() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260909-shutdown-v6-3-62b7bd123236@oss.qualcomm.com>
References: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
 <20260909-shutdown-v6-3-62b7bd123236@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 12:34:18 +0000
Message-Id: <20260909123419.750A61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The local variable `pcie` is used uninitialized on the `firmwa=
re_managed` code path, leading to undefined behavior and a likely kernel pa=
nic when evaluated and dereferenced.
- [High] Calling `dw_pcie_free_msi()` during `.shutdown` destroys the activ=
e MSI IRQ domain while child endpoints still have IRQs mapped, triggering a=
 spurious kernel warning and leaving dangling state.
--

commit 27c88a203aab0fef576a235de5067454639a8757
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI: qcom: Implement shutdown() callback

This commit implements a shutdown callback for PCIe host controllers to
bring the link down cleanly before system shutdown or reboot proceeds.
It reuses dw_pcie_suspend_noirq() in the shutdown path to force the link
into L2 and masks chained MSI IRQs to prevent late spurious interrupts.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 2693a98d0b279..3133e2b2eda69 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -2408,6 +2411,37 @@ static int qcom_pcie_probe(struct platform_device =
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
> +
> +	if (pci->pp.use_imsi_rx)
> +		dw_pcie_free_msi(&pci->pp);

[Severity: High]
Does calling dw_pcie_free_msi() here trigger a core IRQ subsystem warning?

During system shutdown, child endpoints have their .shutdown callbacks
executed rather than .remove, so they do not naturally release their
allocated MSI vectors.

dw_pcie_free_msi() unconditionally destroys the IRQ domain:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_free_msi() {
    ...
    irq_domain_remove(pp->irq_domain);
}

Will destroying this domain while child endpoints still hold IRQ mappings
leave dangling IRQ descriptors and trigger a warning when checking if the
domain tree is empty?

> +
> +	if (pcie)
> +		dw_pcie_suspend_noirq(pcie->pci, true);

[Severity: Critical]
Is the pcie variable left uninitialized in the firmware_managed path?

When pcie_cfg->firmware_managed is true, pci is initialized but pcie is
not. It looks like this branch will then evaluate stack garbage for the
condition check.

If it evaluates to true, could this cause a kernel panic by dereferencing
stack garbage when accessing pcie->pci in dw_pcie_suspend_noirq()?

> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-shutdown-v=
6-0-62b7bd123236@oss.qualcomm.com?part=3D3
