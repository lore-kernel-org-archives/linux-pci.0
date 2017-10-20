Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752726AbdJTQWF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Oct 2017 12:22:05 -0400
Subject: [PATCH v6 1/4] PCI/portdrv: Add #defines for AER and DPC Interrupt
 Message Number masks
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: Charles Chenxin <charles.chenxin@huawei.com>, linuxarm@huawei.com,
        Christoph Hellwig <hch@lst.de>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        linux-pci@vger.kernel.org
Date: Fri, 20 Oct 2017 11:22:03 -0500
Message-ID: <20171020162203.6391.74119.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171020161922.6391.9091.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171020161922.6391.9091.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dongdong Liu <liudongdong3@huawei.com>

In the AER case, the mask isn't strictly necessary because there are no
higher-order bits above the Interrupt Message Number, but using a #define
will make it possible to grep for it.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/pcie/portdrv_core.c |    4 ++--
 include/uapi/linux/pci_regs.h   |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 313a21df1692..72fcbe5567dd 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -114,7 +114,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		 */
 		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
-		entry = reg32 >> 27;
+		entry = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
 		if (entry >= nr_entries)
 			goto out_free_irqs;
 
@@ -141,7 +141,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		 */
 		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
 		pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP, &reg16);
-		entry = reg16 & 0x1f;
+		entry = reg16 & PCI_EXP_DPC_IRQ;
 		if (entry >= nr_entries)
 			goto out_free_irqs;
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f8d58045926f..f7c09a4c494a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -746,6 +746,7 @@
 #define PCI_ERR_ROOT_FIRST_FATAL	0x00000010 /* First UNC is Fatal */
 #define PCI_ERR_ROOT_NONFATAL_RCV	0x00000020 /* Non-Fatal Received */
 #define PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
+#define PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
 #define PCI_ERR_ROOT_ERR_SRC	52	/* Error Source Identification */
 
 /* Virtual Channel */
@@ -960,6 +961,7 @@
 
 /* Downstream Port Containment */
 #define PCI_EXP_DPC_CAP			4	/* DPC Capability */
+#define PCI_EXP_DPC_IRQ			0x1f	/* DPC Interrupt Message Number */
 #define  PCI_EXP_DPC_CAP_RP_EXT		0x20	/* Root Port Extensions for DPC */
 #define  PCI_EXP_DPC_CAP_POISONED_TLP	0x40	/* Poisoned TLP Egress Blocking Supported */
 #define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x80	/* Software Triggering Supported */
