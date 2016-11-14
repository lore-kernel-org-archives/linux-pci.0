Return-Path: <linux-kernel-owner@vger.kernel.org>
From: KY Srinivasan <kys@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Jake Oshins" <jakeo@microsoft.com>,
        Hadden Hoppert <haddenh@microsoft.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] PCI: hv: delete the device earlier from
 hbus->children for hot-remove
Date: Mon, 14 Nov 2016 23:08:02 +0000
Message-ID: <DM5PR03MB24909D15D44948C4E9526848A0BC0@DM5PR03MB2490.namprd03.prod.outlook.com>
References: <MWHPR03MB2669255256A616C62606216EBFB80@MWHPR03MB2669.namprd03.prod.outlook.com>
In-Reply-To: <MWHPR03MB2669255256A616C62606216EBFB80@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Dexuan Cui
> Sent: Wednesday, November 9, 2016 11:20 PM
> To: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> devel@linuxdriverproject.org
> Cc: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Jake Oshins <jakeo@microsoft.com>; Hadden
> Hoppert <haddenh@microsoft.com>; Vitaly Kuznetsov
> <vkuznets@redhat.com>; jasowang@redhat.com; apw@canonical.com;
> olaf@aepfle.de; linux-kernel@vger.kernel.org
> Subject: [PATCH 3/3] PCI: hv: delete the device earlier from hbus->childr=
en
> for hot-remove
>=20
> After we send a PCI_EJECTION_COMPLETE message to the host, the host will
> immediately send us a PCI_BUS_RELATIONS message with
> relations->device_count =3D=3D 0, so pci_devices_present_work(), running =
on
> another thread, can find the being-ejected device, mark
> the hpdev->reported_missing to true, and run list_move_tail()/list_del()
> for the device -- this races hv_eject_device_work() -> list_del().
>=20
> The patch moves the list_del() in hv_eject_device_work() to an earlier
> place, i.e. before we send PCI_EJECTION_COMPLETE, so later the
> pci_devices_present_work() can't see the device.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> CC: Jake Oshins <jakeo@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>
> CC: Haiyang Zhang <haiyangz@microsoft.com>
> CC: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks Dexuan.

Acked-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 7590ad0..fe5179d 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1582,6 +1582,10 @@ static void hv_eject_device_work(struct
> work_struct *work)
>  		pci_dev_put(pdev);
>  	}
>=20
> +	spin_lock_irqsave(&hpdev->hbus->device_list_lock, flags);
> +	list_del(&hpdev->list_entry);
> +	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
> +
>  	memset(&ctxt, 0, sizeof(ctxt));
>  	ejct_pkt =3D (struct pci_eject_response *)&ctxt.pkt.message;
>  	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
> @@ -1590,10 +1594,6 @@ static void hv_eject_device_work(struct
> work_struct *work)
>  			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
>  			 VM_PKT_DATA_INBAND, 0);
>=20
> -	spin_lock_irqsave(&hpdev->hbus->device_list_lock, flags);
> -	list_del(&hpdev->list_entry);
> -	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
> -
>  	put_pcichild(hpdev, hv_pcidev_ref_childlist);
>  	put_pcichild(hpdev, hv_pcidev_ref_pnp);
>  	put_hvpcibus(hpdev->hbus);
> --
> 2.7.4
