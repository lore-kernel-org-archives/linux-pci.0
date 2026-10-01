Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5A36A03F;
	Thu,  1 Oct 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790882972; cv=none; b=cWlHUfeX81DICTGcgeVtdHT3Sr5GuC0WhtdQMcyeLP+Tu4FEvSvCkKIA8FUmghR3PG6kTdm95P/aBO9a85N/Bpc+gkquT0dyNg7whkhgbOi22S4yqINVFOq8Tsbt02xYamzoJCS7s5mmt5mxJsrPEG8b4auUmVxqlPZpkF7j3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790882972; c=relaxed/simple;
	bh=guOW+/08gRNSqfTaEYCyx+gyJOlrtAaIaRO6zclFIGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VxKG7qqskOyAxEA0Ueqwwko2dQ1qpMAY94zJdcb/9s2mAvxhVFE7nlg1xFGtQvlVrddgdiUlZYKghV7djnOMJTEGCzpLFfYIsXY5bLoQXfEYrmaB2SzBLsbBge0BevYUBPq/rlPAhmGn5ve1Rru/Sj+TYmdywYpqmf44F7tKeDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etqvOpLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etqvOpLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4451F000FF;
	Thu,  1 Oct 2026 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790882970;
	bh=0sWDayJOkxAeOGqqB0NIGD2EYTzPiQHVomT9o9M6NJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=etqvOpLPcimxHlPPMuhIKLv01U67MpgFnDZ8Y3ieFvsD8dguldGMoBRIjHNML1ell
	 /8euWeMtkYpB9iJGTyOwz8+RAkiDppmh9yWUQcFOI2sOjC3e2WNyBqlsIxfRf8zDnt
	 R/J0upFjOe+7FopiiAKnmP6Cbuu6z80pGh+Pc8DNd6Yi2ahDp7+uD5qo//nb7UJCMf
	 ioWsMQhp3n/Nu/IoWKDMUDgt2IhQ3TSO+dhOgYSafmwCNScW6lgts5VXrMnxktHs1A
	 yx/jLmuL2oWfB87JG/PEpa2blPrsHTwr/DwrAV4ZReaq3ryymkqKAduTRudHXmry60
	 7sXWdTzVZzCcw==
From: Thomas Gleixner <tglx@kernel.org>
To: Han / =?utf-8?B?7ZWc7IOB7JqwU2FuZ3dvbw==?= <sangwoo.han@nearthlab.com>,
 Bjorn Helgaas
 <helgaas@kernel.org>
Cc: jim2101024@gmail.com, florian.fainelli@broadcom.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 bhelgaas@google.com, bcm-kernel-feedback-list@broadcom.com,
 robh@kernel.org, linux-pci@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Inochi
 Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
In-Reply-To: <CAFg7d9bJJjR7JEMXanttGVcGisa4x3uLYPR43Te4+JKMzHBkfQ@mail.gmail.com>
References: <87cxuo3fl9.ffs@fw13> <20260916231029.GA988000@bhelgaas>
 <CAFg7d9bJJjR7JEMXanttGVcGisa4x3uLYPR43Te4+JKMzHBkfQ@mail.gmail.com>
Date: Thu, 01 Oct 2026 21:29:27 +0200
Message-ID: <871pa9gqy0.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21 2026 at 18:05, Han / =ED=95=9C=EC=83=81=EC=9A=B0Sangwoo wrot=
e:
> I tested Thomas's patch on the same hardware setup with the 5-vector
> MSI endpoint. The patch was applied as posted on top of 6.12.93
> (rpi-6.12.y).
>
> With the patch applied:
>
> - The MSI base hwirq remained at 0x8 across 200 driver reload cycles.
> - The driver got all 5 requested vectors on every cycle, with no
> single-MSI fallback. Multiple Message Enable remained at 8.
> - The brcmstb inner-domain mapping returned to baseline after each
> unload/reload, with 12 mapped while the driver was loaded and 4 after
> unload.
> - A kprobe showed one allocation of 8 vectors followed by eight
> single-vector frees, with nothing left over.

