Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:41311 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbcEMLSW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:18:22 -0400
Message-Id: <59fe8d667a5a82b5bbdb0ba5a93ac4ef0db1f794.1463134232.git.lukas@wunner.de>
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 12/13] thunderbolt: Support runtime pm on upstream bridge
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Document and implement Apple's ACPI-based (but nonstandard) mechanism to
power the controller up and down as needed.  Briefly, an ACPI method
provided by Apple is used to cut power to the controller.  A GPE is
enabled while the controller is powered down which side-band signals a
plug event, whereupon we reinstate power using the ACPI method.

This saves 1.7 W on machines with a Light Ridge controller and is
reported to save 4 W on Cactus Ridge 4C and Falcon Ridge 4C.  It fixes
(at least partially) a power regression introduced in Linux 3.17 by
commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly").

A Thunderbolt controller appears to the OS as a set of PCI devices:  One
NHI (Native Host Interface) and multiple bridges.  Power is cut to the
entire set of devices.  The Linux pm model is hierarchical and assumes
that a child cannot resume before its parent.  To conform to this model,
power control must be governed by the Thunderbolt controller's topmost
device, which is the upstream bridge.  This is achieved by binding to it
as a Thunderbolt port service driver:

  (Root Port) ---- Upstream Bridge --+-- Downstream Bridge 0 ---- NHI
                                     +-- Downstream Bridge 1 --
                                     +-- Downstream Bridge 2 --
                                     ...

There are no Thunderbolt specs publicly available from Intel or Apple,
so I've included documentation to the extent that I was able to reverse-
engineer things.  Documentation on the Go2Sx and Ok2Go2Sx pins is
tentative as those are missing on my Light Ridge.  Apple only uses them
on Cactus Ridge 4C.  Someone with such a controller needs to find out
through experimentation if the documentation is accurate and amend it if
necessary.

