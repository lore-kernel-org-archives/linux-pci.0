Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 6/6] vfio-pci: Move idle devices to D3hot power state
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com, kvm@vger.kernel.org
Cc: linux-pci@vger.kernel.org, bsd@redhat.com,
	linux-kernel@vger.kernel.org
Date: Wed, 18 Mar 2015 14:13:42 -0600
Message-ID: <20150318201342.24807.4286.stgit@gimli.home>
In-Reply-To: <20150318200053.24807.74115.stgit@gimli.home>
References: <20150318200053.24807.74115.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can save some power by putting devices that are bound to vfio-pci
but not in use by the user in the D3hot power state.  Devices get
woken into D0 when opened by the user.  Resets return the device to
D0, so we need to re-apply the low power state after a bus reset.
It's tempting to try to use D3cold, but we have no reason to inhibit
hotplug of idle devices and we might get into a loop of having the
device disappear before we have a chance to try to use it.

A new module parameter allows this feature to be disabled if there are
devices that misbehave as a result of this change.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |   36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index d0f1e70..049b9e9 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -50,6 +50,11 @@ module_param(disable_vga, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_vga, "Disable VGA resource access through vfio-pci");
 #endif
 
+static bool disable_idle_d3;
+module_param(disable_idle_d3, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(disable_idle_d3,
+		 "Disable using the PCI D3 low power state for idle, unused devices");
+
 static DEFINE_MUTEX(driver_lock);
 
 static inline bool vfio_vga_disabled(void)
@@ -114,6 +119,8 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 	u16 cmd;
 	u8 msix_pos;
 
+	pci_set_power_state(pdev, PCI_D0);
+
 	/* Don't allow our initial saved state to include busmaster */
 	pci_clear_master(pdev);
 
@@ -225,6 +232,9 @@ out:
 	pci_disable_device(pdev);
 
 	vfio_pci_try_bus_reset(vdev);
+
+	if (!disable_idle_d3)
+		pci_set_power_state(pdev, PCI_D3hot);
 }
 
 static void vfio_pci_release(void *device_data)
@@ -951,6 +961,20 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 					vfio_pci_set_vga_decode(vdev, false));
 	}
 
+	if (!disable_idle_d3) {
+		/*
+		 * pci-core sets the device power state to an unknown value at
+		 * bootup and after being removed from a driver.  The only
+		 * transition it allows from this unknown state is to D0, which
+		 * typically happens when a driver calls pci_enable_device().
+		 * We're not ready to enable the device yet, but we do want to
+		 * be able to get to D3.  Therefore first do a D0 transition
+		 * before going to D3.
+		 */
+		pci_set_power_state(pdev, PCI_D0);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
+
 	return ret;
 }
 
@@ -971,6 +995,9 @@ static void vfio_pci_remove(struct pci_dev *pdev)
 				VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM |
 				VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM);
 	}
+
+	if (!disable_idle_d3)
+		pci_set_power_state(pdev, PCI_D0);
 }
 
 static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
@@ -1089,10 +1116,13 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
 
 put_devs:
 	for (i = 0; i < devs.cur_index; i++) {
-		if (!ret) {
-			tmp = vfio_device_data(devs.devices[i]);
+		tmp = vfio_device_data(devs.devices[i]);
+		if (!ret)
 			tmp->needs_reset = false;
-		}
+
+		if (!tmp->refcnt && !disable_idle_d3)
+			pci_set_power_state(tmp->pdev, PCI_D3hot);
+
 		vfio_device_put(devs.devices[i]);
 	}
 

