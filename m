Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42204 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752051AbeACPYv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jan 2018 10:24:51 -0500
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [PATCH next 1/3] pci: Report PCI device link status
Date: Wed,  3 Jan 2018 17:24:20 +0200
Message-Id: <1514993062-7328-2-git-send-email-talgi@mellanox.com>
In-Reply-To: <1514993062-7328-1-git-send-email-talgi@mellanox.com>
References: <1514993062-7328-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a function for querying and verifying a PCI device link
status. The PCI speed and width are reported in kernel log.
In case the PCI device went up with non-maximized speed/width,
a warning would be reported in kernel log.

This would allow for a generic way for all PCI devices to
report status and issues in the same manner, instead of each
device reporting in a different place, using different code.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
---
 drivers/pci/pci.c             | 107 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h           |   3 ++
 include/uapi/linux/pci_regs.h |   1 +
 3 files changed, 111 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4a7c686..f8499ba 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5050,6 +5050,113 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 EXPORT_SYMBOL(pcie_get_minimum_link);
 
 /**
+ * pcie_get_link_caps - queries for the PCI device's link speed and width
+ *			capabilities.
+ * @dev: PCI device to query
+ * @speed: storage for link speed
+ * @width: storage for link width
+ *
+ * This function queries the PCI device speed and width capabilities.
+ */
+int pcie_get_link_caps(struct pci_dev *dev, enum pci_bus_speed *speed,
+		       enum pcie_link_width *width)
+{
+	u32 lnkcap1, lnkcap2;
+	int err1, err2;
+
+	*speed = PCI_SPEED_UNKNOWN;
+	*width = PCIE_LNK_WIDTH_UNKNOWN;
+
+	err1 = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP,
+					  &lnkcap1);
+	err2 = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2,
+					  &lnkcap2);
+
+	if (err1 && err2)
+		return err1;
+
+	if (!err2 && lnkcap2) { /* PCIe r3.0-compliant */
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
+			*speed = PCIE_SPEED_8_0GT;
+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
+			*speed = PCIE_SPEED_5_0GT;
+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
+			*speed = PCIE_SPEED_2_5GT;
+	}
+	if (!err1 && lnkcap1) {
+		*width = (lnkcap1 & PCI_EXP_LNKCAP_MLW) >>
+				PCI_EXP_LNKCAP_MLW_SHIFT;
+		if (*speed == PCI_SPEED_UNKNOWN) { /* pre-r3.0 */
+			if (lnkcap1 & PCI_EXP_LNKCAP_SLS_8_0GB)
+				*speed = PCIE_SPEED_8_0GT;
+			else if (lnkcap1 & PCI_EXP_LNKCAP_SLS_5_0GB)
+				*speed = PCIE_SPEED_5_0GT;
+			else if (lnkcap1 & PCI_EXP_LNKCAP_SLS_2_5GB)
+				*speed = PCIE_SPEED_2_5GT;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(pcie_get_link_caps);
+
+/**
+ * pcie_print_link_status - Reports the PCI device's link speed and width.
+ * @dev: PCI device to query
+ *
+ * This function will check the PCI device current speed and width are equal
+ * to the maximum PCI device capabilities. Will issue a warning in cases
+ * there's a mismatch between current status and maximum capabilities.
+ */
+void pcie_print_link_status(struct pci_dev *dev)
+{
+	enum pcie_link_width width, width_cap;
+	enum pci_bus_speed speed, speed_cap;
+	int err;
+
+	err = pcie_get_link_caps(dev, &speed_cap, &width_cap);
+	if (err) {
+		dev_warn(&dev->dev,
+			 "Warning: unable to determine PCIe device BW capabilities (err = %d)\n",
+			 err);
+		return;
+	}
+
+	err = pcie_get_minimum_link(dev, &speed, &width);
+	if (err) {
+		dev_warn(&dev->dev,
+			 "Warning: unable to determine PCIe device chain minimum BW (err = %d)\n",
+			 err);
+		return;
+	}
+
+	if (speed == PCI_SPEED_UNKNOWN)
+		dev_warn(&dev->dev,
+			 "Warning: unable to determine PCIe device chain minimum speed\n");
+	else if (speed != speed_cap)
+		dev_warn(&dev->dev,
+			 "Warning: PCIe speed is slower than device's capability\n");
+
+	if (width == PCIE_LNK_WIDTH_UNKNOWN)
+		dev_warn(&dev->dev,
+			 "Warning: unable to determine PCIe device chain minimum width\n");
+	else if (width != width_cap)
+		dev_warn(&dev->dev,
+			 "Warning: PCIe width is lower than device's capability\n");
+
+#define PCIE_SPEED2STR(speed) \
+	(speed == PCIE_SPEED_8_0GT ? "8.0GT/s" : \
+	 speed == PCIE_SPEED_5_0GT ? "5.0GT/s" : \
+	 speed == PCIE_SPEED_2_5GT ? "2.5GT/s" : \
+	 "Unknown")
+	dev_info(&dev->dev, "PCIe link speed is %s, device supports %s\n",
+		 PCIE_SPEED2STR(speed), PCIE_SPEED2STR(speed_cap));
+	dev_info(&dev->dev, "PCIe link width is x%d, device supports x%d\n",
+		 width, width_cap);
+}
+EXPORT_SYMBOL(pcie_print_link_status);
+
+/**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
  * @flags: resource type mask to be selected
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 978aad7..51845fc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1080,6 +1080,9 @@ static inline int pci_is_managed(struct pci_dev *pdev)
 int pcie_set_mps(struct pci_dev *dev, int mps);
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
+int pcie_get_link_caps(struct pci_dev *dev, enum pci_bus_speed *speed,
+		       enum pcie_link_width *width);
+void pcie_print_link_status(struct pci_dev *dev);
 void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 70c2b2a..a5f9aed 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -521,6 +521,7 @@
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
+#define  PCI_EXP_LNKCAP_MLW_SHIFT 4	   /* Start of MLW mask in link capabilities */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
 #define  PCI_EXP_LNKCAP_L1EL	0x00038000 /* L1 Exit Latency */
-- 
1.8.3.1
