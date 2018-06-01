Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43618 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeFAPBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jun 2018 11:01:42 -0400
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com, okaya@codeaurora.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Check for PCIe downtraining conditions
Date: Fri,  1 Jun 2018 10:01:24 -0500
Message-Id: <20180601150129.10486-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe downtraining happens when both the device and PCIe port are
capable of a larger bus width or higher speed than negotiated.
Downtraining might be indicative of other problems in the system, and
identifying this from userspace is neither intuitive, nor straigh
forward.

The easiest way to detect this is with pcie_print_link_status(),
since the bottleneck is usually the link that is downtrained. It's not
a perfect solution, but it works extremely well in most cases.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/probe.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac91b6fd0bcd..e8e158046cab 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2146,6 +2146,25 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	return dev;
 }
 
+static void pcie_check_upstream_link(struct pci_dev *dev)
+{
+
+	if (!pci_is_pcie(dev))
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
+	pcie_print_link_status(dev);
+}
+
 static void pci_init_capabilities(struct pci_dev *dev)
 {
 	/* Enhanced Allocation */
@@ -2181,6 +2200,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Advanced Error Reporting */
 	pci_aer_init(dev);
 
+	/* Check link and detect downtrain errors */
+	pcie_check_upstream_link(dev);
+
 	if (pci_probe_reset_function(dev) == 0)
 		dev->reset_fn = 1;
 }
-- 
2.14.3
