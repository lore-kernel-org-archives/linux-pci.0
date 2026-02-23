Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com [220.197.31.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD821287257;
	Tue, 24 Feb 2026 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902797; cv=none; b=ey3Zgc/PdUS0Uwy/ZUT7adqxeEPUoj5RhiH8GNzB0VeoMDhG5TJU9P81NxPQeaRKyg1lfIxIh0aXoy39Hy4/7tgxEgFkPbtCd2COUthjCwm59Tpw/aS2uyU1BRCHnxRD8fkYQEGVBjhktQK9QMmAIoeNRu9DtOKrunDbb8OPa+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902797; c=relaxed/simple;
	bh=M4UJ9qoqEgnDJwKAFDyiKjKl2Ar99+wjN7D6njiVANM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sVmWD0dIEHZm6qYs+RhDQpRQ+bTh3esbjNNlWldzUVSEWmGyrjXoxBMcKv7MIjBMBeqNpn1MI55vrIl86iJ5ly1qRhiSc+q5dRgFcivfL90fwHbEbUP1wACRDBnEgTwR5AlUdgLLQfTSIb3FfnHbtnRVSNnwN+ultaf9oYDmuts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=IV0ghmG4; arc=none smtp.client-ip=220.197.31.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="IV0ghmG4"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404601;
	Mon, 23 Feb 2026 23:56:23 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 26/37] net: stmmac: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:56:18 +0800
Message-Id: <1771862178-89833-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b374b1309cckunmb3d17b81987efd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9KGFZCGUNLGBhDSU1LTExWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=IV0ghmG4sGtSy4po62kvJscgyoHY0vUatk9nnrbg2GsGW8ZZOpAhbpgANzi/Q0+3XnavqqlejSiMfPirpEG1pA2RxBIr08516remo9ORZ2pd6NZojcMa4XewN9s5mih13H+u3UKB1nc3K4LFDXw5D+MUxkkyyA47HTePkC+Mn50=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Vs3w1gqIcLFWsADUFrf0uniaLeLE8Vx6Fum5/MP1TYc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: davem@davemloft.net
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 92d77b0..e35c138a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -1122,7 +1122,7 @@ static int stmmac_config_single_msi(struct pci_dev *pdev,
 {
 	int ret;
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	ret = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0) {
 		dev_info(&pdev->dev, "%s: Single IRQ enablement failed\n",
 			 __func__);
@@ -1152,8 +1152,8 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
 		return -1;
 	}
 
-	ret = pci_alloc_irq_vectors(pdev, 2, STMMAC_MSI_VEC_MAX,
-				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	ret = pcim_alloc_irq_vectors(pdev, 2, STMMAC_MSI_VEC_MAX,
+				     PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (ret < 0) {
 		dev_info(&pdev->dev, "%s: multi MSI enablement failed\n",
 			 __func__);
-- 
2.7.4

