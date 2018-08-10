Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 2/4] PCI: Add pci_check_platform_service_irqs
Date: Fri, 10 Aug 2018 21:09:38 +0530
Message-ID: <1533915580-31805-3-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adding method pci_check_platform_service_irqs to check if platform
has registered method to proivde dedicated IRQ lines for PCIe services
like AER/PME etc.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 include/linux/pci.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index c28f575..8eb6470 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2271,6 +2271,30 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 }
 
 /**
+ * pci_check_platform_service_irqs - check platform service irq's
+ * @pdev: PCI Express device to check
+ * @irqs: Array of irqs to populate
+ * @mask: Bitmask of capabilities
+ *
+ * Return value: Bitmask after clearing platform supported service
+ * bits
+ */
+static inline int pci_check_platform_service_irqs(struct pci_dev *dev,
+						  int *irqs, int mask)
+{
+	struct pci_host_bridge *bridge;
+
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+		return -EINVAL;
+
+	bridge = pci_find_host_bridge(dev->bus);
+	if (bridge && bridge->setup_platform_service_irq)
+		return bridge->setup_platform_service_irq(bridge, irqs, mask);
+	else
+		return -EINVAL;
+}
+
+/**
  * pci_is_thunderbolt_attached - whether device is on a Thunderbolt daisy chain
  * @pdev: PCI device to check
  *
-- 
1.7.1
