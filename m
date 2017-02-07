Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:37856
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752035AbdBGJAN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Feb 2017 04:00:13 -0500
From: Dexuan Cui <decui@microsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Jake Oshins <jakeo@microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH] PCI: hv: fix wslot_to_devfn()
Date: Tue, 7 Feb 2017 09:00:10 +0000
Message-ID: <MWHPR03MB26692E8BCBD2B7129EFE1445BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The devfn of 00:02.0 is 0x10.
devfn_to_wslot(0x10) =3D=3D 0x2, and wslot_to_devfn(0x2) should be 0x10,
while it's 0x2 in the current code.

Due to this, hv_eject_device_work() -> pci_get_domain_bus_and_slot()
returns NULL and pci_stop_and_remove_bus_device() is not called.

Later when the real device driver's .remove() is invoked by
hv_pci_remove() -> pci_stop_root_bus(), some warnings can be noticed
because the VM has lost the access to the underlying device at that
time.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

The patch is co-made by Jake and me.

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 3efcc7b..cd114c6 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -130,7 +130,8 @@ enum pci_message_type {
  */
 union win_slot_encoding {
 	struct {
-		u32	func:8;
+		u32	dev:5;
+		u32	func:3;
 		u32	reserved:24;
 	} bits;
 	u32 slot;
@@ -485,7 +486,8 @@ static u32 devfn_to_wslot(int devfn)
 	union win_slot_encoding wslot;
=20
 	wslot.slot =3D 0;
-	wslot.bits.func =3D PCI_SLOT(devfn) | (PCI_FUNC(devfn) << 5);
+	wslot.bits.dev =3D PCI_SLOT(devfn);
+	wslot.bits.func =3D PCI_FUNC(devfn);
=20
 	return wslot.slot;
 }
@@ -503,7 +505,7 @@ static int wslot_to_devfn(u32 wslot)
 	union win_slot_encoding slot_no;
=20
 	slot_no.slot =3D wslot;
-	return PCI_DEVFN(0, slot_no.bits.func);
+	return PCI_DEVFN(slot_no.bits.dev, slot_no.bits.func);
 }
=20
 /*
--=20
1.8.3.1
