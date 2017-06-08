Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43609 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751441AbdFHAN0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2017 20:13:26 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mario Limonciello <mario_limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans De Goede <hdegoede@redhat.com>
Subject: [PATCH 6/6] ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle
Date: Thu, 08 Jun 2017 02:06:11 +0200
Message-ID: <1856199.nW9IXpiBxi@aspire.rjw.lan>
In-Reply-To: <8918199.uo13RZ8hZk@aspire.rjw.lan>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI SCI (System Control Interrupt) is set up as a wakeup IRQ
during suspend-to-idle transitions and, consequently, any events
signaled through it wake up the system from that state.  However,
on some systems some of the events signaled via the ACPI SCI while
suspended to idle should not cause the system to wake up.  In fact,
quite often they should just be discarded.

Arguably, systems should not resume entirely on such events, but in
order to decide which events really should cause the system to resume
and which are spurious, it is necessary to resume up to the point
when ACPI SCIs are actually handled and processed, which is after
executing dpm_resume_noirq() in the system resume path.

For this reasons, add a loop around freeze_enter() in which the
platforms can process events signaled via multiplexed IRQ lines
like the ACPI SCI and add suspend-to-idle hooks that can be
used for this purpose to struct platform_freeze_ops.

In the ACPI case, the ->wake hook is used for checking if the SCI
has triggered while suspended and deferring the interrupt-induced
system wakeup until the events signaled through it are actually
processed sufficiently to decide whether or not the system should
resume.  In turn, the ->sync hook allows all of the relevant event
queues to be flushed so as to prevent events from being missed due
to race conditions.

In addition to that, some ACPI code processing wakeup events needs
to be modified to use the "hard" version of wakeup triggers, so that
it will cause a system resume to happen on device-induced wakeup
events even if the "soft" mechanism to prevent the system from
suspending is not enabled.  However, to preserve the existing
behavior with respect to suspend-to-RAM, this only is done in
the suspend-to-idle case and only if an SCI has occurred while
suspended.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c      |    2 +-
 drivers/acpi/button.c       |    5 +++--
 drivers/acpi/device_pm.c    |    9 ++++++++-
 drivers/acpi/internal.h     |    2 ++
 drivers/acpi/sleep.c        |   37 +++++++++++++++++++++++++++++++++++++
 drivers/base/power/main.c   |    5 -----
 drivers/base/power/wakeup.c |   18 ++++++++++++------
 include/acpi/acpi_bus.h     |    4 ++++
 include/linux/suspend.h     |    7 +++++--
 kernel/power/process.c      |    2 +-
 kernel/power/suspend.c      |   35 +++++++++++++++++++++++++++++------
 11 files changed, 102 insertions(+), 24 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -189,6 +189,8 @@ struct platform_suspend_ops {
 struct platform_freeze_ops {
 	int (*begin)(void);
 	int (*prepare)(void);
+	void (*wake)(void);
+	void (*sync)(void);
 	void (*restore)(void);
 	void (*end)(void);
 };
@@ -428,7 +430,8 @@ extern unsigned int pm_wakeup_irq;
 
 extern bool pm_wakeup_pending(void);
 extern void pm_system_wakeup(void);
-extern void pm_wakeup_clear(void);
+extern void pm_system_cancel_wakeup(void);
+extern void pm_wakeup_clear(bool reset);
 extern void pm_system_irq_wakeup(unsigned int irq_number);
 extern bool pm_get_wakeup_count(unsigned int *count, bool block);
 extern bool pm_save_wakeup_count(unsigned int count);
@@ -478,7 +481,7 @@ static inline int unregister_pm_notifier
 
 static inline bool pm_wakeup_pending(void) { return false; }
 static inline void pm_system_wakeup(void) {}
-static inline void pm_wakeup_clear(void) {}
+static inline void pm_wakeup_clear(bool reset) {}
 static inline void pm_system_irq_wakeup(unsigned int irq_number) {}
 
 static inline void lock_system_sleep(void) {}
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -72,6 +72,8 @@ static void freeze_begin(void)
 
 static void freeze_enter(void)
 {
+	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_FREEZE, true);
+
 	spin_lock_irq(&suspend_freeze_lock);
 	if (pm_wakeup_pending())
 		goto out;
@@ -84,11 +86,9 @@ static void freeze_enter(void)
 
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
-	pr_debug("PM: suspend-to-idle\n");
 	/* Make the current CPU wait so it can enter the idle loop too. */
 	wait_event(suspend_freeze_wait_head,
 		   suspend_freeze_state == FREEZE_STATE_WAKE);
-	pr_debug("PM: resume from suspend-to-idle\n");
 
 	cpuidle_pause();
 	put_online_cpus();
@@ -98,6 +98,31 @@ static void freeze_enter(void)
  out:
 	suspend_freeze_state = FREEZE_STATE_NONE;
 	spin_unlock_irq(&suspend_freeze_lock);
+
+	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_FREEZE, false);
+}
+
+static void s2idle_loop(void)
+{
+	pr_debug("PM: suspend-to-idle\n");
+
+	do {
+		freeze_enter();
+
+		if (freeze_ops && freeze_ops->wake)
+			freeze_ops->wake();
+
+		dpm_resume_noirq(PMSG_RESUME);
+		if (freeze_ops && freeze_ops->sync)
+			freeze_ops->sync();
+
+		if (pm_wakeup_pending())
+			break;
+
+		pm_wakeup_clear(false);
+	} while (!dpm_suspend_noirq(PMSG_SUSPEND));
+
+	pr_debug("PM: resume from suspend-to-idle\n");
 }
 
 void freeze_wake(void)
