Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 10/12] PM / core: Add LEAVE_SUSPENDED driver flag
Date: Mon, 16 Oct 2017 03:30:22 +0200
Message-ID: <1571653.x1WQWp6nIP@aspire.rjw.lan>
In-Reply-To: <3806130.B2KCK0tvef@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Define and document a new driver flag, DPM_FLAG_LEAVE_SUSPENDED, to
instruct the PM core that it is desirable to leave the device in
runtime suspend after system resume (for example, the device may be
slow to resume and it may be better to avoid resuming it right away
for this reason).

Setting that flag causes the PM core to skip the ->resume_noirq,
->resume_early and ->resume callbacks for the device (like in the
direct-complete optimization case) if (1) the wakeup settings of it
are compatible with runtime PM (that is, either the device is
configured to wake up the system from sleep or it cannot generate
wakeup signals at all), and it will not be used for resuming any of
its children or consumers.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/pm/devices.rst |   20 +++++++
 drivers/base/power/main.c               |   81 ++++++++++++++++++++++++++++++--
 include/linux/pm.h                      |   12 +++-
 3 files changed, 104 insertions(+), 9 deletions(-)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -559,6 +559,7 @@ struct pm_subsys_data {
  * NEVER_SKIP: Do not skip system suspend/resume callbacks for the device.
  * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
  * SMART_SUSPEND: No need to resume the device from runtime suspend.
+ * LEAVE_SUSPENDED: Avoid resuming the device during system resume if possible.
  *
  * Setting SMART_PREPARE instructs bus types and PM domains which may want
  * system suspend/resume callbacks to be skipped for the device to return 0 from
@@ -573,10 +574,14 @@ struct pm_subsys_data {
  * the "late" and "noirq" phases of device suspend for the device if it remains
  * in runtime suspend at the beginning of the "late" phase (when runtime PM has
  * been disabled for it).
+ *
+ * Setting LEAVE_SUSPENDED informs the PM core and middle layer code that the
+ * driver prefers the device to be left in runtime suspend after system resume.
  */
-#define DPM_FLAG_NEVER_SKIP	BIT(0)
-#define DPM_FLAG_SMART_PREPARE	BIT(1)
-#define DPM_FLAG_SMART_SUSPEND	BIT(2)
+#define DPM_FLAG_NEVER_SKIP		BIT(0)
+#define DPM_FLAG_SMART_PREPARE		BIT(1)
+#define DPM_FLAG_SMART_SUSPEND		BIT(2)
+#define DPM_FLAG_LEAVE_SUSPENDED	BIT(3)
 
 struct dev_pm_info {
 	pm_message_t		power_state;
@@ -598,6 +603,7 @@ struct dev_pm_info {
 	bool			wakeup_path:1;
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
+	unsigned int		must_resume:1;	/* Owned by the PM core */
 #else
 	unsigned int		should_wakeup:1;
 #endif
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -705,6 +705,12 @@ static int device_resume_early(struct de
 	if (!dev->power.is_late_suspended)
 		goto Out;
 
+	if (dev_pm_test_driver_flags(dev, DPM_FLAG_LEAVE_SUSPENDED) &&
+	    !dev->power.must_resume) {
+		pm_runtime_set_suspended(dev);
+		goto Out;
+	}
+
 	dpm_wait_for_superior(dev, async);
 
 	if (dev->pm_domain) {
@@ -1098,6 +1104,32 @@ static pm_message_t resume_event(pm_mess
 	return PMSG_ON;
 }
 
+static void dpm_suppliers_set_must_resume(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+		link->supplier->power.must_resume = true;
+
+	device_links_read_unlock(idx);
+}
+
+static void dpm_leave_suspended(struct device *dev)
+{
+	pm_runtime_set_suspended(dev);
+	dev->power.is_suspended = false;
+	dev->power.is_late_suspended = false;
+	/*
+	 * This tells middle layer code to schedule runtime resume of the device
+	 * from its ->complete callback to update the device's power state in
+	 * case the platform firmware has been involved in resuming the system.
+	 */
+	dev->power.direct_complete = true;
+}
+
 /**
  * __device_suspend_noirq - Execute a "noirq suspend" callback for given device.
  * @dev: Device to handle.
@@ -1135,8 +1167,20 @@ static int __device_suspend_noirq(struct
 	 * the callback invocation for them.
 	 */
 	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
-	    pm_runtime_status_suspended(dev))
-		goto Skip;
+	    pm_runtime_status_suspended(dev)) {
+		/*
+		 * The device may be left suspended during system resume if
+		 * that is preferred by its driver and it will not be used for
+		 * resuming any of its children or consumers.
+		 */
+		if (dev_pm_test_driver_flags(dev, DPM_FLAG_LEAVE_SUSPENDED) &&
+		    !dev->power.must_resume) {
+			dpm_leave_suspended(dev);
+			goto Complete;
+		} else {
+			goto Skip;
+		}
+	}
 
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
@@ -1163,6 +1207,28 @@ static int __device_suspend_noirq(struct
 		goto Complete;
 	}
 
+	/*
+	 * The device may be left suspended during system resume if that is
+	 * preferred by its driver and its wakeup configuration is compatible
+	 * with runtime PM, and it will not be used for resuming any of its
+	 * children or consumers.
+	 */
+	if (dev_pm_test_driver_flags(dev, DPM_FLAG_LEAVE_SUSPENDED) &&
+	    (device_may_wakeup(dev) || !device_can_wakeup(dev)) &&
+	    !dev->power.must_resume) {
+		dpm_leave_suspended(dev);
+		goto Complete;
+	}
+
+	/*
+	 * The parent and suppliers will be necessary to resume the device
+	 * during system resume, so avoid leaving them in runtime suspend.
+	 */
+	if (dev->parent)
+		dev->parent->power.must_resume = true;
+
+	dpm_suppliers_set_must_resume(dev);
+
 Skip:
 	dev->power.is_noirq_suspended = true;
 
@@ -1698,8 +1764,9 @@ static int device_prepare(struct device
 	if (dev->power.syscore)
 		return 0;
 
-	WARN_ON(dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
-		!pm_runtime_enabled(dev));
+	WARN_ON(!pm_runtime_enabled(dev) &&
+		dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
+					      DPM_FLAG_LEAVE_SUSPENDED));
 
 	/*
 	 * If a device's parent goes into runtime suspend at the wrong time,
@@ -1712,6 +1779,12 @@ static int device_prepare(struct device
 	device_lock(dev);
 
 	dev->power.wakeup_path = device_may_wakeup(dev);
+	/*
+	 * Avoid leaving devices in suspend after transitions that don't really
+	 * suspend them in general.
+	 */
+	dev->power.must_resume = state.event == PM_EVENT_FREEZE ||
+				state.event == PM_EVENT_QUIESCE;
 
 	if (dev->power.no_pm_callbacks) {
 		ret = 1;	/* Let device go direct_complete */
Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -785,6 +785,22 @@ means that they should be put into the f
 
 During system-wide resume from a sleep state it's easiest to put devices into
 the full-power state, as explained in :file:`Documentation/power/runtime_pm.txt`.
-Refer to that document for more information regarding this particular issue as
+[Refer to that document for more information regarding this particular issue as
 well as for information on the device runtime power management framework in
-general.
+general.]
+
+However, it may be desirable to leave some devices in runtime suspend after
+system resume and device drivers can use the ``DPM_FLAG_LEAVE_SUSPENDED`` flag
+to indicate to the PM core that this is the case.  If that flag is set for a
+device and the wakeup settings of it are compatible with runtime PM (that is,
+either the device is configured to wake up the system from sleep or it cannot
+generate wakeup signals at all), and it will not be used for resuming any of its
+children or consumers, the PM core will skip all of the system resume callbacks
+in the ``resume_noirq``, ``resume_early`` and ``resume`` phases for it and its
+runtime power management status will be set to "suspended".
+
+Still, if the platform firmware is involved in the handling of system resume, it
+may change the state of devices in unpredictable ways, so in that case the
+middle layer code (for example, a bus type or PM domain) the driver works with
+should update the device's power state and schedule runtime resume of it to
+align its power settings with the expectations of the runtime PM framework.