To maximize power saving, the controller is left asleep during the
system suspend process ("direct-complete" in runtime pm lingo).  We also
opt out of the mandatory runtime resume after system suspend which was
introduced with 58a1fbbb2ee8 ("PM / PCI / ACPI: Kick devices that might
have been reset by firmware").  We're better than OS X there, which
always wakes the controller after system sleep for no apparent reason.
Finally, we also do not wake the controller on system shutdown to avoid
stalling the shutdown procedure by 2 seconds (that's how long it takes
for the controller to power up).

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=92111
Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/Kconfig    |   4 +-
 drivers/thunderbolt/Makefile   |   4 +-
 drivers/thunderbolt/nhi.c      |  21 ++-
 drivers/thunderbolt/upstream.c | 345 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 369 insertions(+), 5 deletions(-)
 create mode 100644 drivers/thunderbolt/upstream.c

diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index c121acc..79f53fc 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -1,7 +1,9 @@
 menuconfig THUNDERBOLT
 	tristate "Thunderbolt support for Apple devices"
-	depends on PCI
+	depends on PCI && ACPI
+	select PCIEPORTBUS
 	select CRC32
+	select PM
 	help
 	  Cactus Ridge Thunderbolt Controller driver
 	  This driver is required if you want to hotplug Thunderbolt devices on
diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index 5d1053c..8cae413 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -1,3 +1,3 @@
 obj-${CONFIG_THUNDERBOLT} := thunderbolt.o
-thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o tunnel_pci.o eeprom.o
-
+thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o tunnel_pci.o \
+		    eeprom.o upstream.o
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 9c15344..d54666e 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
+#include <linux/pcieport_if.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/dmi.h>
@@ -631,7 +632,7 @@ static const struct dev_pm_ops nhi_pm_ops = {
 	.restore_noirq = nhi_resume_noirq,
 };
 
-static struct pci_device_id nhi_ids[] = {
+struct pci_device_id nhi_ids[] = {
 	/*
 	 * We have to specify class, the TB bridges use the same device and
 	 * vendor (sub)id on gen 1 and gen 2 controllers.
@@ -668,16 +669,32 @@ static struct pci_driver nhi_driver = {
 	.driver.pm = &nhi_pm_ops,
 };
 
+extern struct pcie_port_service_driver upstream_driver;
+
 static int __init nhi_init(void)
 {
+	int res;
+
 	if (!dmi_match(DMI_BOARD_VENDOR, "Apple Inc."))
 		return -ENOSYS;
-	return pci_register_driver(&nhi_driver);
+
+	res = pcie_port_service_register(&upstream_driver);
+	if (res)
+		return res;
+
+	res = pci_register_driver(&nhi_driver);
+	if (res) {
+		pcie_port_service_unregister(&upstream_driver);
+		return res;
+	}
+
+	return 0;
 }
 
 static void __exit nhi_unload(void)
 {
 	pci_unregister_driver(&nhi_driver);
+	pcie_port_service_unregister(&upstream_driver);
 }
 
 module_init(nhi_init);
diff --git a/drivers/thunderbolt/upstream.c b/drivers/thunderbolt/upstream.c
new file mode 100644
index 0000000..d69422b
--- /dev/null
+++ b/drivers/thunderbolt/upstream.c
@@ -0,0 +1,345 @@
+/*
+ * upstream.c - thunderbolt upstream bridge driver (powers controller up/down)
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
+ *   * XRIP and XRIO methods, unused by OS X driver.
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
+ * * The controller is powered down once all child devices have suspended and
+ *   its autosuspend delay has elapsed. The delay is user configurable via
+ *   sysfs and should be lower or equal to that of the NHI since hotplug events
+ *   are not acted upon if the NHI has suspended but the controller has not yet
+ *   powered down. The delay should not be zero to avoid frequent power changes
+ *   (e.g. multiple times just for lspci -vv) since powering up takes 2 sec.
+ *   (Powering down is almost instantaneous.)
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/pcieport_if.h>
+#include <linux/pm_runtime.h>
+
+struct tb_upstream {
+	struct pci_dev *nhi;
+	unsigned long long wake_gpe; /* hotplug interrupt during powerdown */
+	acpi_handle set_power; /* method to power controller up/down */
+	acpi_handle get_power; /* method to query power state */
+};
+
+static int upstream_prepare(struct pcie_device *dev)
+{
+	struct tb_upstream *upstream = get_service_data(dev);
+
+	/* prevent interrupts during system sleep transition */
+	if (pm_runtime_suspended(&dev->port->dev) &&
+	    ACPI_FAILURE(acpi_disable_gpe(NULL, upstream->wake_gpe))) {
+		dev_err(&dev->device, "cannot disable wake GPE, resuming\n");
+		pm_request_resume(&dev->port->dev);
+	}
+
+	return 0;
+}
+
+static int upstream_complete(struct pcie_device *dev)
+{
+	struct tb_upstream *upstream = get_service_data(dev);
+
+	/*
+	 * If the controller was powered up before system sleep, we'll find it
+	 * automatically powered up afterwards.
+	 */
+	if (pm_runtime_active(&dev->port->dev))
+		return 0;
+
+	/*
+	 * If the controller was powered down before system sleep, calling XRPE
+	 * to power it up will fail on the next runtime resume. An additional
+	 * call to XRPE is necessary to reset the power switch first.
+	 */
+	dev_info(&dev->device, "resetting power switch\n");
+	if (ACPI_FAILURE(acpi_execute_simple_method(upstream->set_power, NULL,
+						    0))) {
+		dev_err(&dev->device, "cannot call set_power method\n");
+		dev->port->dev.power.runtime_error = -ENODEV;
+	}
+
+	if (ACPI_FAILURE(acpi_enable_gpe(NULL, upstream->wake_gpe))) {
+		dev_err(&dev->device, "cannot enable wake GPE, resuming\n");
+		pm_request_resume(&dev->port->dev);
+	}
+
+	return 0;
+}
+
+static int pm_set_d3cold_cb(struct pci_dev *pdev, void *ptr)
+{
+	pdev->current_state = PCI_D3cold;
+	return 0;
+}
+
+static int pm_set_d3hot_and_resume_cb(struct pci_dev *pdev, void *ptr)
+{
+	pdev->current_state = PCI_D3hot;
+	WARN_ON(pm_request_resume(&pdev->dev) < 0);
+	return 0;
+}
+
+static int upstream_runtime_suspend(struct pcie_device *dev)
+{
+	struct tb_upstream *upstream = get_service_data(dev);
+	unsigned long long powered_down;
+	int i;
+
+	if (!dev->port->d3cold_allowed)
+		return -EAGAIN;
+
+	pci_save_state(dev->port);
+	pci_walk_bus(dev->port->bus, pm_set_d3cold_cb, NULL);
+
+	dev_info(&dev->device, "powering down\n");
+	if (ACPI_FAILURE(acpi_execute_simple_method(upstream->set_power, NULL,
+						    0))) {
+		dev_err(&dev->device, "cannot call set_power method, resuming\n");
+		goto err;
+	}
+
+	/*
+	 * On gen 2 controllers, the wake GPE fires as long as the controller
+	 * is powered up. Poll until it's powered down before enabling the GPE.
+	 */
+	for (i = 0; i < 300; i++) {
+		if (ACPI_FAILURE(acpi_evaluate_integer(upstream->get_power,
+						       NULL, NULL,
+						       &powered_down))) {
+			dev_err(&dev->device, "cannot call get_power method, resuming\n");
+			goto err;
+		}
+		if (powered_down)
+			break;
+		usleep_range(800, 1600);
+	}
+	if (!powered_down) {
+		dev_err(&dev->device, "refused to power down, resuming\n");
+		goto err;
+	}
+
+	if (ACPI_FAILURE(acpi_enable_gpe(NULL, upstream->wake_gpe))) {
+		dev_err(&dev->device, "cannot enable wake GPE, resuming\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	acpi_execute_simple_method(upstream->set_power, NULL, 1);
+	dev->port->current_state = PCI_D0;
+	pci_restore_state(dev->port);
+	pci_walk_bus(dev->port->subordinate, pm_set_d3hot_and_resume_cb, NULL);
+	return -EAGAIN;
+}
+
+static int upstream_runtime_resume(struct pcie_device *dev)
+{
+	struct tb_upstream *upstream = get_service_data(dev);
+
+	if (system_state >= SYSTEM_HALT)
+		return -ESHUTDOWN;
+
+	if (ACPI_FAILURE(acpi_disable_gpe(NULL, upstream->wake_gpe))) {
+		dev_err(&dev->device, "cannot disable wake GPE, disabling runtime pm\n");
+		pm_runtime_get_noresume(&upstream->nhi->dev);
+	}
+
+	dev_info(&dev->device, "powering up\n");
+	if (ACPI_FAILURE(acpi_execute_simple_method(upstream->set_power, NULL,
+						    1))) {
+		dev_err(&dev->device, "cannot call set_power method\n");
+		return -ENODEV;
+	}
+
+	dev->port->current_state = PCI_D0;
+	pci_restore_state(dev->port);
+
+	/* wake children to force pci_restore_state() after D3cold */
+	pci_walk_bus(dev->port->subordinate, pm_set_d3hot_and_resume_cb, NULL);
+	return 0;
+}
+
+static u32 upstream_wake_nhi(acpi_handle gpe_device, u32 gpe_number, void *ctx)
+{
+	struct pci_dev *nhi = ctx;
+	WARN_ON(pm_request_resume(&nhi->dev) < 0);
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+static int pm_init_cb(struct pci_dev *pdev, void *ptr)
+{
+	/* opt out of mandatory runtime resume after system sleep */
+	pdev->dev.power.direct_complete_noresume = true;
+	return 0;
+}
+
+extern struct pci_device_id nhi_ids[];
+
+static int upstream_probe(struct pcie_device *dev)
+{
+	struct tb_upstream *upstream;
+	struct acpi_handle *nhi_handle;
+	struct pci_dev *dsb0;
+
+	/* host controllers only */
+	if (!dev->port->bus->self ||
+	    pci_pcie_type(dev->port->bus->self) != PCI_EXP_TYPE_ROOT_PORT)
+		return -ENODEV;
+
+	upstream = devm_kzalloc(&dev->device, sizeof(*upstream), GFP_KERNEL);
+	if (!upstream)
+		return -ENOMEM;
+
+	/* find Downstream Bridge 0 and NHI */
+	dsb0 = pci_get_slot(dev->port->subordinate, 0);
+	if (!dsb0 || !dsb0->subordinate) {
+		pci_dev_put(dsb0);
+		return -ENODEV;
+	}
+	upstream->nhi = pci_get_slot(dsb0->subordinate, 0);
+	pci_dev_put(dsb0);
+	if (!upstream->nhi || !pci_match_id(nhi_ids, upstream->nhi))
+		goto err;
+	nhi_handle = ACPI_HANDLE(&upstream->nhi->dev);
+	if (!nhi_handle)
+		goto err;
+
+	/* Macs introduced 2011/2012 have XRPE, 2013+ have TRPE */
+	if (ACPI_FAILURE(acpi_get_handle(nhi_handle, "XRPE",
+					 &upstream->set_power)) &&
+	    ACPI_FAILURE(acpi_get_handle(nhi_handle, "TRPE",
+					 &upstream->set_power))) {
+		dev_err(&dev->device, "cannot find set_power method\n");
+		goto err;
+	}
+
+	if (ACPI_FAILURE(acpi_get_handle(nhi_handle, "XRIL",
+					 &upstream->get_power))) {
+		dev_err(&dev->device, "cannot find get_power method\n");
+		goto err;
+	}
+
+	if (ACPI_FAILURE(acpi_evaluate_integer(nhi_handle, "XRIN", NULL,
+					       &upstream->wake_gpe))) {
+		dev_err(&dev->device, "cannot find wake GPE\n");
+		goto err;
+	}
+
+	if (ACPI_FAILURE(acpi_install_gpe_handler(NULL, upstream->wake_gpe,
+						  ACPI_GPE_LEVEL_TRIGGERED,
+						  upstream_wake_nhi,
+						  upstream->nhi))) {
+		dev_err(&dev->device, "cannot install GPE handler\n");
+		goto err;
+	}
+
+	set_service_data(dev, upstream);
+	pci_walk_bus(dev->port->bus, pm_init_cb, NULL);
+	return 0;
+
+err:
+	pci_dev_put(upstream->nhi);
+	return -ENODEV;
+}
+
+static void upstream_remove(struct pcie_device *dev)
+{
+	struct tb_upstream *upstream = get_service_data(dev);
+
+	if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, upstream->wake_gpe,
+						 upstream_wake_nhi)))
+		dev_err(&dev->device, "cannot remove GPE handler\n");
+
+	pci_dev_put(upstream->nhi);
+	set_service_data(dev, NULL);
+}
+
+struct pcie_port_service_driver upstream_driver = {
+	.name			= "thunderbolt_upstream",
+	.port_type		= PCI_EXP_TYPE_UPSTREAM,
+	.service		= PCIE_PORT_SERVICE_TBT,
+	.probe			= upstream_probe,
+	.remove			= upstream_remove,
+	.prepare		= upstream_prepare,
+	.complete		= upstream_complete,
+	.runtime_suspend	= upstream_runtime_suspend,
+	.runtime_resume		= upstream_runtime_resume,
+};
-- 
2.8.1

