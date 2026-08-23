Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF09018A93F;
	Sun, 23 Aug 2026 04:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787458876; cv=none; b=hHQAKd9qWw+fsaOuGeN2M4fNkd6DqF01TItpMTMNR4EOMOanPPeVR+QCb0m0V11nHddEU1lK/ivnpB6qDkNkoe6k6SaExid0PsaqsogUyYbOInI2fgdQUT5JJhFTuD8WSw3r0aVjQFuSItjauplFNqMoYSKV+YpruOVklOS6+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787458876; c=relaxed/simple;
	bh=6Uj3LV3Gilf572ZZK65PCvmv760bN2FTyCt96zenQGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h1N07W5mG4iwrqSR5d5uqDyETepEqEJbewwRkTw5m0UOwblM/25KD+/BB/whbR20nxYDNsW28NtGtxnBllf6PGNFADe4lVvlc14Am5C3hLMWLrsCTxDOO1mMo6fXoL4pjqxmbtkedgKKDIYI+K/ewtwyZp1NOCMmDwDIumBYJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp1cGxhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp1cGxhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BC81F000E9;
	Sun, 23 Aug 2026 04:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787458874;
	bh=mucUJrqBP9mxXEIz0YU5NBH0jb0zo/XjQQK82TYJGes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xp1cGxhgPGudAPW4OvyQ5zPtPtxSCoZNqd3f+u20VRIhz2aPxQgFdd8JRWTo4+ISo
	 brUxZh31AoMAbC3aJNfOtqMDHeUyh1M+gJj0+IcQqByQeaoP9v0PmuaSSaU0kK/gz+
	 AqZlTvG+/ifKk9nGxYmBFlCJBuxETKqsqowViHSKWjPxkemDGv/7/F2ah952Kj/mxZ
	 MGcvReFZnqfX5KzyNDqykcDi5SBqS1AwUdiNndQEbxpgAr4klqlTTgXl6A8Nnhknrk
	 M1U5j5JIymfostNN3eelaNuYtATvsB0mbMVvpk0pQf/ydXG7gDK6UamM7hO80/e19u
	 LYHqWEMrZ9h2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] PCI: amd-mdb: Add CPM6 host controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260823040715.204096-3-sai.krishna.musham@amd.com>
References: <20260823040715.204096-1-sai.krishna.musham@amd.com>
 <20260823040715.204096-3-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 04:21:13 +0000
Message-Id: <20260823042114.13BC81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Blindly clearing the shared `PS_MISC` severity register in a share=
d interrupt handler creates a race condition that can permanently drop the =
peer controller's interrupts.
- [High] The interrupt handler checks the raw status (`ev_raw`) instead of =
the masked status (`val`) for pending interrupts, breaking spurious IRQ det=
ection and inappropriately clearing masked bits.
- [High] The driver fails to mask unhandled interrupt sources and leaves th=
e sticky aggregator uncleared on boot, leading to an unrecoverable interrup=
t storm on CPM6.

Pre-existing issues:
- [High] On MDB5, INT B, C, and D interrupts are enabled in hardware but no=
t mapped to the Linux IRQ domain, causing them to be silently dropped.
--

--- Patch [2]: [PATCH v7 2/2] PCI: amd-mdb: Add CPM6 host controller suppor=
t ---
commit 23a947213bc9887ee94f4ea8b025fb7bc8ad21bd
Author: Sai Krishna Musham <sai.krishna.musham@amd.com>

PCI: amd-mdb: Add CPM6 host controller support

This patch adds support for AMD Versal2 CPM6 host controllers. It adapts
the driver to handle the differing interrupt register layout of CPM6 and
manages the shared event interrupt line.

Link: https://lore.kernel.org/all/20260819172057.3636214-3-sai.krishna.mush=
am@amd.com/

> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/cont=
roller/dwc/pcie-amd-mdb.c
> --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c

[ ... ]

