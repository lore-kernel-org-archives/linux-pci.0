Return-Path: <linux-kernel-owner@vger.kernel.org>
From: KY Srinivasan <kys@microsoft.com>
To: Long Li <longli@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>
Subject: RE: [Resend PATCH 2/2 v3] pci-hyperv: lock pci bus on device eject
Date: Fri, 27 Jan 2017 18:42:48 +0000
Message-ID: <DM5PR03MB2490101D99B60845B8269A3DA0760@DM5PR03MB2490.namprd03.prod.outlook.com>
References: <1485236759-27699-1-git-send-email-longli@exchange.microsoft.com>
In-Reply-To: <1485236759-27699-1-git-send-email-longli@exchange.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Long Li [mailto:longli@exchange.microsoft.com]
> Sent: Monday, January 23, 2017 9:46 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>
> Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Long Li <longli@microsoft.com>
> Subject: [Resend PATCH 2/2 v3] pci-hyperv: lock pci bus on device eject
>=20
> [This sender failed our fraud detection checks and may not be who they
> appear to be. Learn about spoofing at http://aka.ms/LearnAboutSpoofing]
>=20
> From: Long Li <longli@microsoft.com>
>=20
> A PCI_EJECT message can arrive at the same time we are calling
> pci_scan_child_bus in the workqueue for the previous PCI_BUS_RELATIONS
> message or in create_root_hv_pci_bus(), in this case we could potentailly
> modify the bus from multiple places. Properly lock the bus access.
>=20
> Thanks Dexuan Cui <decui@microsoft.com> for pointing out the race
> condition in create_root_hv_pci_bus().
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>

Acked-by: K. Y. Srinivasan <kys@microsoft.com>

> ---
>  drivers/pci/host/pci-hyperv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 4a37598..33c75c9 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1198,9 +1198,11 @@ static int create_root_hv_pci_bus(struct
> hv_pcibus_device *hbus)
>         hbus->pci_bus->msi =3D &hbus->msi_chip;
>         hbus->pci_bus->msi->dev =3D &hbus->hdev->device;
>=20
> +       pci_lock_rescan_remove();
>         pci_scan_child_bus(hbus->pci_bus);
>         pci_bus_assign_resources(hbus->pci_bus);
>         pci_bus_add_devices(hbus->pci_bus);
> +       pci_unlock_rescan_remove();
>         hbus->state =3D hv_pcibus_installed;
>         return 0;
>  }
> @@ -1590,8 +1592,10 @@ static void hv_eject_device_work(struct
> work_struct *work)
>         pdev =3D pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain,
> 0,
>                                            wslot);
>         if (pdev) {
> +               pci_lock_rescan_remove();
>                 pci_stop_and_remove_bus_device(pdev);
>                 pci_dev_put(pdev);
> +               pci_unlock_rescan_remove();
>         }
>=20
>         memset(&ctxt, 0, sizeof(ctxt));
> --
> 1.8.5.6
