Received: from mail-m93160.xmail.ntesmail.com (mail-m93160.xmail.ntesmail.com [103.126.93.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E57328B61
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.93.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866278; cv=none; b=X2E4hjFQVjXd7sO/zmB6ty690Mmz16SyQtLEz2zJaBNSBROGEmF6cxs0b78BoTWO/bh1l5tVQsz3pKZ0vXRyg6+x+IkHbpz+g0GfsWUGWrpR+UBvvQS/ams+cg/cKSZZxNXwy5P6+6XyL8ZRJWY2S2jBJ4Ph74gk6w/WINbIaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866278; c=relaxed/simple;
	bh=FugjaQrZedoHKzAkwG9Xcj1r+USQrWsFT2qkSWtTmeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G4TnbUpapkS1cLYZpzOh5m1xkVfRsmqNFvswJFekYyxyZNP8apNdHZgdKX0N0ZCT0caMArufsW63mYe9QXvmlMw1HG7rmWyztvVRB9E2AHul5jDrT+6VzR2clvbCa3leGTo7/bOLmPODbso0x+4Odw4Xu7lKi9BxbK8ZdvSbUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YICDdcsW; arc=none smtp.client-ip=103.126.93.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YICDdcsW"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b40451a;
	Mon, 23 Feb 2026 23:48:59 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: mhi@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 13/37] bus: mhi: host: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:48:50 +0800
Message-Id: <1771861730-87191-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b30860e09cckunm85f34c72987758
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlLGlZOSE0YQk1JHx0ZQkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YICDdcsWp8xNMDAEzZ9YcILxHkBrIQNHelhyyr+Rgr/Hpn7KDiJuwMhPLkFmH5tvl7d31mtcC89NUpqHFzInWPsso1P6eKAuyV3PTVC0hbBo9+GhC/mSnlA8MTN+PmeMxQpEKgs2Z91QsQopTj3MebTcTjZgBXgV7RY1dz1Iix0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=cfswe4XpbSxZre7GRqZkdBtdnLSCJT79Y0e7p3gn1w4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Manivannan Sadhasivam <mani@kernel.org>
Cc: mhi@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/bus/mhi/host/pci_generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 0884a38..bb8c766 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1152,7 +1152,8 @@ static int mhi_pci_get_irqs(struct mhi_controller *mhi_cntrl,
 	 */
 	mhi_cntrl->nr_irqs = 1 + mhi_cntrl_config->num_events;
 
-	nr_vectors = pci_alloc_irq_vectors(pdev, 1, mhi_cntrl->nr_irqs, PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	nr_vectors = pcim_alloc_irq_vectors(pdev, 1, mhi_cntrl->nr_irqs,
+					    PCI_IRQ_MSIX | PCI_IRQ_MSI);
 	if (nr_vectors < 0) {
 		dev_err(&pdev->dev, "Error allocating MSI vectors %d\n",
 			nr_vectors);
-- 
2.7.4

