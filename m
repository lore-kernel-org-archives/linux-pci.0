Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:42833 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab2IYI0q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:46 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Doug Thompson <dougthompson@xmission.com>,
	linux-edac@vger.kernel.org
Subject: [PATCH 15/29] PCI, edac: kill pci_find_next_bus in edac
Date: Tue, 25 Sep 2012 01:26:16 -0700
Message-Id: <1348561590-28067-16-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Doug Thompson <dougthompson@xmission.com>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/i7core_edac.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 3672101..ae4c484 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1294,10 +1294,10 @@ static void __init i7core_xeon_pci_fixup(const struct pci_id_table *table)
 static unsigned i7core_pci_lastbus(void)
 {
 	int last_bus = 0, bus;
-	struct pci_bus *b = NULL;
+	struct pci_host_bridge *host_bridge = NULL;
 
-	while ((b = pci_find_next_bus(b)) != NULL) {
-		bus = b->number;
+	for_each_pci_host_bridge(host_bridge) {
+		bus = host_bridge->bus->number;
 		edac_dbg(0, "Found bus %d\n", bus);
 		if (bus > last_bus)
 			last_bus = bus;
-- 
1.7.7

