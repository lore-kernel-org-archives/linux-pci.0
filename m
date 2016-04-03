Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43814 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbcDCK4W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Apr 2016 06:56:22 -0400
From: Colin King <colin.king@canonical.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: xilinx-nwl: Fix spelling mistake "Initialization"
Date: Sun,  3 Apr 2016 11:56:16 +0100
Message-Id: <1459680976-32222-1-git-send-email-colin.king@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Minor fix, spelling mistake "Initalization" should be
"Initialization".

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 5139e64..3479d30 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -819,7 +819,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 
 	err = nwl_pcie_bridge_init(pcie);
 	if (err) {
-		dev_err(pcie->dev, "HW Initalization failed\n");
+		dev_err(pcie->dev, "HW Initialization failed\n");
 		return err;
 	}
 
-- 
2.7.4