@@ -371,10 +396,8 @@ static int suspend_enter(suspend_state_t
 	 * all the devices are suspended.
 	 */
 	if (state == PM_SUSPEND_FREEZE) {
-		trace_suspend_resume(TPS("machine_suspend"), state, true);
-		freeze_enter();
-		trace_suspend_resume(TPS("machine_suspend"), state, false);
-		goto Platform_wake;
+		s2idle_loop();
+		goto Platform_early_resume;
 	}
 
 	error = disable_nonboot_cpus();
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1095,11 +1095,6 @@ static int __device_suspend_noirq(struct
 	if (async_error)
 		goto Complete;
 
-	if (pm_wakeup_pending()) {
-		async_error = -EBUSY;
-		goto Complete;
-	}
-
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -28,8 +28,8 @@ bool events_check_enabled __read_mostly;
 /* First wakeup IRQ seen by the kernel in the last cycle. */
 unsigned int pm_wakeup_irq __read_mostly;
 
-/* If set and the system is suspending, terminate the suspend. */
-static bool pm_abort_suspend __read_mostly;
+/* If greater than 0 and the system is suspending, terminate the suspend. */
+static atomic_t pm_abort_suspend __read_mostly;
 
 /*
  * Combined counters of registered wakeup events and wakeup events in progress.
@@ -855,20 +855,26 @@ bool pm_wakeup_pending(void)
 		pm_print_active_wakeup_sources();
 	}
 
-	return ret || pm_abort_suspend;
+	return ret || atomic_read(&pm_abort_suspend) > 0;
 }
 
 void pm_system_wakeup(void)
 {
-	pm_abort_suspend = true;
+	atomic_inc(&pm_abort_suspend);
 	freeze_wake();
 }
 EXPORT_SYMBOL_GPL(pm_system_wakeup);
 
-void pm_wakeup_clear(void)
+void pm_system_cancel_wakeup(void)
+{
+	atomic_dec(&pm_abort_suspend);
+}
+
+void pm_wakeup_clear(bool reset)
 {
-	pm_abort_suspend = false;
 	pm_wakeup_irq = 0;
+	if (reset)
+		atomic_set(&pm_abort_suspend, 0);
 }
 
 void pm_system_irq_wakeup(unsigned int irq_number)
Index: linux-pm/kernel/power/process.c
===================================================================
--- linux-pm.orig/kernel/power/process.c
+++ linux-pm/kernel/power/process.c
@@ -132,7 +132,7 @@ int freeze_processes(void)
 	if (!pm_freezing)
 		atomic_inc(&system_freezing_cnt);
 
-	pm_wakeup_clear();
+	pm_wakeup_clear(true);
 	pr_info("Freezing user space processes ... ");
 	pm_freezing = true;
 	error = try_to_freeze_tasks(true);
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -650,6 +650,8 @@ static const struct platform_suspend_ops
 	.recover = acpi_pm_finish,
 };
 
+static bool s2idle_wakeup;
+
 static int acpi_freeze_begin(void)
 {
 	acpi_scan_lock_acquire();
@@ -666,6 +668,33 @@ static int acpi_freeze_prepare(void)
 	return 0;
 }
 
+static void acpi_freeze_wake(void)
+{
+	/*
+	 * If IRQD_WAKEUP_ARMED is not set for the SCI at this point, it means
+	 * that the SCI has triggered while suspended, so cancel the wakeup in
+	 * case it has not been a wakeup event (the GPEs will be checked later).
+	 */
+	if (acpi_sci_irq_valid() &&
+	    !irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
+		pm_system_cancel_wakeup();
+		s2idle_wakeup = true;
+	}
+}
+
+static void acpi_freeze_sync(void)
+{
+	/*
+	 * Process all pending events in case there are any wakeup ones.
+	 *
+	 * The EC driver uses the system workqueue, so that one needs to be
+	 * flushed too.
+	 */
+	acpi_os_wait_events_complete();
+	flush_scheduled_work();
+	s2idle_wakeup = false;
+}
+
 static void acpi_freeze_restore(void)
 {
 	if (acpi_sci_irq_valid())
@@ -682,6 +711,8 @@ static void acpi_freeze_end(void)
 static const struct platform_freeze_ops acpi_freeze_ops = {
 	.begin = acpi_freeze_begin,
 	.prepare = acpi_freeze_prepare,
+	.wake = acpi_freeze_wake,
+	.sync = acpi_freeze_sync,
 	.restore = acpi_freeze_restore,
 	.end = acpi_freeze_end,
 };
@@ -700,9 +731,15 @@ static void acpi_sleep_suspend_setup(voi
 }
 
 #else /* !CONFIG_SUSPEND */
+#define s2idle_wakeup	(false)
 static inline void acpi_sleep_suspend_setup(void) {}
 #endif /* !CONFIG_SUSPEND */
 
+bool acpi_s2idle_wakeup(void)
+{
+	return s2idle_wakeup;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static u32 saved_bm_rld;
 
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -24,6 +24,7 @@
 #include <linux/pm_qos.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/suspend.h>
 
 #include "internal.h"
 
@@ -385,6 +386,12 @@ EXPORT_SYMBOL(acpi_bus_power_manageable)
 #ifdef CONFIG_PM
 static DEFINE_MUTEX(acpi_pm_notifier_lock);
 
+void acpi_wakeup_event(struct device *dev)
+{
+	pm_wakeup_dev_event(dev, 0, acpi_s2idle_wakeup());
+}
+EXPORT_SYMBOL_GPL(acpi_wakeup_event);
+
 static void acpi_pm_notify_handler(acpi_handle handle, u32 val, void *not_used)
 {
 	struct acpi_device *adev;
@@ -399,7 +406,7 @@ static void acpi_pm_notify_handler(acpi_
 	mutex_lock(&acpi_pm_notifier_lock);
 
 	if (adev->wakeup.flags.notifier_present) {
-		__pm_wakeup_event(adev->wakeup.ws, 0);
+		pm_wakeup_ws_event(adev->wakeup.ws, 0, acpi_s2idle_wakeup());
 		if (adev->wakeup.context.func)
 			adev->wakeup.context.func(&adev->wakeup.context);
 	}
Index: linux-pm/drivers/acpi/button.c
===================================================================
--- linux-pm.orig/drivers/acpi/button.c
+++ linux-pm/drivers/acpi/button.c
@@ -217,7 +217,7 @@ static int acpi_lid_notify_state(struct
 	}
 
 	if (state)
-		pm_wakeup_event(&device->dev, 0);
+		acpi_wakeup_event(&device->dev);
 
 	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
 	if (ret == NOTIFY_DONE)
@@ -402,7 +402,7 @@ static void acpi_button_notify(struct ac
 		} else {
 			int keycode;
 
-			pm_wakeup_event(&device->dev, 0);
+			acpi_wakeup_event(&device->dev);
 			if (button->suspended)
 				break;
 
@@ -534,6 +534,7 @@ static int acpi_button_add(struct acpi_d
 		lid_device = device;
 	}
 
+	device_init_wakeup(&device->dev, true);
 	printk(KERN_INFO PREFIX "%s [%s]\n", name, acpi_device_bid(device));
 	return 0;
 
Index: linux-pm/drivers/acpi/battery.c
===================================================================
--- linux-pm.orig/drivers/acpi/battery.c
+++ linux-pm/drivers/acpi/battery.c
@@ -782,7 +782,7 @@ static int acpi_battery_update(struct ac
 	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
 	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
             (battery->capacity_now <= battery->alarm)))
-		pm_wakeup_event(&battery->device->dev, 0);
+		acpi_wakeup_event(&battery->device->dev);
 
 	return result;
 }
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -198,8 +198,10 @@ void acpi_ec_remove_query_handler(struct
                                   Suspend/Resume
   -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
+extern bool acpi_s2idle_wakeup(void);
 extern int acpi_sleep_init(void);
 #else
+static inline bool acpi_s2idle_wakeup(void) { return false; }
 static inline int acpi_sleep_init(void) { return -ENXIO; }
 #endif
 
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -598,12 +598,16 @@ static inline bool acpi_device_always_pr
 #endif
 
 #ifdef CONFIG_PM
+void acpi_wakeup_event(struct device *dev);
 acpi_status acpi_add_pm_notifier(struct acpi_device *adev, struct device *dev,
 			void (*func)(struct acpi_device_wakeup_context *context));
 acpi_status acpi_remove_pm_notifier(struct acpi_device *adev);
 int acpi_pm_device_sleep_state(struct device *, int *, int);
 int acpi_pm_device_run_wake(struct device *, bool);
 #else
+void acpi_wakeup_event(struct device *dev)
+{
+}
 static inline acpi_status acpi_add_pm_notifier(struct acpi_device *adev,
 					       struct device *dev,
 				               void (*work_func)(struct work_struct *work))
