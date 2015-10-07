Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM list <linux-pm@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [Update][PATCH 3/3] input: i8042: Avoid resetting controller on system suspend/resume
Date: Wed, 07 Oct 2015 03:03:57 +0200
Message-ID: <1738265.GZcYUZQGSy@vostro.rjw.lan>
In-Reply-To: <3385784.1Q539YNd1G@vostro.rjw.lan>
References: <10641052.oOBhM6BU9G@vostro.rjw.lan> <2723857.EVg1dAvTli@vostro.rjw.lan> <3385784.1Q539YNd1G@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the upcoming system suspend is not going to be handled by the
platform firmware, like in the suspend-to-idle case, it is not
necessary to reset the controller in i8042_pm_suspend(), so avoid
doing that.

Moreover, if the system resume currently in progress has not been
started by the platform firmware, like in the suspend-to-idle case,
i8042_controller_resume() need not be called by i8042_pm_resume(),
so avoid doing that too in that case.

Additionally, try to catch the event that woke up the system by
calling the interrupt handler early during system resume if it has
not been started by the platform firmware.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/input/serio/i8042.c |   32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/input/serio/i8042.c
===================================================================
--- linux-pm.orig/drivers/input/serio/i8042.c
+++ linux-pm/drivers/input/serio/i8042.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/i8042.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 
 #include <asm/io.h>
 
@@ -1170,7 +1171,8 @@ static int i8042_pm_suspend(struct devic
 {
 	int i;
 
-	i8042_controller_reset(true);
+	if (pm_suspend_via_firmware())
+		i8042_controller_reset(true);
 
 	/* Set up serio interrupts for system wakeup. */
 	for (i = 0; i < I8042_NUM_PORTS; i++) {
@@ -1183,8 +1185,17 @@ static int i8042_pm_suspend(struct devic
 	return 0;
 }
 
+static int i8042_pm_resume_noirq(struct device *dev)
+{
+	if (!pm_resume_via_firmware())
+		i8042_interrupt(0, NULL);
+
+	return 0;
+}
+
 static int i8042_pm_resume(struct device *dev)
 {
+	bool force_reset;
 	int i;
 
 	for (i = 0; i < I8042_NUM_PORTS; i++) {
@@ -1195,11 +1206,21 @@ static int i8042_pm_resume(struct device
 	}
 
 	/*
-	 * On resume from S2R we always try to reset the controller
-	 * to bring it in a sane state. (In case of S2D we expect
-	 * BIOS to reset the controller for us.)
+	 * If platform firmware was not going to be involved in suspend, we did
+	 * not restore the controller state to whatever it had been at boot
+	 * time, so we do not need to do anything.
 	 */
-	return i8042_controller_resume(true);
+	if (!pm_suspend_via_firmware())
+		return 0;
+
+	/*
+	 * We only need to reset the controller if we are resuming after handing
+	 * off control to the platform firmware, otherwise we can simply restore
+	 * the mode.
+	 */
+	force_reset = pm_resume_via_firmware();
+
+	return i8042_controller_resume(force_reset);
 }
 
 static int i8042_pm_thaw(struct device *dev)
@@ -1223,6 +1244,7 @@ static int i8042_pm_restore(struct devic
 
 static const struct dev_pm_ops i8042_pm_ops = {
 	.suspend	= i8042_pm_suspend,
+	.resume_noirq	= i8042_pm_resume_noirq,
 	.resume		= i8042_pm_resume,
 	.thaw		= i8042_pm_thaw,
 	.poweroff	= i8042_pm_reset,

