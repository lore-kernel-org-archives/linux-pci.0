Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D8330C16D
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369421; cv=none; b=W6TNNWCa9OxJGYjHxLFZj23342L3WprPJEr7yhlTdt2xklk6ZkPfSsPdhNP0UOZaMJ6GvgbGIKKaaIgV4iik0EqbSIvBY8LUEmhjJoqzJ8VSFU1Ym8iEnjud3O3jmx6Ved1z6w1Vv/cnRe369QvFL6XCCt/nhGMAWRxII84lE0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369421; c=relaxed/simple;
	bh=awwHpxxltWx0Za932SkFN8+/9K+aNtVG+SBvTg5ujiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WDg48UDf27HvdasIctRyqWT91Vpr4bfBVnQTf6b5UvH3rnzCtX+YdGrF9LtjfQ0tSKb4Sisf5PaAy1YstF2NXjcioWCsWDmSkmLLKdA/EwPO80H+iJVfqWzQzAtPn6mD/HW8R/+T9LGvv9tqts8lmsybvfPdYGOMAI/irzZDGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj8pTWMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj8pTWMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4641F00A3D;
	Mon, 10 Aug 2026 13:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786369419;
	bh=UDKC5aBler3SyPM2anP3O5PxxmnhFzxTI9clVvO75Hs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sj8pTWMAWQkIgOLxUYdgseNUXS5YA82qPDSJSBXQZy3DdekZAcb3htx17UZb78fXa
	 kdwgmsTS22PoB9jw3kR7bROz3wj0Tpq+evsZibAQBSnWmafG9bFdFVPJsX6m9kIKyC
	 de5sb80jHFyoKr1DaI3RXuq5E6Llr3vgf8J7m4qBp85dlr64WXaJL/MW06IkGQpA99
	 vmM6Eue+qc6fKEqCMXT7Cgd42/kJrmRCe2T37ug1Bn2OYCTxBflyB3CEsJv+eeOApf
	 Ec5IMsHfsQsYlWF8uQA99VNVssyug5s+53Hgq9o9ABSMibqC9vi/T4zWzmDCjePEGp
	 fjbCcoRRU7qhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Block accesses to downstream devices on link
 down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260810-ecam_blocker-v1-1-e588e07f68d4@oss.qualcomm.com>
References: <20260810-ecam_blocker-v1-1-e588e07f68d4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 13:43:38 +0000
Message-Id: <20260810134339.6B4641F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The ECAM blocker enable bit (`ECAM_BLOCKER_EN`) is not explicitly =
cleared during host initialization, causing downstream devices to remain pe=
rmanently blocked after a link recovery on platforms lacking a full hardwar=
e reset.
- [High] V2-specific ECAM blocker registers are unconditionally programmed =
on all IP revisions, causing system crashes or state corruption on older ha=
rdware.
- [High] Unsynchronized read-modify-write of the `PARF_SYS_CTRL` register b=
etween the link-down IRQ thread and the concurrent AER recovery workqueue l=
eads to hardware state corruption.
--

--- Patch [1]: [PATCH] PCI: qcom: Block accesses to downstream devices on l=
ink down ---
commit 17695f1fbc53b125cd81eddfebc8a383d0abdbd8
Author: Qiang Yu <qiang.yu@oss.qualcomm.com>

PCI: qcom: Block accesses to downstream devices on link down

This patch introduces an ECAM blocker to drop accesses to the PCIe address
space when a link goes down. The blocker range is programmed during host
initialization, and the blocker is enabled in the link-down IRQ handler.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index b58a607b713f5..7005d989f6ff2 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
[ ... ]
> @@ -1382,6 +1400,37 @@ static void qcom_pcie_configure_ports(struct qcom_=
pcie *pcie)
>  		dw_pcie_program_t_power_on(pcie->pci, port->l1ss_t_power_on);
>  }
> =20
> +static void qcom_pcie_init_ecam_blocker(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci =3D pcie->pci;
> +
> +	/* ECAM base must match the DBI base address */
> +	writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
> +	writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_H=
I);
> +
> +	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
> +	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);

[Severity: High]
Does this code unconditionally write to V2-specific PARF offsets on all IP
revisions? On older IPs (like v1.0.0 and v2.3.2), these registers might not
exist, as their PARF_DBI_BASE_ADDR is at 0x168 instead. Could writing to th=
ese
unmapped or undocumented registers trigger a Synchronous External Abort
and cause a kernel panic during boot on older hardware?

[Severity: High]
Is the ECAM_BLOCKER_EN bit explicitly cleared during this host initializati=
on?
If the controller lacks a full hardware reset on some platforms (like v2.3.=
2)
where it only cycles clocks and regulators, the bit might remain set from a
prior link-down event.

Could subsequent read-modify-write operations on PARF_SYS_CTRL, such as:

drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_post_init_2_3_2() {
    ...
	val =3D readl(pcie->parf + PARF_SYS_CTRL);
	val &=3D ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
	writel(val, pcie->parf + PARF_SYS_CTRL);
    ...
}

silently preserve this bit and permanently block downstream devices after a
link recovery?

> +	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
> +	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
> +
> +	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
> +	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
> +	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
> +	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
> +}
> +
> +static void qcom_pcie_enable_ecam_blocker(struct qcom_pcie *pcie)
> +{
> +	u32 sys_ctrl;
> +
> +	sys_ctrl =3D readl(pcie->parf + PARF_SYS_CTRL);
> +	sys_ctrl |=3D ECAM_BLOCKER_EN;
> +	writel(sys_ctrl, pcie->parf + PARF_SYS_CTRL);

[Severity: High]
Can this unprotected read-modify-write of PARF_SYS_CTRL race with a
concurrent AER recovery workqueue?

If a fatal AER error triggers a Root Port reset, the AER workqueue might
execute initialization functions like qcom_pcie_post_init_2_3_2() locklessl=
y:

drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_post_init_2_3_2() {
    ...
	val =3D readl(pcie->parf + PARF_SYS_CTRL);
	val &=3D ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
	writel(val, pcie->parf + PARF_SYS_CTRL);
    ...
}

Since qcom_pcie_enable_ecam_blocker() is called from the link-down IRQ thre=
ad,
could this race silently overwrite vital initialization bits and corrupt
the hardware link state?

> +
> +	/* Flush the write so the blocker is enabled before this function retur=
ns */
> +	readl(pcie->parf + PARF_SYS_CTRL);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-ecam_block=
er-v1-1-e588e07f68d4@oss.qualcomm.com?part=3D1
