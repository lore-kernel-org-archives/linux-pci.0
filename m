Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] ACPI / PM: Rename acpi_wakeup_device() to acpi_device_pm_event()
Date: Sat, 19 Jul 2014 22:38:12 +0200
Message-ID: <11454851.tGNHnoC7c5@vostro.rjw.lan>
In-Reply-To: <1907495.agrCMfRsQN@vostro.rjw.lan>
References: <1907495.agrCMfRsQN@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To avoid confusion with acpi_device_wakeup(), rename the default
ACPI device PM notify handler from acpi_wakeup_device() to
acpi_device_pm_event().

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -640,12 +640,12 @@ static int acpi_device_wakeup(struct acp
 
 #ifdef CONFIG_PM_RUNTIME
 /**
- * acpi_wakeup_device - Wakeup notification handler for ACPI devices.
+ * acpi_device_pm_event - Wakeup notification handler for ACPI devices.
  * @handle: ACPI handle of the device the notification is for.
  * @event: Type of the signaled event.
  * @context: Device corresponding to @handle.
  */
-static void acpi_wakeup_device(acpi_handle handle, u32 event, void *context)
+static void acpi_device_pm_event(acpi_handle handle, u32 event, void *context)
 {
 	struct device *dev = context;
 
@@ -680,7 +680,7 @@ int acpi_pm_device_run_wake(struct devic
 }
 EXPORT_SYMBOL(acpi_pm_device_run_wake);
 #else
-static inline void acpi_wakeup_device(acpi_handle handle, u32 event,
+static inline void acpi_device_pm_event(acpi_handle handle, u32 event,
 				      void *context) {}
 #endif /* CONFIG_PM_RUNTIME */
 
@@ -1036,7 +1036,7 @@ int acpi_dev_pm_attach(struct device *de
 	if (dev->pm_domain)
 		return -EEXIST;
 
-	acpi_add_pm_notifier(adev, acpi_wakeup_device, dev);
+	acpi_add_pm_notifier(adev, acpi_device_pm_event, dev);
 	dev->pm_domain = &acpi_general_pm_domain;
 	if (power_on) {
 		acpi_dev_pm_full_power(adev);
@@ -1064,7 +1064,7 @@ void acpi_dev_pm_detach(struct device *d
 
 	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
 		dev->pm_domain = NULL;
-		acpi_remove_pm_notifier(adev, acpi_wakeup_device);
+		acpi_remove_pm_notifier(adev, acpi_device_pm_event);
 		if (power_off) {
 			/*
 			 * If the device's PM QoS resume latency limit or flags