> +static void amd_mdb_pcie_clear_aggregators(struct amd_mdb_pcie *pcie)
> +{
> +	if (pcie->variant->version =3D=3D MDB5)
> +		return;
> +
> +	/* Clear this host's serviced MISC_EVENT contribution from MERGED. */
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

[Severity: High]
Does clearing this shared register unconditionally create a race condition
that drops interrupts for the peer controller?

If Host 1's interrupt arrives and sets its MERGED_STATUS bit just before
Host 0's interrupt handler executes this W1C write to the shared=20
AMD_CPM6_PS_MISC_IR_STATUS register, the aggregator is cleared while Host 1=
's
event is still pending. Because the aggregator does not re-assert for
already-latched MERGED bits or loses the edge, does this mean the GIC line
drops and Host 1's interrupt is permanently lost?

[ ... ]

>  static irqreturn_t amd_mdb_pcie_event(int irq, void *args)
>  {
>  	struct amd_mdb_pcie *pcie =3D args;
>  	unsigned long val;
> +	u32 ev_raw;
>  	int i;
> =20
> -	val =3D readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> -	val &=3D ~readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_MASK_MISC);
> +	ev_raw =3D readl_relaxed(pcie->intr_base + pcie->variant->misc_status_r=
eg);
> +	val =3D ev_raw;
> +	val &=3D ~readl_relaxed(pcie->intr_base + pcie->variant->misc_mask_reg);

[ ... ]

> +	val &=3D pcie->variant->misc_mask_all;
> +
> +	/*
> +	 * The misc GIC line is shared with the peer host controller. If this
> +	 * host has nothing pending, report the interrupt as not ours so the
> +	 * shared line's spurious detection keeps working and the peer's sticky
> +	 * aggregator state is left untouched.
> +	 */
> +	if (!ev_raw)
> +		return IRQ_NONE;

[Severity: High]
Should this check use the masked status (val) rather than the raw status
(ev_raw) to determine if the interrupt was spurious?

If this controller has a masked status bit active (such as an AER error left
to native AER), ev_raw will be non-zero even when the peer controller asser=
ted
the shared GIC line. The check if (!ev_raw) will pass, proceeding to falsely
return IRQ_HANDLED while unconditionally clearing the masked status bit and
the shared aggregator. Could this break AER error reporting?

[ ... ]

> -static void amd_mdb_pcie_free_irq_domains(struct amd_mdb_pcie *pcie)
> +static void amd_mdb_pcie_disable_interrupts(struct amd_mdb_pcie *pcie)
>  {
> +	u32 misc_mask_all =3D pcie->variant->misc_mask_all;
> +	u32 val;
> +
> +	/* Mask all leaf TLP interrupts. */
> +	writel_relaxed(misc_mask_all,
> +		       pcie->intr_base + pcie->variant->misc_disable_reg);

[Severity: High]
Does this sequence leave unhandled interrupt sources unmasked and the sticky
aggregator uncleared?

For CPM6, misc_mask_all only includes the INTx bit, which leaves other
interrupt sources like PCIe errors unmasked. It also fails to clear the
sticky MERGED_STATUS aggregator.=20

When amd_mdb_pcie_init_port() is called later and enables the shared
aggregator via AMD_CPM6_MERGED_ENABLE, any pending unhandled leaf interrupts
or stale aggregator state will immediately assert the GIC line. If the
handler then returns IRQ_NONE or clears the leaf without resolving the
underlying error, will this cause an unrecoverable interrupt storm on boot?

[ ... ]

>  static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
>  			     struct platform_device *pdev)
>  {
>  	struct dw_pcie *pci =3D &pcie->pci;
>  	struct dw_pcie_rp *pp =3D &pci->pp;
>  	struct device *dev =3D &pdev->dev;
> +	unsigned long event_flags =3D IRQF_NO_THREAD;
>  	int i, irq, err;

[ ... ]

>  	pcie->intx_irq =3D irq_create_mapping(pcie->mdb_domain,
> -					    AMD_MDB_PCIE_INTR_INTX);
> +				    pcie->variant->intx_hwirq);

[Severity: High]
This isn't a bug introduced by this patch, but are the INT B, C, and D
interrupts missing from the IRQ domain mapping on MDB5?

In amd_mdb_setup_irq(), only the intx_hwirq (which corresponds to INT A,
bit 16 on MDB5) is mapped into the mdb_domain. However, the hardware is
configured to unmask all four INTx sources (bits 16, 18, 20, 22) in
amd_mdb_intx_irq_unmask().=20

When INT B, C, or D fire, amd_mdb_pcie_event() will call
generic_handle_domain_irq() for an unmapped hwirq, which returns -EINVAL.
Does this mean legacy PCI devices using INT B, C, or D behind the MDB5
controller will have their interrupts silently dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823040715.2040=
96-1-sai.krishna.musham@amd.com?part=3D2
