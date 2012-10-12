Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60697 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab2JLFfw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Oct 2012 01:35:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2593354pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 11 Oct 2012 22:35:51 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>
Subject: [PATCH 1/3] PCI: correct static code analysis tool issue
Date: Thu, 11 Oct 2012 22:35:53 -0700
Message-Id: <1350020155-3782-2-git-send-email-jdmason@kudzu.us>
In-Reply-To: <1350020155-3782-1-git-send-email-jdmason@kudzu.us>
References: <1350020155-3782-1-git-send-email-jdmason@kudzu.us>
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
 drivers/pci/probe.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9f8a6b7..6b672c1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1570,21 +1570,36 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
 	if (!pci_is_pcie(bus->self))
 		return;
 
-	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
-		return;
-
+	switch (pcie_bus_config) {
+	/* The smpss is used to make the bus and all child devices have
+	 * a uniform value.  Setting the smpss is moot for
+	 * "Performance", since it will be determined dynamically based
+	 * on the max size of the parent device and the child device.
+	 * However, not setting the smpss can result in static code
+	 * analysis tools erroniously reporting an issue.  To avoid
+	 * this, set the smpss to 0.
+	 */
+	case PCIE_BUS_PERFORMANCE:
 	/* FIXME - Peer to peer DMA is possible, though the endpoint would need
 	 * to be aware to the MPS of the destination.  To work around this,
 	 * simply force the MPS of the entire system to the smallest possible.
 	 */
-	if (pcie_bus_config == PCIE_BUS_PEER2PEER)
+	case PCIE_BUS_PEER2PEER:
 		smpss = 0;
+		break;
 
-	if (pcie_bus_config == PCIE_BUS_SAFE) {
+	case PCIE_BUS_SAFE:
 		smpss = mpss;
 
 		pcie_find_smpss(bus->self, &smpss);
 		pci_walk_bus(bus, pcie_find_smpss, &smpss);
+		break;
+
+	case PCIE_BUS_TUNE_OFF:
+	default:
+		return;
+	}
+
 	}
 
 	pcie_bus_configure_set(bus->self, &smpss);
-- 
1.7.9.5

