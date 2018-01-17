Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26209 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbeAQFSz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jan 2018 00:18:55 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Maik Broemme <mbroemme@libmpq.org>,
        Pawandeep Oza <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 5/6] PCI/DPC: Fix interrupt message number print
Date: Tue, 16 Jan 2018 22:22:05 -0700
Message-Id: <20180117052206.7703-6-keith.busch@intel.com>
In-Reply-To: <20180117052206.7703-1-keith.busch@intel.com>
References: <20180117052206.7703-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The interrupt message number is the first 5 bits, but the driver was
masking only the first 4 bits. This patch fixes that by using the
existing define.

This patch is also fixing the define formatting, as it wasn't aligned.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c   | 2 +-
 include/uapi/linux/pci_regs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 85350b00f251..5dfdb4935bac 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -351,7 +351,7 @@ static int dpc_probe(struct pcie_device *dev)
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
 	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
-		cap & 0xf, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
+		cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
 		FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
 		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), (cap >> 8) & 0xf,
 		FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 70c2b2ade048..295a5ebdf9e4 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -966,7 +966,7 @@
 
 /* Downstream Port Containment */
 #define PCI_EXP_DPC_CAP			4	/* DPC Capability */
-#define PCI_EXP_DPC_IRQ			0x1f	/* DPC Interrupt Message Number */
+#define  PCI_EXP_DPC_IRQ		0x1f	/* DPC Interrupt Message Number */
 #define  PCI_EXP_DPC_CAP_RP_EXT		0x20	/* Root Port Extensions for DPC */
 #define  PCI_EXP_DPC_CAP_POISONED_TLP	0x40	/* Poisoned TLP Egress Blocking Supported */
 #define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x80	/* Software Triggering Supported */
-- 
2.13.6
