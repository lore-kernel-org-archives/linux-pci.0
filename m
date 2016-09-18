Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:36377 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756077AbcIRDjt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2016 23:39:49 -0400
Message-Id: <8661098ee5e355f91e9d9c61248e3ac9980b16aa.1474130360.git.lukas@wunner.de>
In-Reply-To: <cover.1474130360.git.lukas@wunner.de>
References: <cover.1474130360.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 18 Sep 2016 05:39:20 +0200
Subject: [PATCH v2 1/5] PCI: Afford direct-complete to devices with
 nonstandard PM
To: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are devices not power-manageable by the platform, but still able
to runtime suspend to D3cold with a nonstandard mechanism.  One example
is laptop hybrid graphics where the discrete GPU and its built-in HDA
controller are power-managed either with a _DSM (AMD PowerXpress, Nvidia
Optimus) or a separate gmux controller (MacBook Pro).  Another example
is Thunderbolt on Macs which is power-managed with custom ACPI methods.

When putting the system to sleep, we currently handle such devices
improperly by transitioning them from D3cold to D3hot (the default power
state defined at the top of pci_target_state()).  This wastes energy and
prolongs the suspend sequence (powering up the Thunderbolt controller
takes 2 seconds).

Avoid that by assuming that a nonstandard PM mechanism is at work if the
device is not platform-power-manageable but currently in D3cold.

If the device is wakeup enabled, we might still have to wake it up from
D3cold if PME cannot be signaled from that power state.

The check for devices without PM capability comes before the check for
D3cold since such devices could in theory also be powered down by
nonstandard means and should then be afforded direct-complete as well.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aab9d51..72a9d3a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1959,9 +1959,22 @@ static pci_power_t pci_target_state(struct pci_dev *dev)
 		default:
 			target_state = state;
 		}
-	} else if (!dev->pm_cap) {
+
+		return target_state;
+	}
+
+	if (!dev->pm_cap)
 		target_state = PCI_D0;
-	} else if (device_may_wakeup(&dev->dev)) {
+
+	/*
+	 * If the device is in D3cold even though it's not power-manageable by
+	 * the platform, it may have been powered down by nonstandard means.
+	 * Best to let it slumber.
+	 */
+	if (dev->current_state == PCI_D3cold)
+		target_state = PCI_D3cold;
+
+	if (device_may_wakeup(&dev->dev)) {
 		/*
 		 * Find the deepest state from which the device can generate
 		 * wake-up events, make it the target state and enable device
-- 
2.9.3

