Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:52577 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602Ab3DWQpC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2013 12:45:02 -0400
Received: by mail-da0-f50.google.com with SMTP id a4so425712dad.37
        for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2013 09:45:01 -0700 (PDT)
Message-ID: <5176BA7F.7050800@gmail.com>
Date: Wed, 24 Apr 2013 00:44:47 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	tangchen <tangchen@cn.fujitsu.com>,
	Lin Feng <linfeng@cn.fujitsu.com>,
	li guang <lig.fnst@cn.fujitsu.com>,
	Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] PCI: Convert alloc_pci_dev(void) to pci_alloc_dev(bus)
 instead
References: <516FB647.5030203@cn.fujitsu.com> <CAErSpo65ARR_fZwsGCZDJqbPWktHYUkufgPt-2mWwur=nPR1Qg@mail.gmail.com> <51763847.8090808@cn.fujitsu.com>
In-Reply-To: <51763847.8090808@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/23/2013 03:29 PM, Gu Zheng wrote:
> From b01e61759f894b651ed3bb39c9fc18e0b66d7cb3 Mon Sep 17 00:00:00 2001
> From: GuZheng <guz.fnst@cn.fujitsu.com>
> Date: Tue, 23 Apr 2013 14:01:39 +0800
> Subject: [PATCH v2 2/2] PCI: Convert alloc_pci_dev(void) to pci_alloc_dev(bus)
>  instead
> 
> Use the new pci_alloc_dev(bus) to replace the existing using of alloc_pci_dev(void).
> And new functions pci_bus_get/put() are introdued to hide pci_bus' reference management.
> 
> v2:
>   Follow Yinghai's suggestions to reduce pci_bus' ref when destroying pci device.
>   Add new functions pci_bus_get/put() to hide pci_bus' reference management.
> 
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---
>  arch/powerpc/kernel/pci_of_scan.c |    3 +--
>  arch/sparc/kernel/pci.c           |    3 +--
>  drivers/char/agp/alpha-agp.c      |    2 +-
>  drivers/char/agp/parisc-agp.c     |    2 +-
>  drivers/pci/bus.c                 |   15 +++++++++++++++
>  drivers/pci/iov.c                 |    8 +++++---
>  drivers/pci/probe.c               |    9 +++------
>  drivers/pci/remove.c              |    2 ++
>  drivers/scsi/megaraid.c           |    2 +-
>  include/linux/pci.h               |    3 +++
>  10 files changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 2a67e9b..24d01c4 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -128,7 +128,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>  	const char *type;
>  	struct pci_slot *slot;
>  
> -	dev = alloc_pci_dev();
> +	dev = pci_alloc_dev(bus);
>  	if (!dev)
>  		return NULL;
>  	type = of_get_property(node, "device_type", NULL);
> @@ -137,7 +137,6 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>  
>  	pr_debug("    create device, devfn: %x, type: %s\n", devfn, type);
>  
> -	dev->bus = bus;
>  	dev->dev.of_node = of_node_get(node);
>  	dev->dev.parent = bus->bridge;
>  	dev->dev.bus = &pci_bus_type;
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index baf4366..e5871fb 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -254,7 +254,7 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
>  	const char *type;
>  	u32 class;
>  
> -	dev = alloc_pci_dev();
> +	dev = pci_alloc_dev(bus);
>  	if (!dev)
>  		return NULL;
>  
> @@ -281,7 +281,6 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
>  		printk("    create device, devfn: %x, type: %s\n",
>  		       devfn, type);
>  
> -	dev->bus = bus;
>  	dev->sysdata = node;
>  	dev->dev.parent = bus->bridge;
>  	dev->dev.bus = &pci_bus_type;
> diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
> index dd84af4..199b8e9 100644
> --- a/drivers/char/agp/alpha-agp.c
> +++ b/drivers/char/agp/alpha-agp.c
> @@ -174,7 +174,7 @@ alpha_core_agp_setup(void)
>  	/*
>  	 * Build a fake pci_dev struct
>  	 */
> -	pdev = alloc_pci_dev();
> +	pdev = pci_alloc_dev(NULL);
>  	if (!pdev)
>  		return -ENOMEM;
>  	pdev->vendor = 0xffff;
> diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
> index 94821ab..bf5d247 100644
> --- a/drivers/char/agp/parisc-agp.c
> +++ b/drivers/char/agp/parisc-agp.c
> @@ -333,7 +333,7 @@ parisc_agp_setup(void __iomem *ioc_hpa, void __iomem *lba_hpa)
>  	struct agp_bridge_data *bridge;
>  	int error = 0;
>  
> -	fake_bridge_dev = alloc_pci_dev();
> +	fake_bridge_dev = pci_alloc_dev(NULL);
>  	if (!fake_bridge_dev) {
>  		error = -ENOMEM;
>  		goto fail;
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 8647dc6..5eacf78 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -18,6 +18,21 @@
>  
>  #include "pci.h"
>  
> +struct pci_bus *pci_bus_get(struct pci_bus *bus)
> +{
> +	if (bus)
> +		get_device(&bus->dev);
> +	return bus;
> +}
> +EXPORT_SYMBOL(pci_bus_get);
> +
> +void pci_bus_put(struct pci_bus *bus)
> +{
> +	if (bus)
> +		put_device(&bus->dev);
> +}
> +EXPORT_SYMBOL(pci_bus_put);
> +
>  void pci_add_resource_offset(struct list_head *resources, struct resource *res,
>  			     resource_size_t offset)
>  {
Hi Zheng,
	Could you please help to split addition of pci_bus_get() and pci_bus_put()
into a separate patch? I'm working on some patches which depends on this.

> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index ee599f2..24134cd 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -75,18 +75,20 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>  	struct pci_dev *virtfn;
>  	struct resource *res;
>  	struct pci_sriov *iov = dev->sriov;
> +	struct pci_bus *bus;
>  
> -	virtfn = alloc_pci_dev();
> +	virtfn = pci_alloc_dev(NULL);
>  	if (!virtfn)
>  		return -ENOMEM;
>  
>  	mutex_lock(&iov->dev->sriov->lock);
> -	virtfn->bus = virtfn_add_bus(dev->bus, virtfn_bus(dev, id));
> -	if (!virtfn->bus) {
> +	bus = virtfn_add_bus(dev->bus, virtfn_bus(dev, id));
> +	if (!bus) {
>  		kfree(virtfn);
>  		mutex_unlock(&iov->dev->sriov->lock);
>  		return -ENOMEM;
>  	}
> +	virtfn->bus = pci_bus_get(bus);
>  	virtfn->devfn = virtfn_devfn(dev, id);
>  	virtfn->vendor = dev->vendor;
>  	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0bb92e4..9d37d46 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1209,10 +1209,8 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  
>  	INIT_LIST_HEAD(&dev->bus_list);
>  
> -	if (bus) {
> -		get_device(&bus->dev);
> -		dev->bus = bus;
> -	}
> +	if (bus)
How about remove above redundant check?

> +		dev->bus = pci_bus_get(bus);
>  
>  	return dev;
>  }
> @@ -1272,11 +1270,10 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
>  		return NULL;
>  
> -	dev = alloc_pci_dev();
> +	dev = pci_alloc_dev(bus);
>  	if (!dev)
>  		return NULL;
>  
> -	dev->bus = bus;
>  	dev->devfn = devfn;
>  	dev->vendor = l & 0xffff;
>  	dev->device = (l >> 16) & 0xffff;
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index cc875e6..fffdee8 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -38,6 +38,8 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	list_del(&dev->bus_list);
>  	up_write(&pci_bus_sem);
>  
> +	pci_bus_put(dev->bus);
> +
>  	pci_free_resources(dev);
>  	put_device(&dev->dev);
>  }
> diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
> index 9504ec0..e1660ca 100644
> --- a/drivers/scsi/megaraid.c
> +++ b/drivers/scsi/megaraid.c
> @@ -2025,7 +2025,7 @@ megaraid_abort_and_reset(adapter_t *adapter, Scsi_Cmnd *cmd, int aor)
>  static inline int
>  make_local_pdev(adapter_t *adapter, struct pci_dev **pdev)
>  {
> -	*pdev = alloc_pci_dev();
> +	*pdev = pci_alloc_dev(NULL);
>  
>  	if( *pdev == NULL ) return -1;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 682de2b..c5f245d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1002,6 +1002,9 @@ int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
>  void pci_release_selected_regions(struct pci_dev *, int);
>  
>  /* drivers/pci/bus.c */
> +extern struct pci_bus *pci_bus_get(struct pci_bus *bus);
> +extern void pci_bus_put(struct pci_bus *bus);
> +
>  void pci_add_resource(struct list_head *resources, struct resource *res);
>  void pci_add_resource_offset(struct list_head *resources, struct resource *res,
>  			     resource_size_t offset);
> 

