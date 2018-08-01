Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:18784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390055AbeHATAp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Aug 2018 15:00:45 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 2/3] PCI: Use dedicated Xilinx controller irq number for AER
Date: Wed, 1 Aug 2018 22:14:48 +0530
Message-ID: <1533141889-19962-3-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
Error Interrupt Message Number. The controller has dedicated interrupt line
for reporting PCIe errors along with AER.

Using pci_dev->sysdata of root port to save controller irq number, which
will be used for registering AER irq handler.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/quirks.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f439de8..e666373 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4753,3 +4753,32 @@ static void quirk_gpu_hda(struct pci_dev *hda)
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
+
+#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_PCIE_XILINX_NWL) && \
+	defined(CONFIG_PCIEAER)
+/*
+ * Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
+ * Error Interrupt Message Number. The controller has dedicated interrupt line
+ * for reporting PCIe errors along with AER.
+ */
+#include <linux/of.h>
+#include <linux/of_irq.h>
+
+static void quirk_xilinx_aer_irq(struct pci_dev *dev)
+{
+	struct device_node *dev_node;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR)) {
+		dev_node = of_find_compatible_node(NULL, NULL,
+						   "xlnx,nwl-pcie-2.11");
+		if (!dev_node) {
+			dev_err(&dev->dev, "Error could not find ZynqMP PS PCIe node\n");
+			return;
+		}
+
+		dev->sysdata = dev_node->data;
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, PCI_ANY_ID, quirk_xilinx_aer_irq);
+#endif
-- 
1.7.1
