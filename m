Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:18837 "EHLO
        wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbeEQHnY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2018 03:43:24 -0400
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v17 7/9] PCI/DPC: Disable ERR_NONFATAL handling by DPC
Date: Thu, 17 May 2018 03:43:09 -0400
Message-Id: <1526542991-5291-8-git-send-email-poza@codeaurora.org>
In-Reply-To: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
References: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe ERR_NONFATAL errors mean a particular transaction is unreliable but
the Link is otherwise fully functional (PCIe r4.0, sec 6.2.2).

The AER driver handles these by logging the error details and calling
driver-supplied pci_error_handlers callbacks.  It does not reset downstream
devices, does not remove them from the PCI subsystem, does not re-enumerate
them, and does not call their driver .remove() or .probe() methods.

But DPC driver previously enabled DPC on ERR_NONFATAL, so if the hardware
supports DPC, these errors caused a Link reset (performed automatically by
the hardware), followed by the DPC driver removing affected devices (which
calls their .remove() methods), bringing the Link back up, and
re-enumerating (which calls driver .probe() methods).

Disable ERR_NONFATAL DPC triggering so these errors will only be handled by
AER.  This means drivers won't have to deal with different usage of their
pci_error_handlers callbacks and .probe() and .remove() methods based on
whether the platform has DPC support.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 80ec384..361903f 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -260,7 +260,7 @@ static int dpc_probe(struct pcie_device *dev)
 		}
 	}
 
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
+	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
 	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
@@ -278,7 +278,7 @@ static void dpc_remove(struct pcie_device *dev)
 	u16 ctl;
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~(PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN);
+	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 }
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 103ba79..5182e0d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -981,6 +981,7 @@
 #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
 
 #define PCI_EXP_DPC_CTL			6	/* DPC control */
+#define  PCI_EXP_DPC_CTL_EN_FATAL 	0x0001	/* Enable trigger on ERR_FATAL message */
 #define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
 #define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
 
-- 
2.7.4
