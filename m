Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-Id: <4560ddb26a2bb15eeaf8eab565ac41c35e36d092.1458126755.git.lukas@wunner.de>
In-Reply-To: <cover.1458126755.git.lukas@wunner.de>
References: <cover.1458126755.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 16 Mar 2016 15:50:35 +0100
Subject: [RFC 4/4] thunderbolt: Support runtime pm
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Document and implement Apple's ACPI-based (but nonstandard) mechanism
to power the controller up and down as needed.

This fixes (at least partially) a power regression introduced in
Linux 3.17 by 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly").

A Thunderbolt controller consists of an NHI (Native Host Interface) and
a set of bridges. Power is cut to the entire chip. The Linux pm model
assumes that runtime pm is governed by the parent device, i.e. the
upstream bridge driver, pcieport. In violation of this model we let a
child govern it, i.e. the NHI driver thunderbolt.ko. The traditional
hierarchical pm model is defeated by setting ignore_children on the
upstream bridge and downstream bridge 0, and by having the NHI update
all the bridges' runtime pm state in unison with itself. It is also the
NHI driver's job to save and restore PCI state of the bridges.

PCIe Port --- Upstream Bridge --+
                                |
                                +-- Downstream Bridge 0 --+
                                |                         |
                                |                         +-- NHI
                                |
                                +-- Downstream Bridge 1 ...
                                |
                                +-- Downstream Bridge 2 ... hotplugged
                                |                           devices
                                +-- Downstream Bridge 3 ...
                                |
                                +-- Downstream Bridge 4 ...

The PCI subsystem pm_ops do not work properly for devices which can be
put into D3cold by some other means than the standard _PSx ACPI platform
methods: We do not want to wake up the chip before system sleep, yet
pci_pm_prepare() does not return 1 as it should since pci_target_state()
returns D3hot. We solve this by overriding pci_pm_prepare() using power
domains. They are assigned to the bridges using a PCI quirk. We also do
not want to wake the chip after system resume as pci_pm_complete() does,
so we override that as well. Note that we can never remove and free the
dev_pm_domain assigned to the bridges as there is no PCI remove fixup
section. We also cannot bail out of the ->probe callback if allocation
of the struct dev_pm_domain fails since the PCI enable fixup does not
allow return values to be passed back.

It might be possible to implement a less kludgy solution which adheres
to the hierarchical pm model and does not need a PCI enable quirk for
the bridges if pcieport had runtime pm support both for itself and
any service drivers registering with it. The runtime pm code could
then be moved from the NHI to a new Thunderbolt service driver that
gets used on the upstream bridge.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=92111
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/quirks.c         |  35 ++++++
 drivers/thunderbolt/Kconfig  |   2 +-
 drivers/thunderbolt/nhi.c    |   4 +
 drivers/thunderbolt/nhi.h    |   3 +
 drivers/thunderbolt/power.c  | 247 +++++++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/power.h  |   3 +
 drivers/thunderbolt/switch.c |   9 ++
 drivers/thunderbolt/tb.c     |   6 ++
 8 files changed, 308 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d1e3956..a007485 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/ktime.h>
 #include <linux/mm.h>
+#include <linux/pm_domain.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -3255,6 +3256,40 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
 			       PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE,
 			       quirk_apple_wait_for_thunderbolt);
+
+static int bridge_prepare(struct device *dev)
+{
+	return 1; /* stay asleep if already runtime suspended */
+}
+
+static void quirk_apple_thunderbolt_runpm(struct pci_dev *dev)
+{
+	struct dev_pm_domain *bridge_pm_domain;
+
+	if (!dmi_match(DMI_BOARD_VENDOR, "Apple Inc."))
+		return;
+	if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
+		return;
+	if (dev->dev.pm_domain)
+		return;
+
+	bridge_pm_domain = kzalloc(sizeof(*bridge_pm_domain), GFP_KERNEL);
+	if (!bridge_pm_domain) {
+		dev_err(&dev->dev, "cannot allocate pm_domain\n");
+		return;
+	}
+
+	bridge_pm_domain->ops	       = *pci_bus_type.pm;
+	bridge_pm_domain->ops.prepare  = bridge_prepare;
+	bridge_pm_domain->ops.complete = NULL;
+	dev_pm_domain_set(&dev->dev, bridge_pm_domain);
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL,
+			 PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
+			 quirk_apple_thunderbolt_runpm);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL,
+			 PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE,
+			 quirk_apple_thunderbolt_runpm);
 #endif
 
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index c121acc..40335f7 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -1,6 +1,6 @@
 menuconfig THUNDERBOLT
 	tristate "Thunderbolt support for Apple devices"
