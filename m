Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:56556 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3LPBPa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 20:15:30 -0500
Received: by mail-ig0-f169.google.com with SMTP id hk11so2704003igb.0
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2013 17:15:30 -0800 (PST)
Received: from localhost (173-8-252-97-Colorado.hfc.comcastbusiness.net. [173.8.252.97])
        by mx.google.com with ESMTPSA id da14sm13393532igc.1.2013.12.15.17.15.29
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 17:15:29 -0800 (PST)
Subject: [PATCH 5/8] PCI: pciehp: Simplify "Power Fault Detected"
 checking/clearing
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 15 Dec 2013 18:15:29 -0700
Message-ID: <20131216011529.7275.23999.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It's simpler to test the PCI_EXP_SLTSTA_PFD bit directly and to write the
constant back to PCI_EXP_SLTSTA.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 55109d6d8a90..cb3100af7e8c 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -501,9 +501,9 @@ int pciehp_power_on_slot(struct slot * slot)
 
 	/* Clear sticky power-fault bit from previous power failures */
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	slot_status &= PCI_EXP_SLTSTA_PFD;
-	if (slot_status)
-		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, slot_status);
+	if (slot_status & PCI_EXP_SLTSTA_PFD)
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+					   PCI_EXP_SLTSTA_PFD);
 	ctrl->power_fault_detected = 0;
 
 	slot_cmd = POWER_ON;