8 single vector frees?

Seems I got something wrong there verus the bulk free. Updated patch
below.

> The MSI vector exhaustion issue I originally observed no longer
> reproduces with the patch.

Good. Can you please retest with the updated patch?

> I also observed a KASAN report with managed affinity. Using a small
> out-of-tree test module bound to the same endpoint and requesting 1..3
> vectors with PCI_IRQ_MSI | PCI_IRQ_AFFINITY, a request for 3 vectors
> resulted in:
>
> BUG: KASAN: slab-out-of-bounds in __irq_alloc_descs+0x158/0x460
>
> Requests for 5 and 7 vectors were capped to 4 on this 4-CPU system and
> did not trigger the report. I have not checked this against the
> unpatched kernel yet, so I cannot tell whether it is related to the
> patch.

Any updates on that? Also please provide the source for that test.

Thanks,

        tglx
---
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1610,6 +1610,17 @@ static void irq_domain_free_irqs_hierarc
 	if (!domain->ops->free)
 		return;
=20
+	/*
+	 * MSI device domains are capable of bulk free.
+	 *
+	 * CHECKME: Are all MSI parent domains capable?
+	 */
+	if (domain->flags & (IRQ_DOMAIN_FLAG_MSI_DEVICE | IRQ_DOMAIN_FLAG_MSI_PAR=
ENT)) {
+		if (irq_domain_get_irq_data(domain, irq_base))
+			domain->ops->free(domain, irq_base, nr_irqs);
+		return;
+	}
+
 	for (i =3D 0; i < nr_irqs; i++) {
 		if (irq_domain_get_irq_data(domain, irq_base + i))
 			domain->ops->free(domain, irq_base + i, 1);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1333,20 +1333,28 @@ static int __msi_domain_alloc_irqs(struc
=20
 		ops->set_desc(&arg, desc);
=20
-		virq =3D __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
+		/* Make sure a MULTI-MSI allocation is power of two */
+		unsigned int nvec_aligned =3D roundup_pow_of_two(desc->nvec_used);
+
+		virq =3D __irq_domain_alloc_irqs(domain, -1, nvec_aligned,
 					       dev_to_node(dev), &arg, false,
 					       desc->affinity);
 		if (virq < 0)
 			return msi_handle_pci_fail(domain, desc, allocated);
=20
-		for (i =3D 0; i < desc->nvec_used; i++) {
+		for (i =3D 0; i < nvec_aligned; i++) {
 			irq_set_msi_desc_off(virq, i, desc);
 			irq_debugfs_copy_devname(virq + i, dev);
 			ret =3D msi_init_virq(domain, virq + i, vflags);
 			if (ret)
 				return ret;
 		}
+
 		if (info->flags & MSI_FLAG_DEV_SYSFS) {
+			/*
+			 * This only exposes desc->nvec_used and ignores the
+			 * overallocated MULTI-MSI ones.
+			 */
 			ret =3D msi_sysfs_populate_desc(dev, desc);
 			if (ret)
 				return ret;
@@ -1610,13 +1618,15 @@ static void __msi_domain_free_irqs(struc
 			continue;
=20
 		/* Make sure all interrupts are deactivated */
-		for (i =3D 0; i < desc->nvec_used; i++) {
+		unsigned int nvec_aligned =3D roundup_pow_of_two(desc->nvec_used);
+
+		for (i =3D 0; i < nvec_aligned; i++) {
 			irqd =3D irq_domain_get_irq_data(domain, desc->irq + i);
 			if (irqd && irqd_is_activated(irqd))
 				irq_domain_deactivate_irq(irqd);
 		}
=20
-		irq_domain_free_irqs(desc->irq, desc->nvec_used);
+		irq_domain_free_irqs(desc->irq, nvec_aligned);
 		if (info->flags & MSI_FLAG_DEV_SYSFS)
 			msi_sysfs_remove_desc(dev, desc);
 		desc->irq =3D 0;
