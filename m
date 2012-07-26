Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48556 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab2GZCeQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jul 2012 22:34:16 -0400
Received: by yenl2 with SMTP id l2so1464640yen.19
        for <linux-pci@vger.kernel.org>; Wed, 25 Jul 2012 19:34:15 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: correct static code analysis tool issue
Date: Wed, 25 Jul 2012 19:34:11 -0700
Message-Id: <1343270051-5217-1-git-send-email-jdmason@kudzu.us>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Coverity noticed that pcie_bus_configure_settings() can call
pcie_bus_configure_set() when "smpss" is uninitialized.  The smpss is
used to make the bus and all child devices have a uniform value.
Setting the smpss is moot for PCIE_BUS_PERFORMANCE, since it will be
determined dynamically based on the max size of the parent device and
the child device.  To avoid the erroneous detection of this issue, set
the smpss to 0.  Also, add a case statement to make clearer the possible
use cases and add a nice comment describing what is being done in the
PCIE_BUS_PERFORMANCE case.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/pci/probe.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6c143b4..e813846 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1567,21 +1567,33 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
 	if (!pci_is_pcie(bus->self))
 		return;
 
-	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
-		return;
-
-	/* FIXME - Peer to peer DMA is possible, though the endpoint would need
-	 * to be aware to the MPS of the destination.  To work around this,
-	 * simply force the MPS of the entire system to the smallest possible.
-	 */
-	if (pcie_bus_config == PCIE_BUS_PEER2PEER)
+	switch (pcie_bus_config) {
+	case PCIE_BUS_PERFORMANCE:
+		/* The smpss is used to make the bus and all child devices have
+		 * a uniform value.  Setting the smpss is moot for
+		 * "Performance", since it will be determined dynamically based
+		 * on the max size of the parent device and the child device.
+		 * However, not setting the smpss can result in static code
+		 * analysis tools erroniously reporting an issue.  To avoid
+		 * this, set the smpss to 0.
+		 */
+	case PCIE_BUS_PEER2PEER:
+		/* FIXME - Peer to peer DMA is possible, though the endpoint
+		 * would need to be aware to the MPS of the destination.  To
+		 * work around this, simply force the MPS of the entire system
+		 * to the smallest possible.
+		 */
 		smpss = 0;
-
-	if (pcie_bus_config == PCIE_BUS_SAFE) {
+		break;
+	case PCIE_BUS_SAFE:
 		smpss = mpss;
 
 		pcie_find_smpss(bus->self, &smpss);
 		pci_walk_bus(bus, pcie_find_smpss, &smpss);
+		break;
+	case PCIE_BUS_TUNE_OFF:
+	default:
+		return;
 	}
 
 	pcie_bus_configure_set(bus->self, &smpss);
-- 
1.7.9.5

