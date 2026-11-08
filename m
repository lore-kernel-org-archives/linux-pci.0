Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141514;
	b=2uBFMobAQ36LjhGocjbyDBDv2tKzYgjZnOoqugrl7iPZzQ6rlGSULsYCItV17d6AT6c1
	 +hlF+d3iwcBiZGSGgA1H0o5yXAUar9rRjcmfm9B3FTuyMyM/LsnwbWnA61XVmIKwMKiWe
	 iOtGsdOly+judcV9RNKtJdRZzV5tFFDX0CHUKSiTVab3Ek63tP0fWZqoeo5YrY6d2dAuN
	 QmfzvKHs5oztDK1ur/xoSIp9OW96j7eU0JxAWG5yTtOnRa0D0KsGOFx53Iji+Qt2hgTDO
	 GQBmp1fUVxM3JwXKOBd34YcUcVtDnP5Vb4wQFdX72qybEA8rsK+1waZbX8uE77SprYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141514;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=SqIX2mCTTdvrGkHHwPQDrdPdPMbgYsDAz9BPYUkZpzI=;
	b=splPEEVfd+sQf2eeQd8d5ULCbMTFlZrdcJeMBixk6+afwlkfIJ/lQHMvjVs6F5KNszEf
	 I1Son37Xeqa/XYBgWQhmnB06g4f/NnolXEK2/+9bYcQvqMGChnoNE9RfIp25vhzEE6SD5
	 Ad5E4hYe4yr53zCT9YTJeB7Bom7mw9SEHoNTe5wyIwnHd3967APaYYngbp0MHRxtxmAZn
	 WpyiMn7pluwn7fgF0I5TsA5+aBS7pl0R3D0yShEhYJ62F0xkZPpPUPoqWve0krdttUAbC
	 1zi+oVrd4sF3rMvP40blK/d2rKFNDbJiCrZDiD1M4sic1kDNt//uuTVb36tQQJ9FWtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GA3Nz6Fd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF844606A31C;
	Sun,  8 Nov 2026 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GA3Nz6Fd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEA11F0089F;
	Sun,  8 Nov 2026 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794141513;
	bh=SqIX2mCTTdvrGkHHwPQDrdPdPMbgYsDAz9BPYUkZpzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GA3Nz6FdmkLoZEuOml4+tut+ZIxKGBV+EPLu+WQFsUO9NT8MikKE4bdk520qQE+qg
	 Q3doag/Yro9ATD+zOx8gqxiwuVZ7sFDuflHqQWxjLl/NYwE2gVCy0g2guOY8UMUk93
	 t+FNjo/CqCszsy6SRVeTEviamp1W6yfNWd75vadz3FneSXHMqWAgLoegktD/PSlTCI
	 esYj4FkV55XMxosq21lsDvh/3t6LGY+E4ysYkvAG4gzZ7gtsqGjK8lsVx3hbQRpJ9f
	 lAz337IUpVNFN1gstseBoJZpf2aYdPSdxRjyaD7++Qklf8DWv0EMvrXYxL2nWW/BbN
	 WOSZ18f0hTY/Q==
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
In-Reply-To: <87h5i3xael.ffs@fw13>
References: <CAFg7d9becn9_=ZzNwQ7bSBBNid28t_RnofL-Vb1cZVHVHxS9fw@mail.gmail.com>
 <20261013160612.GA1522005@bhelgaas>
 <CAFg7d9a2p2jtGyThS1M=2ZFDX0y5rpSK3H34ZuTz09R5r_ff0A@mail.gmail.com>
 <87h5i3xael.ffs@fw13>
