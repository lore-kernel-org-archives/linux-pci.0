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
Subject: [PATCH 0/5] PCI: hv: some minor bug fixes and cleanups
Date: Tue, 23 Aug 2016 04:42:41 +0000
Message-ID: <MWHPR03MB266985BDDEE4EB1A9C481B0DBFEB0@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


1. use zero-length array to make the code more readable.
2. remove an unused struct member.
3. small error handling improvement to some error cases.

Dexuan Cui (5):
  PCI: hv: use zero-length message in struct pci_packet
  PCI: hv: use pci_function_description[0] in struct definitions
  PCI: hv: remove the unused 'wrk' in struct hv_pcibus_device
  PCI: hv: hv_compose_msi_msg: handle the 'ret' value
  PCI: hv: hv_pci_generic_compl(): handle the error case

 drivers/pci/host/pci-hyperv.c | 56 ++++++++++++++++++++++-----------------=
----
 1 file changed, 29 insertions(+), 27 deletions(-)

--=20
2.7.4
