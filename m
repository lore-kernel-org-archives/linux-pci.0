Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v2] PCI/DPC: Fix PCI legacy interrupt acknowledgement
Date: Wed, 14 Mar 2018 21:20:48 +0530
Message-Id: <1521042648-20522-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current DPC driver acknowledges the interrupt in deferred work, which works
since MSI are edge triggered.

But when MSI is disabled (e.g. pci=nomsi boot option) port service
driver falls back to PCI legacy INT interrupt.

With current code we do not acknowledge the interrupt back in dpc_irq()
and we get dpc interrupt storm.

This patch acknowledges the interrupt in interrupt handler.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 38e40c6..9c05120 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -112,7 +112,7 @@ static void dpc_work(struct work_struct *work)
 	}
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
-		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
+			      PCI_EXP_DPC_STATUS_TRIGGER);
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
@@ -222,6 +222,9 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
 		dpc_process_rp_pio_error(dpc);
 
+	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
+			      PCI_EXP_DPC_STATUS_INTERRUPT);
+
 	schedule_work(&dpc->work);
 
 	return IRQ_HANDLED;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
