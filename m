Return-Path: <SRS0=Ark7=Y5=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=Ark7=Y5=wunner.de=lukas@kernel.org>
Message-Id: <be633737115c0be241fccd75bc136dd1da72c1b5.1484486499.git.lukas@wunner.de>
In-Reply-To: <cover.1484486499.git.lukas@wunner.de>
References: <cover.1484486499.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 15 Jan 2017 21:03:45 +0100
Subject: [PATCH v5 3/8] PCI: Don't block runtime PM for Thunderbolt host
 hotplug ports
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-ID: <linux-pci.vger.kernel.org>

Hotplug ports generally block their parents from suspending to D3hot as
otherwise their interrupts couldn't be delivered.

An exception are Thunderbolt host controllers:  They have a separate
GPIO pin to side-band signal plug events even if the controller is
powered down or its parent ports are suspended to D3.  They can be told
apart from Thunderbolt controllers in attached devices by checking if
they're situated below a non-Thunderbolt device (typically a root port,
or the downstream port of a PCIe switch in the case of the MacPro6,1).

To enable runtime PM for Thunderbolt on the Mac, the downstream bridges
of a host controller must not block runtime PM on the upstream bridge as
power to the chip is only cut once the upstream bridge has suspended.
Amend the condition in pci_dev_check_d3cold() accordingly.

This change does not impact non-Macs as their Thunderbolt hotplug ports
are handled by the firmware rather than natively by the OS:  The hotplug
ports are not allowed to suspend in pci_bridge_d3_possible() and keep
their parent ports awake all the time.  Consequently it is meaningless
whether they block runtime PM on their parent ports or not.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Amir Levy <amir.jer.levy@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8ed098db82e1..e7a354cd13ce 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2269,6 +2269,24 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 	return false;
 }
 
+static bool pci_hotplug_bridge_may_wakeup(struct pci_dev *dev)
+{
+	struct pci_dev *parent, *grandparent;
+
+	/*
+	 * Thunderbolt host controllers have a pin to side-band signal
+	 * plug events.  Their hotplug ports are recognizable by having
+	 * a non-Thunderbolt device as grandparent.
+	 */
+	if (dev->is_thunderbolt &&
+	    (parent = pci_upstream_bridge(dev)) &&
+	    (grandparent = pci_upstream_bridge(parent)) &&
+	    !grandparent->is_thunderbolt)
+		return true;
+
+	return false;
+}
+
 static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 {
 	bool *d3cold_ok = data;
@@ -2284,7 +2302,7 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 	    !pci_power_manageable(dev) ||
 
 	    /* Hotplug interrupts cannot be delivered if the link is down. */
-	    dev->is_hotplug_bridge)
+	    (dev->is_hotplug_bridge && !pci_hotplug_bridge_may_wakeup(dev)))
 
 		*d3cold_ok = false;
 
-- 
2.11.0
