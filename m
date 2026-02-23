Received: from mail-m49243.qiye.163.com (mail-m49243.qiye.163.com [45.254.49.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B11A9FBC;
	Tue, 24 Feb 2026 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771906073; cv=none; b=Y7LYUMuYizAWig5+wX4VJ3dHQ0nuTEeqh/OH21EGLF8XZaYqpZqR7nPNxI7ZCb1K7XshnVqeU0l+ngNUqN2dz2llmPxVAwSI2H4pQy/hv4R7s1Pw0X8iQNm3XFUUMK5bcsdlpH5Z0UjawyiNrOZkFRTKbYNFpG8Kl4ovsNZtj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771906073; c=relaxed/simple;
	bh=cr7XFSbhm9oUtV7O2V2pK3+rCfdYy4tTY+ajSyGenUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uQ6nqvwKrsmWYRqBySMO+BJFg3xZMQkCok6bugq3IyL2FOD40pZMGDcMbT+fgsY52WxK4pm/mNa0/DFjvlwKiCOu+u6G5epi4bQbyjsLHIEhi6YsCPcewWAJdpusRm7FuhAaSVCKqsbQspsGFlWfAhRI42D7ebgzoof71g74MME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=I/L3+03K; arc=none smtp.client-ip=45.254.49.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="I/L3+03K"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b3c91fb;
	Mon, 23 Feb 2026 23:44:08 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 07/37] spi: spi-pci1xxxx: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:44:04 +0800
Message-Id: <1771861444-85899-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b2c150809cckunma9575ea2987141
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx1CTFYaTU5ITkofThgZHUNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=I/L3+03K/8tGO+INU9hOqzQyuD2NGHT4dk3YUhCm0/+l3QoAA0hYSPWXoRUsmNfPZG9sOd0xhcWgsfXuNZMlViIFvz6vlj/gcPkNqiS5pAncW3aD73ymFIVatHsNaEWlBCo/iBcdFAZPGUZvq1rstMRs+OX4NG/tf8kUO3vZudU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=znKHD4I00rIoe/1sHtM7bwJNUSv/Ul2a9tN+zviqQpk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/spi/spi-pci1xxxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 8577a19..ccb22de 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -852,8 +852,8 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 			if (!spi_bus->reg_base)
 				return -EINVAL;
 
-			num_vector = pci_alloc_irq_vectors(pdev, 1, hw_inst_cnt * NUM_VEC_PER_INST,
-							   PCI_IRQ_INTX | PCI_IRQ_MSI);
+			num_vector = pcim_alloc_irq_vectors(pdev, 1, hw_inst_cnt * NUM_VEC_PER_INST,
+							    PCI_IRQ_INTX | PCI_IRQ_MSI);
 			if (num_vector < 0) {
 				dev_err(&pdev->dev, "Error allocating MSI vectors\n");
 				return num_vector;
-- 
2.7.4

