Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59561 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759840AbbCDUDD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Mar 2015 15:03:03 -0500
Subject: [PATCH 4/5] vfio-pci: Move idle devices to D3hot power state
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com, kvm@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2015 13:03:01 -0700
Message-ID: <20150304200300.26766.29902.stgit@gimli.home>
In-Reply-To: <20150304194711.26766.75450.stgit@gimli.home>
References: <20150304194711.26766.75450.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can save some power by putting devices that are bound to vfio-pci
but not in use by the user in the D3hot power state.  Devices get
woken into D0 when opened by the user.  Resets return the device to
D0, so we need to re-apply the low power state after a bus reset.
It's tempting to try to use D3cold, but we have no reason to inhibit
hotplug of idle devices and we might get into a loop of having the
device disappear before we have a chance to try to use it.

A new module parameter "disable_idle_pm" allows this feature to be
disabled if there are devices that misbehave as a result of this
change.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e5eb2e6..2133b74 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -48,6 +48,11 @@ MODULE_PARM_DESC(disable_vga,
 		 "Disable VGA resource access for VGA-capable devices");
 #endif
 
+static bool disable_idle_pm;
+module_param_named(disable_idle_pm, disable_idle_pm, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(disable_idle_pm,
+		 "Disable support for trying to move idle, unused devices to a low power state.  This might be necessary if devices do not behave properly moving into or out of low power states.");
+
 static DEFINE_MUTEX(driver_lock);
 
 static inline bool vfio_vga_disabled(void)
@@ -68,6 +73,8 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 	u16 cmd;
 	u8 msix_pos;
 
+	pci_set_power_state(pdev, PCI_D0);
+
 	/* Don't allow our initial saved state to include busmaster */
 	pci_clear_master(pdev);
 
@@ -179,6 +186,9 @@ out:
 	pci_disable_device(pdev);
 
 	vfio_pci_try_bus_reset(vdev);
+
+	if (!disable_idle_pm)
+		pci_set_power_state(pdev, PCI_D3hot);
 }
 
 static void vfio_pci_release(void *device_data)
@@ -899,6 +909,17 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		kfree(vdev);
 	}
 
+	if (!disable_idle_pm) {
+		/*
+		 * pci-core sets the device power state to an unknown value at
+		 * bootup and after being removed from a driver.  The only
+		 * transition it allows from this unknown state is to D0.  We
+		 * therefore first do a D0 transition before going to D3.
+		 */
+		pci_set_power_state(pdev, PCI_D0);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
+
 	return ret;
 }
 
@@ -911,6 +932,9 @@ static void vfio_pci_remove(struct pci_dev *pdev)
 		iommu_group_put(pdev->dev.iommu_group);
 		kfree(vdev);
 	}
+
+	if (!disable_idle_pm)
+		pci_set_power_state(pdev, PCI_D0);
 }
 
 static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
@@ -1029,10 +1053,13 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
 
 put_devs:
 	for (i = 0; i < devs.cur_index; i++) {
-		if (!ret) {
-			tmp = vfio_device_data(devs.devices[i]);
+		tmp = vfio_device_data(devs.devices[i]);
+		if (!ret)
 			tmp->needs_reset = false;
-		}
+
+		if (!tmp->refcnt && !disable_idle_pm)
+			pci_set_power_state(tmp->pdev, PCI_D3hot);
+
 		vfio_device_put(devs.devices[i]);
 	}
 

