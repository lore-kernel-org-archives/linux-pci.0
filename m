Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD12C859;
	Wed,  6 May 2026 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094960; cv=none; b=YJ1J0LVGISfiz+lLNzqldkBhhVcHnY97S8XbxQruxaJocScEUAdHZKzXRE9+76ZyueXD6x+spM5A3JZKz4I+HeONWkXopSnoc11Xc8nyfWE6XgwHAFxnsa0WRPIhgJpTLKWrc8HWehSCfs6U1TUiz5uwdnojAQhhwHX7wfcQFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094960; c=relaxed/simple;
	bh=AbnO94ZVptIBKCpUctWPCDkOtrt7PDN76sGDctB+yZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gF3vCh9YmPKqKRyOqKQl41yWnhStOQm+U4HnTHgxoa3FQewBwn36MEnrHVlW7kSqRxzTdujlq/qgPXBFU8CIr1oRNEK3yPgaI/hidlr7uTtEcItPpWYkBTGI/uyXdI/Q47RiGQ6TLr+57nutAz4Dzvd9TmauFU7E4p3yKfMrOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHq0A0FP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHq0A0FP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2119EC2BCB0;
	Wed,  6 May 2026 19:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778094959;
	bh=AbnO94ZVptIBKCpUctWPCDkOtrt7PDN76sGDctB+yZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FHq0A0FPhnbISGGJ8Uc5YpPJx1WPzvJR2ZLswtrgUQIFeWtS5XKdGBW4z3rEuR/OE
	 EzprQ0ulaYpxGq82aXg7dg/Ib5gUevxVZvMtx+yDRwQoXMSIwufnaikViBRFT+3pTF
	 ft57HHJmW5FYF/K6+eXNULs6izDhwwhk38XgET2IpbCsFDdK029WTLcEOLZ3hmjsGY
	 DdB/dpiuWj+m9pzS5eV23nVjc8w9e86B/GJuOyLsCbwEjtheGzUqmGmVQH5iTMs4vK
	 /oDzN98bDMJc5y1yDAIQ350Ag1Iw3zprpLRu/J6e3GYqcP3xTvMjfI8EyCq0tHQBtj
	 Zlh+VuvJxeTXg==
From: Thomas Gleixner <tglx@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Stefan Roese
 <stefan.roese@mailbox.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 roxmail@list.ru, Linux kernel regressions list
 <regressions@lists.linux.dev>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Regression fyi: pci usb3 card in 32bit P4 s478 stopped working
In-Reply-To: <87df54eb-c527-4f1a-a3a7-67afbd73cb47@leemhuis.info>
References: <87df54eb-c527-4f1a-a3a7-67afbd73cb47@leemhuis.info>
Date: Wed, 06 May 2026 21:15:55 +0200
Message-ID: <87o6iswdqs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 24 2026 at 12:51, Thorsten Leemhuis wrote:
> Hi Stefan! It seems the change 83dbf898a2d452 ("PCI/MSI: Mask MSI-X
> vectors only on success") [v5.16-rc6, v5.15.11, v5.10.88] you submitted
> years ago (committed and mainlined by Thomas) causes a regression:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=221028
>
> To quote:
>
> """
> I have a system (32bit P4 s478) with pci usb3 controller card, it is
> based on uPD720200 with (PI7C9X111SL PCIe-to-PCI Reversible Bridge).
>
> since commit 83dbf898a2d45289be875deb580e93050ba67529 PCI/MSI: Mask
> MSI-X vectors only on success
>
> card stops to work (this commit was backported to lts kernels since
> 5.10.88).
>
> manual reverting from master (test patch attached) makes a card working.
> """
>
> Might be a very special case, nevertheless wanted to let you know about it.

Seems to be a special case and I don't have access to this Marvell NVME
device to validate that a potential fix might work.

But looking at the context when this commit was merged and the
information in the thread discussing the whole issue then this was
required because the PCI/MSI code back then did not check upfront
whether MSIX is supported by the underlying PCI interrupt domain.

Since 6.2 (roughly a year after the above commit) this changed so that
the code in question can't be reached anymore when the underlying
interrupt domain does not support MSI-X, which in turn makes this hack
moot.

That means we can revert to the original behavior on kernels >= 6.2,
which still leaves us with the gap of 5.10, 5.15, 6.1 LTS kernels.

That makes me realize in hindsight that we should have created a quirk
for that broken Marvell NVME device instead of playing games with the
specification. Even if that spcificiation is not worth the paper it is
written on as demonstrated by that Marvell device which has been
rubberstamped as fully compliant. Oh well...

The more I think about it, the more I tend to revert that commit all the
way back to 5.10 and wait for people to complain about that broken
Marvell device again. If they show up, we fix it properly with a quirk
even if it's a major nuisance.

Roman, can you confirm that the patch below makes your setup work again
on 6.18+ kernels?

Thanks,

        tglx
---
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -656,11 +656,15 @@ static void msix_update_entries(struct p
 	}
 }
 
-static void msix_mask_all(void __iomem *base, int tsize)
+static void msix_mask_all(struct device *dev, int tsize)
 {
 	u32 ctrl = PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	void __iomem *base = dev->msix_base;
 	int i;
 
+	if (pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY))
+		return;
+
 	for (i = 0; i < tsize; i++, base += PCI_MSIX_ENTRY_SIZE)
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
@@ -724,7 +728,6 @@ static int msix_capability_init(struct p
 	 */
 	pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
 				    PCI_MSIX_FLAGS_ENABLE);
-
 	/* Mark it enabled so setup functions can query it */
 	dev->msix_enabled = 1;
 
@@ -737,6 +740,12 @@ static int msix_capability_init(struct p
 		goto out_disable;
 	}
 
+	/*
+	 * Ensure that all table entries are masked to prevent stale entries
+	 * from firing in a crash kernel.
+	 */
+	msix_mask_all(dev, tsize);
+
 	ret = msix_setup_interrupts(dev, entries, nvec, affd);
 	if (ret)
 		goto out_unmap;
@@ -744,17 +753,6 @@ static int msix_capability_init(struct p
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
 
-	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY)) {
-		/*
-		 * Ensure that all table entries are masked to prevent
-		 * stale entries from firing in a crash kernel.
-		 *
-		 * Done late to deal with a broken Marvell NVME device
-		 * which takes the MSI-X mask bits into account even
-		 * when MSI-X is disabled, which prevents MSI delivery.
-		 */
-		msix_mask_all(dev->msix_base, tsize);
-	}
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	pcibios_free_irq(dev);





