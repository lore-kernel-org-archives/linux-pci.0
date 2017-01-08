Return-Path: <SRS0=aNbu=YW=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=aNbu=YW=wunner.de=lukas@kernel.org>
Message-Id: <7ddaaa371101208db7b8bc4dcc2f44c056645923.1483806825.git.lukas@wunner.de>
In-Reply-To: <cover.1483806825.git.lukas@wunner.de>
References: <cover.1483806825.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 8 Jan 2017 09:41:45 +0100
Subject: [PATCH v4 2/8] PCI: Allow runtime PM on Thunderbolt ports
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Tomas Winkler <tomas.winkler@intel.com>, Amir Levy <amir.jer.levy@intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
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
to benefit from the additional power saving of putting the root port
into D3.  In practice, root ports can be suspended to D3 without issues
at least on 2012 Ivy Bridge machines.

If the BIOS cut-off date is ever lowered to 2010, the Thunderbolt
special case can be removed.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Amir Levy <amir.jer.levy@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a881c0d..8ed098d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2224,7 +2224,7 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
  * @bridge: Bridge to check
  *
  * This function checks if it is possible to move the bridge to D3.
- * Currently we only allow D3 for recent enough PCIe ports.
+ * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
@@ -2258,6 +2258,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		    year >= 2015) {
 			return true;
 		}
+
+		/* Even the oldest 2010 Thunderbolt controller supports D3. */
+		if (bridge->is_thunderbolt)
+			return true;
+
 		break;
 	}
 
-- 
2.11.0
