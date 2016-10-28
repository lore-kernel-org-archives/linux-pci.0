Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:46679 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758880AbcJ1IxV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2016 04:53:21 -0400
Message-Id: <91d06bdc4b76f7386a4ad8a5b521e1e1d7fde150.1477611126.git.lukas@wunner.de>
In-Reply-To: <cover.1477611126.git.lukas@wunner.de>
References: <cover.1477611126.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 28 Oct 2016 10:52:06 +0200
Subject: [PATCH v2 3/9] PCI: Speed up algorithm in pci_bridge_d3_update()
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After a device has been added, removed or had its D3cold attributes
changed, we recheck whether its parent bridge may runtime suspend to
D3hot with pci_bridge_d3_update().

The most naive algorithm would be to iterate over the bridge's
children and check if any of them are blocking D3.

The function already tries to be a bit smarter than that by first
checking the device that was changed.  If this device already blocks D3
on the bridge, then walking over all the other children can be skipped.
A drawback of this approach is that if the device is *not* blocking D3,
it will be checked a second time by pci_walk_bus().  But that's cheap
and is outweighed by the performance gain of potentially skipping
pci_walk_bus() altogether.

The algorithm can be optimized further by taking into account if D3 is
currently allowed for the bridge, as shown in the following truth table:

(a)  remove &&  bridge_d3:  D3 is currently allowed for the bridge and
                            removing one of its children won't change
                            that.  No action necessary.
(b)  remove && !bridge_d3:  D3 may now be allowed for the bridge if the
                            removed child was the only one blocking it.
                            Check all its siblings to verify that.
(c) !remove &&  bridge_d3:  D3 may now be disallowed but this can only
                            be caused by the added/changed child, not
                            any of its siblings.  Check only that single
                            device.
(d) !remove && !bridge_d3:  D3 may now be allowed for the bridge if the
                            changed child was the only one blocking it.
                            Check all its siblings to verify that.
                            By checking beforehand if the changed child
                            is blocking D3, we may be able to skip
                            checking its siblings.

Currently we do not special-case option (a) and in case of option (c) we
gratuitously call pci_walk_bus().  Speed up the algorithm by adding
these optimizations.  Reword the comments a bit in an attempt to improve
clarity.

No functional change intended.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c12fae7..bc60f2c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2293,20 +2293,32 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 		return;
 
 	/*
-	 * If the device is removed we do not care about its D3cold
-	 * capabilities.
+	 * If D3 is currently allowed for the bridge, removing one of its
+	 * children won't change that.
+	 */
+	if (remove && bridge->bridge_d3)
+		return;
+
+	/*
+	 * If D3 is currently allowed for the bridge and a child is added or
+	 * changed, disallowance of D3 can only be caused by that child, so
+	 * we only need to check that single device, not any of its siblings.
+	 *
+	 * If D3 is currently not allowed for the bridge, checking the device
+	 * first may allow us to skip checking its siblings.
 	 */
 	if (!remove)
 		pci_dev_check_d3cold(dev, &d3cold_ok);
 
-	if (d3cold_ok) {
-		/*
-		 * We need to go through all children to find out if all of
-		 * them can still go to D3cold.
-		 */
+	/*
+	 * If D3 is currently not allowed for the bridge, this may be caused
+	 * either by the device being changed/removed or any of its siblings,
+	 * so we need to go through all children to find out if one of them
+	 * continues to block D3.
+	 */
+	if (d3cold_ok && !bridge->bridge_d3)
 		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
 			     &d3cold_ok);
-	}
 
 	if (bridge->bridge_d3 != d3cold_ok) {
 		bridge->bridge_d3 = d3cold_ok;
-- 
2.9.3

