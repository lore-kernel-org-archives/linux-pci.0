Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60818 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753310AbeAaQTK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jan 2018 11:19:10 -0500
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
Subject: [PATCH] PCI/DPC: Fix INT legacy interrupt in dpc_irq
Date: Wed, 31 Jan 2018 21:48:55 +0530
Message-Id: <1517415535-21850-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current dpc driver acknowledge the interrupt in deferred work, which works
okay since LPI are edge triggered.
But when RP does not have MSI support, port service driver falls back to
legacy GIC SPI interrupts, and with current code we do not acknowledge the
interrupt and we get dpc interrupt storm.
This patch acknowledges the interrupt in interrupt handler.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 2d976a6..570b561 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -134,7 +134,7 @@ static void interrupt_event_handler(struct work_struct *work)
 	}
 
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
-		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
+			      PCI_EXP_DPC_STATUS_TRIGGER);
 }
 
 static void dpc_rp_pio_print_tlp_header(struct device *dev,
@@ -277,6 +277,8 @@ static irqreturn_t dpc_irq(int irq, void *context)
 
 		schedule_work(&dpc->work);
 	}
+	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
+			      PCI_EXP_DPC_STATUS_INTERRUPT);
 	return IRQ_HANDLED;
 }
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
