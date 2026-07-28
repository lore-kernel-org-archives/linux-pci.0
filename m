Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C03BED42;
	Tue, 28 Jul 2026 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270819; cv=none; b=iWC1oVeQTrx9xZ8bgoh+GJ0MYtcxpFTVM+jIE6nNHgm2HEa5U2bOsM9Kfbzllc0wL7oHbeawcy75N0mYso7wqSVWdPIxfYjMMI8L8P2WQGApwEHvNVXhRrU2L3nFCXIhFkSfO+1DZ7R8dmQt6svtGsCTww7fWS7sN2/JTAusecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270819; c=relaxed/simple;
	bh=RinCKNCOIo43TtNwquVwBwNI5I1yCL0v6ly3U43rio4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u0tg9KujG8LzgYj34zPJ3oL8Hf330xhTZTVPtJNEzeCp7sOBVOcvPGxuvtqsD/ko6bKFGg8NPlAXb5u+Zu9qRSSt2UVdfv0pvhi/UPIXPw41eyeiQ81zHD6grFaI0f3Zpy8cZorU2EV6tHojg652wdlFlOwcEbFhkSpLTw5wgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuQi07mY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuQi07mY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA661F000E9;
	Tue, 28 Jul 2026 20:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785270817;
	bh=bti3Gy3z1GdZOLNQIsrx1kQOqVeXHsgN+hWD2GSD9MY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KuQi07mYdWQCpMsJFMAUrnHEngCcimd6HJ3j4Kw+jICNvbj3JwVinRnieblIGL0XZ
	 WLkiKKGFYSCt5jltCW8hirNH6PNqW8fc2ZNgy9BMjtiwIeeaKF5j95gi4hlIzcapXg
	 Dypu1VLdTjuyFjpqEO3Rjyrx5xfsC3A4CMFKvwU9GxnXpQuEO+0We+sj48oEnq+yKq
	 aVw1Z7mQunUHtilQ0MTEv7G7Q+X0RjqD+TS8pdzyE3Su6wD3kJSM9yu9ybIksYGq12
	 WVBb+0FBIUoiE8SCC30Fqo/21O8KSRbpQa1pkyWJVCyBoZ/uVYyHNILEnBoC2QNf67
	 CF5SLcXhaS0mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] pci: AMD: Add CPM6 host controller support to
 AMD MDB PCIe driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260728202044.1785986-3-sai.krishna.musham@amd.com>
References: <20260728202044.1785986-1-sai.krishna.musham@amd.com>
 <20260728202044.1785986-3-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 20:33:36 +0000
Message-Id: <20260728203337.7EA661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] Double-free and Use-After-Free of devm-managed interrupts on probe=
 failure.
- [High] Masking a single virtual INTx line on CPM6 unconditionally disable=
s the aggregate hardware INTx interrupt, breaking other devices.
- [High] Unhandled bits in `AMD_CPM6_PCIE_ERR_STATUS` are never cleared, le=
ading to an unrecoverable infinite IRQ storm.
- [High] Exclusive ioremap of the shared `slcr` region will cause the secon=
d CPM6 host controller to fail probing.
- [High] Uncoordinated W1C clearing of the shared sticky aggregator bit cau=
ses lost interrupts for the other host.

Pre-existing issues:
- [High] INTxB, INTxC, and INTxD interrupts on MDB5 are silently dropped be=
cause their hardware IRQs are never mapped.
- [High] Use-After-Free of irq_domain triggered by concurrent hardware inte=
rrupt during probe error path.
- [High] Clearing sticky W1C status registers at the end of the interrupt h=
andler creates a race condition that loses concurrent edges.
--

--- Patch [2]: [PATCH v2 2/2] pci: AMD: Add CPM6 host controller support to=
 AMD MDB PCIe driver ---
commit 72da33718ab9f6a5d8466cccef118aefc6c26f76
Author: Sai Krishna Musham <sai.krishna.musham@amd.com>
Subject: pci: AMD: Add CPM6 host controller support to AMD MDB PCIe driver

