Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com [45.254.49.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933022EDD40;
	Mon, 23 Feb 2026 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862288; cv=none; b=m8hPFz2uJmkx3phMsM414KUOPpvYw42EVUG4PkwHflJ/KAKhYpsQCq1J7uND2Yfwa/N8aaVex9ISuAeydJ9Ybk3tKRjZkkYZImpuzQHI8O4lzvvhKCYC2J1EGWIzTliWM05yal5He6iRvbD7YDIdN8eOC3GcG3Pq8MSX/UKNjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862288; c=relaxed/simple;
	bh=k6v7R71H6BeiONLx7xfILe+GAg0HA5j6Qzbx2+CJY4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ejUGK5m4YOsg5kn2dqcxGvB24wWHQ0bVC8sZyi/k84ZOUIIK1YWytJZ8ft5kZTxer84Pb+osB9bWCSU1hzOc49J+Dfmb+/Dm0GzgWkCgaVudQWFN5ALi5aGO/V2u9NKiNbtVpbeFbLh1yw3kN5ztS0aAWsFPHvkrOSFYQWrJFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=d4UYuxIe; arc=none smtp.client-ip=45.254.49.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="d4UYuxIe"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404633;
	Mon, 23 Feb 2026 23:58:02 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 29/37] net: hibmcge: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:57:58 +0800
Message-Id: <1771862278-90387-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b38cef009cckunm587e3fff9880aa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNCSlZMSUpKQx5IT01CShpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=d4UYuxIey/MlqpIEpyoJAGoFKm3z2+JNCglP0Chd1D4i6IiF671LAVkKZAaFscfpsZot9ej/RDL/RC0Xx8eC9LuO/PaeGffW5NLHVI1VLB1YQop1lo06fbgyZGItmNa+zZohY9zBfxVnnzM2kvbL5XGuuh5auKw+e7tfdjAWezQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=FH5HoW7K3cZcfLUf1KkiisC7LXy4BSwQBABLhKunaDk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Jijie Shao <shaojijie@huawei.com>
To: Jian Shen <shenjian15@huawei.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: davem@davemloft.net
Cc: netdev@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
index ae4cb35..597c8c8 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -103,8 +103,8 @@ int hbg_irq_init(struct hbg_priv *priv)
 	u32 i;
 
 	/* used pcim_enable_device(),  so the vectors become device managed */
-	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
-				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	ret = pcim_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
+				     PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to allocate vectors\n");
 
-- 
2.7.4

