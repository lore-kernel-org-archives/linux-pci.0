Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507F30DEAC;
	Wed,  6 May 2026 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095194; cv=none; b=qKmRsbyu3zET5ZVuwofHXY7XfZn9V1fy5wJCcFus544S/zRA96Nm7rqsoA/h602upBlKw9oYVGe6NZeQ5F52wkYfpss1dHYJAmloOuZobf3eJ652VJm8SLzQTPFW90guq93XmVm841O+NAzFtKIhrO6kc+xq89u8OLl29x0dZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095194; c=relaxed/simple;
	bh=Z4GI0KWcW7yWvDHyuLmOHZwjY6bMRUGR3X8Y519YmG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RnDw1MD9ayvPf5PmR1/N1i3Kv4BMmCEmryZ0v/jIxFjWupwmQjQS4vLEgHSqaB+KuSMlmgcDgk1BSy3dSAloOYowRbCa4p6ElRPaRjjWrpwSemKPmJz8eAr7VTqBg3zEaBxd/IpBaXemQqMAFSXxlCUO7LUdhdlUAh8ds7XBQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT0n2bji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT0n2bji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4B1C2BCB0;
	Wed,  6 May 2026 19:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778095193;
	bh=Z4GI0KWcW7yWvDHyuLmOHZwjY6bMRUGR3X8Y519YmG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aT0n2bjiqcpn8fHKqAZt8l+apcufJRB+xQp0YJiQUphuOc3KbVvi3UqHbLYswb26R
	 CfEE8gZYyQrX49JjxP8TwOGl15sKmqDhYXEiOgbNckVoniL9pH0TgOQkqMZKw37BKy
	 OUYILhbmCd8DTIRX809UMdmDAvYbF2lP12KHL+IYNBUSMe7f3kKl9PGTmVEQFwNoPX
	 8DL8lJPcwsTFtB70rFEF21us5CAK63gbmB3dmfwOpgKk2hu+1X6MBwAoZQS7bCuNAS
	 zTU6u7D32od/nW4tm+wQZ+WhGPj+Sfb2fwGSIdTq5/XxwcuUVb1R7qpKTqbJARWrJG
	 cQLztV+Gk7lYQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Stefan Roese
 <stefan.roese@mailbox.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 roxmail@list.ru, Linux kernel regressions list
 <regressions@lists.linux.dev>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Regression fyi: pci usb3 card in 32bit P4 s478 stopped working
In-Reply-To: <87o6iswdqs.ffs@tglx>
References: <87df54eb-c527-4f1a-a3a7-67afbd73cb47@leemhuis.info>
 <87o6iswdqs.ffs@tglx>
Date: Wed, 06 May 2026 21:19:49 +0200
Message-ID: <87lddwwdka.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 06 2026 at 21:15, Thomas Gleixner wrote:
> Seems to be a special case and I don't have access to this Marvell NVME
> device to validate that a potential fix might work.
>
> But looking at the context when this commit was merged and the
> information in the thread discussing the whole issue then this was
> required because the PCI/MSI code back then did not check upfront
> whether MSIX is supported by the underlying PCI interrupt domain.
>
> Since 6.2 (roughly a year after the above commit) this changed so that
> the code in question can't be reached anymore when the underlying
> interrupt domain does not support MSI-X, which in turn makes this hack
> moot.
>
> That means we can revert to the original behavior on kernels >= 6.2,
> which still leaves us with the gap of 5.10, 5.15, 6.1 LTS kernels.
>
> That makes me realize in hindsight that we should have created a quirk
> for that broken Marvell NVME device instead of playing games with the
> specification. Even if that spcificiation is not worth the paper it is
> written on as demonstrated by that Marvell device which has been
> rubberstamped as fully compliant. Oh well...
>
> The more I think about it, the more I tend to revert that commit all the
> way back to 5.10 and wait for people to complain about that broken
> Marvell device again. If they show up, we fix it properly with a quirk
> even if it's a major nuisance.
>
> Roman, can you confirm that the patch below makes your setup work again
> on 6.18+ kernels?

Duh! Inserted the non-compiling version and then hit send before
noticing... Proper patch below.

Thanks,

        tglx
---
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -656,11 +656,15 @@ static void msix_update_entries(struct p
 	}
 }
 
-static void msix_mask_all(void __iomem *base, int tsize)
+static void msix_mask_all(struct pci_dev *dev, int tsize)
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
