Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:20861 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab3GVViB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2013 17:38:01 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v6 3/7] PCI: Check pci bus address for unassigned res
Date: Mon, 22 Jul 2013 14:37:14 -0700
Message-Id: <1374529038-14311-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
References: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We should compare res->start with root bus window offset.
Otherwise will have problem with arch that support hostbridge
resource offset.

BenH pointed out that during reviewing patchset that separate
assign unassigned to per root buses.

According to Bjorn, have it in separated patch.

Use pcibios_resource_to_bus to get region at first, and check
region.start instead.

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ec93aa0..87687a5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1367,9 +1367,14 @@ static int __init check_unassigned_resources(struct pci_dev *dev, void *data)
 
 	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
 		struct resource *r = &dev->resource[i];
+		struct pci_bus_region region;
 
 		/* Not assigned, or rejected by kernel ? */
-		if (r->flags && !r->start) {
+		if (!r->flags)
+			continue;
+
+		pcibios_resource_to_bus(dev, &region, r);
+		if (!region.start) {
 			(*unassigned)++;
 			return 1; /* return early from pci_walk_bus */
 		}
-- 
1.8.1.4

