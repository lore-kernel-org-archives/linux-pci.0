Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F1030FC33
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793870; cv=none; b=ExLljiwjUUEAQEjbBTd+QLGlaY4f0K31WfIlK4Q6zK2vMtU6Wjr+p02EBRJZDaXBgvnsRDSvtI8jceXvd498562+x/3YUTUZW1ndlaKz4FmJ21Qi31PqbAgiP0CjoyZg5e59MXZjhJR5VMHIqwWYhNZqDvFS7pe7MKUem4OUDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793870; c=relaxed/simple;
	bh=FsUgLk766ZRbbjOIAaiSRCuqvU+yCxL6cW0M3pAZ+FI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTcPQ+cLreeY1XT3IxRHH0wq5FuQMyiy9XRJpeEq8WAV97xPzoqlNcXE76PGJJKAXMgUMxT/vIb5RoNLzJqg5FDwNWve2nqqvw8rw9XZkCvYD4L+kRw9xMQt/DlJ8zdTnY2hyvn14nMtzUMDEVoBcE6SrDevUh2GydGJPQuQ73o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vks5tQTj; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vks5tQTj"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc86a9ef97so73108835ad.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785793869; x=1786398669; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRBKJRqDdwyuffVZ6WAc5QHmw5xxQBAcOoh92VnWqbQ=;
        b=Vks5tQTjEbJWuSgwuE5wyYsgyI0VfVu8z97i8uJW/T3JqstxxsEpLH9aiM1Hy4V2hm
         gyAsYo/KkgJoGZMBm9b4qa/Bs5TaIrTjmTduVkpJXtN4hZ0IDLExINAH3g4yZdmC8wzz
         xb8WKvWSgkFwI3kX30b82zfaTQV4D329kbtj9DaOx1B6MajoZ/l0pqcNzVplm7IOmw7Y
         ber62tgQEdN+f3kbN6hIt6UXLDrU/QEpJ8ZPYtQfg0LCILJRSOP86xaDPRRU8VPvvqyo
         aIqQvsHEgb7spllCLShUUC+uvNVE9y2E9vWQ6pbmC9DDAB+rGeE6AB71B7vSVNcnMijv
         awTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785793869; x=1786398669;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRBKJRqDdwyuffVZ6WAc5QHmw5xxQBAcOoh92VnWqbQ=;
        b=HdMI1pZiuzoZJRwWVWNKEAW9Pzu8oyHOvbUpMVOwfVyCF0LdpzEUsdHEYLeCWgV54U
         3iOcqrI/aTWjHkMHbYx77PuEwNpG0W0HX2jUII501KOrvGxPftLVrzz0bg9r1qq3uB1/
         uyNFWtytBp8FjmJaNsoBGv1NKrH3ngFUCV9pW6LWr1RknMp9x9UeD3daVUdcyR2E7BzD
         iAKEm5+po2YWTxC4/LLOLXjvsRSVC5jXHgkAKBHzSViNRm3puB3ci8huFi+Yevnldvzj
         fP109glc/9nsdOEkqEPktprNM50OmzC16Pwkw2N8SKTqP6ndv6RWE6bz3jZ8f7SxNWGV
         pgDw==
X-Forwarded-Encrypted: i=1; AHgh+RrwllnfEiA01goCGI4sqKlhSNgHMOprYI2rdEzGnHV5/ka3NGfOjgw7rzneIGDUnoIfVSC729q7Rks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBLZYsDB7Sl5nZqFn3XDTQaFRVDNBkUiqQa80fHLmoq9oS2e4
	RibNTX4hn2HbotW6ZNtb9n8cCr3EqV2+ZutfFDNnfMXCL0MR4FnGOIc3UTZ1tkZaDn1W5N4MuVW
	qFAJC+k0Vv+GnqMM1v9mMtfnhRSyNt1+8+A==
X-Received: from plxd6.prod.google.com ([2002:a17:902:ef06:b0:2cc:7709:b166])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:390b:b0:2cf:bfbb:61e2 with SMTP id d9443c01a7336-2d0524723b8mr113426065ad.39.1785793868519;
 Mon, 03 Aug 2026 14:51:08 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:51:06 +0000
In-Reply-To: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v3-2-e87159611933@google.com>
Subject: [PATCH v3 2/2] PCI/AER: Fix memory leak in aer_recover_work_func()
 when pci_dev is missing
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (entry.regs) from ghes_estatus_pool and queues
the entry into aer_recover_ring.

In aer_recover_work_func(), items are popped from aer_recover_ring via
kfifo_get(). If pci_get_domain_bus_and_slot() fails to find a matching
pci_dev, the code previously executed 'continue', bypassing the call to
ghes_estatus_pool_region_free(). As a result, the memory allocated for
entry.regs from ghes_estatus_pool was leaked.

Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
is called unconditionally for every dequeued entry, releasing the pool
memory even when pci_dev is missing.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 967cde9dd519..9683cdef649b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1223,14 +1223,13 @@ static void aer_recover_work_func(struct work_struct *work)
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
 						   entry.devfn);
-		if (!pdev) {
+		if (!pdev)
 			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
 					   entry.domain, entry.bus,
 					   PCI_SLOT(entry.devfn),
 					   PCI_FUNC(entry.devfn));
-			continue;
-		}
-		pci_print_aer(pdev, entry.severity, entry.regs);
+		else
+			pci_print_aer(pdev, entry.severity, entry.regs);
 
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being
@@ -1242,13 +1241,15 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
-		pci_dev_put(pdev);
+		if (pdev) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+			pci_dev_put(pdev);
+		}
 	}
 }
 

-- 
2.55.0.571.g244d577d93-goog

