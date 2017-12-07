Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Govinda Tatti <Govinda.Tatti@Oracle.COM>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        boris.ostrovsky@Oracle.COM, jgross@suse.com, JBeulich@suse.com,
        roger.pau@citrix.com
Cc: konrad.wilk@Oracle.COM
Subject: [PATCH V3 2/2] Xen/PCIback: Implement PCI flr/slot/bus reset with 'reset' SysFS attribute
Date: Thu,  7 Dec 2017 17:21:45 -0500
Message-Id: <20171207222145.9769-3-Govinda.Tatti@Oracle.COM>
In-Reply-To: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The life-cycle of a PCI device in Xen pciback is complex and is constrained
by the generic PCI locking mechanism.

- It starts with the device being bound to us, for which we do a function
  reset (done via SysFS so the PCI lock is held).
- If the device is unbound from us, we also do a function reset
  (done via SysFS so the PCI lock is held).
- If the device is un-assigned from a guest - we do a function reset
  (no PCI lock is held).

All reset operations are done on the individual PCI function level
(so bus:device:function).

The reset for an individual PCI function means device must support FLR
(PCIe or AF), PM reset on D3hot->D0 device specific reset, or a secondary
bus reset for a singleton device on a bus but FLR does not have widespread
support or it is not reliable in some cases. So, we need to provide an
alternate mechanism to users to perform a slot or bus level reset.

Currently, a slot or bus reset is not exposed in SysFS as there is no good
way of exposing a bus topology there. This is due to the complexity -
we MUST know that the different functions of a PCIe device are not in use
by other drivers, or if they are in use (say one of them is assigned to a
guest and the other is  idle) - it is still OK to reset the slot (assuming
both of them are owned by Xen pciback).

This patch does that providing an option to perform a flr/slot/bus reset
when a PCI device is owned by Xen PCI backend. It will try to execute one
of these reset method, starting with FLR if it is supported. Otherwise,
it tries slot or bus reset method. For slot or bus reset method, it also
checks to make sure that all of the devices under the bridge are owned by
Xen PCI backend before applying those resets.

Due to the complexity with the PCI lock we cannot do the reset when a
device is bound ('echo $BDF > bind') or when unbound ('echo $BDF > unbind')
as the pci_[slot|bus]_reset also takes the same lock resulting in a
dead-lock.

Putting the reset function in a work-queue or thread won't work either -
as we have to do the reset function outside the 'unbind' context (it holds
the PCI lock). But once you 'unbind' a device the device is no longer under
the ownership of Xen pciback and the pci_set_drvdata has been reset, so
we cannot use a thread for this.

Instead of doing all this complex dance, we depend on the tool-stack doing
the right thing. As such, we implement 'reset' SysFS attribute which 'xl'
uses when a device is detached or attached from/to a guest. It bypasses
the need to worry about the PCI lock. BTW, previously defined "do_flr"
attribute has been renamed to "reset" since "do_flr" name doesn't represent
all PCI reset methods and plus, currently it is not being used. So, there
is no impact in renaming this sysfs attribute.

To not inadvertently do a bus reset that would affect devices that are in
use by other drivers (other than Xen pciback) prior to the reset, we check
that all of the devices under the bridge are owned by Xen pciback. If they
are not, we refrain from executing the bus (or slot) reset.

Signed-off-by: Govinda Tatti <Govinda.Tatti@Oracle.COM>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
v1: - First posting
v2: - struct pcistub_args: Changed docunt field as unsigned int
    - pcistub_reset_dev: initialization of "struct pcistub_args"
    - pcistub_reset_dev: combined multiple if-statements
    - pcistub_do_flr: removed goto statement
v3: - Resynced with linux kernel 4.14.4 and latest pci_stub.c changes.
    - Renamed "do_flr" SysFS attribute to "reset". Plus, modified
      "reset" SysFS attribute code as per the latest changes in 4.14.4.
    - struct pcistub_args: added "const" to "struct pci_dev *dev" field
    - pcistub_device_search: Renamed found_dev to found
    - pcistub_device_search: Modified comments and return statements
    - pcistub_device_reset: introduced FLR reset code
    - pcistub_device_reset: Modified all dev_dbg messages

 Documentation/ABI/testing/sysfs-driver-pciback |  15 +++
 drivers/xen/xen-pciback/pci_stub.c             | 128 +++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-pciback b/Documentation/ABI/testing/sysfs-driver-pciback
index 6a733bf..d295b42 100644
--- a/Documentation/ABI/testing/sysfs-driver-pciback
+++ b/Documentation/ABI/testing/sysfs-driver-pciback
@@ -11,3 +11,18 @@ Description:
                 #echo 00:19.0-E0:2:FF > /sys/bus/pci/drivers/pciback/quirks
                 will allow the guest to read and write to the configuration
                 register 0x0E.
+
+What:           /sys/bus/pci/drivers/pciback/reset
+Date:           Dec 2017
+KernelVersion:  4.15
+Contact:        xen-devel@lists.xenproject.org
+Description:
+                An option to perform a flr/slot/bus reset when a PCI device
+		is owned by Xen PCI backend. Writing a string of DDDD:BB:DD.F
+		will cause the pciback driver to perform a flr or slot or bus
+		reset if the device supports it. It will try to execute one
+		of these reset method, starting with FLR if it is supported.
+		Otherwise, it tries slot or bus reset methods. For slot or
+		bus reset method, it also checks to make sure that all of the
+		devices under the bridge are owned by Xen PCI backend before
+		performing those resets.
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 9e480fd..cad704e 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -313,6 +313,102 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	up_write(&pcistub_sem);
 }
 
