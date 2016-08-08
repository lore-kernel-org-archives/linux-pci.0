Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7899 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbcHHUTT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 16:19:19 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/2] pci: add option to ignore slot capabilities
Date: Mon,  8 Aug 2016 14:19:01 -0600
Message-Id: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds flags to struct pci_dev that can be set to request ignoring
attention and power indicators. This is in prepration for devices that
advertise these capabilities, but do not support it.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 6 ++++++
 include/linux/pci.h              | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 08e84d6..3e6646c 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -804,6 +804,12 @@ struct controller *pcie_init(struct pcie_device *dev)
 	}
 	ctrl->pcie = dev;
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
+
+	if (pdev->ignore_aip)
+		slot_cap &= ~PCI_EXP_SLTCAP_AIP;
+	if (pdev->ignore_pip)
+		slot_cap &= ~PCI_EXP_SLTCAP_PIP;
+
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
 	init_waitqueue_head(&ctrl->queue);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9890906..d8bc530 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -308,6 +308,8 @@ struct pci_dev {
 						   powered on/off by the
 						   corresponding bridge */
 	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
+	unsigned int	ignore_aip:1;		/* Ignore attention indicator */
+	unsigned int	ignore_pip:1;		/* Ignore power indicator */
 	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
-- 
2.7.2

