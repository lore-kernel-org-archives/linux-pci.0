Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Jake Oshins <jakeo@microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: RE: [PATCH] PCI: hv: fix wslot_to_devfn()
Date: Tue, 7 Feb 2017 16:17:34 +0000
Message-ID: <BLUPR03MB1412ACC83842880A6AEDB9D5CA430@BLUPR03MB1412.namprd03.prod.outlook.com>
References: <MWHPR03MB26692E8BCBD2B7129EFE1445BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
In-Reply-To: <MWHPR03MB26692E8BCBD2B7129EFE1445BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Dexuan Cui
> Sent: Tuesday, February 7, 2017 4:00 AM
> To: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> devel@linuxdriverproject.org; Jake Oshins <jakeo@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> olaf@aepfle.de; gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> apw@canonical.com; jasowang@redhat.com; Vitaly Kuznetsov
> <vkuznets@redhat.com>
> Subject: [PATCH] PCI: hv: fix wslot_to_devfn()
>=20
> The devfn of 00:02.0 is 0x10.
> devfn_to_wslot(0x10) =3D=3D 0x2, and wslot_to_devfn(0x2) should be 0x10,
> while it's 0x2 in the current code.
>=20
> Due to this, hv_eject_device_work() -> pci_get_domain_bus_and_slot()
> returns NULL and pci_stop_and_remove_bus_device() is not called.
>=20
> Later when the real device driver's .remove() is invoked by
> hv_pci_remove() -> pci_stop_root_bus(), some warnings can be noticed
> because the VM has lost the access to the underlying device at that time.
>=20
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> CC: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> The patch is co-made by Jake and me.

I think this line should be put together with other comments.

Thanks.
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
