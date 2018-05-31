Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41165 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755036AbeEaPFu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 May 2018 11:05:50 -0400
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Check for PCIe downtraining conditions
Date: Thu, 31 May 2018 10:05:33 -0500
Message-Id: <20180531150535.9684-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe downtraining happens when both the device and PCIe port are
capable of a larger bus width or higher speed than negotiated.
Downtraining might be indicative of other problems in the system, and
identifying this from userspace is neither intuitive, nor straigh
forward.
Instead, check for such conditions on device probe, and print an
appropriate message.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/probe.c           | 78 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |  1 +
 2 files changed, 79 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac91b6fd0bcd..b58c5de70540 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2146,6 +2146,82 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	return dev;
 }
 
+static void pcie_max_link_cap(struct pci_dev *dev, enum pci_bus_speed *speed,
+				enum pcie_link_width *width)
+{
+	uint32_t lnkcap;
+
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+
+	*speed = pcie_link_speed[lnkcap & PCI_EXP_LNKCAP_SLS];
+	*width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> PCI_EXP_LNKCAP_MLW_SHIFT;
+}
+
+static void pcie_cur_link_sta(struct pci_dev *dev, enum pci_bus_speed *speed,
+				enum pcie_link_width *width)
+{
+	uint16_t lnksta;
+
+	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	*speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
+	*width = (lnksta & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
+}
+
+static const char *pcie_bus_speed_name(enum pci_bus_speed speed)
+{
+	switch (speed) {
+	case PCIE_SPEED_2_5GT:
+		return "2.5 GT/s";
+	case PCIE_SPEED_5_0GT:
+		return "5.0 GT/s";
+	case PCIE_SPEED_8_0GT:
+		return "8.0 GT/s";
+	default:
+		return "unknown";
+	}
+}
+
+static void pcie_check_downtrain_errors(struct pci_dev *dev)
+{
+	enum pci_bus_speed dev_max_speed, dev_cur_speed;
+	enum pci_bus_speed max_link_speed, bus_max_speed;
+	enum pcie_link_width dev_cur_width, dev_max_width;
+	enum pcie_link_width bus_max_width, max_link_width;
+	struct pci_dev *uport = pci_upstream_bridge(dev);
+
+	if (!pci_is_pcie(dev) || !uport)
+		return;
+
+	/* Look from the device up to avoid downstream ports with no devices. */
+	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
+		return;
+
+	/* Multi-function PCIe share the same link/status. */
+	if (PCI_FUNC(dev->devfn) != 0)
+		return;
+
+	pcie_cur_link_sta(dev, &dev_cur_speed, &dev_cur_width);
+	pcie_max_link_cap(dev, &dev_max_speed, &dev_max_width);
+	pcie_max_link_cap(uport, &bus_max_speed, &bus_max_width);
+
+	max_link_speed = min(bus_max_speed, dev_max_speed);
+	max_link_width = min(bus_max_width, dev_max_width);
+
+
+	if (dev_cur_speed < max_link_speed)
+		pci_warn(dev, "PCIe downtrain: link speed is %s (%s capable)",
+			 pcie_bus_speed_name(dev_cur_speed),
+			 pcie_bus_speed_name(max_link_speed));
+
+	if (dev_cur_width < max_link_width) {
+		/* Lanes might not be routed, so use info instead of warn. */
+		pci_info(dev, "PCIe downtrain: Port and device capable of x%d, but link running at x%d",
+			 max_link_width, dev_cur_width);
+	}
+}
+
 static void pci_init_capabilities(struct pci_dev *dev)
 {
 	/* Enhanced Allocation */
@@ -2181,6 +2257,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Advanced Error Reporting */
 	pci_aer_init(dev);
 
+	pcie_check_downtrain_errors(dev);
+
 	if (pci_probe_reset_function(dev) == 0)
 		dev->reset_fn = 1;
 }
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 103ba797a8f3..5557e6dfd05a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -522,6 +522,7 @@
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
 #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
+#define  PCI_EXP_LNKCAP_MLW_SHIFT 4	/* start of MLW mask in link status */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
 #define  PCI_EXP_LNKCAP_L1EL	0x00038000 /* L1 Exit Latency */
-- 
2.14.3
