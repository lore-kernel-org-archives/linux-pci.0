Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0110.outbound.protection.outlook.com ([104.47.125.110]:43168
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932890AbeCCAUk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Mar 2018 19:20:40 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
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
        Dexuan Cui <decui@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/3] PCI: hv: fix a comment typo in _hv_pcifront_read_config()
Date: Sat, 3 Mar 2018 00:20:32 +0000
Message-ID: <20180303001947.20564-1-decui@microsoft.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Fixes: bdd74440d9e8 ("PCI: hv: Add explicit barriers to config space access=
")
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 2faf38eab785..1233300f41c6 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -653,7 +653,7 @@ static void _hv_pcifront_read_config(struct hv_pci_dev =
*hpdev, int where,
 			break;
 		}
 		/*
-		 * Make sure the write was done before we release the spinlock
+		 * Make sure the read was done before we release the spinlock
 		 * allowing consecutive reads/writes.
 		 */
 		mb();
--=20
2.7.4
