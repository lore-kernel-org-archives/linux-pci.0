Received: from mail-m49224.qiye.163.com (mail-m49224.qiye.163.com [45.254.49.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F331A556
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022131; cv=none; b=hB8nQa5ryVJEpUPsibX2Thlamyg3VWL549iYphZ+iQAxXOQLcto78zHhlCswgrCGzXJg2YqvEvuMS0lTB2y++/Jjm89y9HWS64VulCoi2L7Eb/XQQnE3dg7k4+xY71mdTWWjMiAvyqocHJY67CUHntgJhkDeDEt6mCeOPj0ndac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022131; c=relaxed/simple;
	bh=cfWULAyqZ21m0P6B9wCMb+bIoZiQS7Sgi0RoAFHp80A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U6QbATxeMwyUL9xW711S++vnJ6jsDdRxbCUREavolHAZzC8O9XjzqhW4zGnKi2aApHo3D+4RD3uqG/rqFg+s+j/P4LcJaxRzKUE+7NTOzvok7XDqOxvZS/hBi1z2ZLD24V9C16h4q7oWu5hasX24CeDqVUxWOuUWt+RYwSMSAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OOveTkta; arc=none smtp.client-ip=45.254.49.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OOveTkta"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c022059e;
	Fri, 24 Apr 2026 15:59:30 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 6/7] PCI: switchtec: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Fri, 24 Apr 2026 15:57:39 +0800
Message-Id: <1777017460-243543-7-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9dbe80436d09cckunm66d640875ecd1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0tDVh0fHU8aThkdHUxPSVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OOveTktaF3TfaMNFDF2SWyWFKU/EeLdpONqtKR7+OUw2HGYKYo40rHBZ0Ld8R2MVHyTzB/BsDfQb+Q6bRS06Lv2YTiKXyzOkae92cgQZWSEBDuZUhyjsuhlcoQQhtA29yn7M1PPIRZOtCRrdzIHSpaMngsq8hlSXsEslYukwOkM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=A4ywhVGEVq2UT956X0EtOgl6z6pID8Z1lF+EOtlEhGc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors() to
explicitly request devres-managed interrupt vectors. This makes the
driver's intention clear and avoids the ambiguous implicit management
previously provided by pcim_enable_device().

The change prepares the driver for the eventual removal of the hybrid
IRQ management pattern from pcim_enable_device(), ensuring consistent
resource management through devres.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/switch/switchtec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 93ebec9..ed42661 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1493,9 +1493,9 @@ static int switchtec_init_isr(struct switchtec_dev *stdev)
 	if (nirqs < 4)
 		nirqs = 4;
 
-	nvecs = pci_alloc_irq_vectors(stdev->pdev, 1, nirqs,
-				      PCI_IRQ_MSIX | PCI_IRQ_MSI |
-				      PCI_IRQ_VIRTUAL);
+	nvecs = pcim_alloc_irq_vectors(stdev->pdev, 1, nirqs,
+				       PCI_IRQ_MSIX | PCI_IRQ_MSI |
+				       PCI_IRQ_VIRTUAL);
 	if (nvecs < 0)
 		return nvecs;
 
-- 
2.7.4

