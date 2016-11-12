Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jake Oshins <jakeo@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        Hadden Hoppert <haddenh@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] PCI: hv: fix hv_pci_remove() for hot-remove
Date: Sat, 12 Nov 2016 00:40:11 +0000
Message-ID: <SN1PR0301MB1598BC04BEBF6BD373668FDEABBA0@SN1PR0301MB1598.namprd03.prod.outlook.com>
References: <MWHPR03MB2669BF0EB52B9289747F04E1BFB80@MWHPR03MB2669.namprd03.prod.outlook.com>
In-Reply-To: <MWHPR03MB2669BF0EB52B9289747F04E1BFB80@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Dexuan Cui
> Sent: Wednesday, November 9, 2016 11:19 PM
> To: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> devel@linuxdriverproject.org
> Cc: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Jake Oshins <jakeo@microsoft.com>; Hadden
> Hoppert <haddenh@microsoft.com>; Vitaly Kuznetsov
> <vkuznets@redhat.com>; jasowang@redhat.com; apw@canonical.com;
> olaf@aepfle.de; linux-kernel@vger.kernel.org
> Subject: [PATCH 2/3] PCI: hv: fix hv_pci_remove() for hot-remove
>=20
> 1. We don't really need such a big on-stack buffer when sending
> the teardown_packet: vmbus_sendpacket() here only uses
> sizeof(struct pci_message).
>=20
> 2. In the hot-remove case (PCI_EJECT), after we send
> PCI_EJECTION_COMPLETE
> to the host, the host will send a RESCIND_CHANNEL message to us and the
> host won't access the per-channel ringbuffer any longer, so we needn't
> send PCI_RESOURCES_RELEASED/PCI_BUS_D0EXIT to the host, and we
> shouldn't
> expect the host's completion message of PCI_BUS_D0EXIT, which will never
> come.
>=20
> 3. We should send PCI_BUS_D0EXIT after hv_send_resources_released().
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> CC: Jake Oshins <jakeo@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>
> CC: Haiyang Zhang <haiyangz@microsoft.com>
> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
>=20
> ---
>=20
> I made the patch based on discussions with Jake Oshins and others.
>=20
>  drivers/pci/host/pci-hyperv.c | 53 +++++++++++++++++++++++++++--------
> --------
>  1 file changed, 33 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 93ed64a..7590ad0 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -2266,24 +2266,32 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	return ret;
>  }
>=20
> -/**
> - * hv_pci_remove() - Remove routine for this VMBus channel
> - * @hdev:	VMBus's tracking struct for this root PCI bus
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int hv_pci_remove(struct hv_device *hdev)
> +static void hv_pci_bus_exit(struct hv_device *hdev)
>  {
> -	int ret;
> -	struct hv_pcibus_device *hbus;
> -	union {
> +	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
> +	struct {
>  		struct pci_packet teardown_packet;
> -		u8 buffer[0x100];
> +		u8 buffer[sizeof(struct pci_message)];
>  	} pkt;
>  	struct pci_bus_relations relations;
>  	struct hv_pci_compl comp_pkt;
> +	int ret;
>=20
> -	hbus =3D hv_get_drvdata(hdev);
> +	/*
> +	 * After the host sends the RESCIND_CHANNEL message, it doesn't
> +	 * access the per-channel ringbuffer any longer.
> +	 */
> +	if (hdev->channel->rescind)
> +		return;
> +
> +	/* Delete any children which might still exist. */
> +	memset(&relations, 0, sizeof(relations));
> +	hv_pci_devices_present(hbus, &relations);
> +
> +	ret =3D hv_send_resources_released(hdev);
> +	if (ret)
> +		dev_err(&hdev->device,
> +			"Couldn't send resources released packet(s)\n");
>=20
>  	memset(&pkt.teardown_packet, 0, sizeof(pkt.teardown_packet));
>  	init_completion(&comp_pkt.host_event);
> @@ -2298,7 +2306,19 @@ static int hv_pci_remove(struct hv_device *hdev)
>=20
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (!ret)
>  		wait_for_completion_timeout(&comp_pkt.host_event, 10 *
> HZ);
> +}
> +
> +/**
> + * hv_pci_remove() - Remove routine for this VMBus channel
> + * @hdev:	VMBus's tracking struct for this root PCI bus
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +static int hv_pci_remove(struct hv_device *hdev)
> +{
> +	struct hv_pcibus_device *hbus;
>=20
> +	hbus =3D hv_get_drvdata(hdev);
>  	if (hbus->state =3D=3D hv_pcibus_installed) {
>  		/* Remove the bus from PCI's point of view. */
>  		pci_lock_rescan_remove();
> @@ -2307,17 +2327,10 @@ static int hv_pci_remove(struct hv_device
> *hdev)
>  		pci_unlock_rescan_remove();
>  	}
>=20
> -	ret =3D hv_send_resources_released(hdev);
> -	if (ret)
> -		dev_err(&hdev->device,
> -			"Couldn't send resources released packet(s)\n");
> +	hv_pci_bus_exit(hdev);
>=20
>  	vmbus_close(hdev->channel);
>=20
> -	/* Delete any children which might still exist. */
> -	memset(&relations, 0, sizeof(relations));
> -	hv_pci_devices_present(hbus, &relations);
> -
>  	iounmap(hbus->cfg_addr);
>  	hv_free_config_window(hbus);
>  	pci_free_resource_list(&hbus->resources_for_children);
> --
> 2.7.4

This looks fine to me.

-- Jake Oshins
