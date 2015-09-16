Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:13841 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbbIPAjH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 20:39:07 -0400
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Hauke Mehrtens <hauke@hauke-m.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH 1/8] PCI: iproc: Fix code comment
Date: Tue, 15 Sep 2015 17:39:15 -0700
Message-ID: <1442363962-29805-2-git-send-email-rjui@broadcom.com>
In-Reply-To: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix code comment in pcie-iproc.h so it matches the code

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/pcie-iproc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index c9e4c10..4880b09 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -20,11 +20,11 @@
  * iProc PCIe device
  * @dev: pointer to device data structure
  * @base: PCIe host controller I/O register base
- * @resources: linked list of all PCI resources
  * @sysdata: Per PCI controller data (ARM-specific)
  * @root_bus: pointer to root bus
  * @phy: optional PHY device that controls the Serdes
  * @irqs: interrupt IDs
+ * @map_irq: function callback to map interrupts
  */
 struct iproc_pcie {
 	struct device *dev;
-- 
1.9.1

