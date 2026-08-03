Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153DA428470
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782344; cv=none; b=mSuYMB73YAC3+7X4aLl/ikl+wCDcJtSj6u9kNkXZMMRYPrrjp0e6NPwphqca9NRdnuu/+7LYZkUJcTE9cG9bDUqK9In83/+OklFdRtQNK+92AhJsQSiAfCWRyWdENs0KzESN1vyeWyB4d2Z8EF+Z9NacYo/pH262UCzc1dthuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782344; c=relaxed/simple;
	bh=nawgbZOcUUMAhp+QHIlZVsB8qYG3Js6cjLMtkwnYZwA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=depd0Kb1LRrtahwLNaTZn90Qpu2qqECHxhFLpVUAR3zbrWJ0t2nCuqiQSVZm55NTT5quoMLDQfvPS86QCQKelEdCOGptwu68JFyKVfs0uMzL1HnVLmgP+cUI+z3zC5AUP/VC2HFqDPBWbFZWCauDgiW2cCUtXFs973m9hrqldyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+fBoRbG; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+fBoRbG"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso4126877a91.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782342; x=1786387142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iaF1vf6QOKeaYbRr7iA7Kf2ImiB954aE1RsWnBJ3e3k=;
        b=s+fBoRbGdVDoqGUJzMepWFAlD3CjdfwpbOQdI+3dDI0Ya09soCAaLAkPm19l5bl4/C
         uF+EfBmXttnIRcrOXY4sAqFj+AKPvRkEcj2K65Z7GB+ROM4cobaHLawn+iR1N1uc00Jk
         azS+BctmMIoTYOHdDyarwcYtkDzWmhSA/AYUDe+AIC62YF0icycz7MQMGmHprQiuXBbb
         w5qw1jwLnlw+0JziIctqJEnrhvGXC6VkAZnOmjkotjYswRPpTAHUUWAD84mLTpuxuaTc
         dp+C1nfzyqKYqoDMd8dSf3LJDWqQ2fpjM6F2Q53qFJas87envbChTX8nvyVF2+kNIyE5
         NgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782342; x=1786387142;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iaF1vf6QOKeaYbRr7iA7Kf2ImiB954aE1RsWnBJ3e3k=;
        b=cjUxAZS0M/z5ZtbPgCRgoP6hIZWTYmJf7/ll4uOTU56BjhEsNdnH9lovb3aLBYaB2Q
         7cdLx5iZAknjkp+tGPWX4kBB11gkVUjcKCsMDTZWzFeswbEM9OHqAdaBEC1P1clxbEqJ
         OkwTWkMRiw7et4qzOGvTjq0riQnmZCF7YIYgApakZckJ7gURU7n7LlXEDra51+yS7ZMC
         V4jBOYsuciz3u6nPebg3NSh3DRdhCyZAYeClhhBEQJr7DvFH7BviREoZbIyo5KWPPSyu
         h6ghbeEwI0n8EbqOQn5TEWOo4RqE677NByK607/nSNkE01IcYv2lbAd+n9EWcf+3Qu/A
         SgCw==
X-Gm-Message-State: AOJu0Yx+7q5lihnRDXPug8dhOYtFAS/zIUo4L5+VB/Tj+aOvwv2PTFsQ
	lPoVtJ4ElAL1K8qslpcX3I9p+d5+GDKS+UsIh6krGsiITEYblqonXUQFLuNLARFFx5j/K9NwDrm
	cteLC1sOkMyDelu2jTcZXSt7G6tHvaLzK3w==
X-Received: from pjzt5.prod.google.com ([2002:a17:90b:585:b0:38f:5dae:af56])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5807:b0:381:6466:7160 with SMTP id 98e67ed59e1d1-38fbc51c1acmr10689271a91.26.1785782341944;
 Mon, 03 Aug 2026 11:39:01 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:38:52 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803183853.432459-2-rathodpriyank@google.com>
Subject: [PATCH] PCI/AER: Fix memory leak in aer_recover_work_func() when
 pci_dev is missing
From: Priyank Rathod <rathodpriyank@google.com>
To: bhelgaas@google.com, helgaas@kernel.org
Cc: linux-pci@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="UTF-8"

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
index c4fd9c0b2a54..555f39b60b14 100644
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

