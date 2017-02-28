Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0112.outbound.protection.outlook.com ([104.47.38.112]:21468
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750971AbdB1DC2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Feb 2017 22:02:28 -0500
From: Long Li <longli@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2 v4] pci-hyperv: lock pci bus on device eject
Date: Tue, 28 Feb 2017 02:22:04 +0000
Message-ID: <BN3PR03MB2227E6DE747C7C07C2B762ECCE560@BN3PR03MB2227.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A PCI_EJECT message can arrive at the same time we are calling=20
pci_scan_child_bus in the workqueue for the previous PCI_BUS_RELATIONS=20
message or in create_root_hv_pci_bus(), in this case we could=20
potentially modify the bus from multiple places.=20

Properly lock the bus access.

Thanks Dexuan Cui <decui@microsoft.com> for pointing out the race condition=
 in create_root_hv_pci_bus().

Signed-off-by: Long Li <longli@microsoft.com>
Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 4a37598..33c75c9 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1198,9 +1198,11 @@ static int create_root_hv_pci_bus(struct hv_pcibus_d=
evice *hbus)
 	hbus->pci_bus->msi =3D &hbus->msi_chip;
 	hbus->pci_bus->msi->dev =3D &hbus->hdev->device;
=20
+	pci_lock_rescan_remove();
 	pci_scan_child_bus(hbus->pci_bus);
 	pci_bus_assign_resources(hbus->pci_bus);
 	pci_bus_add_devices(hbus->pci_bus);
+	pci_unlock_rescan_remove();
 	hbus->state =3D hv_pcibus_installed;
 	return 0;
 }
@@ -1590,8 +1592,10 @@ static void hv_eject_device_work(struct work_struct =
*work)
 	pdev =3D pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain, 0,
 					   wslot);
 	if (pdev) {
+		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(pdev);
 		pci_dev_put(pdev);
+		pci_unlock_rescan_remove();
 	}
=20
 	memset(&ctxt, 0, sizeof(ctxt));
--=20
1.8.5.6
