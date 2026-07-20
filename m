Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0A30F94D;
	Mon, 20 Jul 2026 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561343; cv=none; b=kVlD1k6cZ+tsXBm4X8XU6AOgvStH1dIfJlSO2rQPfnwo6BJrMOPE9BkPawyCviZmOvJCjA+ym19uwgHsx/UT2NXqCTw2fnAwhw8Age7r6my7e7CHmbYRqpwhxHv9GCtXiEdACi7aDl97APkMoRwWJEr3NxXyCJcrrQvgHbRxZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561343; c=relaxed/simple;
	bh=7O0vC6/yqYA0BI4cZmKbu1kjJIMuCL0aau+hjeo2LCA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WY1CoxxkmqockXnwPSsIh6hSiScm+q6Sbnt310WKunJSgwyGBCBxSvApSNoIkyGQ+w6llEdaieAerFWd/+ICM2YA6Am1Xu7gb9Xh01NtzWdelebCevuPJtRECHRXAFA+HbfSTi+Y/l+s78OmRg4UqxmTIg9qk9IbvXud9zm21Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWqsMtpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWqsMtpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D8B1F00A3D;
	Mon, 20 Jul 2026 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561341;
	bh=dWPGGLsF2G/6ezyrvFhnGo/wg7YMOtfz7V0dnxZgbtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cWqsMtpydBlML83AsA+ikPeWf7b22QD++F4XPMvZRe2Qz4eOHwMQ2u9LXL1sjC39k
	 qKFGMcAjldB5Pdr328XAPBDnL9qol6ffXYSNuRVEzXwlI7KKHDOKEVnM796DoCOOxt
	 NpOk7+CprQRS84R16g1BoHeVGlYHk4yrEm4vzSOPH3ZCBjBC0ony/x6r7qRs/Yeiyn
	 u1PwgDbgp8jPKW+jZUDVo8/iXuj81udUAxK6IghMOiENM3vLEuJV0H5P7ajF2966TV
	 +cB8ayydU1sV4XCoQex3ZqGjC/wqdcNDIbix5TronbPlXTdsN/QSGJc9Mv71K5kiIY
	 EBOM5tJhZ9aKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/16] PCI: dwc: qcom-ep: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, Frank.Li@kernel.org, imx@lists.linux.dev, neil.armstrong@linaro.org
In-Reply-To: <20260720150619.24733-11-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-11-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:29:00 +0000
Message-Id: <20260720152900.B1D8B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] `pci->pcie_cap` is used uninitialized (as 0) in `qcom_pcie_ep_icc_=
update()` if the global IRQ triggers before `perst_irq` completes.

Pre-existing issues:
- [High] Lost interrupt events due to mutually exclusive `if-else if` chain=
 dropping concurrently pending status bits.
- [High] Concurrent execution of global IRQ and PERST IRQ leads to unclocke=
d MMIO accesses and system crash.
--

--- Patch [10]: [PATCH v3 10/16] PCI: dwc: qcom-ep: Use cached PCIe capabil=
ity offset ---
commit 66f17f8dee9121b185f046f6247725965823798a
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: qcom-ep: Use cached PCIe capability offset
   =20
dw_pcie_ep_init() no longer caches the offset automatically. For qcom-ep,
hardware (clocks, PHY) is enabled only after PERST# deassert. Therefore,
we must call dw_pcie_get_pcie_cap() in qcom_pcie_perst_deassert() after
the resources are enabled, before any DBI access. This ensures the cached
offset is valid for subsequent uses in interrupt handlers and ICC updates.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/cont=
roller/dwc/pcie-qcom-ep.c
> index 56184e6ca6e69..16b0891f95713 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -307,15 +307,13 @@ static void qcom_pcie_ep_icc_update(struct qcom_pci=
e_ep *pcie_ep)
>  {
>  	struct dw_pcie *pci =3D &pcie_ep->pci;
> -	u32 offset, status;
> -	int speed, width;
> -	int ret;
> +	int speed, width, ret;
> +	u32 status;
> =20
>  	if (!pcie_ep->icc_mem)
>  		return;
> =20
> -	offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	status =3D readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +	status =3D readw(pci->dbi_base + pci->pcie_cap + PCI_EXP_LNKSTA);

[Severity: High]
Does this read from an uninitialized offset if the global IRQ triggers
before the PERST IRQ completes?

qcom_pcie_ep_enable_irq_resources() requests the global IRQ without
IRQ_NOAUTOEN, making it active immediately. If the PCIe link is already
established (e.g., by the bootloader or firmware), the IRQ can trigger
before pci_epc_start() enables the PERST IRQ and qcom_pcie_perst_deassert()
caches the offset.

If this happens, pci->pcie_cap would be 0, causing the function to read
from DBI offset 0x12 instead of PCI_EXP_LNKSTA. This would compute arbitrary
speed and width values to pass to icc_set_bw(), which could misconfigure the
system interconnect bandwidth.

> =20
>  	speed =3D FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>  	width =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, status);

[ ... ]

> @@ -491,14 +489,15 @@ static int qcom_pcie_perst_deassert(struct dw_pcie =
*pci)
> =20
>  	dw_pcie_dbi_ro_wr_en(pci);
> =20
> +	dw_pcie_get_pcie_cap(pci);
> +
>  	/* Set the L0s Exit Latency to 2us-4us =3D 0x6 */
> -	offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	offset =3D pci->pcie_cap;
>  	val =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);

[ ... ]


drivers/pci/controller/dwc/pcie-qcom-ep.c:qcom_pcie_ep_global_irq_thread() {
...
	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);

	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
...
	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
...
}

[Severity: High]
This is a pre-existing issue, but does this if-else chain lose concurrent
interrupt events?

qcom_pcie_ep_global_irq_thread() clears all pending events simultaneously in
hardware. If the host sends multiple events in close succession (e.g., both
Bus Master Enable and Link Up are set in PARF_INT_ALL_STATUS), the else-if
logic will process the first matching event and discard the others.

Since the discarded events are already cleared from the register, they would
be permanently lost, potentially leaving the endpoint in an incorrect logic=
al
state.


drivers/pci/controller/dwc/pcie-qcom-ep.c:qcom_pcie_ep_global_irq_thread() {
...
	u32 status =3D readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
...
}

drivers/pci/controller/dwc/pcie-qcom-ep.c:qcom_pcie_disable_resources() {
...
	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
...
}

[Severity: High]
This is a pre-existing issue, but can the global IRQ thread race with
PERST deassertion/assertion and cause an unclocked MMIO access?

Both the global and PERST IRQs are requested as threaded IRQs without mutual
exclusion. If the host toggles PERST, qcom_pcie_ep_perst_irq_thread() calls
qcom_pcie_perst_assert(), which unconditionally disables the PCIe clocks via
clk_bulk_disable_unprepare().

If a simultaneous link state change triggers qcom_pcie_ep_global_irq_thread=
()
and it reads from PARF_INT_ALL_STATUS after the clocks are disabled, this
would cause a synchronous external abort (SError) and crash the system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D10