This patch extends the AMD MDB PCIe driver to support AMD Versal2 CPM6
variants. It adds variant-specific register layouts and implements a shared
aggregator clearing mechanism for the new interrupt architecture.

Link: https://lore.kernel.org/all/20260402180006.486229-3-sai.krishna.musha=
m@amd.com/

> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/cont=
roller/dwc/pcie-amd-mdb.c
> index dee295f281a30..dbf36ce9902c8 100644
> --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
[ ... ]
> @@ -148,42 +287,34 @@ static void amd_mdb_pcie_clear_aggregators(struct a=
md_mdb_pcie *pcie)
>  	writel_relaxed(merged_mask, pcie->slcr + AMD_CPM6_MERGED_STATUS);
> =20
>  	/*
>  	 * Clear MERGED in the PS_MISC severity register so the misc GIC line
>  	 * de-asserts.
>  	 */
>  	writel_relaxed(AMD_CPM6_PS_IR_MERGED,
>  		       pcie->slcr + AMD_CPM6_PS_MISC_IR_STATUS);
>  }

[Severity: High]
Does blindly clearing the shared sticky aggregator bit drop concurrent
interrupts from the other host controller?

The commit mentions this aggregator is shared between controllers. If Host 0
clears this W1C bit while Host 1 has a pending unserviced interrupt in the
MERGED register, Host 1's edge might be swallowed and never serviced.

Does this need coordinated locking to ensure it is only cleared when no
other hosts have pending interrupts?

[ ... ]
> @@ -213,11 +237,15 @@ static void amd_mdb_intx_irq_mask(struct irq_data *=
data)
>  	if (pcie->variant->version =3D=3D MDB5)
>  		val =3D FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
>  				 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
>  	else
>  		val =3D pcie->variant->intx_mask;
> =20
>  	/*
>  	 * Writing '1' to a bit in AMD_MDB_TLP_IR_DISABLE_MISC disables that
>  	 * interrupt, writing '0' has no effect.
>  	 */
> -	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
> +	writel_relaxed(val, pcie->intr_base + pcie->variant->misc_disable_reg);

[Severity: High]
Will masking a single virtual INTx line on CPM6 unconditionally disable the
aggregate hardware INTx interrupt?

On CPM6, there appears to be only a single aggregate INTx hardware interrupt
bit. If an endpoint driver unbinds or calls disable_irq() on INTA, this
unconditionally writes the intx_mask bit to the disable register.

Does this disable the hardware aggregate interrupt completely, potentially
starving other endpoint devices relying on INTB, INTC, or INTD?

[ ... ]
> @@ -354,16 +375,19 @@ static irqreturn_t amd_mdb_pcie_event(int irq, void=
 *args)
>  	ev_raw =3D readl_relaxed(pcie->intr_base + pcie->variant->misc_status_r=
eg);
>  	val =3D ev_raw;
>  	val &=3D ~readl_relaxed(pcie->intr_base + pcie->variant->misc_mask_reg);
> =20
>  	if (pcie->variant->version =3D=3D MDB5) {
>  		for_each_set_bit(i, &val, 32)
>  			generic_handle_domain_irq(pcie->mdb_domain, i);

[Severity: High]
This is a pre-existing issue, but are INTxB, INTxC, and INTxD interrupts
silently dropped on MDB5?

When an INTx occurs, amd_mdb_pcie_event() extracts the asserted bit and
calls generic_handle_domain_irq(). However, amd_mdb_setup_irq() only
creates a mapping for the single intx_hwirq (INTxA).

Bits corresponding to INTxB, INTxC, and INTxD are never mapped, so
generic_handle_domain_irq() will return -EINVAL and the interrupts will be
lost.

>  		writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_reg);
>  		return IRQ_HANDLED;
>  	}
> =20
>  	val &=3D pcie->variant->misc_mask_all;
> =20
>  	for_each_set_bit(i, &val, 32)
>  		generic_handle_domain_irq(pcie->mdb_domain, i);
> =20
>  	/* Clear handled + any unhandled sticky bits to avoid IRQ storms. */
> -	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> +	writel_relaxed(ev_raw, pcie->intr_base + pcie->variant->misc_status_reg=
);

