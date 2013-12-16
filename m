Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:43126 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3LPBPY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 20:15:24 -0500
Received: by mail-ie0-f180.google.com with SMTP id tp5so5721873ieb.11
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2013 17:15:24 -0800 (PST)
Received: from localhost (173-8-252-97-Colorado.hfc.comcastbusiness.net. [173.8.252.97])
        by mx.google.com with ESMTPSA id l7sm13386988igx.2.2013.12.15.17.15.23
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 17:15:23 -0800 (PST)
Subject: [PATCH 4/8] PCI: pciehp: Announce slot capabilities (slot #, button,
 LEDs, etc)
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 15 Dec 2013 18:15:22 -0700
Message-ID: <20131216011522.7275.36607.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We already have the vendor/device IDs from pci_setup_device(), so drop that
info and print things that will be more useful for debugging: the slot
number and presence of button/indicators/link active reporting/etc.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 83df74910f9a..55109d6d8a90 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -771,6 +771,8 @@ static inline void dbg_ctrl(struct controller *ctrl)
 	ctrl_info(ctrl, "Slot Control           : 0x%04x\n", reg16);
 }
 
+#define FLAG(x,y)	(((x) & (y)) ? '+' : '-')
+
 struct controller *pcie_init(struct pcie_device *dev)
 {
 	struct controller *ctrl;
@@ -811,9 +813,16 @@ struct controller *pcie_init(struct pcie_device *dev)
 	/* Disable software notification */
 	pcie_disable_notification(ctrl);
 
-	ctrl_info(ctrl, "HPC vendor_id %x device_id %x ss_vid %x ss_did %x\n",
-		  pdev->vendor, pdev->device, pdev->subsystem_vendor,
-		  pdev->subsystem_device);
+	ctrl_info(ctrl, "Slot #%d AttnBtn%c AttnInd%c PwrInd%c PwrCtrl%c MRL%c Interlock%c NoCompl%c LLActRep%c\n",
+		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
+		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_AIP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_PIP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_MRLSP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
+		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC));
 
 	if (pcie_init_slot(ctrl))
 		goto abort_ctrl;

