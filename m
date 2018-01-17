Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26209 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751238AbeAQFS4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jan 2018 00:18:56 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Maik Broemme <mbroemme@libmpq.org>,
        Pawandeep Oza <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 6/6] PCI/DPC: Enable ERR_COR
Date: Tue, 16 Jan 2018 22:22:06 -0700
Message-Id: <20180117052206.7703-7-keith.busch@intel.com>
In-Reply-To: <20180117052206.7703-1-keith.busch@intel.com>
References: <20180117052206.7703-1-keith.busch@intel.com>
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
index 5dfdb4935bac..b7b327367588 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -347,7 +347,10 @@ static int dpc_probe(struct pcie_device *dev)
 
 	dpc->rp = (cap & PCI_EXP_DPC_CAP_RP_EXT);
 
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
+	ctl = (ctl & 0xfff4) |
+		PCI_EXP_DPC_CTL_EN_NONFATAL |
+		PCI_EXP_DPC_CTL_INT_EN |
+		PCI_EXP_DPC_CTL_ERR_COR;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
 	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 295a5ebdf9e4..0bee9a99dae1 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -976,6 +976,7 @@
 #define PCI_EXP_DPC_CTL			6	/* DPC control */
 #define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x02	/* Enable trigger on ERR_NONFATAL message */
 #define  PCI_EXP_DPC_CTL_INT_EN 	0x08	/* DPC Interrupt Enable */
+#define  PCI_EXP_DPC_CTL_ERR_COR 	0x10	/* DPC ERR_COR Enable */
 
 #define PCI_EXP_DPC_STATUS		8	/* DPC Status */
 #define  PCI_EXP_DPC_STATUS_TRIGGER	0x01	/* Trigger Status */
-- 
2.13.6
