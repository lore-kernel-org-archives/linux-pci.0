Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Long Li <longli@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2 v4] pci-hyperv: properly handle pci bus remove
Date: Tue, 28 Feb 2017 02:19:45 +0000
Message-ID: <BN3PR03MB22270F97B502941940E0E91ECE560@BN3PR03MB2227.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

hv_pci_devices_present is called in hv_pci_remove when we remove a PCI
device from host (e.g. by disabling SRIOV on a device). In hv_pci_remove,
the bus is already removed before the call, so we don't need to rescan=20
the bus in the workqueue scheduled from hv_pci_devices_present. By=20
introducing status hv_pcibus_removed, we can avoid this situation.

Signed-off-by: Long Li <longli@microsoft.com>
Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index a8deeca..4a37598 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -348,6 +348,7 @@ enum hv_pcibus_state {
 	hv_pcibus_init =3D 0,
 	hv_pcibus_probed,
 	hv_pcibus_installed,
+	hv_pcibus_removed,
 	hv_pcibus_maximum
 };
=20
@@ -1481,13 +1482,24 @@ static void pci_devices_present_work(struct work_st=
ruct *work)
 		put_pcichild(hpdev, hv_pcidev_ref_initial);
 	}
=20
-	/* Tell the core to rescan bus because there may have been changes. */
-	if (hbus->state =3D=3D hv_pcibus_installed) {
+	switch (hbus->state) {
+	case hv_pcibus_installed:
+		/*
+		 * Tell the core to rescan bus
+		 * because there may have been changes.
+		 */
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
-	} else {
+		break;
+
+	case hv_pcibus_init:
+	case hv_pcibus_probed:
 		survey_child_resources(hbus);
+		break;
+
+	default:
+		break;
 	}
=20
 	up(&hbus->enum_sem);
@@ -2163,6 +2175,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus =3D kzalloc(sizeof(*hbus), GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
+	hbus->state =3D hv_pcibus_init;
=20
 	/*
 	 * The PCI bus "domain" is what is called "segment" in ACPI and
@@ -2305,6 +2318,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 		pci_stop_root_bus(hbus->pci_bus);
 		pci_remove_root_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
+		hbus->state =3D hv_pcibus_removed;
 	}
=20
 	ret =3D hv_send_resources_released(hdev);
--=20
1.8.5.6
