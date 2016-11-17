Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35481 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbcKQWZ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2016 17:25:27 -0500
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] PCI/ASPM: Don't retrain link if ASPM not possible.
Date: Thu, 17 Nov 2016 14:25:01 -0800
Message-Id: <1479421501-31029-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

Some (defective) PCIe devices are not able to reliably do link
retraining.

Check to see if ASPM is possible between link partners before
configuring common clocking, and doing the resulting link retraining.
If ASPM is not possible, there is no reason to risk losing access to a
device due to an unnecessary link retraining.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/pcie/aspm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 0ec649d..d6667db 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -351,12 +351,26 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		return;
 	}
 
+	/* Get upstream/downstream components' register state */
+	pcie_get_aspm_reg(parent, &upreg);
+	child = list_entry(linkbus->devices.next, struct pci_dev, bus_list);
+	pcie_get_aspm_reg(child, &dwreg);
+
+	/*
+	 * If ASPM not supported, don't mess with the clocks and link,
+	 * bail out now.
+	 */
+	if (!(upreg.support & dwreg.support))
+		return;
+
 	/* Configure common clock before checking latencies */
 	pcie_aspm_configure_common_clock(link);
 
-	/* Get upstream/downstream components' register state */
+	/*
+	 * Re-read upstream/downstream components' register state
+	 * after clock configuration
+	 */
 	pcie_get_aspm_reg(parent, &upreg);
-	child = list_entry(linkbus->devices.next, struct pci_dev, bus_list);
 	pcie_get_aspm_reg(child, &dwreg);
 
 	/*
-- 
1.7.11.7

