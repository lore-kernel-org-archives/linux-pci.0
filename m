Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:31961 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbaHWBPl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 21:15:41 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI: remove not needed pcie_disable_notification
Date: Fri, 22 Aug 2014 18:15:12 -0700
Message-Id: <1408756512-16885-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

disable and enable notification in a row will cause 1 second delay
per hotplug slot on system with Intel chip that only have command
complete for real hotplut operations.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/hotplug/pciehp_hpc.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -785,9 +785,6 @@ struct controller *pcie_init(struct pcie
 		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
 		PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
 
-	/* Disable software notification */
-	pcie_disable_notification(ctrl);
-
 	ctrl_info(ctrl, "Slot #%d AttnBtn%c AttnInd%c PwrInd%c PwrCtrl%c MRL%c Interlock%c NoCompl%c LLActRep%c\n",
 		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
 		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