[Severity: High]
This isn't a bug introduced by this patch, but does clearing the sticky W1C
status register at the end of the interrupt handler create a race condition?

If a second edge of the same interrupt type occurs during the handling
phase, writing ev_raw back to the W1C register at the very end will clear
the new edge without it ever being processed.

Should the status register be ACKed before handling the events so that new
edges can latch correctly?

> +	/* On CPM6 the completion timeout is reported via the PCIE_ERR register=
. */
> +	err =3D readl_relaxed(pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
> +	err &=3D ~readl_relaxed(pcie->intr_base + AMD_CPM6_PCIE_ERR_MASK);
> +	err &=3D AMD_CPM6_PCIE_ERR_MASK_ALL;
> +	if (err) {
> +		dev_warn(pcie->pci.dev, "Completion timeout\n");
> +		writel_relaxed(err, pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
> +	}

[Severity: High]
Are unhandled bits in the PCIE_ERR_STATUS register masked out and never
cleared?

The driver masks the read value with AMD_CPM6_PCIE_ERR_MASK_ALL and only
writes back the known bits to the W1C register. If any unhandled bit is
set, it remains uncleared.

Since this register feeds into the sticky MERGED aggregator, will this cause
the hardware to immediately re-assert the main parent interrupt and create
an unrecoverable IRQ storm?

[ ... ]
> @@ -400,10 +421,30 @@ static void amd_mdb_pcie_free_irq_domains(struct am=
d_mdb_pcie *pcie)
> +		const struct amd_mdb_intr_cause *intr_cause =3D
> +			pcie->variant->version =3D=3D MDB5 ?
> +			mdb5_intr_cause : cpm6_intr_cause;
> +		int i, irq;
> +
> +		for (i =3D 0; i < ARRAY_SIZE(mdb5_intr_cause); i++) {
> +			if (!intr_cause[i].str)
> +				continue;
> +			irq =3D irq_find_mapping(pcie->mdb_domain, i);
> +			if (irq) {
> +				disable_irq(irq);
> +				free_irq(irq, pcie);
> +				irq_dispose_mapping(irq);
> +			}
> +		}

[Severity: High]
Is it safe to manually call free_irq() on an interrupt allocated with
devm_request_irq()?

In amd_mdb_setup_irq(), these interrupts are allocated under devres
management. On probe failure, this error path manually frees them. When the
driver unbinds, devres will attempt to free the same IRQs again.

Can this cause a double-free on a disposed virtual IRQ mapping?

[ ... ]
>  		irq_domain_remove(pcie->mdb_domain);
>  		pcie->mdb_domain =3D NULL;

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free of the
irq_domain if a hardware interrupt arrives concurrently?

The error path destroys and frees pcie->mdb_domain, but fails to disable
the main event interrupt first. If an interrupt fires concurrently,
amd_mdb_pcie_event() might dereference the freed domain pointer to dispatch
child interrupts.

[ ... ]
> @@ -639,12 +660,26 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pci=
e *pcie,
>  	pcie->slcr =3D devm_platform_ioremap_resource_byname(pdev, "slcr");
>  	if (IS_ERR(pcie->slcr))
>  		return PTR_ERR(pcie->slcr);

[Severity: High]
Will an exclusive ioremap of the shared slcr region cause the second CPM6
host controller to fail probing?

The commit message notes the aggregation layer is shared between the two
controllers. Requesting exclusive access to the memory region here means the
first device claims it, and the second device might fail to probe with a
resource conflict.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728202044.1785=
986-1-sai.krishna.musham@amd.com?part=3D2
