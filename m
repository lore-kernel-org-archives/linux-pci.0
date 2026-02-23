Received: from mail-m1973178.qiye.163.com (mail-m1973178.qiye.163.com [220.197.31.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB286191
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861728; cv=none; b=hLB4/2tBMetx+gaLFm0TuCK4bWvmneTZqIbkvt8VpEJccg8RHUrVjh8qhOTXvNlboTFr5RMtasqA5svvAcQg1XIVRytFJxpH7DxpVPmgCTU6yDBZLb4Yr2DDDgdTHFrskX7XyAoqp/+mmNH4vRwjrLZd9P9KHd/+XYKZi4qvxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861728; c=relaxed/simple;
	bh=e6Lvj/0BIZ858hRF233D3sae9D7otGTql6UG5bJZIKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OF6rjPQYZK/+AQG79pUUpuXdAxHqtdVqGCl3t939vCDWW7jBXqPKLpNht8s4cbmimj8zhiMFKGPkYsfGWsKMYKG2ynrD0kUeItwJeAGUd3Dzt1QTGh7iz50moWNvxWzgiRI03T0HXnqPtOLGFHuP2+LxqnHXkG5Ce+oF55sD3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FCsnHYpE; arc=none smtp.client-ip=220.197.31.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FCsnHYpE"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b3c91c9;
	Mon, 23 Feb 2026 23:43:34 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 05/37] PCI: switchtec: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:43:24 +0800
Message-Id: <1771861404-85578-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b2b916b09cckunmeaf5aec89870ae
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUofHVZNTk5OSR1KSE0ZSxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FCsnHYpE4H6ctP20sTU8SRLhVm3q0sQnCsApIwCD0E07OM6gzuA1WBX7GFQQguB0Dznd4vGxfeot4X/6DXB0V5gSwzbAcPp/08LR52qQds/Uj1eEE33M27lhmUIlDXYhTi3YGVwi9/6Y3AU975QjpqQibZgmES9Pw5akFVoSOSE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=DFZrSXwfQ23hpyLAkjWNhWiI1ut7sZ/HdFfP7nX3ns0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
To: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/switch/switchtec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 5ff84fb..5b6d8b7 100644
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

