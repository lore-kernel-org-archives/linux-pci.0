Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65218 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbeA2V2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jan 2018 16:28:06 -0500
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 5/6] PCI/DPC: Enable ERR_COR
Date: Mon, 29 Jan 2018 14:31:44 -0700
Message-Id: <20180129213145.26068-5-keith.busch@intel.com>
In-Reply-To: <20180129213145.26068-1-keith.busch@intel.com>
References: <20180129213145.26068-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A DPC port may be configured to send ERR_COR message when the
triggered. This patch enables this feature so additional notification
of the event is possible.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c   | 5 ++++-
 include/uapi/linux/pci_regs.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 8c28840b6b91..bf9f7e0f3f90 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -255,7 +255,10 @@ static int dpc_probe(struct pcie_device *dev)
 		}
 	}
 
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
+	ctl = (ctl & 0xfff4) |
+		PCI_EXP_DPC_CTL_EN_NONFATAL |
+		PCI_EXP_DPC_CTL_INT_EN |
+		PCI_EXP_DPC_CTL_ERR_COR;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
 	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 0c79eac5e9b8..9cfcecdc3ec7 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -980,6 +980,7 @@
 #define PCI_EXP_DPC_CTL			6	/* DPC control */
 #define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
 #define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
+#define  PCI_EXP_DPC_CTL_ERR_COR 	0x0010	/* DPC ERR_COR Enable */
 
 #define PCI_EXP_DPC_STATUS		8	/* DPC Status */
 #define  PCI_EXP_DPC_STATUS_TRIGGER	    0x0001 /* Trigger Status */
-- 
2.14.3
