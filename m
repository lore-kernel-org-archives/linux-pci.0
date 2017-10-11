Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750738AbdJKVf7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Oct 2017 17:35:59 -0400
Subject: [RFC PATCH] PCI: Detach driver before procfs & sysfs teardown on
 device remove
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org
Date: Wed, 11 Oct 2017 15:35:56 -0600
Message-ID: <20171011213007.12012.37774.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When removing a device, for example a VF being removed due to SR-IOV
teardown, a "soft" hot-unplug via 'echo 1 > remove' in sysfs, or an
actual hot-unplug, we first remove the procfs and sysfs attributes
for the device before attempting to release the device from any driver
bound to it.  Unbinding the driver from the device can take time.  The
device might need to write out data or it might be actively in use.
If it's in use by userspace through a vfio driver, the unbind might
block until the user releases the device.  This leads to a potentially
non-trivial amount of time where the device exists, but we've torn
down the interfaces that userspace uses to examine devices, for
instance lspci might generate this sort of error:

pcilib: Cannot open /sys/bus/pci/devices/0000:01:0a.3/config
lspci: Unable to read the standard configuration space header of device 0000:01:0a.3

We don't seem to have any dependence on this teardown ordering in the
kernel, so let's unbind the driver first, which is also more symmetric
with the instantiation of the device.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

Am I missing any reason for the existing ordering?  Looking through
history, it seems that we've simply always had this ordering.  We're
dealing only with pci related device attributes, so I can't figure
how the current ordering protects us from any races.  Anyway, I'd
appreciate comments if there's something obvious I'm missing.  Thanks.

 drivers/pci/remove.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 73a03d382590..2fa0dbde36b7 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -19,9 +19,9 @@ static void pci_stop_dev(struct pci_dev *dev)
 	pci_pme_active(dev, false);
 
 	if (dev->is_added) {
+		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
-		device_release_driver(&dev->dev);
 		dev->is_added = 0;
 	}
 
