Received: from mail-m93193.xmail.ntesmail.com (mail-m93193.xmail.ntesmail.com [103.126.93.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495534CFBA
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.93.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890608; cv=none; b=I7RcDZ5moFqYaJGDSJJ12WO7toAF3OnfpouCTmOh09wxkSvf0/ywMVCcZv1LZsLNWezdUtO98HIIubUpzar1aBiR1QAEef/X9PGCm0candXtrvAhbU5ASr1Ie5jmxhsnlerozgUKFE8xS9gdDfDDEaturH+AlManTuqPpXG6Oxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890608; c=relaxed/simple;
	bh=T+nm0qKrNASyZNNfvl0kIQ/afWpRbZESpv+cpmtipN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hnERtwM6sWxWLx2EVRGgttkbQrG4pscf9Kb6eUluNMVuHJ/BqOnIpXhxf51WbeDGzmDTvyRCTFAjz40Ff2V+46eZm2bP75+R6GVyaitUcTOIuRB/e+TOy+BWDX/HcJzKz0zXbb+BiRJ+dtquoe6V0E1ZsPUlDB9xx20F+A8cAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LLSM1v25; arc=none smtp.client-ip=103.126.93.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LLSM1v25"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b4045a8;
	Mon, 23 Feb 2026 23:53:40 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 21/37] iommu/riscv: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:53:31 +0800
Message-Id: <1771862011-88864-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b34ceec09cckunmbc588dbe987c42
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5MGVYdTx0eGU4aSEwdSR5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LLSM1v25WAq/SswkB376EBgHwzq59kOjUC3q28q1wsGGcTM5L9eitwYv7a8xmF/IOVyrRvAo68tEuXQbYCRBc9iLQOKoU5gE0L3lmMlA/Zg0MPoGKBigIZ3zCLLrKuBItr+0+BfGNOC6vu1WhO01OItcic58bkzTGyI8yA4VVAo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=TeaSVotaIdmlBVwbjwoZ6VK6NcCzkiCU/IZWFmgDxVY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev
Cc: linux-riscv@lists.infradead.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/iommu/riscv/iommu-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
index d82d2b0..c5bb926 100644
--- a/drivers/iommu/riscv/iommu-pci.c
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -75,8 +75,8 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_i
 	}
 
 	/* Allocate and assign IRQ vectors for the various events */
-	rc = pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT,
-				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	rc = pcim_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT,
+				    PCI_IRQ_MSIX | PCI_IRQ_MSI);
 	if (rc <= 0)
 		return dev_err_probe(dev, -ENODEV,
 				     "unable to allocate irq vectors\n");
-- 
2.7.4

