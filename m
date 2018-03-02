Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 2/3] vfio: Add support for unmanaged or userspace managed
 SR-IOV
From: Alexander Duyck <alexander.duyck@gmail.com>
To: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, mheyne@amazon.de,
        liang-min.wang@intel.com, mark.d.rustad@intel.com,
        dwmw2@infradead.org, dwmw@amazon.co.uk
Date: Fri, 02 Mar 2018 15:44:52 -0800
Message-ID: <20180302234432.3337.96123.stgit@localhost.localdomain>
In-Reply-To: <20180302234218.3337.16486.stgit@localhost.localdomain>
References: <20180302234218.3337.16486.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch is meant to allow assignment of an SR-IOV enabled PF, as in VFs
have been generated, with vfio-pci. My understanding is the primary use
case for this is something like DPDK running the PF while the VFs are all
assigned to guests.

A secondary effect of this is that it provides an interface through which
it would be possible to enable SR-IOV on drivers that may not have a
physical function that actually manages the device.

Enabling SR-IOV should be pretty straight forward. As long as there are no
userspace processes currently controlling the interface the number of VFs
can be changed, and VFs will be generated without drivers being loaded on
the host. Once the userspace process begins controlling the interface the
number of VFs cannot be updated via the sysfs until the control is
released.

Note the VFs will have drivers load on them in the host if the
sriov_unmanaged_autoprobe is updated to a value of 1. However the behavior
of the VFs in such a setup cannot be guaranteed as the PF will not be
available until the userspace process starts and begins to manage the
device.

For now I am leaving the value as locked when the PF is being controlled
from userspace as a form of synchronization. Basically this way we cannot
have the number of VFs change out from under the process so it should not
require any notification framework, and the configuration can just be read
out via configuration space accesses.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/vfio/pci/vfio_pci.c |   57 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b0f759476900..3023bda39aa9 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1224,6 +1224,8 @@ static void vfio_pci_remove(struct pci_dev *pdev)
 				VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM);
 	}
 
+	pci_disable_sriov(pdev);
+
 	if (!disable_idle_d3)
 		pci_set_power_state(pdev, PCI_D0);
 }
@@ -1260,12 +1262,67 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
 	.error_detected = vfio_pci_aer_err_detected,
 };
 
+static int vfio_pci_sriov_configure(struct pci_dev *pdev, int nr_virtfn)
+{
+	struct vfio_pci_device *vdev;
+	struct vfio_device *device;
+	int err;
+
+	device = vfio_device_get_from_dev(&pdev->dev);
+	if (device == NULL)
+		return -ENODEV;
+
+	vdev = vfio_device_data(device);
+	if (vdev == NULL) {
+		vfio_device_put(device);
+		return -ENODEV;
+	}
+
+	/*
+	 * If a userspace process is already using this device just return
+	 * busy and don't allow for any changes.
+	 */
+	if (vdev->refcnt) {
+		pci_warn(pdev,
+			 "PF is currently in use, blocked until released by user\n");
+		return -EBUSY;
+	}
+
+	err = pci_sriov_configure_unmanaged(pdev, nr_virtfn);
+	if (err <= 0)
+		return err;
+
+	/*
+	 * We are now leaving VFs in the control of some unknown PF entity.
+	 *
+	 * Best case is a well behaved userspace PF is expected and any VMs
+	 * that the VFs will be assigned to are dependent on the userspace
+	 * entity anyway. An example being NFV where maybe the PF is acting
+	 * as an accelerated interface for a firewall or switch.
+	 *
+	 * Worst case is somebody really messed up and just enabled SR-IOV
+	 * on a device they were planning to assign to a VM somwhere.
+	 *
+	 * In either case it is probably best for us to set the taint flag
+	 * and warn the user since this could get really ugly really quick
+	 * if this wasn't what they were planning to do.
+	 */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+	pci_warn(pdev,
+		 "Adding kernel taint for vfio-pci now managing SR-IOV PF device\n");
+
+	return nr_virtfn;
+}
+
 static struct pci_driver vfio_pci_driver = {
 	.name		= "vfio-pci",
 	.id_table	= NULL, /* only dynamic ids */
 	.probe		= vfio_pci_probe,
 	.remove		= vfio_pci_remove,
 	.err_handler	= &vfio_err_handlers,
+#ifdef CONFIG_PCI_IOV
+	.sriov_configure = vfio_pci_sriov_configure,
+#endif
 };
 
 struct vfio_devices {