-	depends on PCI
+	depends on PCI && ACPI
 	select CRC32
 	help
 	  Cactus Ridge Thunderbolt Controller driver
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index fa89160..964b006 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -588,6 +588,8 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 	pci_set_drvdata(pdev, tb);
 
+	nhi_runtime_pm_init(nhi);
+
 	return 0;
 }
 
@@ -595,6 +597,8 @@ static void nhi_remove(struct pci_dev *pdev)
 {
 	struct tb *tb = pci_get_drvdata(pdev);
 	struct tb_nhi *nhi = tb->nhi;
+
+	nhi_runtime_pm_fini(nhi);
 	thunderbolt_shutdown_and_free(tb);
 	nhi_shutdown(nhi);
 }
diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 3172429..dd725f7 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -7,6 +7,7 @@
 #ifndef DSL3510_H_
 #define DSL3510_H_
 
+#include <linux/acpi.h>
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
 
@@ -25,6 +26,8 @@ struct tb_nhi {
 	struct tb_ring **rx_rings;
 	struct work_struct interrupt_work;
 	u32 hop_count; /* Number of rings (end point hops) supported by NHI. */
+	unsigned long long wake_gpe; /* Hotplug interrupt during powerdown. */
+	acpi_handle set_power; /* Method to power controller up/down. */
 };
 
 /**
diff --git a/drivers/thunderbolt/power.c b/drivers/thunderbolt/power.c
index 1095ad0..cc83940 100644
--- a/drivers/thunderbolt/power.c
+++ b/drivers/thunderbolt/power.c
@@ -2,11 +2,15 @@
  * Thunderbolt Cactus Ridge driver - power management
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (c) 2016 Lukas Wunner <lukas@wunner.de>
  */
 
+#include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
+#include "nhi.h"
 #include "tb.h"
 
 static int nhi_suspend_noirq(struct device *dev)
@@ -39,3 +43,246 @@ const struct dev_pm_ops nhi_pm_ops = {
 					     */
 	.restore_noirq = nhi_resume_noirq,
 };
