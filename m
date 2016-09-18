Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-Id: <32b08ff2dab38555db7759d627d7bcbdf4b119b9.1474130360.git.lukas@wunner.de>
In-Reply-To: <cover.1474130360.git.lukas@wunner.de>
References: <cover.1474130360.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 18 Sep 2016 05:39:20 +0200
Subject: [PATCH v2 3/5] PCI: Recognize D3cold in pci_update_current_state()
To: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Whenever a device is resumed or its power state is changed using the
platform, its new power state is read from the PM Control & Status
Register and cached in pci_dev->current_state by calling
pci_update_current_state().

If the device is in D3cold, reading from config space typically results
in a fabricated "all ones" response.  But if it's in D3hot, the two bits
representing the power state in the PMCSR are *also* set to 1.  Thus
D3hot and D3cold are not discernible by just reading the PMCSR.

To account for this, pci_update_current_state() uses two workarounds:

- When transitioning to D3cold using pci_platform_power_transition(),
  the new power state is set blindly by pci_update_current_state(),
  i.e. without verifying that the device actually *is* in D3cold.
  This is achieved by setting the "state" argument to PCI_D3cold.
  The "state" argument was originally intended to convey the new state
  in case the device doesn't have the PM capability.  It is *also* used
  to convey the device state if the PM capability is present and the
  new state is D3cold, but this was never explained in the kerneldoc.

- Once the current_state is set to D3cold, further invocations of
  pci_update_current_state() will blindly assume that the device is
  still in D3cold and leave the current_state unmodified.  To get out of
  this impasse, the current_state has to be set directly, typically by
  calling pci_raw_set_power_state() or pci_enable_device().

It would be desirable if pci_update_current_state() could reliably
detect D3cold by itself.  That would allow us to do away with these
workarounds, and it would allow for a smarter, more energy conserving
runtime resume strategy after system sleep:  Currently devices which
utilize direct_complete are mandatorily runtime resumed in their
->complete stage.  This can be avoided if their power state after system
sleep is the same as before, but it requires a mechanism to detect the
power state reliably.

We've just gained the ability to query the platform firmware for its
opinion on the device's power state.  On platforms conforming to
ACPI 4.0 or newer, this allows recognition of D3cold.  Pre-4.0 platforms
lack _PR3 and therefore the deepest power state that will ever be
reported is D3hot, even though the device may actually be in D3cold.
To detect D3cold in those cases, accessibility of the vendor ID in
config space is probed using pci_device_is_present().  This also works
for devices which are not platform-power-manageable at all, but can be
suspended to D3cold using a nonstandard mechanism (e.g. some hybrid
graphics laptops or Thunderbolt on the Mac).

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---

Changes since v1:
* Instead of solely relying on the platform firmware to report D3cold,
  also probe the vendor ID and assume D3cold if it can't be read.
  This should ensure proper detection of D3cold on pre-ACPI 4.0
  platforms (which will never report anything deeper than D3hot)
  as well as for devices with nonstandard PM mechanisms.
* The two existing workarounds for D3cold are removed from
  pci_update_current_state(), as explained in the commit message.

 drivers/pci/pci.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6ea0d2d..7d3188b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -707,26 +707,25 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 }
 
 /**
- * pci_update_current_state - Read PCI power state of given device from its
- *                            PCI PM registers and cache it
+ * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
  * @state: State to cache in case the device doesn't have the PM capability
+ *
+ * The power state is read from the PMCSR register, which however is
+ * inaccessible in D3cold.  The platform firmware is therefore queried first
+ * to detect accessibility of the register.  In case the platform firmware
+ * reports an incorrect state or the device isn't power manageable by the
+ * platform at all, we try to detect D3cold by testing accessibility of the
+ * vendor ID in config space.
  */
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
 {
-	if (dev->pm_cap) {
+	if (platform_pci_get_power_state(dev) == PCI_D3cold ||
+	    !pci_device_is_present(dev)) {
+		dev->current_state = PCI_D3cold;
+	} else if (dev->pm_cap) {
 		u16 pmcsr;
 
-		/*
-		 * Configuration space is not accessible for device in
-		 * D3cold, so just keep or set D3cold for safety
-		 */
-		if (dev->current_state == PCI_D3cold)
-			return;
-		if (state == PCI_D3cold) {
-			dev->current_state = PCI_D3cold;
-			return;
-		}
 		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
 	} else {
-- 
2.9.3

