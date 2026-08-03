Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8943769F8
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794383; cv=none; b=oyXkuW43X/dRpsy130nVdwAkmnnL2yIVNL1kGFkmThGEKfAYOtve+GJpGF7Y4UGKnfsDTk4XzxuF54CXdu2SEPIfs9N2EI2fzo+IoOAk6Cdqm08zQlH0ccw7CiK77EOgeqKBXRygPR0fGQpgdUIHAM6GvP8FDrkdRuTIwffkf2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794383; c=relaxed/simple;
	bh=FsUgLk766ZRbbjOIAaiSRCuqvU+yCxL6cW0M3pAZ+FI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KknQq/P4QQn6+UI7hpfDenzUvipqcNnIcfy0jxLqVFvB/Dnowpaufi7rZxqR725oWQKQcfFoeP9fB34oogM3BJb9hrZXnrEWB+gq4sN38epmhWbluJyIKtNkAOc+VHAdjYG0WhvwLmZsTKjZk2lZXVLjsfdxqqRN+oq73nEloqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJfOG+KJ; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJfOG+KJ"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84859a64079so7787226b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785794382; x=1786399182; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRBKJRqDdwyuffVZ6WAc5QHmw5xxQBAcOoh92VnWqbQ=;
        b=jJfOG+KJ0tpCeh1fC97knDZHBgW6mluWVJ1Zz7W/QCZWgYUey1WrqttxVmM1MUwp19
         qsY8/paZcYRb2G2vwLkh3C1cvyVAM78mz2HidxrWqhtmoPcDZZS57PV/waNNZTA+1kFT
         evRYNSt7QBzANcY5Zo7nKyfH0zIMl7vCx8ygEswYddUBjb8jfaSmzzxVQS0lNTCDDOPR
         ThutkpzE+8eOoW5ygTtFHWdDZ84uLEdIJdiPmTeodNij6268J029AKWajo0mXDzwqO3f
         lfWuNkSAY9CVSdbhwBf/0SqBNuMGDJDMgmHD+tQ68ALLOy16uEUu1OWzRKuIxy+CxmOX
         Kylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785794382; x=1786399182;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRBKJRqDdwyuffVZ6WAc5QHmw5xxQBAcOoh92VnWqbQ=;
        b=nnGlHkPou33aP/7UbNIkgVwpnWSnTo+zFfL81LooWZCDW/bD6wml0eH/P3jAnB+rz2
         yaPxZfcEDXwZGUlZzM2loFEf7aTqrZynyL7Y2gvF7+2E4RqjMvPNw6/5Pc5IKIay4ORa
         pglVNF2htZXqJ2M9m5D65L/4Su8FBDaPD/u4pat6lGAiazUqz225dD6E7OW7s7x+Xmzu
         bQzY8mfPsezRxfkXj29sw5+cOMKOZhES1eid4TMlOo/tsxB5mI1VCLYmvMOrTIZa5Zze
         ryIsJMAsnHqKxHi9bfX/mbO4MCg1h0SFbIL/zzfVfCbmyqJngYPIQtxZ9NYXPMpupJDn
         k3SQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBxvgHrMkfaa8WPVABndK+aU+5BPUM6n0+bu/V2qH8cS9Xlbt2RV+sfSc6J82UYUkItgWfMmBW72w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjHuArz4PozExl8nlVt/L8Q6faHdDc/hMUiW+rjnMtI8LS7/Q
	vffMZnlBUrDnyF6xofPZPLtnlyFeEn3w6feyzBWz4V8vaNLuAPE9TEmS/vB7f4RSpNPHZqdt2jD
	CKsWbPlzd8nxrqEJZ/djAobo5cygH28sDNQ==
X-Received: from pfbkr8.prod.google.com ([2002:a05:6a00:4b48:b0:845:e386:e036])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:f98:b0:845:e9e5:cdec with SMTP id d2e1a72fcca58-84ee4933b3emr10031695b3a.62.1785794381432;
 Mon, 03 Aug 2026 14:59:41 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:59:39 +0000
In-Reply-To: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v2-2-fd199b0171fd@google.com>
Subject: [PATCH v2 2/2] PCI/AER: Fix memory leak in aer_recover_work_func()
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

