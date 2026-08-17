Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927218DB35;
	Mon, 17 Aug 2026 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935057; cv=none; b=U+tG+i/brg0f2neK6mEX0Q3PaIerxlYn+00ukO4M6MQeCiEUROVd8OYLBhsQiKSCc1t+7SmBvTGUYWMIX0s2gJVZt9rVz11yFs3Z8cFSyPElw0UzDDJ24lwhW9TzhuuizPi/wyBFVV7jFhKpHboBe/0MeroqC4FlPG2qirQDfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935057; c=relaxed/simple;
	bh=2jMaZoLMO3ZZkDLRBHDak4qaAmwkKcRRA+ZnZH+e62w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LeME5AaxYppAyaIeweztmzan9HrF3goRs772+aQSUsUl78g6ffDbW8d/Q5uRzwHDNSoFhJnD3b23SdP0WWvOiC2tXyF6Zc6QIIBZHFysoCE6baSTBHK62wvajg3gatnKh+SpFL9WREG5CcZFPhaOe763eVSrr3ZILoYU9KNhUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idbv7Sr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idbv7Sr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF551F000E9;
	Mon, 17 Aug 2026 02:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786935055;
	bh=JTx2FwHXX0ADF2/sQ2VCSNCeZPDujDY6lUKrh8KVHrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idbv7Sr4OygHptvvbRQStfrR5EEI58Uewa1IZiNNDWcnqeeBrR7zNBsN1dBEhj/gA
	 P/TMy8kwKmk0N6nlRVH8nzER2ByloXvbHpS2TtnOH5OMfy5ZuzLJI3dtfdkxX1BD69
	 JqlX4BV+eoE7O+Jx3TJ4zOEkYnV41wiY/SwOd2BbS3Sn/djmVJqdUpTWAWLIo5Q85E
	 WdFPxiM8JQwOvShIGSnPYy5kZDDWLtCFP68hXjBPBl7cdh9T23xpKOHexbPspimYkS
	 dM0RLi36A45Ry4wJvxeIyUUSK477sqsoA7hYwSRGLsOE2x9iGuHQU1vV8O5etsf+J0
	 SUof1sHdgQGcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] PCI: amd-mdb: Add CPM6 host controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260817023932.1743100-3-sai.krishna.musham@amd.com>
References: <20260817023932.1743100-1-sai.krishna.musham@amd.com>
 <20260817023932.1743100-3-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 02:50:54 +0000
Message-Id: <20260817025055.5AF551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Early return in interrupt handler bypasses W1C status clears, lead=
ing to infinite IRQ storms for unhandled or sticky aggregator interrupts.
- [High] Conflicting INTx mask management causes the hardware INTx bit to b=
e unconditionally enabled at boot, leading to early IRQ storms.
- [Medium] Uncoordinated clearing of the shared sticky PS_MISC aggregator b=
it may drop interrupts for the peer host controller.

Pre-existing issues:
- [High] Manual IRQ domain destruction before devres IRQ cleanup causes Use=
-After-Free during teardown and error paths.
--

--- Patch [2]: [PATCH v5 2/2] PCI: amd-mdb: Add CPM6 host controller suppor=
t ---
commit 84c0c1fb0997cc1fabcfdf4b8e8bd900916b97d7
Author: Sai Krishna Musham <sai.krishna.musham@amd.com>

PCI: amd-mdb: Add CPM6 host controller support

Extend the AMD MDB PCIe driver to support AMD Versal2 CPM6 variants
(amd,versal2-cpm6-host and amd,versal2-cpm6-host1). Like MDB5, CPM6 is
based on the Synopsys DesignWare PCIe controller and reuses the existing
DesignWare host support, while adding CPM6-specific interrupt register
layouts and aggregator clearing.

> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/cont=
roller/dwc/pcie-amd-mdb.c
> --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -51,24 +88,133 @@
[ ... ]
> +#define AMD_CPM6_MISC_EVENT_MASK_ALL					\
> +	(								\
> +		BIT(AMD_CPM6_PCIE_INTR_FATAL)			|	\
> +		BIT(AMD_CPM6_PCIE_INTR_NONFATAL)		|	\
> +		BIT(AMD_CPM6_PCIE_INTR_MISC_CORRECTABLE)	|	\
> +		BIT(AMD_CPM6_PCIE_INTR_PME_TO_ACK_RCVD)		|	\
> +		BIT(AMD_CPM6_PCIE_INTR_PM_PME_RCVD)		|	\
> +		BIT(AMD_CPM6_PCIE_INTR_INTX)				\
> +	)

[Severity: High]
Does including INTx in the global mask enable it unconditionally during
hardware initialization? This seems to defeat the intx_refmask logic
designed to prevent early IRQ storms before endpoint drivers are loaded.

[ ... ]
> @@ -152,42 +308,40 @@
[ ... ]
> +static void amd_mdb_pcie_clear_aggregators(struct amd_mdb_pcie *pcie)
> +{
> +	if (pcie->variant->version =3D=3D MDB5)
> +		return;
> +
> +	/*
> +	 * Clear this host's serviced contributions (MISC_EVENT and PCIE_ERR)
> +	 * from MERGED.
> +	 */
> +	writel_relaxed(amd_mdb_pcie_merged_host_mask(pcie),
> +		       pcie->slcr + AMD_CPM6_MERGED_STATUS);
> +
> +	/*
> +	 * Clear MERGED in the PS_MISC severity register so the misc GIC line
> +	 * de-asserts.
> +	 */
> +	writel_relaxed(AMD_CPM6_PS_IR_MERGED,
> +		       pcie->slcr + AMD_CPM6_PS_MISC_IR_STATUS);
> +}

