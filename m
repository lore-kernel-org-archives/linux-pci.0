Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0128.outbound.protection.outlook.com ([104.47.32.128]:48288
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751526AbdC0SNe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Mar 2017 14:13:34 -0400
From: Long Li <longli@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] pci-hyperv: Fix a bug in specifying CPU affinity
Date: Mon, 27 Mar 2017 18:13:30 +0000
Message-ID: <BN3PR03MB2227C9E21CC131FDCB6B2CABCE330@BN3PR03MB2227.namprd03.prod.outlook.com>
References: <1490378800-26907-1-git-send-email-kys@exchange.microsoft.com>
 <1490378842-26950-2-git-send-email-kys@exchange.microsoft.com>
In-Reply-To: <1490378842-26950-2-git-send-email-kys@exchange.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: devel [mailto:driverdev-devel-bounces@linuxdriverproject.org] On
> Behalf Of kys@exchange.microsoft.com
> Sent: Friday, March 24, 2017 11:07 AM
> To: helgaas@kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets@redhat.com; jasowang@redhat.com;
> leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen
> Hemminger <sthemmin@microsoft.com>
> Cc: stable@vger.kernel.org
> Subject: [PATCH 1/2] pci-hyperv: Fix a bug in specifying CPU affinity
>=20
> From: K. Y. Srinivasan <kys@microsoft.com>
>=20
> When we have 32 or more CPUs in the affinity mask, we should use a specia=
l
> constant to specify that to the host. Fix this issue.
>=20
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/pci/host/pci-hyperv.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index ada9856..32a16fb 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -72,6 +72,7 @@ enum {
>         PCI_PROTOCOL_VERSION_CURRENT =3D PCI_PROTOCOL_VERSION_1_1  };
>=20
> +#define CPU_AFFINITY_ALL       -1ULL
>  #define PCI_CONFIG_MMIO_LENGTH 0x2000
>  #define CFG_PAGE_OFFSET 0x1000
>  #define CFG_PAGE_SIZE (PCI_CONFIG_MMIO_LENGTH -
> CFG_PAGE_OFFSET) @@ -897,9 +898,13 @@ static void
> hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>          * processors because Hyper-V only supports 64 in a guest.
>          */
>         affinity =3D irq_data_get_affinity_mask(data);
> -       for_each_cpu_and(cpu, affinity, cpu_online_mask) {
> -               int_pkt->int_desc.cpu_mask |=3D
> -                       (1ULL << vmbus_cpu_number_to_vp_number(cpu));
> +       if (cpumask_weight(affinity) >=3D 32) {
> +               int_pkt->int_desc.cpu_mask =3D CPU_AFFINITY_ALL;
> +       } else {
> +               for_each_cpu_and(cpu, affinity, cpu_online_mask) {
> +                       int_pkt->int_desc.cpu_mask |=3D
> +                               (1ULL << vmbus_cpu_number_to_vp_number(cp=
u));
> +               }
>         }
>=20
>         ret =3D vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt,
> --
> 1.7.1
>=20
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
