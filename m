Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:19081 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752365AbdBCVlH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 16:41:07 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/2] pcie-dpc: Wait for root port busy to clear
Date: Fri,  3 Feb 2017 16:46:13 -0500
Message-Id: <1486158373-18655-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1486158373-18655-1-git-send-email-keith.busch@intel.com>
References: <1486158373-18655-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Root Ports implementing DPC optionally advertise extensions that, when
advertised, require the driver wait for the RP Busy status to clear prior
to releasing from containment. Results are undefined if we release from
containment while this bit is set.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c   | 26 +++++++++++++++++++++++++-
 include/uapi/linux/pci_regs.h |  1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 9ca74f4..2acd9de 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -20,8 +20,28 @@ struct dpc_dev {
 	struct pcie_device	*dev;
 	struct work_struct	work;
 	int			cap_pos;
+	bool			rp;
 };
 
+static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
+{
+	unsigned long timeout = jiffies + HZ;
+	struct pci_dev *pdev = dpc->dev->port;
+	u16 status;
+
+	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
+	while (status & PCI_EXP_DPC_RP_BUSY &&
+					!time_after(jiffies, timeout)) {
+		msleep(10);
+		pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
+	}
+	if (status & PCI_EXP_DPC_RP_BUSY) {
+		dev_warn(&pdev->dev, "DPC root port still busy\n");
+		return -EBUSY;
+	}
+	return 0;
+}
+
 static void dpc_wait_link_inactive(struct pci_dev *pdev)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -34,7 +54,7 @@ static void dpc_wait_link_inactive(struct pci_dev *pdev)
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 	}
 	if (lnk_status & PCI_EXP_LNKSTA_DLLLA)
-		dev_warn(&pdev->dev, "Link state not disabled for DPC event");
+		dev_warn(&pdev->dev, "Link state not disabled for DPC event\n");
 }
 
 static void interrupt_event_handler(struct work_struct *work)
@@ -56,6 +76,8 @@ static void interrupt_event_handler(struct work_struct *work)
 	pci_unlock_rescan_remove();
 
 	dpc_wait_link_inactive(pdev);
+	if (dpc->rp && dpc_wait_rp_inactive(dpc))
+		return;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
 		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
 }
@@ -119,6 +141,8 @@ static int dpc_probe(struct pcie_device *dev)
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
 
+	dpc->rp = (cap & PCI_EXP_DPC_CAP_RP_EXT);
+
 	ctl |= PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 174d114..c1b94b0 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -973,6 +973,7 @@
 #define PCI_EXP_DPC_STATUS		8	/* DPC Status */
 #define  PCI_EXP_DPC_STATUS_TRIGGER	0x01	/* Trigger Status */
 #define  PCI_EXP_DPC_STATUS_INTERRUPT	0x08	/* Interrupt Status */
+#define  PCI_EXP_DPC_RP_BUSY		0x10	/* Root Port Busy */
 
 #define PCI_EXP_DPC_SOURCE_ID		10	/* DPC Source Identifier */
 
-- 
2.7.2
