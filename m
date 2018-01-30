Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbeA3S1J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:27:09 -0500
Subject: [PATCH v2 13/14] PCI/DPC: Add and use DPC Status register field
 definitions
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 30 Jan 2018 12:27:05 -0600
Message-ID: <20180130182705.106875.15572.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Add definitions for DPC Status register fields and use them in the code.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c   |    4 ++--
 include/uapi/linux/pci_regs.h |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 76a50d03e5db..5b4c65bc9267 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -216,8 +216,8 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	dev_info(dev, "DPC containment event, status:%#06x source:%#06x\n",
 		status, source);
 
-	reason = (status >> 1) & 0x3;
-	ext_reason = (status >> 5) & 0x3;
+	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
+	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
 
 	dev_warn(dev, "DPC %s detected, remove downstream devices\n",
 		 (reason == 0) ? "unmasked uncorrectable error" :
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 70c2b2ade048..970a0dc535c4 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -979,8 +979,10 @@
 
 #define PCI_EXP_DPC_STATUS		8	/* DPC Status */
 #define  PCI_EXP_DPC_STATUS_TRIGGER	0x01	/* Trigger Status */
+#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN	0x06	/* Trigger Reason */
 #define  PCI_EXP_DPC_STATUS_INTERRUPT	0x08	/* Interrupt Status */
 #define  PCI_EXP_DPC_RP_BUSY		0x10	/* Root Port Busy */
+#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT 0x60 /* Trig Reason Extension */
 
 #define PCI_EXP_DPC_SOURCE_ID		10	/* DPC Source Identifier */
 
