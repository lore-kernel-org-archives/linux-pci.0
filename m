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
Subject: [PATCH 4/5] PCI: hv: hv_compose_msi_msg: handle the 'ret' value
Date: Tue, 23 Aug 2016 04:48:11 +0000
Message-ID: <MWHPR03MB266954FABD2DD49DC19CF106BFEB0@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


I happened to find this when reading the code.
I didn't get a real issue however.

Cc: Jake Oshins <jakeo@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index aef2e1e..f337239 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -893,8 +893,10 @@ static void hv_compose_msi_msg(struct irq_data *data, =
struct msi_msg *msg)
 			       sizeof(*int_pkt), (unsigned long)&ctxt.pkt,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
-	if (!ret)
-		wait_for_completion(&comp.comp_pkt.host_event);
+	if (ret)
+		goto free_int_desc;
+
+	wait_for_completion(&comp.comp_pkt.host_event);
=20
 	if (comp.comp_pkt.completion_status < 0) {
 		dev_err(&hbus->hdev->device,
--=20
2.7.4
