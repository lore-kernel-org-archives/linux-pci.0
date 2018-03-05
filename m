Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pu1apc01on0111.outbound.protection.outlook.com ([104.47.126.111]:38336
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752931AbeCETWX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Mar 2018 14:22:23 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 2/6] PCI: hv: hv_eject_device_work(): remove the bogus test
Date: Mon, 5 Mar 2018 19:22:15 +0000
Message-ID: <20180305192134.32207-3-decui@microsoft.com>
References: <20180305192134.32207-1-decui@microsoft.com>
In-Reply-To: <20180305192134.32207-1-decui@microsoft.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we're in the function, hpdev->state must be hv_pcichild_ejecting:
see hv_pci_eject_device().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 1233300f41c6..04edb24c92ee 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1796,10 +1796,7 @@ static void hv_eject_device_work(struct work_struct =
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
