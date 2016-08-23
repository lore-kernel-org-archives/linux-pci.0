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
Subject: [PATCH 5/5] PCI: hv: hv_pci_generic_compl(): handle the error case
Date: Tue, 23 Aug 2016 04:49:22 +0000
Message-ID: <MWHPR03MB2669E217046A38470D7E8A27BFEB0@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


'completetion_status' is used in some places, e.g.,
hv_pci_protocol_negotiation(), so we should make sure it's initialized in
error case too, though the error is unlikely here.

I didn't get a real issue.

Cc: Jake Oshins <jakeo@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index f337239..a93bd5d 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -456,6 +456,9 @@ hv_pci_generic_compl(void *context, struct pci_response=
 *resp,
=20
 	if (resp_packet_size >=3D offsetofend(struct pci_response, status))
 		comp_pkt->completion_status =3D resp->status;
+	else
+		comp_pkt->completion_status =3D -1;
+
 	complete(&comp_pkt->host_event);
 }
=20
--=20
2.7.4
