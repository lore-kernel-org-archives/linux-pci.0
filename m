Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        rjw@rjwysocki.net, dianders@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>
Subject: [RFC PATCH v9 6/7] PCI / PM: Move acpi wakeup code to pci core
Date: Fri, 27 Oct 2017 15:17:38 +0800
Message-Id: <20171027071739.21927-7-jeffy.chen@rock-chips.com>
In-Reply-To: <20171027071739.21927-1-jeffy.chen@rock-chips.com>
References: <20171027071739.21927-1-jeffy.chen@rock-chips.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move acpi wakeup code to pci core as pci_set_wakeup(), so that other
platforms could reuse it.

Also add .setup_dev() / .setup_host_bridge() / .cleanup() platform pm
ops's callbacks to setup and cleanup pci devices and host bridge for
wakeup.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v3: None
Changes in v2: None

 drivers/pci/pci-acpi.c   | 121 +++++++++++++++++++++++------------------------
 drivers/pci/pci-driver.c |   9 ++++
 drivers/pci/pci.c        |  84 ++++++++++++++++++++++++++++----
 drivers/pci/pci.h        |  28 +++++++++--
 drivers/pci/probe.c      |  12 ++++-
 drivers/pci/remove.c     |   2 +
 include/linux/pci.h      |   2 +
 7 files changed, 180 insertions(+), 78 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4708eb9df71b..ee96e7afe1ac 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -569,31 +569,6 @@ static pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
 	return state_conv[state];
 }
 
-static int acpi_pci_propagate_wakeup(struct pci_bus *bus, bool enable)
-{
-	while (bus->parent) {
-		if (acpi_pm_device_can_wakeup(&bus->self->dev))
-			return acpi_pm_set_bridge_wakeup(&bus->self->dev, enable);
-
-		bus = bus->parent;
-	}
-
-	/* We have reached the root bus. */
-	if (bus->bridge) {
-		if (acpi_pm_device_can_wakeup(bus->bridge))
-			return acpi_pm_set_bridge_wakeup(bus->bridge, enable);
-	}
-	return 0;
-}
-
-static int acpi_pci_wakeup(struct pci_dev *dev, bool enable)
-{
-	if (acpi_pm_device_can_wakeup(&dev->dev))
-		return acpi_pm_set_device_wakeup(&dev->dev, enable);
-
-	return acpi_pci_propagate_wakeup(dev->bus, enable);
-}
-
 static bool acpi_pci_need_resume(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
@@ -610,14 +585,29 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
 	return !!adev->power.flags.dsw_present;
 }
 
-static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
-	.is_manageable = acpi_pci_power_manageable,
-	.set_state = acpi_pci_set_power_state,
-	.get_state = acpi_pci_get_power_state,
-	.choose_state = acpi_pci_choose_state,
-	.set_wakeup = acpi_pci_wakeup,
-	.need_resume = acpi_pci_need_resume,
-};
+static bool acpi_pci_can_wakeup(void *pmdata)
+{
+	struct device *dev = pmdata;
+
+	if (!dev)
+		return false;
+
+	return acpi_pm_device_can_wakeup(dev);
+}
+
+static int acpi_pci_dev_wakeup(void *pmdata, bool enable)
+{
+	struct device *dev = pmdata;
+
+	return acpi_pm_set_device_wakeup(dev, enable);
+}
+
+static int acpi_pci_bridge_wakeup(void *pmdata, bool enable)
+{
+	struct device *dev = pmdata;
+
+	return acpi_pm_set_bridge_wakeup(dev, enable);
+}
 
 void acpi_pci_add_bus(struct pci_bus *bus)
 {
@@ -658,20 +648,6 @@ void acpi_pci_remove_bus(struct pci_bus *bus)
 	acpi_pci_slot_remove(bus);
 }
 
