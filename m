Return-Path: <linux-kernel-owner@vger.kernel.org>
From: KY Srinivasan <kys@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        Hadden Hoppert <haddenh@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH 0/5] PCI: hv: some minor bug fixes and cleanups
Date: Tue, 6 Sep 2016 17:06:08 +0000
Message-ID: <DM2PR0301MB078388A0EEE624EFCC3AB668A0F90@DM2PR0301MB0783.namprd03.prod.outlook.com>
References: <MWHPR03MB266985BDDEE4EB1A9C481B0DBFEB0@MWHPR03MB2669.namprd03.prod.outlook.com>
 <20160906154045.GB1214@localhost>
In-Reply-To: <20160906154045.GB1214@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, September 6, 2016 9:11 PM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com; vkuznets@redhat.com; Haiyang
> Zhang <haiyangz@microsoft.com>; Hadden Hoppert
> <haddenh@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>
> Subject: Re: [PATCH 0/5] PCI: hv: some minor bug fixes and cleanups
>=20
> On Tue, Aug 23, 2016 at 04:42:41AM +0000, Dexuan Cui wrote:
> >
> > 1. use zero-length array to make the code more readable.
> > 2. remove an unused struct member.
> > 3. small error handling improvement to some error cases.
> >
> > Dexuan Cui (5):
> >   PCI: hv: use zero-length message in struct pci_packet
> >   PCI: hv: use pci_function_description[0] in struct definitions
> >   PCI: hv: remove the unused 'wrk' in struct hv_pcibus_device
> >   PCI: hv: hv_compose_msi_msg: handle the 'ret' value
> >   PCI: hv: hv_pci_generic_compl(): handle the error case
> >
> >  drivers/pci/host/pci-hyperv.c | 56 ++++++++++++++++++++++-------------=
-------
> -
> >  1 file changed, 29 insertions(+), 27 deletions(-)
>=20
> I'm waiting for an ack from the Hyper-V maintainers:

I have Acked these patches.

K. Y
>=20
>   Hyper-V CORE AND DRIVERS
>   M:      "K. Y. Srinivasan" <kys@microsoft.com>
>   M:      Haiyang Zhang <haiyangz@microsoft.com>
>   L:      devel@linuxdriverproject.org
>   S:      Maintained
>   ...
>   F:      drivers/pci/host/pci-hyperv.c
>   ...
