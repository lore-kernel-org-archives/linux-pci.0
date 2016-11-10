Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbcKJSzY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 13:55:24 -0500
Subject: [PATCH] PCI: pciehp: Check for PCIe capabilities change after resume
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>, Yinghai Lu <yinghai@kernel.org>,
        Len Brown <lenb@kernel.org>
Date: Thu, 10 Nov 2016 12:55:20 -0600
Message-ID: <20161110185520.19461.9789.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Len Brown reported that resume on a Dell XPS11 laptop takes longer than it
should.  The delay is caused by pciehp scanning for a device below a Root
Port that has nothing connected to it.

At boot-time, the 00:1c.0 Root Port's PCI Express Capabilities Register
(PCIe spec r3.0, sec 7.8.2) advertises a slot (PCI_EXP_FLAGS_SLOT is set),
so pciehp claims the port.

At resume-time, PCI_EXP_FLAGS_SLOT is clear, so the Root Port no longer
advertises a slot.  But pciehp doesn't notice that change, and it reads
Slot Status to see if anything changed.  Slot Status says a device is
present (Ports not connected to slots are required to report "Card Present"
per sec 7.8.11), so pciehp tries to bring up the link and scan for the
device, which accounts for the delay.

Per sec 7.8.2, the PCIe Capabilities Register is all read-only, so I
think the fact that it changes between boot- and resume-time is a
firmware defect.

Work around this by re-reading the Capabilites at resume-time and updating
the cached copy in pci_dev->pcie_flags_reg.  Then stop using pciehp on the
port if it no longer advertises a slot.

Reported-and-tested-by: Len Brown <lenb@kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=99751
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_core.c |   10 ++++++++++
 drivers/pci/pci-driver.c          |   13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 7d32fa33..f5461cb 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -278,6 +278,9 @@ static void pciehp_remove(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
 
+	if (!ctrl)
+		return;
+
 	cleanup_slot(ctrl);
 	pciehp_release_ctrl(ctrl);
 }
@@ -296,6 +299,13 @@ static int pciehp_resume(struct pcie_device *dev)
 
 	ctrl = get_service_data(dev);
 
+	if (!(pcie_caps_reg(dev->port) & PCI_EXP_FLAGS_SLOT)) {
+		dev_info(&dev->port->dev, "No longer supports hotplug\n");
+		pciehp_remove(dev);
+		set_service_data(dev, NULL);
+		return 0;
+	}
+
 	/* reinitialize the chipset's event detection logic */
 	pcie_enable_notification(ctrl);
 
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 1ccce1c..fe8e964 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -505,7 +505,20 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
 
 static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 {
+	u16 flags;
+
 	pci_power_up(pci_dev);
+
+	if (pci_dev->pcie_cap) {
+		pci_read_config_word(pci_dev, pci_dev->pcie_cap + PCI_EXP_FLAGS,
+				     &flags);
+		if (pci_dev->pcie_flags_reg != flags) {
+			dev_info(&pci_dev->dev, "PCIe Capabilities was %#06x, is %#06x after resume (possible firmware defect)\n",
+				 pci_dev->pcie_flags_reg, flags);
+			pci_dev->pcie_flags_reg = flags;
+		}
+	}
+
 	pci_restore_state(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 }

