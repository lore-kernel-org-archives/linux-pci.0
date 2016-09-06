Return-Path: <linux-kernel-owner@vger.kernel.org>
From: KY Srinivasan <kys@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Hadden Hoppert <haddenh@microsoft.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "Stephen Hemminger" <sthemmin@microsoft.com>
Subject: RE: [PATCH 0/5] PCI: hv: some minor bug fixes and cleanups
Date: Tue, 6 Sep 2016 17:05:33 +0000
Message-ID: <DM2PR0301MB07830A8BFB34BF58C9FBB598A0F90@DM2PR0301MB0783.namprd03.prod.outlook.com>
References: <MWHPR03MB266985BDDEE4EB1A9C481B0DBFEB0@MWHPR03MB2669.namprd03.prod.outlook.com>
In-Reply-To: <MWHPR03MB266985BDDEE4EB1A9C481B0DBFEB0@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Dexuan Cui
> Sent: Tuesday, August 23, 2016 10:13 AM
> To: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com; vkuznets@redhat.com; Haiyang
> Zhang <haiyangz@microsoft.com>; Hadden Hoppert
> <haddenh@microsoft.com>; helgaas@kernel.org; Stephen Hemminger
> <sthemmin@microsoft.com>
> Subject: [PATCH 0/5] PCI: hv: some minor bug fixes and cleanups
>=20
>=20
> 1. use zero-length array to make the code more readable.
> 2. remove an unused struct member.
> 3. small error handling improvement to some error cases.
>=20
> Dexuan Cui (5):
>   PCI: hv: use zero-length message in struct pci_packet
>   PCI: hv: use pci_function_description[0] in struct definitions
>   PCI: hv: remove the unused 'wrk' in struct hv_pcibus_device
>   PCI: hv: hv_compose_msi_msg: handle the 'ret' value
>   PCI: hv: hv_pci_generic_compl(): handle the error case

Acked-by: KY Srinivasan <kys@microsoft.com>

K. Y
