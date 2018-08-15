Return-Path: <SRS0=/dXs=K6=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=/dXs=K6=kernel.crashing.org=benh@kernel.org>
Message-ID: <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
Subject: [RFC PATCH] pci: Proof of concept at fixing
 pci_enable_device/bridge races
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Thu, 16 Aug 2018 07:50:13 +1000
In-Reply-To: <58192cf94de3941f9141aa3203399ae2bcdf6b7a.camel@kernel.crashing.org>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
	 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
	 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
	 <5e42f7990673d11e3a020e7efcfd333215d48138.camel@kernel.crashing.org>
	 <58192cf94de3941f9141aa3203399ae2bcdf6b7a.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

(Resent with lkml on copy)

[Note: This isn't meant to be merged, it need splitting at the very
least, see below]

This is something I cooked up quickly today to test if that would fix
my problems with large number of switch and NVME devices on POWER.

So far it does...

The issue (as discussed in the Re: PCIe enable device races thread) is
that pci_enable_device and related functions along with pci_set_master
and pci_enable_bridge are fundamentally racy.

There is no lockign protecting the state of the device in pci_dev and
if multiple devices under the same bridge try to enable it simultaneously
one some of them will potentially start accessing it before it has actually
been enabled.

Now there are a LOT more fields in pci_dev that aren't covered by any
form of locking.

Additionally, some other parts such as ASPM or SR-IOV seem to be trying to do
their own ad-hoc locking, but will manipulate bit fields in pci_dev that
might be sharing words with other unrelated bit fields racily.

So I think we need to introduce a pci_dev mutex aimed at synchronizing
the main enable/master state of a given device, and possibly also the
bazillion of state bits held inside pci_dev.

I suggest a progressive approach:

 1- First we add the mutex, and put a red line comment "/* ----- */" in
    struct pci_dev, at the bottom

 2- We move the basic enable/disable/set_master stuff under that lock and
    move the corresponding fields in pci_dev below the line comment.

 3- Progressively, as we untangle them and verify their locking, we move
    individual fields below the line so that we have a good visibility of
    what has been addressed/audited already and what not

Note: I would very much like to keep most of the probing/resource allocation
single threaded at least within a given domain, I know we have some attempts
at locking in the hotplug code for that, I'm not ready to tackle that or
change it at this stage.

We might be able to also addrss the is_added issues (Hari Vyas stuff) using
the same mutex, I haven't looked into the details.

Not-signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 316496e99da9..9c4895c40f1d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1348,9 +1348,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
  */
 int pci_reenable_device(struct pci_dev *dev)
 {
+	int rc = 0;
+
+	mutex_lock(&dev->lock);
 	if (pci_is_enabled(dev))
-		return do_pci_enable_device(dev, (1 << PCI_NUM_RESOURCES) - 1);
-	return 0;
+		rc = do_pci_enable_device(dev, (1 << PCI_NUM_RESOURCES) - 1);
+	mutex_unlock(&dev->lock);
+	return rc;
 }
 EXPORT_SYMBOL(pci_reenable_device);
 
@@ -1363,12 +1367,6 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	if (bridge)
 		pci_enable_bridge(bridge);
 
-	if (pci_is_enabled(dev)) {
-		if (!dev->is_busmaster)
-			pci_set_master(dev);
-		return;
-	}
-
 	retval = pci_enable_device(dev);
 	if (retval)
 		pci_err(dev, "Error enabling bridge (%d), continuing\n",
@@ -1379,9 +1377,16 @@ static void pci_enable_bridge(struct pci_dev *dev)
 static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 {
 	struct pci_dev *bridge;
-	int err;
+	int err = 0;
 	int i, bars = 0;
 
+	/* Handle upstream bridges first to avoid locking issues */
+	bridge = pci_upstream_bridge(dev);
+	if (bridge)
+		pci_enable_bridge(bridge);
+
+	mutex_lock(&dev->lock);
+
 	/*
 	 * Power state could be unknown at this point, either due to a fresh
 	 * boot or a device removal call.  So get the current power state
@@ -1394,12 +1399,9 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
 	}
 
+	/* Already enabled ? */
 	if (atomic_inc_return(&dev->enable_cnt) > 1)
-		return 0;		/* already enabled */
-
-	bridge = pci_upstream_bridge(dev);
-	if (bridge)
-		pci_enable_bridge(bridge);
+		goto bail;
 
 	/* only skip sriov related */
 	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
@@ -1412,6 +1414,8 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 	err = do_pci_enable_device(dev, bars);
 	if (err < 0)
 		atomic_dec(&dev->enable_cnt);
+ bail:
+	mutex_unlock(&dev->lock);
 	return err;
 }
 
@@ -1618,6 +1622,7 @@ static void do_pci_disable_device(struct pci_dev *dev)
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
+		dev->is_busmaster = 0;
 	}
 
 	pcibios_disable_device(dev);
@@ -1632,8 +1637,10 @@ static void do_pci_disable_device(struct pci_dev *dev)
  */
 void pci_disable_enabled_device(struct pci_dev *dev)
 {
+	mutex_lock(&dev->lock);
 	if (pci_is_enabled(dev))
 		do_pci_disable_device(dev);
+	mutex_unlock(&dev->lock);
 }
 
 /**
@@ -1657,12 +1664,13 @@ void pci_disable_device(struct pci_dev *dev)
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
+	mutex_lock(&dev->lock);
 	if (atomic_dec_return(&dev->enable_cnt) != 0)
-		return;
+		goto bail;
 
 	do_pci_disable_device(dev);
-
-	dev->is_busmaster = 0;
+ bail:
+	mutex_unlock(&dev->lock);
 }
 EXPORT_SYMBOL(pci_disable_device);
 
@@ -3764,8 +3772,12 @@ void __weak pcibios_set_master(struct pci_dev *dev)
  */
 void pci_set_master(struct pci_dev *dev)
 {
-	__pci_set_master(dev, true);
-	pcibios_set_master(dev);
+	mutex_lock(&dev->lock);
+	if (!dev->is_busmaster) {
+		__pci_set_master(dev, true);
+		pcibios_set_master(dev);
+	}
+	mutex_unlock(&dev->lock);
 }
 EXPORT_SYMBOL(pci_set_master);
 
@@ -3775,7 +3787,9 @@ EXPORT_SYMBOL(pci_set_master);
  */
 void pci_clear_master(struct pci_dev *dev)
 {
+	mutex_lock(&dev->lock);
 	__pci_set_master(dev, false);
+	mutex_unlock(&dev->lock);
 }
 EXPORT_SYMBOL(pci_clear_master);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 611adcd9c169..77701bfe0d3d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2102,6 +2102,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
+	mutex_init(&dev->lock);
 
 	return dev;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c133ccfa002e..09e94ba6adf0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -33,6 +33,7 @@
 #include <linux/io.h>
 #include <linux/resource_ext.h>
 #include <uapi/linux/pci.h>
+#include <linux/mutex.h>
 
 #include <linux/pci_ids.h>
 
@@ -289,6 +290,8 @@ struct pci_dev {
 	struct proc_dir_entry *procent;	/* Device entry in /proc/bus/pci */
 	struct pci_slot	*slot;		/* Physical slot this device is in */
 
+	struct mutex	lock;
+
 	unsigned int	devfn;		/* Encoded device & function index */
 	unsigned short	vendor;
 	unsigned short	device;
