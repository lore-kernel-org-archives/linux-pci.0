Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Dexuan Cui <decui@microsoft.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
Date: Thu, 15 Mar 2018 14:21:51 +0000
Message-ID: <KL1P15301MB0006E2FA71F87B312D9DECA4BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since we serialize the present/eject work items now, we don't need the
semaphore any more.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 1d2e1cb617f4..0dc2ecdbbe45 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -447,7 +447,6 @@ struct hv_pcibus_device {
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
=20
-	struct semaphore enum_sem;
 	struct list_head resources_for_children;
=20
 	struct list_head children;
@@ -1648,12 +1647,8 @@ static struct hv_pci_dev *get_pcichild_wslot(struct =
hv_pcibus_device *hbus,
  * It must also treat the omission of a previously observed device as
  * notification that the device no longer exists.
  *
- * Note that this function is a work item, and it may not be
- * invoked in the order that it was queued.  Back to back
- * updates of the list of present devices may involve queuing
- * multiple work items, and this one may run before ones that
- * were sent later. As such, this function only does something
- * if is the last one in the queue.
+ * Note that this function is serialized with hv_eject_device_work(),
+ * because both are pushed to the ordered workqueue hbus->wq.
  */
 static void pci_devices_present_work(struct work_struct *work)
 {
@@ -1674,11 +1669,6 @@ static void pci_devices_present_work(struct work_str=
uct *work)
=20
 	INIT_LIST_HEAD(&removed);
=20
-	if (down_interruptible(&hbus->enum_sem)) {
-		put_hvpcibus(hbus);
-		return;
-	}
-
 	/* Pull this off the queue and process it if it was the last one. */
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	while (!list_empty(&hbus->dr_list)) {
@@ -1695,7 +1685,6 @@ static void pci_devices_present_work(struct work_stru=
ct *work)
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
=20
 	if (!dr) {
-		up(&hbus->enum_sem);
 		put_hvpcibus(hbus);
 		return;
 	}
@@ -1782,7 +1771,6 @@ static void pci_devices_present_work(struct work_stru=
ct *work)
 		break;
 	}
=20
-	up(&hbus->enum_sem);
 	put_hvpcibus(hbus);
 	kfree(dr);
 }
@@ -2516,7 +2504,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
-	sema_init(&hbus->enum_sem, 1);
 	init_completion(&hbus->remove_event);
 	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
 					   hbus->sysdata.domain);
--=20
2.7.4
