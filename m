Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] ACPI / PM: Split acpi_device_wakeup()
Date: Fri, 21 Jul 2017 14:40:49 +0200
Message-ID: <3408475.MC8krXn0zk@aspire.rjw.lan>
In-Reply-To: <3116391.JNS1F4DjTg@aspire.rjw.lan>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To prepare for a subsequent change and make the code somewhat easier
to follow, do the following in the ACPI device wakeup handling code:

 * Replace wakeup.flags.enabled under struct acpi_device with
   wakeup.enable_count as that will be necessary going forward.

   For now, wakeup.enable_count is not allowed to grow beyond 1,
   so the current behavior is retained.

 * Split acpi_device_wakeup() into acpi_device_wakeup_enable()
   and acpi_device_wakeup_disable() and modify the callers of
   it accordingly.

 * Introduce a new acpi_wakeup_lock mutex to protect the wakeup
   enabling/disabling code from races in case it is executed
   more than once in parallel for the same device (which may
   happen for bridges theoretically).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |  121 ++++++++++++++++++++++++++++++-----------------
 include/acpi/acpi_bus.h  |    2 
 2 files changed, 80 insertions(+), 43 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -680,47 +680,74 @@ static void acpi_pm_notify_work_func(str
 	}
 }
 
+static DEFINE_MUTEX(acpi_wakeup_lock);
+
 /**
- * acpi_device_wakeup - Enable/disable wakeup functionality for device.
- * @adev: ACPI device to enable/disable wakeup functionality for.
+ * acpi_device_wakeup_enable - Enable wakeup functionality for device.
+ * @adev: ACPI device to enable wakeup functionality for.
  * @target_state: State the system is transitioning into.
- * @enable: Whether to enable or disable the wakeup functionality.
  *
- * Enable/disable the GPE associated with @adev so that it can generate
- * wakeup signals for the device in response to external (remote) events and
- * enable/disable device wakeup power.
+ * Enable the GPE associated with @adev so that it can generate wakeup signals
+ * for the device in response to external (remote) events and enable wakeup
+ * power for it.
  *
  * Callers must ensure that @adev is a valid ACPI device node before executing
  * this function.
  */
