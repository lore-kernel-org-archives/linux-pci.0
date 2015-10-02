Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [RFC][PATCH v2 1/2] PM / sleep: Add flags to indicate platform firmware involvement
Date: Fri, 02 Oct 2015 03:52:34 +0200
Message-ID: <1753290.aWURjseO2E@vostro.rjw.lan>
In-Reply-To: <5472042.4c1h9diL7E@vostro.rjw.lan>
References: <10641052.oOBhM6BU9G@vostro.rjw.lan> <5472042.4c1h9diL7E@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are quite a few cases in which device drivers, bus types or
even the PM core itself may benefit from knowing whether or not
the platform firmware will be involved in the upcoming system power
transition (during system suspend) or whether or not it was involved
in it (during system resume).

For this reason, introduce global system suspend flags that can be
used by the platform code to expose that information for the benefit
of the other parts of the kernel and make the ACPI core set them
as appropriate.

Users of the new flags will be added later.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Apply EXPORT_SYMBOL_GPL() to pm_suspend_global_flags so modular
drivers can use it too.

---
 drivers/acpi/sleep.c    |    3 +++
 include/linux/suspend.h |   36 ++++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c  |    4 ++++
 3 files changed, 43 insertions(+)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -202,6 +202,36 @@ struct platform_freeze_ops {
 extern void suspend_set_ops(const struct platform_suspend_ops *ops);
 extern int suspend_valid_only_mem(suspend_state_t state);
 
+extern unsigned int pm_suspend_global_flags;
+
+#define PM_SUSPEND_FLAG_FW_SUSPEND	(1 << 0)
+#define PM_SUSPEND_FLAG_FW_RESUME	(1 << 1)
+
+static inline void pm_suspend_clear_flags(void)
+{
+	pm_suspend_global_flags = 0;
+}
+
+static inline void pm_set_suspend_via_firmware(void)
+{
+	pm_suspend_global_flags |= PM_SUSPEND_FLAG_FW_SUSPEND;
+}
+
+static inline void pm_set_resume_via_firmware(void)
+{
+	pm_suspend_global_flags |= PM_SUSPEND_FLAG_FW_RESUME;
+}
+
+static inline bool pm_suspend_via_firmware(void)
+{
+	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_FW_SUSPEND);
+}
+
+static inline bool pm_resume_via_firmware(void)
+{
+	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_FW_RESUME);
+}
+
 /* Suspend-to-idle state machnine. */
 enum freeze_state {
 	FREEZE_STATE_NONE,      /* Not suspended/suspending. */
@@ -241,6 +271,12 @@ extern int pm_suspend(suspend_state_t st
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
+static inline void pm_suspend_clear_flags(void) {}
+static inline void pm_set_suspend_via_firmware(void) {}
+static inline void pm_set_resume_via_firmware(void) {}
+static inline bool pm_suspend_via_firmware(void) { return false; }
+static inline bool pm_resume_via_firmware(void) { return false; }
+
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
 static inline bool idle_should_freeze(void) { return false; }
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -35,6 +35,9 @@
 const char *pm_labels[] = { "mem", "standby", "freeze", NULL };
 const char *pm_states[PM_SUSPEND_MAX];
 
+unsigned int pm_suspend_global_flags;
+EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
+
 static const struct platform_suspend_ops *suspend_ops;
 static const struct platform_freeze_ops *freeze_ops;
 static DECLARE_WAIT_QUEUE_HEAD(suspend_freeze_wait_head);
@@ -493,6 +496,7 @@ static int enter_state(suspend_state_t s
 #endif
 
 	pr_debug("PM: Preparing system for sleep (%s)\n", pm_states[state]);
+	pm_suspend_clear_flags();
 	error = suspend_prepare(state);
 	if (error)
 		goto Unlock;
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -487,6 +487,8 @@ static int acpi_suspend_begin(suspend_st
 		pr_err("ACPI does not support sleep state S%u\n", acpi_state);
 		return -ENOSYS;
 	}
+	if (acpi_state > ACPI_STATE_S1)
+		pm_set_suspend_via_firmware();
 
 	acpi_pm_start(acpi_state);
 	return 0;
@@ -522,6 +524,7 @@ static int acpi_suspend_enter(suspend_st
 		if (error)
 			return error;
 		pr_info(PREFIX "Low-level resume complete\n");
+		pm_set_resume_via_firmware();
 		break;
 	}
 	trace_suspend_resume(TPS("acpi_suspend"), acpi_state, false);

