Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-Id: <4e8b490a18cc349318f0b71482d5dc7a7e9ca364.1474130360.git.lukas@wunner.de>
In-Reply-To: <cover.1474130360.git.lukas@wunner.de>
References: <cover.1474130360.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 18 Sep 2016 05:39:20 +0200
Subject: [PATCH v2 4/5] PCI: Avoid unnecessary resume after direct-complete
To: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 58a1fbbb2ee8 ("PM / PCI / ACPI: Kick devices that might have been
reset by firmware") added a runtime resume for devices that were runtime
suspended when the system entered sleep.

The motivation was that devices might be in a reset-power-on state after
waking from system sleep, so their power state as perceived by Linux
(stored in pci_dev->current_state) would no longer reflect reality.
By resuming such devices, we allow them to return to a low-power state
via autosuspend and also bring their current_state in sync with reality.

However for devices that are *not* in a reset-power-on state, doing an
unconditional resume wastes energy.  A more refined approach is called
for which issues a runtime resume only if the power state after
direct-complete is shallower than it was before. To achieve this, update
the device's current_state and compare it to its pre-sleep value.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci-driver.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e39a67c..fd4b9c4 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -684,8 +684,19 @@ static int pci_pm_prepare(struct device *dev)
 
 static void pci_pm_complete(struct device *dev)
 {
-	pci_dev_complete_resume(to_pci_dev(dev));
-	pm_complete_with_resume_check(dev);
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
+	pci_dev_complete_resume(pci_dev);
+	pm_generic_complete(dev);
+
+	/* Resume device if platform firmware has put it in reset-power-on */
+	if (dev->power.direct_complete && pm_resume_via_firmware()) {
+		pci_power_t pre_sleep_state = pci_dev->current_state;
+
+		pci_update_current_state(pci_dev, pci_dev->current_state);
+		if (pci_dev->current_state < pre_sleep_state)
+			pm_request_resume(dev);
+	}
 }
 
 #else /* !CONFIG_PM_SLEEP */
-- 
2.9.3

