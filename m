Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Message-Id: <a53d44439d42029c55233dc3d67a1f1898e8fc72.1486913733.git.lukas@wunner.de>
In-Reply-To: <cover.1486913733.git.lukas@wunner.de>
References: <cover.1486913733.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 12 Feb 2017 17:07:45 +0100
Subject: [PATCH v6 7/8] thunderbolt: Power down controller when idle
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Document and implement Apple's ACPI-based (but nonstandard) pm mechanism
for Thunderbolt.  Briefly, an ACPI method provided by Apple is used to
cut power to the controller.  A GPE is enabled while the controller is
powered down which sideband-signals a plug event, whereupon we reinstate
power using the ACPI method.

This saves 1.7 W on machines with a Light Ridge controller and is
reported to save 4 W on Cactus Ridge 4C and Falcon Ridge 4C.  (I believe
4 W includes the bus power drawn by Apple's Gigabit Ethernet adapter.)
It fixes a power regression introduced in 3.17 by commit 7bc5a2bad0b8
("ACPI: Support _OSI("Darwin") correctly").

A Thunderbolt controller appears to the OS as a set of virtual devices:
One upstream bridge, multiple downstream bridges and one NHI (Native
Host Interface).  The upstream and downstream bridges represent a PCIe
switch (see definition of a switch in the PCIe spec).  The NHI device is
used to manage the Converged I/O switch over which PCI tunnels are set
up to hotplugged devices.  Those devices appear behind the downstream
bridges:

  (Root Port) ---- Upstream Bridge --+-- Downstream Bridge 0 ---- NHI
                                     +-- Downstream Bridge 1 --
                                     +-- Downstream Bridge 2 --
                                     ...

Power is cut to the entire set of devices.  The Linux pm model is
hierarchical and assumes that a child cannot resume before its parent.
To conform to this model, power control must be governed by the
Thunderbolt controller's topmost device, which is the upstream bridge.
The NHI and downstream bridges go to D3hot independently and the
upstream bridge goes to D3cold once all its children have suspended.
This commit only adds runtime pm for the upstream bridge.  Runtime pm
for the NHI is added in a separate commit to signify its independence.
Runtime pm for the downstream bridges is handled by the pcieport driver.

Because Apple's ACPI methods are nonstandard, a struct dev_pm_domain is
used to override the PCI bus pm_ops.  The thunderbolt driver binds to
the NHI, thus the dev_pm_domain is assigned to the upstream bridge when
its grandchild ->probes and evicted when it ->removes.

There are no Thunderbolt specs publicly available from Intel or Apple,
so I've included documentation to the extent that I was able to reverse-
engineer things.  Documentation on the Go2Sx and Ok2Go2Sx pins is
tentative as those are missing on my Light Ridge.  Apple only uses them
on Cactus Ridge 4C.  Someone with such a controller needs to find out
through experimentation if the documentation is accurate and amend it if
necessary.

To maximize power saving, the controller utilizes the PM core's direct-
complete procedure, i.e. it stays suspended during the system sleep
process.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=92111
Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/Kconfig  |   3 +-
 drivers/thunderbolt/Makefile |   4 +-
 drivers/thunderbolt/nhi.c    |   3 +
 drivers/thunderbolt/power.c  | 350 +++++++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/power.h  |  37 +++++
 drivers/thunderbolt/tb.h     |   2 +
 6 files changed, 396 insertions(+), 3 deletions(-)
 create mode 100644 drivers/thunderbolt/power.c
 create mode 100644 drivers/thunderbolt/power.h

diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index d35db16aa43f..41625cf3f461 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -1,9 +1,10 @@
 menuconfig THUNDERBOLT
 	tristate "Thunderbolt support for Apple devices"
-	depends on PCI
+	depends on PCI && ACPI
 	depends on X86 || COMPILE_TEST
 	select APPLE_PROPERTIES if EFI_STUB && X86
 	select CRC32
+	select PM
 	help
 	  Cactus Ridge Thunderbolt Controller driver
 	  This driver is required if you want to hotplug Thunderbolt devices on
diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index 5d1053cdfa54..b22082596c42 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -1,3 +1,3 @@
 obj-${CONFIG_THUNDERBOLT} := thunderbolt.o
-thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o tunnel_pci.o eeprom.o
-
+thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o tunnel_pci.o \
+		    eeprom.o power.o
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index a8c20413dbda..88fb2fb8cf4e 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -605,6 +605,8 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 	pci_set_drvdata(pdev, tb);
 
+	thunderbolt_power_init(tb);
+
 	return 0;
 }
 
