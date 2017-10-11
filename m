Return-Path: <SRS0=aHpY=BK=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=aHpY=BK=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <hch@lst.de>
CC: <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH V4 2/2] PCI/portdrv: Add #defines for the AER and DPC Interrupt Message Number masks
Date: Wed, 11 Oct 2017 18:52:58 +0800
Message-ID: <1507719178-112556-3-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
References: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

In the AER case, the mask isn't strictly necessary because there are no
higher-order bits above the Interrupt Message Number, but using a #define
will make it possible to grep for it.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/pcie/portdrv_core.c | 4 ++--
 include/uapi/linux/pci_regs.h   | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 9692379..2b48297 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -116,7 +116,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		 */
 		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
-		entry = reg32 >> 27;
+		entry = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
 		if (entry >= nr_entries)
 			goto out_free_irqs;
 
@@ -142,7 +142,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		 */
 		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
 		pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP, &reg16);
-		entry = reg16 & 0x1f;
+		entry = reg16 & PCI_EXP_DPC_IRQ;
 		if (entry >= nr_entries)
 			goto out_free_irqs;
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f8d5804..756e704 100644
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
+#define PCI_EXP_DPC_IRQ			0x1f	/* DPC Interrupt message number */
 #define  PCI_EXP_DPC_CAP_RP_EXT		0x20	/* Root Port Extensions for DPC */
 #define  PCI_EXP_DPC_CAP_POISONED_TLP	0x40	/* Poisoned TLP Egress Blocking Supported */
 #define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x80	/* Software Triggering Supported */
-- 
1.9.1
