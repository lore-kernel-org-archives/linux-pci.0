Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:13249 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbIQVVe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 17:21:34 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v1 1/7] PCI: Use child bus's number instead of assuming max+1
Date: Thu, 17 Sep 2015 21:10:48 +0000
Message-ID: <474aecb40e0740f687ea86d9a3d0bff3@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In pci_scan_bridge(), a newly allocated child bus's resource is given
the bus number "max+1".  The current enumeration algorithm numbers
each child sequentially, thus the new child's number happens to always
be max+1; see the call to pci_add_new_bus() a few lines earlier.

An upcoming patch will reserve bus numbers, such that the new child
bus's number might no longer be max+1.  Thus when inserting the
child's resources, use the number actually assigned to the child
instead of assuming that it is always max+1.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636..c905db3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -862,7 +862,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 			child = pci_add_new_bus(bus, dev, max+1);
 			if (!child)
 				goto out;
-			pci_bus_insert_busn_res(child, max+1, 0xff);
+			pci_bus_insert_busn_res(child, child->number, 0xff);
 		}
 		max++;
 		buses = (buses & 0xff000000)
-- 
1.8.3.1