-/* ACPI bus type */
-static struct acpi_device *acpi_pci_find_companion(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	bool check_children;
-	u64 addr;
-
-	check_children = pci_is_bridge(pci_dev);
-	/* Please ref to ACPI spec for the syntax of _ADR */
-	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
-	return acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
-				      check_children);
-}
-
 /**
  * pci_acpi_optimize_delay - optimize PCI D3 and D3cold delay from ACPI
  * @pdev: the PCI device whose delay is to be updated
@@ -723,34 +699,55 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
-static void pci_acpi_setup(struct device *dev)
+static void *acpi_pci_setup_dev(struct pci_dev *pci_dev)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev = ACPI_COMPANION(&pci_dev->dev);
 
 	if (!adev)
-		return;
+		return NULL;
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
 	if (!adev->wakeup.flags.valid)
-		return;
+		return NULL;
+
+	device_set_wakeup_capable(&pci_dev->dev, true);
+	acpi_pm_set_device_wakeup(&pci_dev->dev, false);
 
-	device_set_wakeup_capable(dev, true);
-	acpi_pci_wakeup(pci_dev, false);
+	return &pci_dev->dev;
 }
 
-static void pci_acpi_cleanup(struct device *dev)
+static void *acpi_pci_setup_host_bridge(struct pci_host_bridge *bridge)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	return &bridge->dev;
+}
 
-	if (!adev)
-		return;
+static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
+	.is_manageable = acpi_pci_power_manageable,
+	.set_state = acpi_pci_set_power_state,
+	.get_state = acpi_pci_get_power_state,
+	.choose_state = acpi_pci_choose_state,
+	.need_resume = acpi_pci_need_resume,
+	.setup_dev = acpi_pci_setup_dev,
+	.setup_host_bridge = acpi_pci_setup_host_bridge,
+	.can_wakeup = acpi_pci_can_wakeup,
+	.dev_wakeup = acpi_pci_dev_wakeup,
+	.bridge_wakeup = acpi_pci_bridge_wakeup,
+};
+
+/* ACPI bus type */
+static struct acpi_device *acpi_pci_find_companion(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	bool check_children;
+	u64 addr;
 
-	pci_acpi_remove_pm_notifier(adev);
-	if (adev->wakeup.flags.valid)
-		device_set_wakeup_capable(dev, false);
+	check_children = pci_is_bridge(pci_dev);
+	/* Please ref to ACPI spec for the syntax of _ADR */
+	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
+	return acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
+				      check_children);
 }
 
 static bool pci_acpi_bus_match(struct device *dev)
@@ -762,8 +759,6 @@ static struct acpi_bus_type acpi_pci_bus = {
 	.name = "PCI",
 	.match = pci_acpi_bus_match,
 	.find_companion = acpi_pci_find_companion,
-	.setup = pci_acpi_setup,
-	.cleanup = pci_acpi_cleanup,
 };
 
 
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 9be563067c0c..abb7caa8a6e5 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -421,10 +421,17 @@ static int pci_device_probe(struct device *dev)
 	if (error < 0)
 		return error;
 
