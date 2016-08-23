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
Subject: [PATCH 2/5] PCI: hv: use pci_function_description[0] in struct
 definitions
Date: Tue, 23 Aug 2016 04:46:39 +0000
Message-ID: <MWHPR03MB26690A6775AA12D58E6770E1BFEB0@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


The 2 structs can use a zero-length array here, because dynamic memory of
the correct size is allocated in hv_pci_devices_present() and we don't
need this extra element.

No functional change.

Cc: Jake Oshins <jakeo@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 78758e9..cdbadea5 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -259,7 +259,7 @@ struct pci_bus_d0_entry {
 struct pci_bus_relations {
 	struct pci_incoming_message incoming;
 	u32 device_count;
-	struct pci_function_description func[1];
+	struct pci_function_description func[0];
 } __packed;
=20
 struct pci_q_res_req_response {
@@ -394,7 +394,7 @@ struct hv_dr_work {
 struct hv_dr_state {
 	struct list_head list_entry;
 	u32 device_count;
-	struct pci_function_description func[1];
+	struct pci_function_description func[0];
 };
=20
 enum hv_pcichild_state {
--=20
2.7.4
