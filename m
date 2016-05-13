Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:34197 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbcEMLQD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:16:03 -0400
Message-Id: <eaa7acce56c12b44bd6a354efae1f83b7106de65.1463134231.git.lukas@wunner.de>
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 02/13] PCI: Allow D3 for Thunderbolt ports
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently PCIe ports are only allowed to go to D3 if the BIOS is dated
2015 or newer to avoid potential issues with old chipsets.  However for
Thunderbolt we know that even the oldest controller, Light Ridge (2010),
is able to suspend its ports to D3 just fine.

We're about to add runtime PM for Thunderbolt on the Mac.  Apple has
released two EFI security updates in 2015 which encompass all machines
with Thunderbolt, but the achieved power saving should be made available
to users even if they haven't updated their BIOS.  To this end,
special-case Thunderbolt in pci_bridge_d3_possible().

This allows the Thunderbolt controller to power down but the root port
to which the Thunderbolt controller is attached remains in D0 unless
the EFI update is installed.  Users can pass pcie_port_pm=force on the
kernel command line if they cannot install the EFI update but still want
to benefit from the additional power saving of putting the root port to
D3.  In practice root ports can be suspended to D3 without problems at
least on 2012 Ivy Bridge machines.

If the BIOS cut-off date is ever lowered to 2010, the Thunderbolt
special case can be removed.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2eb530f..95727b4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2176,7 +2176,7 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
  * @bridge: Bridge to check
  *
  * This function checks if it is possible to move the bridge to D3.
- * Currently we only allow D3 for recent enough PCIe ports.
+ * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
  */
 static bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
@@ -2202,6 +2202,9 @@ static bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		    year >= 2015) {
 			return true;
 		}
+		/* Even the oldest 2010 Thunderbolt controller supports D3. */
+		if (bridge->is_thunderbolt)
+			return true;
 		break;
 	}
 
-- 
2.8.1

