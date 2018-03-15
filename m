Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0093.outbound.protection.outlook.com ([104.47.125.93]:55200
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752548AbeCOOWD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Mar 2018 10:22:03 -0400
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
Subject: [PATCH v4 2/4] PCI: hv: Remove the bogus test in
 hv_eject_device_work()
Date: Thu, 15 Mar 2018 14:21:43 +0000
Message-ID: <KL1P15301MB00069CB9573BB682DEAD8404BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we're in the function, hpdev->state must be hv_pcichild_ejecting:
see hv_pci_eject_device().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 28fce2be0a5f..1d2e1cb617f4 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1854,10 +1854,7 @@ static void hv_eject_device_work(struct work_struct =
*work)
=20
 	hpdev =3D container_of(work, struct hv_pci_dev, wrk);
=20
-	if (hpdev->state !=3D hv_pcichild_ejecting) {
-		put_pcichild(hpdev, hv_pcidev_ref_pnp);
-		return;
-	}
+	WARN_ON(hpdev->state !=3D hv_pcichild_ejecting);
=20
 	/*
 	 * Ejection can come before or after the PCI bus has been set up, so
--=20
2.7.4