+
+/*
+ * Runtime Power Management
+ *
+ * Apple provides the following means for runtime pm in ACPI:
+ *
+ * * XRPE method (TRPE on Cactus Ridge and newer), takes argument 1 or 0,
+ *   toggles a GPIO pin to switch the controller on or off.
+ * * XRIN named object (alternatively _GPE), contains number of a GPE which
+ *   fires as long as something is plugged in (regardless of power state).
+ * * XRIL method returns 0 as long as something is plugged in, 1 otherwise.
+ * * XRIP + XRIO methods, unused by OS X driver. (Flip interrupt polarity?)
+ *
+ * If there are multiple Thunderbolt controllers (e.g. MacPro6,1), each NHI
+ * device has a separate XRIN GPE and separate instances of these methods.
+ *
+ * We acquire a runtime pm ref for each newly allocated switch (except for
+ * the root switch) and drop one when a switch is freed. The controller is
+ * thus powered up as long as something is plugged in. This behaviour is
+ * identical to the OS X driver.
+ *
+ * Powering the controller down is almost instantaneous, but powering up takes
+ * about 2 sec. To handle situations gracefully where a device is unplugged
+ * and immediately replaced by another one, we afford a grace period of 10 sec
+ * before powering down. This autosuspend_delay_ms may be reduced to 0 via
+ * sysfs and to handle that properly we need to wait during runtime_resume
+ * since it takes about 0.7 sec after resuming until a hotplug event appears.
+ *
+ * When the system wakes from suspend-to-RAM, the controller's power state is
+ * as it was before. However if it was powered down, calling XRPE once to power
+ * it up is not sufficient: An additional call to XRPE is necessary to reset
+ * the power switch first.
+ */
+
+static int nhi_prepare(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tb *tb = pci_get_drvdata(pdev);
+	acpi_status res;
+
+	if (pm_runtime_active(dev))
+		return 0;
+
+	res = acpi_disable_gpe(NULL, tb->nhi->wake_gpe);
+	if (ACPI_FAILURE(res)) {
+		dev_err(dev, "cannot disable wake GPE, resuming\n");
+		return 0;
+	} else
+		return 1; /* stay asleep if already runtime suspended */
+}
+
+static void nhi_complete(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tb *tb = pci_get_drvdata(pdev);
+	acpi_status res;
+
+	if (pm_runtime_active(dev))
+		return;
+
+	tb_info(tb, "resetting power switch\n");
+	res = acpi_execute_simple_method(tb->nhi->set_power, NULL, 0);
+	if (ACPI_FAILURE(res)) {
+		dev_err(dev, "cannot call set_power method\n");
+		dev->power.runtime_error = -ENODEV;
+	}
+
+	res = acpi_enable_gpe(NULL, tb->nhi->wake_gpe);
+	if (ACPI_FAILURE(res)) {
+		dev_err(dev, "cannot enable wake GPE, resuming\n");
+		pm_request_resume(dev);
+	}
+}
+
+static int pci_save_state_cb(struct pci_dev *pdev, void *ptr)
+{
+	pci_save_state(pdev);
+	if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+	}
+	pdev->current_state = PCI_D3cold;
+	return 0;
+}
+
+static int pci_restore_state_cb(struct pci_dev *pdev, void *ptr)
+{
+	pdev->current_state = PCI_D0;
+	if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_active(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+	}
+	pci_restore_state(pdev);
+	return 0;
+}
+
+static int nhi_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus *upstream_bridge = pdev->bus->parent->parent;
+	struct tb *tb = pci_get_drvdata(pdev);
+	acpi_status res;
+
+	if (!pdev->d3cold_allowed)
+		return -EAGAIN;
+
+	thunderbolt_suspend(tb);
+	pci_walk_bus(upstream_bridge, pci_save_state_cb, NULL);
+
+	tb_info(tb, "powering down\n");
+	res = acpi_execute_simple_method(tb->nhi->set_power, NULL, 0);
+	if (ACPI_FAILURE(res)) {
+		dev_err(dev, "cannot call set_power method, resuming\n");
+		goto err;
+	}
+
+	res = acpi_enable_gpe(NULL, tb->nhi->wake_gpe);
+	if (ACPI_FAILURE(res)) {
+		dev_err(dev, "cannot enable wake GPE, resuming\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	acpi_execute_simple_method(tb->nhi->set_power, NULL, 1);
+	pci_walk_bus(upstream_bridge, pci_restore_state_cb, NULL);
+	thunderbolt_resume(tb);
+	return -EAGAIN;
+}
+
+static int nhi_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus *upstream_bridge = pdev->bus->parent->parent;
+	struct tb *tb = pci_get_drvdata(pdev);
+	acpi_status res;
+
+	if (system_state >= SYSTEM_HALT)
+		return -ESHUTDOWN;
+
+	res = acpi_disable_gpe(NULL, tb->nhi->wake_gpe);
+	if (ACPI_FAILURE(res)) {
+		dev_err(dev, "cannot disable wake GPE, disabling runtime pm\n");
+		pm_runtime_disable(dev);
+	}
+
+	tb_info(tb, "powering up\n");
+	res = acpi_execute_simple_method(tb->nhi->set_power, NULL, 1);
+	if (ACPI_FAILURE(res)) {
+		dev_err(dev, "cannot call set_power method\n");
+		return -ENODEV;
+	}
+
+	pci_walk_bus(upstream_bridge, pci_restore_state_cb, NULL);
+	thunderbolt_resume(tb);
+	msleep(1500); /* allow 1.5 sec for hotplug event to arrive */
+	pm_runtime_mark_last_busy(dev);
+
+	return 0;
+}
+
+static u32 nhi_runtime_wake(acpi_handle gpe_device, u32 gpe_number, void *ctx)
+{
+	struct device *dev = ctx;
+	WARN_ON(pm_request_resume(dev) < 0);
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+static struct dev_pm_domain nhi_pm_domain;
+
+void nhi_runtime_pm_init(struct tb_nhi *nhi)
+{
+	struct device *dev = &nhi->pdev->dev;
+	struct acpi_handle *nhi_handle = ACPI_HANDLE(dev);
+	acpi_status res;
+
+	/* gen 1 controllers use XRPE, gen 2+ controllers use TRPE */
+	if (nhi->pdev->device <= PCI_DEVICE_ID_INTEL_EAGLE_RIDGE)
+		res = acpi_get_handle(nhi_handle, "XRPE", &nhi->set_power);
+	else
+		res = acpi_get_handle(nhi_handle, "TRPE", &nhi->set_power);
+	if (ACPI_FAILURE(res)) {
+		dev_warn(dev, "cannot find set_power method, disabling runtime pm\n");
+		goto err;
+	}
+
+	res = acpi_evaluate_integer(nhi_handle, "XRIN", NULL, &nhi->wake_gpe);
+	if (ACPI_FAILURE(res)) {
+		dev_warn(dev, "cannot find wake GPE, disabling runtime pm\n");
+		goto err;
+	}
+
+	res = acpi_install_gpe_handler(NULL, nhi->wake_gpe,
+				       ACPI_GPE_LEVEL_TRIGGERED,
+				       nhi_runtime_wake, dev);
+	if (ACPI_FAILURE(res)) {
+		dev_warn(dev, "cannot install GPE handler, disabling runtime pm\n");
+		goto err;
+	}
+
+	nhi_pm_domain.ops		  = *pci_bus_type.pm;
+	nhi_pm_domain.ops.prepare	  = nhi_prepare;
+	nhi_pm_domain.ops.complete	  = nhi_complete;
+	nhi_pm_domain.ops.runtime_suspend = nhi_runtime_suspend;
+	nhi_pm_domain.ops.runtime_resume  = nhi_runtime_resume;
+	dev_pm_domain_set(dev, &nhi_pm_domain);
+
+	/* apply to upstream bridge and downstream bridge 0 */
+	pm_suspend_ignore_children(dev->parent->parent, true);
+	pm_suspend_ignore_children(dev->parent, true);
+
+	pm_runtime_allow(dev);
+	pm_runtime_set_autosuspend_delay(dev, 10000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put(dev);
+	return;
+
+err:
+	nhi->wake_gpe = -1;
+	if (pm_runtime_enabled(dev))
+		pm_runtime_disable(dev);
+}
+
+void nhi_runtime_pm_fini(struct tb_nhi *nhi)
+{
+	struct device *dev = &nhi->pdev->dev;
+	acpi_status res;
+
+	if (nhi->wake_gpe == -1)
+		return;
+
+	res = acpi_remove_gpe_handler(NULL, nhi->wake_gpe, nhi_runtime_wake);
+	if (ACPI_FAILURE(res))
+		dev_warn(dev, "cannot remove GPE handler\n");
+
+	pm_runtime_get(dev);
+	pm_runtime_forbid(dev);
+	dev_pm_domain_set(dev, NULL);
+}
diff --git a/drivers/thunderbolt/power.h b/drivers/thunderbolt/power.h
index 99cb900..4fc836d 100644
--- a/drivers/thunderbolt/power.h
+++ b/drivers/thunderbolt/power.h
@@ -11,4 +11,7 @@
 
 extern const struct dev_pm_ops nhi_pm_ops;
 
+void nhi_runtime_pm_fini(struct tb_nhi *nhi);
+void nhi_runtime_pm_init(struct tb_nhi *nhi);
+
 #endif
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index c6270f0..e9be3d5 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "tb.h"
@@ -326,6 +327,11 @@ void tb_switch_free(struct tb_switch *sw)
 	if (!sw->is_unplugged)
 		tb_plug_events_active(sw, false);
 
+	if (sw != sw->tb->root_switch) {
+		pm_runtime_mark_last_busy(&sw->tb->nhi->pdev->dev);
+		pm_runtime_put(&sw->tb->nhi->pdev->dev);
+	}
+
 	kfree(sw->ports);
 	kfree(sw->drom);
 	kfree(sw);
@@ -417,6 +423,9 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, u64 route)
 	if (tb_plug_events_active(sw, true))
 		goto err;
 
+	if (tb->root_switch)
+		pm_runtime_get(&tb->nhi->pdev->dev);
+
 	return sw;
 err:
 	kfree(sw->ports);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 24b6d30..c33d3f1 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include "tb.h"
 #include "tb_regs.h"
@@ -217,8 +218,11 @@ static void tb_handle_hotplug(struct work_struct *work)
 {
 	struct tb_hotplug_event *ev = container_of(work, typeof(*ev), work);
 	struct tb *tb = ev->tb;
+	struct device *dev = &tb->nhi->pdev->dev;
 	struct tb_switch *sw;
 	struct tb_port *port;
+
+	pm_runtime_get(dev);
 	mutex_lock(&tb->lock);
 	if (!tb->hotplug_active)
 		goto out; /* during init, suspend or shutdown */
@@ -274,6 +278,8 @@ static void tb_handle_hotplug(struct work_struct *work)
 out:
 	mutex_unlock(&tb->lock);
 	kfree(ev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put(dev);
 }
 
 /**
-- 
2.7.0

