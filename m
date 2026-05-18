Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B19283FD4
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125917; cv=none; b=DXZOVoahrbFpaEfR0u+nIsTFgJ6JCzaPXITc9SUpnPxpiXNGncXG7EhxmuaaZ5hLLxVLZxfFjjLTizGPpMS3cCuW20apr+7doQZAmdj2Qxb1vjhwsUvdtsVq+Y6Zi9uZwdqBNcg6tJfVhSikOqmH9xaydahtFprXo2WTnFjDe7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125917; c=relaxed/simple;
	bh=ywUrW+cc8wAzj7JWoBL0xhy8ORDq8eQbbNmV1AsmF6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SvbOXI/HO5ixV/def/q9+w134wY/UJIN+gtctHcCyeEeE8STYnr5Ftr/xsa5vVj0kgcV0Tm/4VMAsgGRZdZAuUh35GJVJvkQNAwXZznLWuz0jayRVjjDUyXNs06y3/0gbVA8d1qhvYi9h3a9+SvbOdaShSHLQRu2Wi6KdcKc3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pN0Vj+g3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pN0Vj+g3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77C3C2BCB7;
	Mon, 18 May 2026 17:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779125917;
	bh=ywUrW+cc8wAzj7JWoBL0xhy8ORDq8eQbbNmV1AsmF6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pN0Vj+g3HQ1EV9rZU6VhweNXRLQTAXz776+0p7O4HHn4e3zqp309WvULpeRMaXIjD
	 JYAMIdM0hifSG2FtRta2MwmWmXUVDzZO/QOP/JnkUOubCtlG0VpVs+OQ1ZoPp5QUzK
	 efaxjpRYb4zhWUACLw9rzDx5N5pBtGOFgpCUARFxK5+46gVKDWsL62p9a18u32K5Mp
	 RPThdlbhtrthti2sq8+8S73fwaFV4CQZGnThOl9jbXeklC1FmjbaJnkGXAwsPEqFXs
	 TjHljHuRs9XLak6q9gZO8SnG1trrnUskBhSIwDuKWP3hf2QQtQZ5tF6reZrQ1WccWB
	 +0VKoUqEbr5pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] PCI: qcom: Add support for resetting the Root
 Port due to link down event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518-pci-port-reset-v8-4-eb5a7d331dfc@oss.qualcomm.com>
References: <20260518-pci-port-reset-v8-4-eb5a7d331dfc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 17:38:36 +0000
Message-Id: <20260518173836.C77C3C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] System crash on error path due to unclocked controller.
- [High] Unintended MSI interception by the global IRQ handler causes sever=
e performance regressions or silently drops events.
- [High] Data race and use-after-free via lockless iteration of PCI bus dev=
ices in IRQ thread.
- [Medium] Ignored return value masks link retraining failures.
--

commit f4a6523af4f70d1a2c5951a7190c4516cab3c8fc
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI: qcom: Add support for resetting the Root Port due to link down event

This commit detects the PCIe link down event and resets the Root Port
by first resetting the PCIe core, reinitializing resources, and restarting
the link to make it operational again.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index af6bf5cce65be..feda8abf5f851 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -1613,6 +1633,78 @@ static void qcom_pcie_icc_opp_update(struct qcom_p=
cie *pcie)
> +static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
> +				  struct pci_dev *pdev)
> +{

[ ... ]

> +	ret =3D dw_pcie_setup_rc(pp);
> +	if (ret)
> +		goto err_host_deinit;
> +
> +	/*
> +	 * Re-enable global IRQ events as the PARF_INT_ALL_MASK register is
> +	 * non-sticky.
> +	 */
> +	if (pcie->global_irq)
> +		writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
> +				pcie->parf + PARF_INT_ALL_MASK);
> +
> +	qcom_pcie_start_link(pci);
> +	dw_pcie_wait_for_link(pci);
> +
> +	dev_dbg(dev, "Root Port reset completed\n");
> +
> +	return 0;

Does dw_pcie_wait_for_link() return an error code (such as -ETIMEDOUT) if t=
he
link fails to retrain?

Since this return value is ignored and the function unconditionally returns=
 0,
the PCI core is falsely informed that the recovery was successful.

Could this prevent the PCI subsystem from properly disconnecting the downst=
ream
devices if the link fails to come up, leaving zombie device structures that
cannot communicate?

> +
> +err_host_deinit:
> +	qcom_pcie_host_deinit(pp);
> +
> +	return ret;
> +}

If an error occurs earlier in this function and the code jumps to
err_host_deinit, qcom_pcie_host_deinit() will be called, which turns off the
PHY power, regulators, and PCIe clocks.

When this function returns the error code back to the PCI core, the PCI core
handles the reset failure by returning PCI_ERS_RESULT_DISCONNECT and
triggering device removal.

Since the PCI core and userspace tools might attempt to read the devices'
configuration space during unbind, and the clocks are now disabled, will th=
ese
MMIO accesses cause a synchronous external abort and a kernel panic?

Should the controller remain clocked on the error path so it can safely rej=
ect
config accesses with 0xFFFFFFFF?

> @@ -1650,6 +1742,27 @@ static void qcom_pcie_init_debugfs(struct qcom_pci=
e *pcie)
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
> +

In qcom_pcie_reset_root_port() and qcom_pcie_probe(), PARF_INT_MSI_DEV_0_7
is unmasked in PARF_INT_ALL_MASK. By explicitly unmasking this bit alongside
PARF_INT_ALL_LINK_DOWN, does this cause MSI interrupts to be incorrectly
routed to this global IRQ handler?

The threaded handler reads the status and writes it to PARF_INT_ALL_CLEAR,
but ignores the MSI bits and unconditionally returns IRQ_HANDLED.

Could this lead to silent dropping of MSI interrupts if the Synopsys Design=
Ware
core relies on this status being preserved?

Also, for high-frequency interrupt sources, would every MSI unnecessarily w=
ake
up qcom_pcie_global_irq_thread, causing excessive CPU overhead?

> +	if (test_and_clear_bit(INT_ALL_LINK_DOWN, &status)) {
> +		dev_dbg(dev, "Received Link down event\n");
> +		for_each_pci_bridge(port, pp->bridge->bus) {
> +			if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +				pci_host_handle_link_down(port);
> +		}
> +	}

Does iterating over the root bus devices using for_each_pci_bridge() in an
asynchronous threaded IRQ context require holding the pci_bus_sem read-write
semaphore?

Without locking, could this iteration race with concurrent PCI topology
changes like hotplug events, AER recoveries, or driver unbinds, potentially
leading to list corruption or a use-after-free if a device structure is
freed while the loop is executing?

Would it be safer to use pci_walk_bus() or explicitly acquire
down_read(&pci_bus_sem)?

> +
> +	return IRQ_HANDLED;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-pci-port-r=
eset-v8-0-eb5a7d331dfc@oss.qualcomm.com?part=3D4