+	pci_dev->pmdata = platform_pci_setup_dev(pci_dev);
+	if (IS_ERR(pci_dev->pmdata)) {
+		pcibios_free_irq(pci_dev);
+		return PTR_ERR(pci_dev->pmdata);
+	}
+
 	pci_dev_get(pci_dev);
 	if (pci_device_can_probe(pci_dev)) {
 		error = __pci_device_probe(drv, pci_dev);
 		if (error) {
+			platform_pci_cleanup(pci_dev->pmdata);
 			pcibios_free_irq(pci_dev);
 			pci_dev_put(pci_dev);
 		}
@@ -438,6 +445,8 @@ static int pci_device_remove(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	platform_pci_cleanup(pci_dev->pmdata);
+
 	if (drv) {
 		if (drv->remove) {
 			pm_runtime_get_sync(dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e120b00a9017..6add5d3209bf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -585,6 +585,52 @@ static inline bool platform_pci_power_manageable(struct pci_dev *dev)
 	return false;
 }
 
+void *platform_pci_setup_dev(struct pci_dev *dev)
+{
+	if (pci_platform_pm && pci_platform_pm->setup_dev)
+		return pci_platform_pm->setup_dev(dev);
+
+	return NULL;
+}
+
+void *platform_pci_setup_host_bridge(struct pci_host_bridge *bridge)
+{
+	if (pci_platform_pm && pci_platform_pm->setup_host_bridge)
+		return pci_platform_pm->setup_host_bridge(bridge);
+
+	return NULL;
+}
+
+void platform_pci_cleanup(void *pmdata)
+{
+	if (pci_platform_pm && pci_platform_pm->cleanup)
+		pci_platform_pm->cleanup(pmdata);
+}
+
+static inline bool platform_pci_can_wakeup(void *pmdata)
+{
+	if (pci_platform_pm && pci_platform_pm->can_wakeup)
+		return pci_platform_pm->can_wakeup(pmdata);
+
+	return false;
+}
+
+static inline int platform_pci_dev_wakeup(void *pmdata, bool enable)
+{
+	if (pci_platform_pm && pci_platform_pm->dev_wakeup)
+		return pci_platform_pm->dev_wakeup(pmdata, enable);
+
+	return -ENODEV;
+}
+
+static inline int platform_pci_bridge_wakeup(void *pmdata, bool enable)
+{
+	if (pci_platform_pm && pci_platform_pm->bridge_wakeup)
+		return pci_platform_pm->bridge_wakeup(pmdata, enable);
+
+	return -ENODEV;
+}
+
 static inline int platform_pci_set_power_state(struct pci_dev *dev,
 					       pci_power_t t)
 {
@@ -610,14 +656,6 @@ static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
 	return PCI_POWER_ERROR;
 }
 
-static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
-{
-	if (pci_platform_pm && pci_platform_pm->set_wakeup)
-		return pci_platform_pm->set_wakeup(dev, enable);
-
-	return -ENODEV;
-}
-
 static inline bool platform_pci_need_resume(struct pci_dev *dev)
 {
 	if (pci_platform_pm && pci_platform_pm->need_resume)
@@ -1903,6 +1941,32 @@ void pci_pme_active(struct pci_dev *dev, bool enable)
 }
 EXPORT_SYMBOL(pci_pme_active);
 
+static int pci_set_wakeup(struct pci_dev *dev, bool enable)
+{
+	struct pci_bus *bus = dev->bus;
+	struct pci_host_bridge *bridge;
+
+	/* Handle per device wakeup  */
+	if (platform_pci_can_wakeup(dev->pmdata))
+		return platform_pci_dev_wakeup(dev->pmdata, enable);
+
+	/* Find a parent which can handle wakeup */
+	while (bus->parent) {
+		if (platform_pci_can_wakeup(bus->self->pmdata))
+			return platform_pci_bridge_wakeup(bus->self->pmdata,
+							  enable);
+
+		bus = bus->parent;
+	}
+
+	/* We have reached the root bus. */
+	bridge = to_pci_host_bridge(bus->bridge);
+	if (platform_pci_can_wakeup(bridge->pmdata))
+		return platform_pci_bridge_wakeup(bridge->pmdata, enable);
+
+	return 0;
+}
+
 /**
  * pci_enable_wake - enable PCI device as wakeup event source
  * @dev: PCI device affected
@@ -1950,13 +2014,13 @@ int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
 			pci_pme_active(dev, true);
 		else
 			ret = 1;
-		error = platform_pci_set_wakeup(dev, true);
+		error = pci_set_wakeup(dev, true);
 		if (ret)
 			ret = error;
 		if (!ret)
 			dev->wakeup_prepared = true;
 	} else {
-		platform_pci_set_wakeup(dev, false);
+		pci_set_wakeup(dev, false);
 		pci_pme_active(dev, false);
 		dev->wakeup_prepared = false;
 	}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 048668271014..dcefb9e759d7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -47,21 +47,43 @@ int pci_probe_reset_function(struct pci_dev *dev);
  *                platform; to be used during system-wide transitions from a
  *                sleeping state to the working state and vice versa
  *
- * @set_wakeup: enables/disables wakeup capability for the device
- *
  * @need_resume: returns 'true' if the given device (which is currently
  *		suspended) needs to be resumed to be configured for system
  *		wakeup.
+ *
+ * @setup_dev: setup device's wakeup ability, alloc and return device's private
+ * 		pm data.
+ *
+ * @setup_host_bridge: setup host bridge's wakeup ability, alloc and return host
+ * 		bridge's private pm data.
+ *
+ * @cleanup: cleanup the private pm data and deinit wakeup ability.
+ *
+ * @can_wakeup: returns 'true' if given device is capable of waking up the
+ *		system from a sleeping state.
+ *
+ * @dev_wakeup: enables/disables wakeup capability for the device.
+ *
+ * @bridge_wakeup: enables/disables wakeup capability for the bridge.
  */
 struct pci_platform_pm_ops {
 	bool (*is_manageable)(struct pci_dev *dev);
 	int (*set_state)(struct pci_dev *dev, pci_power_t state);
 	pci_power_t (*get_state)(struct pci_dev *dev);
 	pci_power_t (*choose_state)(struct pci_dev *dev);
-	int (*set_wakeup)(struct pci_dev *dev, bool enable);
 	bool (*need_resume)(struct pci_dev *dev);
+	void *(*setup_dev)(struct pci_dev *dev);
+	void *(*setup_host_bridge)(struct pci_host_bridge *bridge);
+	void (*cleanup)(void *pmdata);
+	bool (*can_wakeup)(void *pmdata);
+	int (*dev_wakeup)(void *pmdata, bool enable);
+	int (*bridge_wakeup)(void *pmdata, bool enable);
 };
 
+void *platform_pci_setup_dev(struct pci_dev *dev);
+void *platform_pci_setup_host_bridge(struct pci_host_bridge *bridge);
+void platform_pci_cleanup(void *pmdata);
+
 void pci_set_platform_pm(const struct pci_platform_pm_ops *ops);
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_power_up(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cdc2f83c11c5..b12c552a5522 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -809,7 +809,13 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 	err = device_register(&bus->dev);
 	if (err)
-		goto unregister;
+		goto unregister_bridge;
+
+	bridge->pmdata = platform_pci_setup_host_bridge(bridge);
+	if (IS_ERR(bridge->pmdata)) {
+		err = PTR_ERR(bridge->pmdata);
+		goto unregister_bus;
+	}
 
 	pcibios_add_bus(bus);
 
@@ -853,7 +859,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 	return 0;
 
-unregister:
+unregister_bus:
+	device_unregister(&bus->dev);
+unregister_bridge:
 	put_device(&bridge->dev);
 	device_unregister(&bridge->dev);
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 73a03d382590..d7a8cf1dc69f 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -153,6 +153,8 @@ void pci_remove_root_bus(struct pci_bus *bus)
 	if (!pci_is_root_bus(bus))
 		return;
 
+	platform_pci_cleanup(host_bridge->pmdata);
+
 	host_bridge = to_pci_host_bridge(bus->bridge);
 	list_for_each_entry_safe(child, tmp,
 				 &bus->devices, bus_list)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 80eaa2dbe3e9..628faa58c790 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -293,6 +293,7 @@ struct pci_dev {
 	struct pci_bus	*subordinate;	/* bus this device bridges to */
 
 	void		*sysdata;	/* hook for sys-specific extension */
+	void		*pmdata;	/* data for platform pm */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/pci */
 	struct pci_slot	*slot;		/* Physical slot this device is in */
 
@@ -467,6 +468,7 @@ struct pci_host_bridge {
 	struct pci_bus *bus;		/* root bus */
 	struct pci_ops *ops;
 	void *sysdata;
+	void *pmdata;			/* data for platform pm */
 	int busnr;
 	struct list_head windows;	/* resource_entry */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* platform IRQ swizzler */
-- 
2.11.0


