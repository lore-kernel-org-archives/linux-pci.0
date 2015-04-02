Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46027 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbbDBVLj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Apr 2015 17:11:39 -0400
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Sean O. Stalley" <sean.stalley@intel.com>
Subject: [PATCH] Read ID & Pointer from PCI Capabilities List in 1 call
Date: Thu,  2 Apr 2015 14:10:19 -0700
Message-Id: <1428009019-19563-1-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reading both fields at the same time lets us parse the
list with half the number of configspace reads.

Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
---
 drivers/pci/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5e3c8e9..db7f3d6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -145,19 +145,22 @@ static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
 				   u8 pos, int cap, int *ttl)
 {
 	u8 id;
+	u16 ent;
+
+	pci_bus_read_config_byte(bus, devfn, pos, &pos);
 
 	while ((*ttl)--) {
-		pci_bus_read_config_byte(bus, devfn, pos, &pos);
 		if (pos < 0x40)
 			break;
 		pos &= ~3;
-		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_ID,
-					 &id);
+		pci_bus_read_config_word(bus, devfn, pos, &ent);
+
+		id = ent & 0xff;
 		if (id == 0xff)
 			break;
 		if (id == cap)
 			return pos;
-		pos += PCI_CAP_LIST_NEXT;
+		pos = (ent >> 8);
 	}
 	return 0;
 }
-- 
1.9.1

