Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:46887 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3LPBPg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 20:15:36 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so5728346ieb.17
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2013 17:15:36 -0800 (PST)
Received: from localhost (173-8-252-97-Colorado.hfc.comcastbusiness.net. [173.8.252.97])
        by mx.google.com with ESMTPSA id y10sm13382914igl.4.2013.12.15.17.15.35
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 17:15:36 -0800 (PST)
Subject: [PATCH 6/8] PCI: pciehp: Use symbolic constants,
 not hard-coded bitmask
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 15 Dec 2013 18:15:35 -0700
Message-ID: <20131216011535.7275.77761.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the PCI_EXP_SLTSTA definitions, not 0x1f, when clearing Slot Status
bits.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index cb3100af7e8c..915bb35f9180 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -808,7 +808,10 @@ struct controller *pcie_init(struct pcie_device *dev)
         }
 
 	/* Clear all remaining event bits in Slot Status register */
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, 0x1f);
+	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+		PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
+		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
+		PCI_EXP_SLTSTA_CC);
 
 	/* Disable software notification */
 	pcie_disable_notification(ctrl);

