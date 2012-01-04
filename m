Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:61766 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098Ab2ADTGV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2012 14:06:21 -0500
Date: Wed, 4 Jan 2012 14:04:48 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
Subject: Re: pci_reset_function() being called from "bind" or "unbind"
Message-ID: <20120104190448.GA16758@phenom.dumpdata.com>
References: <20120104184307.GA30359@phenom.dumpdata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120104184307.GA30359@phenom.dumpdata.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 04, 2012 at 01:43:08PM -0500, Konrad Rzeszutek Wilk wrote:
> 
> I am looking at implementing the FLR functionality in the xen-pciback driver and
> found a mutex issue I am not entirely sure how to resolve.
> 
> In essence I am trying to call pci_reset_function() when a PCI device is
> "attached" (using "bind") to the xen-pciback driver.
> 
> This means that when a user does:
> 
>  echo "0000:01.07.0" > /sys/bus/pci/drivers/pciback/bind
> 
> we end up calling:
>   driver_bind:
>     device_lock(dev);
>     pcistub_probe:
>        pcistub_seize:
>          pcistub_init_device:
>            .. pci_enable_device()
>            --> want also to do pci_reset_function(), which calls
>                  pci_dev_reset(dev, 0):
> 			if (!0) {
> 				device_lock(dev) <==== DEADLOCK
> 
>            .. pci_disable_device()
> 
> So looking at the code I saw __pci_reset_function which I thought
> would do the same as pci_reset_function but without locking.
> However, it is actually the opposite - it is with the locking.
> 
> My thought is that one way to resolve this is by wrapping
> pci_probe_reset_function with a EXPORT_SYMBOL_GPL and use that
> instead. Or perhaps have a new function called
> "pci_reset_function_locked" ?
> 
> Thoughts?

Here is what I am doing right now, which is hack-ish - I end up
unlocking the device_unlock(dev) to make it possible from user-space
to work:

So thinking of the 'psi_reset_function_locked" variant but not
sure if you are OK with it?


commit 591daec1a0b5f3528bd8480ea32c09551e7613ce
Author: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date:   Tue Jan 3 19:11:24 2012 -0500

    xen/pciback: Support FLR/PM D3 reset of PCI devices.
    
    Using the generic pci_reset_function call.
    And also save the PM states of the PCI device and restore them.
    
    Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 8f06e1e..e80eaec 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -85,19 +85,46 @@ static struct pcistub_device *pcistub_device_alloc(struct pci_dev *dev)
 static void pcistub_device_release(struct kref *kref)
 {
 	struct pcistub_device *psdev;
+	struct xen_pcibk_dev_data *dev_data;
 
 	psdev = container_of(kref, struct pcistub_device, kref);
+	dev_data = pci_get_drvdata(psdev->dev);
 
 	dev_dbg(&psdev->dev->dev, "pcistub_device_release\n");
 
 	xen_unregister_device_domain_owner(psdev->dev);
 
-	/* Clean-up the device */
+	/* HACK: Check whether the release is driven from "unbind" which
+	 * takes a mutex. */
+	if (device_trylock(&psdev->dev->dev)) {
+		/* nobody has the mutex, except us so unlock */
+		device_unlock(&psdev->dev->dev);
+		/* so that we can call reset. */
+		pci_reset_function(psdev->dev);
+	} else {
+		/* "unbind" called, so release the mutex. */
+		device_unlock(&psdev->dev->dev);
+		/* so that we can do the reset */
+		pci_reset_function(psdev->dev);
+		/* and then establish the mutex again. */
+		device_lock(&psdev->dev->dev);
+	}
+
+	if (pci_load_and_free_saved_state(psdev->dev,
+					  &dev_data->pci_saved_state)) {
+		dev_dbg(&psdev->dev->dev, "Could not reload PCI state\n");
+	} else
+		pci_restore_state(psdev->dev);
+
+	/* Disable the device */
 	xen_pcibk_reset_device(psdev->dev);
+
+	kfree(dev_data);
+	pci_set_drvdata(psdev->dev, NULL);
+
+	/* Clean-up the device */
 	xen_pcibk_config_free_dyn_fields(psdev->dev);
 	xen_pcibk_config_free_dev(psdev->dev);
-	kfree(pci_get_drvdata(psdev->dev));
-	pci_set_drvdata(psdev->dev, NULL);
 
 	pci_dev_put(psdev->dev);
 
@@ -230,7 +257,17 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	/* Cleanup our device
 	 * (so it's ready for the next domain)
 	 */
+
+	/* This is OK - we are running from workqueue context
+	 * and want to inhibit the user from fiddling with 'reset'
+	 */
+	pci_reset_function(dev);
+	pci_restore_state(psdev->dev);
+
+	/* This disables the device. */
 	xen_pcibk_reset_device(found_psdev->dev);
+
+	/* And cleanup up our emulated fields. */
 	xen_pcibk_config_free_dyn_fields(found_psdev->dev);
 	xen_pcibk_config_reset_dev(found_psdev->dev);
 
@@ -325,12 +362,28 @@ static int __devinit pcistub_init_device(struct pci_dev *dev)
 	if (err)
 		goto config_release;
 
+	dev_dbg(&dev->dev, "reseting (FLR, D3, etc) the device\n");
+	/* HACK: Mutex is present if user did "bind" on the device. */
+	if (device_trylock(&dev->dev)) {
+		device_unlock(&dev->dev);
+		pci_reset_function(dev);
+	} else {
+		device_unlock(&dev->dev);
+		pci_reset_function(dev);
+		device_lock(&dev->dev);
+	}
+
+	/* We need the device active to save the state. */
+	dev_dbg(&dev->dev, "save state of device\n");
+	pci_save_state(dev);
+	dev_data->pci_saved_state = pci_store_saved_state(dev);
+	if (!dev_data->pci_saved_state)
+		dev_err(&dev->dev, "Could not store PCI conf saved state!\n");
+
 	/* Now disable the device (this also ensures some private device
 	 * data is setup before we export)
 	 */
-	dev_dbg(&dev->dev, "reset device\n");
 	xen_pcibk_reset_device(dev);
-
 	return 0;
 
 config_release:
diff --git a/drivers/xen/xen-pciback/pciback.h b/drivers/xen/xen-pciback/pciback.h
index e9b4011..a7def01 100644
--- a/drivers/xen/xen-pciback/pciback.h
+++ b/drivers/xen/xen-pciback/pciback.h
@@ -41,6 +41,7 @@ struct xen_pcibk_device {
 
 struct xen_pcibk_dev_data {
 	struct list_head config_fields;
+	struct pci_saved_state *pci_saved_state;
 	unsigned int permissive:1;
 	unsigned int warned_on_write:1;
 	unsigned int enable_intx:1;
