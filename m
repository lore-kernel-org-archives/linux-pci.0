Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:49801 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbcCGEkl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 6 Mar 2016 23:40:41 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI/keystone: check return value of devm_phy_get with EPROBE_DEFER
Date: Mon,  7 Mar 2016 12:32:21 +0800
Message-Id: <1457325141-1354-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the return value of devm_phy_get is EPROBE_DEFER, we should
defer probing the driver.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pci-keystone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 0aa81bd..42af6ac 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -363,6 +363,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		ret = phy_init(phy);
 		if (ret < 0)
 			return ret;
+	} else if (PTR_ERR(phy) == -EPROBE_DEFER) {
+		return PTR_ERR(phy);
 	}
 
 	/* index 2 is to read PCI DEVICE_ID */
-- 
2.3.7


