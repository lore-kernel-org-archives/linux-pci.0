Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:48650 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab3DSRfl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2013 13:35:41 -0400
Received: by mail-vb0-f42.google.com with SMTP id p12so3931106vbe.15
        for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2013 10:35:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51711236.9070305@cn.fujitsu.com>
References: <516FB647.5030203@cn.fujitsu.com> <CAErSpo65ARR_fZwsGCZDJqbPWktHYUkufgPt-2mWwur=nPR1Qg@mail.gmail.com>
 <51711236.9070305@cn.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 19 Apr 2013 11:35:20 -0600
Message-ID: <CAErSpo5ywSx-ZR=Z3+v8_QfBGTrDF__SQ09fU-6qsU=ZdqFEMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Convert alloc_pci_dev(void) to
 pci_alloc_dev(bus) instead
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	tangchen <tangchen@cn.fujitsu.com>,
	Lin Feng <linfeng@cn.fujitsu.com>,
	li guang <lig.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 19, 2013 at 3:45 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
> From 2535fb1a2502b3d9bebc31f7c7205f42392ea5f9 Mon Sep 17 00:00:00 2001
> From: Gu Zheng <guz.fnst@cn.fujitsu.com>
> Date: Fri, 19 Apr 2013 17:46:36 +0900
> Subject: [PATCH 2/2] PCI: Convert alloc_pci_dev(void) to pci_alloc_dev(bus) instead
>
> Use the new pci_alloc_dev(bus) to replace the existing using of alloc_pci_dev(void).

You didn't do anything with Yinghai's comment.  He's 100% correct: you
have to add the put_device() that corresponds to the new get_device()
calls you're adding.  Both have to be in the same patch.

> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---
>  arch/powerpc/kernel/pci_of_scan.c |    3 +--
>  drivers/char/agp/alpha-agp.c      |    2 +-
>  drivers/char/agp/parisc-agp.c     |    2 +-
>  drivers/pci/iov.c                 |    2 +-
>  drivers/pci/probe.c               |    3 +--
>  drivers/scsi/megaraid.c           |    2 +-
>  6 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 2a67e9b..24d01c4 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -128,7 +128,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>         const char *type;
>         struct pci_slot *slot;
>
> -       dev = alloc_pci_dev();
> +       dev = pci_alloc_dev(bus);
>         if (!dev)
>                 return NULL;
>         type = of_get_property(node, "device_type", NULL);
> @@ -137,7 +137,6 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>
>         pr_debug("    create device, devfn: %x, type: %s\n", devfn, type);
>
> -       dev->bus = bus;
>         dev->dev.of_node = of_node_get(node);
>         dev->dev.parent = bus->bridge;
>         dev->dev.bus = &pci_bus_type;
> diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
> index dd84af4..199b8e9 100644
> --- a/drivers/char/agp/alpha-agp.c
> +++ b/drivers/char/agp/alpha-agp.c
> @@ -174,7 +174,7 @@ alpha_core_agp_setup(void)
>         /*
>          * Build a fake pci_dev struct
>          */
> -       pdev = alloc_pci_dev();
> +       pdev = pci_alloc_dev(NULL);
>         if (!pdev)
>                 return -ENOMEM;
>         pdev->vendor = 0xffff;
> diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
> index 94821ab..bf5d247 100644
> --- a/drivers/char/agp/parisc-agp.c
> +++ b/drivers/char/agp/parisc-agp.c
> @@ -333,7 +333,7 @@ parisc_agp_setup(void __iomem *ioc_hpa, void __iomem *lba_hpa)
>         struct agp_bridge_data *bridge;
>         int error = 0;
>
> -       fake_bridge_dev = alloc_pci_dev();
> +       fake_bridge_dev = pci_alloc_dev(NULL);
>         if (!fake_bridge_dev) {
>                 error = -ENOMEM;
>                 goto fail;
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index ee599f2..dba2031 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -76,7 +76,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>         struct resource *res;
>         struct pci_sriov *iov = dev->sriov;
>
> -       virtfn = alloc_pci_dev();
> +       virtfn = pci_alloc_dev(NULL);
>         if (!virtfn)
>                 return -ENOMEM;
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5233fb6..59637a6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1280,11 +1280,10 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>         if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
>                 return NULL;
>
> -       dev = alloc_pci_dev();
> +       dev = pci_alloc_dev(bus);
>         if (!dev)
>                 return NULL;
>
> -       dev->bus = bus;
>         dev->devfn = devfn;
>         dev->vendor = l & 0xffff;
>         dev->device = (l >> 16) & 0xffff;
> diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
> index 9504ec0..e1660ca 100644
> --- a/drivers/scsi/megaraid.c
> +++ b/drivers/scsi/megaraid.c
> @@ -2025,7 +2025,7 @@ megaraid_abort_and_reset(adapter_t *adapter, Scsi_Cmnd *cmd, int aor)
>  static inline int
>  make_local_pdev(adapter_t *adapter, struct pci_dev **pdev)
>  {
> -       *pdev = alloc_pci_dev();
> +       *pdev = pci_alloc_dev(NULL);
>
>         if( *pdev == NULL ) return -1;
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