@@ -612,6 +614,7 @@ static void nhi_remove(struct pci_dev *pdev)
 {
 	struct tb *tb = pci_get_drvdata(pdev);
 	struct tb_nhi *nhi = tb->nhi;
+	thunderbolt_power_fini(tb);
 	thunderbolt_shutdown_and_free(tb);
 	nhi_shutdown(nhi);
 }
diff --git a/drivers/thunderbolt/power.c b/drivers/thunderbolt/power.c
new file mode 100644
index 000000000000..e17edab13e4c
--- /dev/null
+++ b/drivers/thunderbolt/power.c
@@ -0,0 +1,350 @@
+/*
+ * power.c - power thunderbolt controller down when idle
+ * Copyright (C) 2016 Lukas Wunner <lukas@wunner.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Apple provides the following means for power control in ACPI:
+ *
+ * * On Macs with Thunderbolt 1 Gen 1 controllers (Light Ridge, Eagle Ridge):
+ *   * XRPE method ("Power Enable"), takes argument 1 or 0, toggles a GPIO pin
+ *     to switch the controller on or off.
+ *   * XRIN named object (alternatively _GPE), contains number of a GPE which
+ *     fires as long as something is plugged in (regardless of power state).
+ *   * XRIL method ("Interrupt Low"), returns 0 as long as something is
+ *     plugged in, 1 otherwise.
+ *   * XRIP and XRIO methods, unused by macOS driver.
+ *
+ * * On Macs with Thunderbolt 1 Gen 2 controllers (Cactus Ridge 4C):
+ *   * XRIN not only fires as long as something is plugged in, but also as long
+ *     as the controller's CIO switch is powered up.
+ *   * XRIL method changed its meaning, it returns 0 as long as the CIO switch
+ *     is powered up, 1 otherwise.
+ *   * Additional SXFP method ("Force Power"), accepts only argument 0,
+ *     switches the controller off. This carries out just the raw power change,
+ *     unlike XRPE which disables the link on the PCIe Root Port in an orderly
+ *     fashion before switching off the controller.
+ *   * Additional SXLV, SXIO, SXIL methods to utilize the Go2Sx and Ok2Go2Sx
+ *     pins (see background below). Apparently SXLV toggles the value given to
+ *     the POC via Go2Sx (0 or 1), SXIO changes the direction (0 or 1) and SXIL
+ *     returns the value received from the POC via Ok2Go2Sx.
+ *   * On some Macs, additional XRST method, takes argument 1 or 0, asserts or
+ *     deasserts a GPIO pin to reset the controller.
+ *   * On Macs introduced 2013, XRPE was renamed TRPE.
+ *
+ * * On Macs with Thunderbolt 2 controllers (Falcon Ridge 4C and 2C):
+ *   * SXLV, SXIO, SXIL methods to utilize Go2Sx and Ok2Go2Sx are gone.
+ *   * On the MacPro6,1 which has multiple Thunderbolt controllers, each NHI
+ *     device has a separate XRIN GPE and separate TRPE, SXFP and XRIL methods.
+ *
+ * Background:
+ *
+ * * Gen 1 controllers (Light Ridge, Eagle Ridge) had no power management
+ *   and no ability to distinguish whether a DP or Thunderbolt device is
+ *   plugged in. Apple put an ARM Cortex MCU (NXP LPC1112A) on the logic board
+ *   which snoops on the connector lines and, depending on the type of device,
+ *   sends an HPD signal to the GPU or rings the Thunderbolt XRIN doorbell
+ *   interrupt. The switches for the 3.3V and 1.05V power rails to the
+ *   Thunderbolt controller are toggled by a GPIO pin on the southbridge.
+ *
+ * * On gen 2 controllers (Cactus Ridge 4C), Intel integrated the MCU into the
+ *   controller and called it POC. This caused a change of semantics for XRIN
+ *   and XRIL. The POC is powered by a separate 3.3V rail which is active even
+ *   in sleep state S4. It only draws a very small current. The regular 3.3V
+ *   and 1.05V power rails are no longer controlled by the southbridge but by
+ *   the POC. In other words the controller powers *itself* up and down! It is
+ *   instructed to do so with the Go2Sx pin. Another pin, Ok2Go2Sx, allows the
+ *   controller to indicate if it is ready to power itself down. Apple wires
+ *   Go2Sx and Ok2Go2Sx to the same GPIO pin on the southbridge, hence the pin
+ *   is used bidirectionally. A third pin, Force Power, is intended by Intel
+ *   for debug only but Apple abuses it for XRPE/TRPE and SXFP. Perhaps it
+ *   leads to larger power saving gains. They utilize Go2Sx and Ok2Go2Sx only
+ *   on Cactus Ridge, presumably because the controller somehow requires that.
+ *   On Falcon Ridge they forego these pins and rely solely on Force Power.
+ *
+ * Implementation Notes:
+ *
+ * * To conform to Linux' hierarchical power management model, power control
+ *   is governed by the topmost PCI device of the controller, which is the
+ *   upstream bridge. The controller is powered down once all child devices
+ *   of the upstream bridge have suspended and its autosuspend delay has
+ *   elapsed.
+ *
+ * * The autosuspend delay is user configurable via sysfs and should be lower
+ *   or equal to that of the NHI since hotplug events are not acted upon if
+ *   the NHI has suspended but the controller has not yet powered down.
+ *   However the delay should not be zero to avoid frequent power changes
+ *   (e.g. multiple times just for lspci -vv) since powering up takes 2 sec.
+ *   (Powering down is almost instantaneous.)
+ */
+
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+
+#include "power.h"
+
+/*
+ * The dev_pm_ops assigned to the upstream bridge use pr_*() instead of dev_*()
+ * to get a "thunderbolt" prefix on messages, rather than "pcieport".
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " %s: " fmt, dev_name(dev)
+
+#define to_power(dev) container_of(dev->pm_domain, struct tb_power, pm_domain)
+
+static int upstream_prepare(struct device *dev)
+{
+	struct tb_power *power = to_power(dev);
+
+	if (pm_runtime_active(dev))
+		return 0;
+
+	/* prevent interrupts during system sleep transition */
+	if (ACPI_FAILURE(acpi_disable_gpe(NULL, power->wake_gpe))) {
+		pr_err("cannot disable wake GPE, resuming\n");
+		pm_request_resume(dev);
+		return -EAGAIN;
+	}
+
+	return DPM_DIRECT_COMPLETE;
+}
+
+static void upstream_complete(struct device *dev)
+{
+	struct tb_power *power = to_power(dev);
+
+	if (pm_runtime_active(dev))
+		return;
+
+	/*
+	 * If the controller was powered down before system sleep, calling XRPE
+	 * to power it up will fail on the next runtime resume. An additional
+	 * call to XRPE is necessary to reset the power switch first.
+	 */
+	pr_info("resetting power switch\n");
+	if (ACPI_FAILURE(acpi_execute_simple_method(power->set, NULL, 0))) {
+		pr_err("cannot call power->set method\n");
+		dev->power.runtime_error = -EIO;
+	}
+
+	if (ACPI_FAILURE(acpi_enable_gpe(NULL, power->wake_gpe))) {
+		pr_err("cannot enable wake GPE, resuming\n");
+		pm_request_resume(dev);
+	}
+}
+
+static int set_d3cold(struct pci_dev *pdev, void *ptr)
+{
+	pdev->current_state = PCI_D3cold;
+	return 0;
+}
+
+static int request_resume(struct pci_dev *pdev, void *ptr)
+{
+	WARN_ON(pm_request_resume(&pdev->dev) < 0);
+	return 0;
+}
+
+static int upstream_runtime_suspend(struct device *dev)
+{
+	struct tb_power *power = to_power(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	unsigned long long powered_down;
+	int ret, i;
+
+	/* children are effectively in D3cold once upstream goes to D3hot */
+	pci_walk_bus(pdev->subordinate, set_d3cold, NULL);
+
+	ret = dev->bus->pm->runtime_suspend(dev);
+	if (ret) {
+		pci_walk_bus(pdev->subordinate, request_resume, NULL);
+		return ret;
+	}
+
+	pr_info("powering down\n");
+	pdev->current_state = PCI_D3cold;
+	if (ACPI_FAILURE(acpi_execute_simple_method(power->set, NULL, 0))) {
+		pr_err("cannot call power->set method, resuming\n");
+		goto err_resume;
+	}
+
+	/*
+	 * On gen 2 controllers, the wake GPE fires as long as the CIO switch
+	 * is powered up. Poll until it's powered down before enabling the GPE.
+	 * macOS polls up to 300 times with a 1 ms delay, just mimic that.
+	 */
+	for (i = 0; i < 300; i++) {
+		if (ACPI_FAILURE(acpi_evaluate_integer(power->get,
+					      NULL, NULL, &powered_down))) {
+			pr_err("cannot call power->get method, resuming\n");
+			goto err_resume;
+		}
+		if (powered_down)
+			break;
+		usleep_range(800, 1200);
+	}
+	if (!powered_down) {
+		pr_err("refused to power down, resuming\n");
+		goto err_resume;
+	}
+
+	if (ACPI_FAILURE(acpi_enable_gpe(NULL, power->wake_gpe))) {
+		pr_err("cannot enable wake GPE, resuming\n");
+		goto err_resume;
+	}
+
+	return 0;
+
+err_resume:
+	acpi_execute_simple_method(power->set, NULL, 1);
+	dev->bus->pm->runtime_resume(dev);
+	pci_walk_bus(pdev->subordinate, request_resume, NULL);
+	return -EAGAIN;
+}
+
+static int upstream_runtime_resume(struct device *dev)
+{
+	struct tb_power *power = to_power(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	if (!dev->power.is_prepared &&
+	    ACPI_FAILURE(acpi_disable_gpe(NULL, power->wake_gpe))) {
+		pr_err("cannot disable wake GPE, disabling runtime pm\n");
+		pm_runtime_disable(&power->tb->nhi->pdev->dev);
+	}
+
+	pr_info("powering up\n");
+	if (ACPI_FAILURE(acpi_execute_simple_method(power->set, NULL, 1))) {
+		pr_err("cannot call power->set method\n");
+		return -ENODEV;
+	}
+
+	ret = dev->bus->pm->runtime_resume(dev);
+
+	/* wake children to force pci_restore_state() after D3cold */
+	pci_walk_bus(pdev->subordinate, request_resume, NULL);
+
+	return ret;
+}
+
+static u32 nhi_wake(acpi_handle gpe_device, u32 gpe_number, void *ctx)
+{
+	struct device *nhi_dev = ctx;
+	WARN_ON(pm_request_resume(nhi_dev) < 0);
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+static int disable_pme_poll(struct pci_dev *pdev, void *ptr)
+{
+	struct pci_bus *downstream_bus = (struct pci_bus *)ptr;
+
+	/* the wake GPE is used instead of PME */
+	if (pdev->bus == downstream_bus	||		/* downstream bridge */
+	    pdev->subordinate == downstream_bus ||	  /* upstream bridge */
+	    (pdev->bus->parent == downstream_bus &&
+	     pdev->class == PCI_CLASS_SYSTEM_OTHER << 8))	      /* NHI */
+		pdev->pme_poll = false;
+
+	return 0;
+}
+
+void thunderbolt_power_init(struct tb *tb)
+{
+	struct device *upstream_dev, *nhi_dev = &tb->nhi->pdev->dev;
+	struct acpi_handle *nhi_handle;
+	struct tb_power *power;
+
+	power = kzalloc(sizeof(*power), GFP_KERNEL);
+	if (!power) {
+		dev_err(nhi_dev, "cannot allocate power data\n");
+		goto err_free;
+	}
+
+	nhi_handle = ACPI_HANDLE(nhi_dev);
+	if (!nhi_handle) {
+		dev_err(nhi_dev, "cannot find ACPI handle\n");
+		goto err_free;
+	}
+
+	if (!nhi_dev->parent || !nhi_dev->parent->parent) {
+		dev_err(nhi_dev, "cannot find upstream bridge\n");
+		goto err_free;
+	}
+	upstream_dev = nhi_dev->parent->parent;
+
+	/* Macs introduced 2011/2012 have XRPE, 2013+ have TRPE */
+	if (ACPI_FAILURE(acpi_get_handle(nhi_handle, "XRPE", &power->set)) &&
+	    ACPI_FAILURE(acpi_get_handle(nhi_handle, "TRPE", &power->set))) {
+		dev_err(nhi_dev, "cannot find power->set method\n");
+		goto err_free;
+	}
+
+	if (ACPI_FAILURE(acpi_get_handle(nhi_handle, "XRIL", &power->get))) {
+		dev_err(nhi_dev, "cannot find power->get method\n");
+		goto err_free;
+	}
+
+	if (ACPI_FAILURE(acpi_evaluate_integer(nhi_handle, "XRIN", NULL,
+							&power->wake_gpe))) {
+		dev_err(nhi_dev, "cannot find wake GPE\n");
+		goto err_free;
+	}
+
+	if (ACPI_FAILURE(acpi_install_gpe_handler(NULL, power->wake_gpe,
+			     ACPI_GPE_LEVEL_TRIGGERED, nhi_wake, nhi_dev))) {
+		dev_err(nhi_dev, "cannot install GPE handler\n");
+		goto err_free;
+	}
+
+	pci_walk_bus(to_pci_dev(upstream_dev)->bus, disable_pme_poll,
+		     to_pci_dev(upstream_dev)->subordinate);
+
+	power->pm_domain.ops		     = *upstream_dev->bus->pm;
+	power->pm_domain.ops.prepare	     =  upstream_prepare;
+	power->pm_domain.ops.complete	     =  upstream_complete;
+	power->pm_domain.ops.runtime_suspend =  upstream_runtime_suspend;
+	power->pm_domain.ops.runtime_resume  =  upstream_runtime_resume;
+	power->tb			     =  tb;
+	dev_pm_domain_set(upstream_dev, &power->pm_domain);
+
+	tb->power = power;
+
+	return;
+
+err_free:
+	dev_err(nhi_dev, "controller will stay powered up permanently\n");
+	kfree(power);
+}
+
+void thunderbolt_power_fini(struct tb *tb)
+{
+	struct device *nhi_dev = &tb->nhi->pdev->dev;
+	struct device *upstream_dev = nhi_dev->parent->parent;
+	struct tb_power *power = tb->power;
+
+	if (!power)
+		return; /* thunderbolt_power_init() failed */
+
+	tb->power = NULL;
+	dev_pm_domain_set(upstream_dev, NULL);
+
+	if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, power->wake_gpe,
+						 nhi_wake)))
+		dev_err(nhi_dev, "cannot remove GPE handler\n");
+
+	kfree(power);
+}
diff --git a/drivers/thunderbolt/power.h b/drivers/thunderbolt/power.h
new file mode 100644
index 000000000000..4ab9b29a9136
--- /dev/null
+++ b/drivers/thunderbolt/power.h
@@ -0,0 +1,37 @@
+/*
+ * power.h - power thunderbolt controller down when idle
+ * Copyright (C) 2016 Lukas Wunner <lukas@wunner.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef THUNDERBOLT_POWER_H
+#define THUNDERBOLT_POWER_H
+
+#include <linux/acpi.h>
+#include <linux/pm_domain.h>
+
+#include "tb.h"
+
+struct tb_power {
+	struct tb *tb;
+	struct dev_pm_domain pm_domain; /* assigned to upstream bridge */
+	unsigned long long wake_gpe; /* hotplug interrupt during powerdown */
+	acpi_handle set; /* method to power controller up/down */
+	acpi_handle get; /* method to query power state */
+};
+
+void thunderbolt_power_init(struct tb *tb);
+void thunderbolt_power_fini(struct tb *tb);
+
+#endif
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 61d57ba64035..43aed5832c9e 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -11,6 +11,7 @@
 
 #include "tb_regs.h"
 #include "ctl.h"
+#include "power.h"
 
 /**
  * struct tb_switch - a thunderbolt switch
@@ -103,6 +104,7 @@ struct tb {
 				 */
 	struct tb_nhi *nhi;
 	struct tb_ctl *ctl;
+	struct tb_power *power;
 	struct workqueue_struct *wq; /* ordered workqueue for plug events */
 	struct tb_switch *root_switch;
 	struct list_head tunnel_list; /* list of active PCIe tunnels */
-- 
2.11.0