Date: Sun, 08 Nov 2026 13:38:29 +0100
Message-ID: <87fqxbwla2.ffs@fw13>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 30 2026 at 20:20, Thomas Gleixner wrote:
> On Fri, Oct 30 2026 at 21:59, Han wrote:
>> On Thu, Oct 01 2026 at 21:29, Thomas Gleixner wrote:
>>   The buggy address is located 0 bytes to the right of
>>    allocated 48-byte region [ffff8000053a6880, ffff8000053a68b0)
>>
>> The report is caused by the patch. __msi_domain_alloc_irqs() passes
>> nvec_aligned (4) to __irq_domain_alloc_irqs() together with
>> desc->affinity, which has only nvec_used (3) entries. alloc_descs()
>> then reads all 4 entries. The fourth entry is read past the end of
>> the array. If the data there has no CPU set, the allocation fails
>> with -ENOSPC. Without PCI_IRQ_AFFINITY, desc->affinity is NULL, so
>> this read does not happen.
>
> Ah. I missed that detail. I'll look at it on Monday.

The updated patch below should handle that situation too.

Thanks,

        tglx
---
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -421,7 +421,7 @@ int devm_platform_get_irqs_affinity(stru
 		ptr->irq[i] = irq;
 	}
 
-	desc = irq_create_affinity_masks(nvec, affd);
+	desc = irq_create_affinity_masks(nvec, nvec, affd);
 	if (!desc) {
 		ret = -ENOMEM;
 		goto err_free_devres;
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -286,7 +286,7 @@ int pci_alloc_irq_vectors_affinity(struc
 			 * for the single interrupt case.
 			 */
 			if (affd)
-				irq_create_affinity_masks(1, affd);
+				irq_create_affinity_masks(1, 1, affd);
 			pci_intx(dev, 1);
 			return 1;
 		}
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -414,8 +414,14 @@ static int msi_capability_init(struct pc
 	 */
 	pci_msi_set_enable(dev, 0);
 
+	/*
+	 * Make sure a MULTI-MSI allocation is power of two even if the
+	 * requested number of vectors (@nvec) is not.
+	 */
+	unsigned int nvec_aligned = roundup_pow_of_two(nvec);
+
 	struct irq_affinity_desc *masks __free(kfree) =
-		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
+		affd ? irq_create_affinity_masks(nvec, nvec_aligned, affd) : NULL;
 
 	guard(msi_descs_lock)(&dev->dev);
 	return __msi_capability_init(dev, nvec, masks);
@@ -704,7 +710,7 @@ static int msix_setup_interrupts(struct
 				 int nvec, struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks __free(kfree) =
-		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
+		affd ? irq_create_affinity_masks(nvec, nvec, affd) : NULL;
 
 	guard(msi_descs_lock)(&dev->dev);
 	return __msix_setup_interrupts(dev, entries, nvec, masks);
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -370,7 +370,7 @@ extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
 struct irq_affinity_desc *
-irq_create_affinity_masks(unsigned int nvec, struct irq_affinity *affd);
+irq_create_affinity_masks(unsigned int nvec, unsigned int totvec, struct irq_affinity *affd);
 
 unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 				       const struct irq_affinity *affd);
@@ -425,7 +425,7 @@ irq_set_affinity_notifier(unsigned int i
 }
 
 static inline struct irq_affinity_desc *
-irq_create_affinity_masks(unsigned int nvec, struct irq_affinity *affd)
+irq_create_affinity_masks(unsigned int nvec, unsigned int totvec, struct irq_affinity *affd)
 {
 	return NULL;
 }
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -17,13 +17,17 @@ static void default_calc_sets(struct irq
 
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
- * @nvecs:	The total number of vectors
+ * @nvecs:	The number of active vectors for which affinity spreading is required
+ * @totvecs:	The total number of required descriptors to handle the over
+ *		allocation for PCI/MSI which requires power of two even if @nvec is
+ *		not power of two. The extra descriptors are filled with default
+ *		affinity and not relevant for the spreading calcuations.
  * @affd:	Description of the affinity requirements
  *
  * Returns the irq_affinity_desc pointer or NULL if allocation failed.
  */
 struct irq_affinity_desc *
-irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
+irq_create_affinity_masks(unsigned int nvecs, unsigned int totvecs, struct irq_affinity *affd)
 {
 	unsigned int affvecs, curvec, usedvecs, i;
 	struct irq_affinity_desc *masks = NULL;
@@ -56,7 +60,7 @@ irq_create_affinity_masks(unsigned int n
 	if (!affvecs)
 		return NULL;
 
-	masks = kzalloc_objs(*masks, nvecs);
+	masks = kzalloc_objs(*masks, totvecs);
 	if (!masks)
 		return NULL;
 
@@ -90,7 +94,7 @@ irq_create_affinity_masks(unsigned int n
 		curvec = affd->pre_vectors + affvecs;
 	else
 		curvec = affd->pre_vectors + usedvecs;
-	for (; curvec < nvecs; curvec++)
+	for (; curvec < totvecs; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
 	/* Mark the managed interrupts */
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1611,6 +1611,17 @@ static void irq_domain_free_irqs_hierarc
 	if (!domain->ops->free)
 		return;
 
+	/*
+	 * MSI device domains are capable of bulk free.
+	 *
+	 * CHECKME: Are all MSI parent domains capable?
+	 */
+	if (domain->flags & (IRQ_DOMAIN_FLAG_MSI_DEVICE | IRQ_DOMAIN_FLAG_MSI_PARENT)) {
+		if (irq_domain_get_irq_data(domain, irq_base))
+			domain->ops->free(domain, irq_base, nr_irqs);
+		return;
+	}
+
 	for (i = 0; i < nr_irqs; i++) {
 		if (irq_domain_get_irq_data(domain, irq_base + i))
 			domain->ops->free(domain, irq_base + i, 1);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1333,20 +1333,28 @@ static int __msi_domain_alloc_irqs(struc
 
 		ops->set_desc(&arg, desc);
 
-		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
+		/* Make sure a MULTI-MSI allocation is power of two */
+		unsigned int nvec_aligned = roundup_pow_of_two(desc->nvec_used);
+
+		virq = __irq_domain_alloc_irqs(domain, -1, nvec_aligned,
 					       dev_to_node(dev), &arg, false,
 					       desc->affinity);
 		if (virq < 0)
 			return msi_handle_pci_fail(domain, desc, allocated);
 
-		for (i = 0; i < desc->nvec_used; i++) {
+		for (i = 0; i < nvec_aligned; i++) {
 			irq_set_msi_desc_off(virq, i, desc);
 			irq_debugfs_copy_devname(virq + i, dev);
 			ret = msi_init_virq(domain, virq + i, vflags);
 			if (ret)
 				return ret;
 		}
+
 		if (info->flags & MSI_FLAG_DEV_SYSFS) {
+			/*
+			 * This only exposes desc->nvec_used and ignores the
+			 * overallocated MULTI-MSI ones.
+			 */
 			ret = msi_sysfs_populate_desc(dev, desc);
 			if (ret)
 				return ret;
@@ -1610,13 +1618,15 @@ static void __msi_domain_free_irqs(struc
 			continue;
 
 		/* Make sure all interrupts are deactivated */
-		for (i = 0; i < desc->nvec_used; i++) {
+		unsigned int nvec_aligned = roundup_pow_of_two(desc->nvec_used);
+
+		for (i = 0; i < nvec_aligned; i++) {
 			irqd = irq_domain_get_irq_data(domain, desc->irq + i);
 			if (irqd && irqd_is_activated(irqd))
 				irq_domain_deactivate_irq(irqd);
 		}
 
-		irq_domain_free_irqs(desc->irq, desc->nvec_used);
+		irq_domain_free_irqs(desc->irq, nvec_aligned);
 		if (info->flags & MSI_FLAG_DEV_SYSFS)
 			msi_sysfs_remove_desc(dev, desc);
 		desc->irq = 0;
