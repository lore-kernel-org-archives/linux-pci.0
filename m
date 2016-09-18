Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-Id: <760eb8c67a02e35938a4fbd3b31cbe9bb1414c5a.1474130360.git.lukas@wunner.de>
In-Reply-To: <cover.1474130360.git.lukas@wunner.de>
References: <cover.1474130360.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 18 Sep 2016 05:39:20 +0200
Subject: [PATCH v2 5/5] PCI: Avoid unnecessary resume on shutdown
To: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We currently perform a mandatory runtime resume of all PCI devices on
->shutdown.  However it is pointless to wake devices only to immediately
power them down afterwards.  (Or have the firmware reset them, in case
of a reboot.)

It seems there are only two cases when a runtime resume is actually
necessary:  If the driver has declared a ->shutdown callback or if kexec
is in progress.

Constrain resume of a device to these cases and let it slumber
otherwise, thereby conserving energy and speeding up shutdown.

To prevent the device from being runtime resumed during the remainder of
the shutdown process, disable runtime PM for it.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---

Changes since v1:
* Disable runtime PM on the device to prevent it from being runtime
  resumed during the remainder of the shutdown process.

 drivers/pci/pci-driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index fd4b9c4..f21c620 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -459,6 +459,15 @@ static void pci_device_shutdown(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	/* Fast path for suspended devices */
+	if (pm_runtime_status_suspended(dev) && (!drv || !drv->shutdown) &&
+	    !kexec_in_progress) {
+		pm_runtime_disable(dev);
+		if (pm_runtime_status_suspended(dev))
+			return;
+		pm_runtime_enable(dev);
+	}
+
 	pm_runtime_resume(dev);
 
 	if (drv && drv->shutdown)
-- 
2.9.3