[Severity: Medium]
Could this uncoordinated W1C clear race with the peer host controller asser=
ting
its interrupt? If the downstream PS_MISC bit is edge-sensitive, might Host =
0's
clear permanently drop Host 1's edge when both are experiencing heavy I/O?

[ ... ]
> @@ -226,13 +388,54 @@ static irqreturn_t amd_mdb_pcie_event(int irq, void=
 *args)
>  {
>  	struct amd_mdb_pcie *pcie =3D args;
>  	unsigned long val;
> +	u32 ev_raw, err, err_pending;
>  	int i;
> =20
> -	val =3D readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> -	val &=3D ~readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_MASK_MISC);
> +	ev_raw =3D readl_relaxed(pcie->intr_base + pcie->variant->misc_status_r=
eg);
> +	val =3D ev_raw;
> +	val &=3D ~readl_relaxed(pcie->intr_base + pcie->variant->misc_mask_reg);
[ ... ]
> +	/*
> +	 * The misc GIC line is shared with the peer host controller. If this
> +	 * host has nothing pending, return IRQ_NONE so the shared IRQ core can
> +	 * poll the peer and spurious-interrupt detection keeps working. Leave
> +	 * the shared aggregators untouched, otherwise the peer's pending
> +	 * interrupt would be dropped.
> +	 */
> +	if (!val && !err_pending)
> +		return IRQ_NONE;

[Severity: High]
If the bootloader leaves an unhandled interrupt active, or sticky aggregato=
rs
contain stale assertions, won't returning early here bypass the W1C clears
further down the handler? Because the hardware status is never cleared, can
this lead to an infinite IRQ storm that disables the shared interrupt line?

[ ... ]
> @@ -250,24 +453,77 @@ static void amd_mdb_pcie_free_irq_domains(struct am=
d_mdb_pcie *pcie)
[ ... ]
> +static void amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
> +{
> +	u32 misc_mask_all;
> +	u32 val;
[ ... ]
> +	/* Enable all TLP interrupts. */
> +	writel_relaxed(misc_mask_all,
> +		       pcie->intr_base + pcie->variant->misc_enable_reg);
> +
> +	if (pcie->variant->version !=3D MDB5) {
> +		writel_relaxed(AMD_CPM6_PCIE_ERR_MASK_ALL,
> +			       pcie->intr_base + AMD_CPM6_PCIE_ERR_ENABLE);
> +
> +		/*
> +		 * Unmask this host's MISC_EVENT and PCIE_ERR inputs in the
> +		 * shared MERGED aggregator so they reach the GIC.
> +		 */
> +		writel_relaxed(amd_mdb_pcie_merged_host_mask(pcie),
> +			       pcie->slcr + AMD_CPM6_MERGED_ENABLE);
> +	}
>  }

[Severity: High]
Does enabling the shared sticky aggregators without first clearing them all=
ow
stale state to immediately trigger the IRQ storm mentioned above?

[ ... ]
> @@ -351,15 +610,25 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *p=
cie,
[ ... ]
>  	pcie->intx_irq =3D irq_create_mapping(pcie->mdb_domain,
> -					    AMD_MDB_PCIE_INTR_INTX);
> +				    pcie->variant->intx_hwirq);
>  	if (!pcie->intx_irq) {
>  		dev_err(dev, "Failed to map INTx interrupt\n");
>  		return -ENXIO;
>  	}
> =20
>  	err =3D devm_request_irq(dev, pcie->intx_irq, dw_pcie_rp_intx,
>  			       IRQF_NO_THREAD, NULL, pcie);

[Severity: High]
Does requesting the INTx IRQ from the mdb_domain here unconditionally unmask
the INTx bit in the controller? If so, does this bypass the reference count=
ing
logic in amd_mdb_intx_irq_unmask() and enable INTx at boot, opening a window
for early IRQ storms if an endpoint asserts INTx?

[ ... ]
> @@ -466,6 +772,11 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie=
 *pcie,
>  	return 0;
> =20
>  out:
> +	/*
> +	 * Mask the hardware interrupts before tearing down so a stale source
> +	 * cannot storm the shared CPM6 GIC line once this host is unwound.
> +	 */
> +	amd_mdb_pcie_disable_interrupts(pcie);
>  	amd_mdb_pcie_free_irq_domains(pcie);
>  	return err;
>  }

[Severity: High]
This is a pre-existing issue, but does manually destroying the IRQ domains
here cause a Use-After-Free during teardown?

Child IRQs are requested via devm_request_irq() in amd_mdb_setup_irq(), mea=
ning
they will only be freed by devres after the probe function returns. When de=
vres
subsequently attempts to clean up those IRQs, won't it access the already f=
reed
domain's ops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817023932.1743=
100-1-sai.krishna.musham@amd.com?part=3D2