-static int acpi_device_wakeup(struct acpi_device *adev, u32 target_state,
-			      bool enable)
+static int acpi_device_wakeup_enable(struct acpi_device *adev, u32 target_state)
 {
 	struct acpi_device_wakeup *wakeup = &adev->wakeup;
+	acpi_status status;
+	int error = 0;
 
-	if (enable) {
-		acpi_status res;
-		int error;
+	mutex_lock(&acpi_wakeup_lock);
 
-		if (adev->wakeup.flags.enabled)
-			return 0;
+	if (wakeup->enable_count > 0)
+		goto out;
 
-		error = acpi_enable_wakeup_device_power(adev, target_state);
-		if (error)
-			return error;
+	error = acpi_enable_wakeup_device_power(adev, target_state);
+	if (error)
+		goto out;
 
-		res = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
-		if (ACPI_FAILURE(res)) {
-			acpi_disable_wakeup_device_power(adev);
-			return -EIO;
-		}
-		adev->wakeup.flags.enabled = 1;
-	} else if (adev->wakeup.flags.enabled) {
-		acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
+	status = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
+	if (ACPI_FAILURE(status)) {
 		acpi_disable_wakeup_device_power(adev);
-		adev->wakeup.flags.enabled = 0;
+		error = -EIO;
+		goto out;
 	}
-	return 0;
+
+	wakeup->enable_count++;
+
+out:
+	mutex_unlock(&acpi_wakeup_lock);
+	return error;
+}
+
+/**
+ * acpi_device_wakeup_disable - Disable wakeup functionality for device.
+ * @adev: ACPI device to disable wakeup functionality for.
+ *
+ * Disable the GPE associated with @adev and disable wakeup power for it.
+ *
+ * Callers must ensure that @adev is a valid ACPI device node before executing
+ * this function.
+ */
+static void acpi_device_wakeup_disable(struct acpi_device *adev)
+{
+	struct acpi_device_wakeup *wakeup = &adev->wakeup;
+
+	mutex_lock(&acpi_wakeup_lock);
+
+	if (!wakeup->enable_count)
+		goto out;
+
+	acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
+	acpi_disable_wakeup_device_power(adev);
+
+	wakeup->enable_count--;
+
+out:
+	mutex_unlock(&acpi_wakeup_lock);
 }
 
 /**
@@ -742,9 +769,15 @@ int acpi_pm_set_device_wakeup(struct dev
 	if (!acpi_device_can_wakeup(adev))
 		return -EINVAL;
 
-	error = acpi_device_wakeup(adev, acpi_target_system_state(), enable);
+	if (!enable) {
+		acpi_device_wakeup_disable(adev);
+		dev_dbg(dev, "Wakeup disabled by ACPI\n");
+		return 0;
+	}
+
+	error = acpi_device_wakeup_enable(adev, acpi_target_system_state());
 	if (!error)
-		dev_dbg(dev, "Wakeup %s by ACPI\n", enable ? "enabled" : "disabled");
+		dev_dbg(dev, "Wakeup enabled by ACPI\n");
 
 	return error;
 }
@@ -798,13 +831,15 @@ int acpi_dev_runtime_suspend(struct devi
 
 	remote_wakeup = dev_pm_qos_flags(dev, PM_QOS_FLAG_REMOTE_WAKEUP) >
 				PM_QOS_FLAGS_NONE;
-	error = acpi_device_wakeup(adev, ACPI_STATE_S0, remote_wakeup);
-	if (remote_wakeup && error)
-		return -EAGAIN;
+	if (remote_wakeup) {
+		error = acpi_device_wakeup_enable(adev, ACPI_STATE_S0);
+		if (error)
+			return -EAGAIN;
+	}
 
 	error = acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
-	if (error)
-		acpi_device_wakeup(adev, ACPI_STATE_S0, false);
+	if (error && remote_wakeup)
+		acpi_device_wakeup_disable(adev);
 
 	return error;
 }
@@ -827,7 +862,7 @@ int acpi_dev_runtime_resume(struct devic
 		return 0;
 
 	error = acpi_dev_pm_full_power(adev);
-	acpi_device_wakeup(adev, ACPI_STATE_S0, false);
+	acpi_device_wakeup_disable(adev);
 	return error;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_runtime_resume);
@@ -882,13 +917,15 @@ int acpi_dev_suspend_late(struct device
 
 	target_state = acpi_target_system_state();
 	wakeup = device_may_wakeup(dev) && acpi_device_can_wakeup(adev);
-	error = acpi_device_wakeup(adev, target_state, wakeup);
-	if (wakeup && error)
-		return error;
+	if (wakeup) {
+		error = acpi_device_wakeup_enable(adev, target_state);
+		if (error)
+			return error;
+	}
 
 	error = acpi_dev_pm_low_power(dev, adev, target_state);
-	if (error)
-		acpi_device_wakeup(adev, ACPI_STATE_UNKNOWN, false);
+	if (error && wakeup)
+		acpi_device_wakeup_disable(adev);
 
 	return error;
 }
@@ -911,7 +948,7 @@ int acpi_dev_resume_early(struct device
 		return 0;
 
 	error = acpi_dev_pm_full_power(adev);
-	acpi_device_wakeup(adev, ACPI_STATE_UNKNOWN, false);
+	acpi_device_wakeup_disable(adev);
 	return error;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_resume_early);
@@ -1054,7 +1091,7 @@ static void acpi_dev_pm_detach(struct de
 			 */
 			dev_pm_qos_hide_latency_limit(dev);
 			dev_pm_qos_hide_flags(dev);
-			acpi_device_wakeup(adev, ACPI_STATE_S0, false);
+			acpi_device_wakeup_disable(adev);
 			acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
 		}
 	}
@@ -1098,7 +1135,7 @@ int acpi_dev_pm_attach(struct device *de
 	dev_pm_domain_set(dev, &acpi_general_pm_domain);
 	if (power_on) {
 		acpi_dev_pm_full_power(adev);
-		acpi_device_wakeup(adev, ACPI_STATE_S0, false);
+		acpi_device_wakeup_disable(adev);
 	}
 
 	dev->pm_domain->detach = acpi_dev_pm_detach;
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -316,7 +316,6 @@ struct acpi_device_perf {
 struct acpi_device_wakeup_flags {
 	u8 valid:1;		/* Can successfully enable wakeup? */
 	u8 notifier_present:1;  /* Wake-up notify handler has been installed */
-	u8 enabled:1;		/* Enabled for wakeup */
 };
 
 struct acpi_device_wakeup_context {
@@ -333,6 +332,7 @@ struct acpi_device_wakeup {
 	struct acpi_device_wakeup_context context;
 	struct wakeup_source *ws;
 	int prepare_count;
+	int enable_count;
 };
 
 struct acpi_device_physical_node {

