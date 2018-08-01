Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr700054.outbound.protection.outlook.com ([40.107.70.54]:48566
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390055AbeHATBJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Aug 2018 15:01:09 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx controller irq with AER
Date: Wed, 1 Aug 2018 22:14:49 +0530
Message-ID: <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
Error Interrupt Message Number. The controller has dedicated interrupt line
for reporting PCIe errors along with AER.

Using dedicated controller irq number for AER which is shared with misc
interrupt handler in pcie-xilinx-nwl. This irq number is set
using PCI quirk.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/pcie/portdrv_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e0261ad..fa9150e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -264,6 +264,10 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
 	int retval;
 	struct pcie_device *pcie;
 	struct device *device;
+#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_PCIE_XILINX_NWL)
+	if (service == PCIE_PORT_SERVICE_AER && pdev->sysdata)
+		irq = *(int *)pdev->sysdata;
+#endif
 
 	pcie = kzalloc(sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
-- 
1.7.1
