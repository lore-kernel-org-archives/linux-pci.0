Return-Path: <decui@microsoft.com>
Return-Path: <decui@microsoft.com>
From: Dexuan Cui <decui@microsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hadden Hoppert
	<haddenh@microsoft.com>, "helgaas@kernel.org" <helgaas@kernel.org>, "Stephen
 Hemminger" <sthemmin@microsoft.com>
Subject: [PATCH 3/5] PCI: hv: remove the unused 'wrk' in struct
 hv_pcibus_device
Date: Tue, 23 Aug 2016 04:47:23 +0000
Message-ID: <MWHPR03MB2669B3E02C848820740880E4BFEB0@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


The member is not used.

Cc: Jake Oshins <jakeo@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index cdbadea5..aef2e1e 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -374,7 +374,6 @@ struct hv_pcibus_device {
=20
 	struct list_head children;
 	struct list_head dr_list;
-	struct work_struct wrk;
=20
 	struct msi_domain_info msi_info;
 	struct msi_controller msi_chip;
--=20
2.7.4
