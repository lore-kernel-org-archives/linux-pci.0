Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from manchmal.in-ulm.de ([217.10.9.201]:57613 "EHLO
	manchmal.in-ulm.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbbLWPwA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Dec 2015 10:52:00 -0500
Date: Wed, 23 Dec 2015 16:51:57 +0100
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Fix minimum allocation address overwrite
Message-ID: <1450885675@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 36e097a8a297 ("PCI: Split out bridge window override of minimum
allocation address") claimed to do no functional changes but unfortunately
did: The "min" variable is altered. At least the AVM A1 PCMCIA adapter was
no longer detected, breaking ISDN operation.

So use a local copy of min to restore the previous behaviour.

Cc: stable@vger.kernel.org      # v3.14+
Fixes: 36e097a8a297 ("PCI: Split out bridge window override of minimum allocation address")
Signed-off-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
---
Since I have access to that piece of hardware for a limited time only,
please get back to ASAP in case I should do more tests, by 2015-12-26
the latest.

Additional tests were done for -stable on the latest 3.14, 4.1 and 4.3
releases, with all results as expected.
---
 drivers/pci/bus.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index d3346d2..60263f7 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -140,6 +140,8 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 	type_mask |= IORESOURCE_TYPE_BITS;
 
 	pci_bus_for_each_resource(bus, r, i) {
+		resource_size_t min_used;
+
 		if (!r)
 			continue;
 
@@ -162,13 +164,11 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 		 * this is an already-configured bridge window, its start
 		 * overrides "min".
 		 */
-		if (avail.start)
-			min = avail.start;
-
+		min_used = avail.start ? : min;
 		max = avail.end;
 
 		/* Ok, try it out.. */
-		ret = allocate_resource(r, res, size, min, max,
+		ret = allocate_resource(r, res, size, min_used, max,
 					align, alignf, alignf_data);
 		if (ret == 0)
 			return 0;
-- 
1.7.10.4

