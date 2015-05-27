Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57497 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbbE0VMO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:12:14 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 12/13] PCI: Keep searching upstream for enclosing bus
Date: Wed, 27 May 2015 20:59:53 +0000
Message-ID: <10beb309e8e14e00aa44284e4f0382f3@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When reassigning a device's BARs, look for an enumeration profile in all
upstream buses, not just the immediate upstream bus.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/pci_static_enum.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
index 50f4db4..14626cd 100644
--- a/drivers/pci/pci_static_enum.c
+++ b/drivers/pci/pci_static_enum.c
@@ -542,11 +542,14 @@ void pci_static_enum_device(struct pci_dev *dev)
 	 */
 	parent = pci_upstream_bridge(dev);
 
-	if (parent) {
+	while (parent) {
 		setting = pci_static_enum_find_setting(pci_domain_nr(dev->bus),
 						       parent->bus->number,
 						       parent->devfn);
-		if (setting)
+		if (setting) {
 			pci_static_enum_set_mmio_bars(dev, setting);
+			break;
+		}
+		parent = pci_upstream_bridge(parent);
 	}
 }
-- 
1.7.9.5

