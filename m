Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49306 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbcAOGXB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jan 2016 01:23:01 -0500
From: Qipeng Zha <qipeng.zha@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
	mika.westerberg@intel.com, Qi Zheng <qi.zheng@intel.com>
Subject: [PATCH 2/2] PCI/PM: enable runtime PM support for Intel Broxton platform.
Date: Fri, 15 Jan 2016 22:27:45 +0800
Message-Id: <1452868065-96999-2-git-send-email-qipeng.zha@intel.com>
In-Reply-To: <1452868065-96999-1-git-send-email-qipeng.zha@intel.com>
References: <1452868065-96999-1-git-send-email-qipeng.zha@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe runtime PM is disabled by default, add special treatment
to allow runtime PM for Intel Broxton platform.

Signed-off-by: Qi Zheng <qi.zheng@intel.com>
Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
---
 drivers/pci/quirks.c    | 13 +++++++++++++
 include/linux/pci_ids.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7e32730..a745d06 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/ktime.h>
 #include <linux/mm.h>
+#include <linux/pm_runtime.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -2989,6 +2990,18 @@ static void quirk_intel_ntb(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e08, quirk_intel_ntb);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e0d, quirk_intel_ntb);
 
+
+/*PCIe ports on Intel Broxton should support runtime PM*/
+static void quirk_pcie_enable_rtpm(struct pci_dev *dev)
+{
+	pm_runtime_put_noidle(&dev->dev);
+	pm_runtime_allow(&dev->dev);
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL,
+	PCI_DEVICE_ID_INTEL_BXT_B0_PCIe_0, quirk_pcie_enable_rtpm);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL,
+	PCI_DEVICE_ID_INTEL_BXT_B0_PCIe_1, quirk_pcie_enable_rtpm);
+
 static ktime_t fixup_debug_start(struct pci_dev *dev,
 				 void (*fn)(struct pci_dev *dev))
 {
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d9ba49c..731f05f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2596,6 +2596,8 @@
 #define PCI_DEVICE_ID_INTEL_82840_HB	0x1a21
 #define PCI_DEVICE_ID_INTEL_82845_HB	0x1a30
 #define PCI_DEVICE_ID_INTEL_IOAT	0x1a38
+#define PCI_DEVICE_ID_INTEL_BXT_B0_PCIe_0		0x1ad6
+#define PCI_DEVICE_ID_INTEL_BXT_B0_PCIe_1		0x1ad7
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MIN	0x1c41
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MAX	0x1c5f
 #define PCI_DEVICE_ID_INTEL_PATSBURG_LPC_0	0x1d40
-- 
1.8.3.2