+struct pcistub_args {
+	const struct pci_dev *dev;
+	unsigned int dcount;
+};
+
+static int pcistub_device_search(struct pci_dev *dev, void *data)
+{
+	struct pcistub_device *psdev;
+	struct pcistub_args *arg = data;
+	bool found = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pcistub_devices_lock, flags);
+
+	list_for_each_entry(psdev, &pcistub_devices, dev_list) {
+		if (psdev->dev == dev) {
+			found = true;
+			arg->dcount++;
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&pcistub_devices_lock, flags);
+
+	/* Device not owned by pcistub. Abort the walk */
+	if (!found) {
+		arg->dev = dev;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int pcistub_device_reset(struct pci_dev *dev)
+{
+	struct xen_pcibk_dev_data *dev_data;
+	bool slot = false, bus = false;
+	struct pcistub_args arg = {};
+
+	if (!dev)
+		return -EINVAL;
+
+	dev_dbg(&dev->dev, "[%s]\n", __func__);
+
+	/* First check and try FLR */
+	if (pcie_has_flr(dev)) {
+		dev_dbg(&dev->dev, "resetting %s device using FLR\n",
+			pci_name(dev));
+		pcie_flr(dev);
+		return 0;
+	}
+
+	if (!pci_probe_reset_slot(dev->slot))
+		slot = true;
+	else if ((!pci_probe_reset_bus(dev->bus)) &&
+		 (!pci_is_root_bus(dev->bus)))
+		bus = true;
+
+	if (!bus && !slot)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Make sure all devices on this bus are owned by the
+	 * PCI backend so that we can safely reset the whole bus.
+	 */
+	pci_walk_bus(dev->bus, pcistub_device_search, &arg);
+
+	/* All devices under the bus should be part of pcistub! */
+	if (arg.dev) {
+		dev_err(&dev->dev,
+			"%s on the same bus as %s and is not owned by "
+			DRV_NAME "\n", pci_name(arg.dev), pci_name(dev));
+
+		return -EBUSY;
+	}
+
+	dev_dbg(&dev->dev, "pcistub owns %d devices on PCI Bus %04x:%02x",
+		arg.dcount, pci_domain_nr(dev->bus), dev->bus->number);
+
+	dev_data = pci_get_drvdata(dev);
+	if (!pci_load_saved_state(dev, dev_data->pci_saved_state))
+		pci_restore_state(dev);
+
+	/* This disables the device. */
+	xen_pcibk_reset_device(dev);
+
+	/* Cleanup up any emulated fields */
+	xen_pcibk_config_reset_dev(dev);
+
+	dev_dbg(&dev->dev, "resetting %s device using %s reset\n",
+		pci_name(dev), slot ? "slot" : "bus");
+
+	return slot ? pci_try_reset_slot(dev->slot) :
+			pci_try_reset_bus(dev->bus);
+}
+
 static int pcistub_match_one(struct pci_dev *dev,
 			     struct pcistub_device_id *pdev_id)
 {
@@ -1430,6 +1526,32 @@ static ssize_t permissive_show(struct device_driver *drv, char *buf)
 }
 static DRIVER_ATTR_RW(permissive);
 
+static ssize_t reset_store(struct device_driver *drv, const char *buf,
+			   size_t count)
+{
+	struct pcistub_device *psdev;
+	int domain, bus, slot, func;
+	int err;
+
+	err = str_to_slot(buf, &domain, &bus, &slot, &func);
+	if (err)
+		return err;
+
+	psdev = pcistub_device_find(domain, bus, slot, func);
+	if (psdev) {
+		err = pcistub_device_reset(psdev->dev);
+		pcistub_device_put(psdev);
+	} else {
+		err = -ENODEV;
+	}
+
+	if (!err)
+		err = count;
+
+	return err;
+}
+static DRIVER_ATTR_WO(reset);
+
 static void pcistub_exit(void)
 {
 	driver_remove_file(&xen_pcibk_pci_driver.driver, &driver_attr_new_slot);
@@ -1443,6 +1565,8 @@ static void pcistub_exit(void)
 			   &driver_attr_irq_handlers);
 	driver_remove_file(&xen_pcibk_pci_driver.driver,
 			   &driver_attr_irq_handler_state);
+	driver_remove_file(&xen_pcibk_pci_driver.driver,
+			   &driver_attr_reset);
 	pci_unregister_driver(&xen_pcibk_pci_driver);
 }
 
@@ -1536,6 +1660,10 @@ static int __init pcistub_init(void)
 	if (!err)
 		err = driver_create_file(&xen_pcibk_pci_driver.driver,
 					&driver_attr_irq_handler_state);
+	if (!err)
+		err = driver_create_file(&xen_pcibk_pci_driver.driver,
+					 &driver_attr_reset);
+
 	if (err)
 		pcistub_exit();
 
-- 
2.9.5
