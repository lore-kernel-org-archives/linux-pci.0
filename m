Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0107.outbound.protection.outlook.com ([104.47.32.107]:19635
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbdBXVtV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Feb 2017 16:49:21 -0500
From: Long Li <longli@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Resend PATCH 2/2 v3] pci-hyperv: lock pci bus on device eject
Date: Fri, 24 Feb 2017 21:49:17 +0000
Message-ID: <BN3PR03MB22273E86EDBC8875C55E2FB7CE520@BN3PR03MB2227.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A PCI_EJECT message can arrive at the same time we are calling pci_scan_chi=
ld_bus in the workqueue for the previous PCI_BUS_RELATIONS message or in cr=
eate_root_hv_pci_bus(), in this case we could potentailly modify the bus fr=
om multiple places. Properly lock the bus access.

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
