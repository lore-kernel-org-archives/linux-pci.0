Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B50C2C8
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785302407; cv=none; b=O+JyXc0GrjZNGzdZT6xxwWOWuxqflQ1hCRBRXW0flOB82k3ipSka1MypyjMcfPubvVZ23M4GPsu8bWUFVUCTtN9FDQGxPXnahq133IkpDHPXCGAw/L4EMAmnQsYggJkq/0PV4yxaugIGMcqKyEn5wGCEOn29MBJUGFRl2i29pI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785302407; c=relaxed/simple;
	bh=Apjaavm8f8nHMzONZjDMNyNomf5xuDzKfSh4NidpJl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aB+hpSYSt67tkKGrVwU1ZWCKo8YCOu1KRFpCWwNH2OtgSZOahW7NF7w4RFAgILDsS0kJv3c5EjMLpAL1g20qOC6Hw8TPghrWu0cnXSnaWDsLm1psLOKZrq7NLNce+KaG7QmNlifwbZH1qWhPycx1umbB9u6k0XNqKVo9q8hxG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9TUT7kr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9TUT7kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8F81F000E9;
	Wed, 29 Jul 2026 05:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785302405;
	bh=i3GWFKerf7dLcHAKFzvb/+8Ijf17eMP2tCHHXycOKYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e9TUT7krNGU+qRtlWXK9GN/nXaen2+C91PHC5UL+gbfSis1PVbZI2Ia3GekkpsDvD
	 5OYRgFrDM01DZVP/VrwcNxeqhIAebCvbzPkqrVCDfMUsYF8s2FvX76KUIgthJvTFN6
	 J+wElBYX87jvkdji8E7hE35H3Azbj7f+FN5cPdaPF7W5QUGj4ggPOzos7/vqNLGnPA
	 /tnTahfxzCe1bCArphocApGzJcuoHlwROjnjICJBcKxAtlqDJGtUVD6MwxLAxS52w7
	 WezvdMxxKO07/y9jr5tXJEm00pF//3RWi8dWJH8jM8pHH73MMfVq6Q+Q5rtzHJR5yF
	 uaydD3h7Yuj4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/5] PCI: qcom: Add support for resetting the Root
 Port due to link down event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729-pci-port-reset-v9-4-53570b92064d@oss.qualcomm.com>
References: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
 <20260729-pci-port-reset-v9-4-53570b92064d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 05:20:05 +0000
Message-Id: <20260729052005.BF8F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unprotected iteration over PCI bus devices risks list corruption a=
nd use-after-free.
- [High] Accidental routing of MSI interrupts to the global IRQ thread caus=
es an interrupt storm.
- [Medium] Platform devices created for power controllers are leaked if the=
 newly added global IRQ request fails.
--

--- Patch [4]: [PATCH v9 4/5] PCI: qcom: Add support for resetting the Root=
 Port due to link down event ---
commit 89d5e2336d3e173c1acc29f1a3ce080e06d174b3
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI: qcom: Add support for resetting the Root Port due to link down event

This commit adds handling for PCIe link down events on Qcom controllers
by resetting the Root Port. It enables the link down event in the=20
PARF_INT_ALL_MASK register and requests a global IRQ to detect and recover
from these events.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
[ ... ]
> @@ -1734,6 +1754,75 @@ static int qcom_pcie_set_max_opp(struct device *de=
v)
[ ... ]
> +static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
> +				  struct pci_dev *pdev)
> +{
[ ... ]
> +	/*
> +	 * Re-enable global IRQ events as the PARF_INT_ALL_MASK register is
> +	 * non-sticky.
> +	 */
> +	if (pcie->global_irq)
> +		writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
> +				pcie->parf + PARF_INT_ALL_MASK);

[Severity: High]
Does unmasking PARF_INT_MSI_DEV_0_7 here (and during probe) inadvertently
route downstream MSI interrupts to the global IRQ thread instead of the
standard MSI handler?

Since modern endpoints can generate thousands of MSIs per second, could
this cause an interrupt storm that saturates the CPU when the global
threaded handler is woken up for every single MSI event?

> +
> +	qcom_pcie_start_link(pci);
[ ... ]
> +static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
> +{
> +	struct qcom_pcie *pcie =3D data;
> +	struct dw_pcie_rp *pp =3D &pcie->pci->pp;
> +	struct device *dev =3D pcie->pci->dev;
> +	struct pci_dev *port;
> +	unsigned long status =3D readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS=
);
> +
> +	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);

[Severity: High]
Since PARF_INT_MSI_DEV_0_7 is unmasked, will this unconditional read and
clear of PARF_INT_ALL_STATUS steal the MSI events from the actual DWC MSI
handler? Might this cause MSIs to be silently dropped?

> +
> +	if (test_and_clear_bit(INT_ALL_LINK_DOWN, &status)) {
> +		dev_dbg(dev, "Received Link down event\n");
> +		for_each_pci_bridge(port, pp->bridge->bus) {

[Severity: High]
Is it safe to iterate over pp->bridge->bus->devices without holding the
pci_bus_sem reader lock?

If a user triggers the removal of the root port device via sysfs concurrent=
ly
with a link down event, could this cause list corruption or a use-after-fre=
e?

Also, does the loop need to take a reference to the port device via
pci_dev_get() before passing it to pci_host_handle_link_down() to ensure
the device structure isn't freed while being handled?

> +			if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +				pci_host_handle_link_down(port);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
[ ... ]
> @@ -2135,6 +2245,32 @@ static int qcom_pcie_probe(struct platform_device =
*pdev)
[ ... ]
> +		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						qcom_pcie_global_irq_thread,
> +						IRQF_ONESHOT, name, pcie);
> +		if (ret) {
> +			dev_err_probe(&pdev->dev, ret,
> +				      "Failed to request Global IRQ\n");
> +			goto err_host_deinit;

[Severity: Medium]
Can this error path cause a resource leak of platform devices?

When qcom_pcie_host_init() succeeds earlier in probe, it creates power
controller devices via pci_pwrctrl_create_devices(). If the newly added
global IRQ request then fails here, it jumps to err_host_deinit which
eventually calls qcom_pcie_host_deinit().

However, qcom_pcie_host_deinit() explicitly assumes it is only called
during system suspend and skips calling pci_pwrctrl_destroy_devices():

	if (!pci->pp.skip_pwrctrl_off) {
		/*
		 * No need to destroy pwrctrl devices as this function only
		 * gets called during system suspend as of now.
		 */
		pci_pwrctrl_power_off_devices(pci->dev);
	}

Will this leave the power controller devices permanently leaked on probe
failure?

> +		}
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-pci-port-r=
eset-v9-0-53570b92064d@oss.qualcomm.com?part=3D4
