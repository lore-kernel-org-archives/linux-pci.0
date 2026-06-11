Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C925F7B9;
	Thu, 11 Jun 2026 02:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146758; cv=none; b=K/H+vpNsUKRK3I1l9PXLPNXjEEIX0Hmvg712++jUdVZClygulePjCrzcqPHpNcFo1YYiRI9LgPxNgL9mMmCvE2KmnpsxIFafS55P+aaPX7gPzjnZKL2hCD48G5JhnlydgVXnoicj0iFoKLr5RlpTYbOfT9iXiTkiZQutww5tYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146758; c=relaxed/simple;
	bh=LPXdwUPN5CPyMF0lFpKAMTkE4iziqHt9AX3yA9ESnDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eqJO/pzoqF3hJ0DL7/VlYrifviNVp6vr2YwtTgjN7yqolSvjDioXNZm9IJH8NpiCj9pENwz6Gf9w7uFHYCHz6NJBBT32mfzT62G5gr4Fus6bolTCno+4uWfztQo1beMTuiA6R5mwl8uDbXJeIrKLFz527iHZno9/2Ou14Wx9EJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JJpACAWW; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JJpACAWW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781146753; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cHfH8jbdVeN8dS+EJ5bhOQOUmMAjbNAjPu3cvozfhQM=;
	b=JJpACAWWqe5yx6A6KKw+oFabqn7vACjbtzu3sYDU5Kzye3/DnQmdhQ5EICPM8GlFdaCKK4UxTpefnT0hOY1bDPb9CkXYylM2bvbbOZ/p1d8COwx/TU3DiNV7RBXTtcRO3X5Za0ydPBrx+8bYcJl5WH51RhFAGjgnTpXQV1vDH1k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X4cAe-j_1781146743;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X4cAe-j_1781146743 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Jun 2026 10:59:12 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	jgross@suse.com,
	hans.zhang@cixtech.com,
	himanshu.madhani@oracle.com,
	roger.pau@citrix.com,
	chrisl@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH] Revert "PCI/MSI: Unmap MSI-X region on error"
Date: Thu, 11 Jun 2026 10:59:01 +0800
Message-Id: <20260611025901.1105209-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 1a8d4c6ecb4c81261bcdf13556abd4a958eca202.

Commit 1a8d4c6ecb4c ("PCI/MSI: Unmap MSI-X region on error") added an
iounmap(dev->msix_base) on the error path of msix_capability_init() to
release the MSI-X region when msix_setup_interrupts() fails.

When msix_setup_interrupts() fails, the call chain is:

  msix_setup_interrupts()
    -> __msix_setup_interrupts()
         struct pci_dev *dev __free(free_msi_irqs) = __dev;
         ...
         return ret;  // __free cleanup fires on error

The __free(free_msi_irqs) cleanup calls pci_free_msi_irqs(), which
already handles the unmap:

  void pci_free_msi_irqs(struct pci_dev *dev)
  {
      pci_msi_teardown_msi_irqs(dev);
      if (dev->msix_base) {
          iounmap(dev->msix_base);   // already unmapped here
          dev->msix_base = NULL;     // and set to NULL
      }
  }

So dev->msix_base is unmapped and set to NULL before
msix_setup_interrupts() returns to msix_capability_init(). The
"goto out_unmap" introduced by commit 1a8d4c6ecb4c ("PCI/MSI: Unmap
MSI-X region on error") then calls iounmap() a second time on a NULL
pointer.

This was reproduced on Intel Emerald Rapids (192 CPUs) while
running tools/testing/selftests/kexec/test_kexec_jump.sh:

  WARNING: CPU#44 at iounmap+0x2a/0xe0
  RIP: 0010:iounmap+0x2a/0xe0
  RDI: 0000000000000000
  Call Trace:
   msix_capability_init+0x317/0x3f0
   __pci_enable_msix_range+0x21d/0x2c0
   pci_alloc_irq_vectors_affinity+0xa9/0x130
   nvme_setup_io_queues+0x2a8/0x420 [nvme]
   nvme_reset_work+0x151/0x340 [nvme]
   ...

RDI=0 confirms iounmap() is called with NULL.

Restore the original "goto out_disable" and leave the unmap to the
existing __free(free_msi_irqs) cleanup.

Fixes: 1a8d4c6ecb4c ("PCI/MSI: Unmap MSI-X region on error")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/4fc6208d-513b-4f41-a13a-4a0829ab50ad@roeck-us.net/
Link: https://lore.kernel.org/all/20260610194406.GA380991@bhelgaas/
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 drivers/pci/msi/msi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 81d24a270a79..a3e0daff0988 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -749,7 +749,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 
 	ret = msix_setup_interrupts(dev, entries, nvec, affd);
 	if (ret)
-		goto out_unmap;
+		goto out_disable;
 
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
@@ -770,8 +770,6 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	pcibios_free_irq(dev);
 	return 0;
 
-out_unmap:
-	iounmap(dev->msix_base);
 out_disable:
 	dev->msix_enabled = 0;
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
-- 
2.39.5 (Apple Git-154)


