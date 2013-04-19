Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:8385 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751430Ab3DSFgr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Apr 2013 01:36:47 -0400
Message-ID: <5170D787.9010809@cn.fujitsu.com>
Date: Fri, 19 Apr 2013 13:35:03 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	tangchen <tangchen@cn.fujitsu.com>,
	Lin Feng <linfeng@cn.fujitsu.com>,
	li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 2/3] PCI: rename alloc_pci_dev() to pci_alloc_dev()
References: <516FB647.5030203@cn.fujitsu.com> <CAErSpo65ARR_fZwsGCZDJqbPWktHYUkufgPt-2mWwur=nPR1Qg@mail.gmail.com>
In-Reply-To: <CAErSpo65ARR_fZwsGCZDJqbPWktHYUkufgPt-2mWwur=nPR1Qg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/19/2013 12:00 AM, Bjorn Helgaas wrote:

> On Thu, Apr 18, 2013 at 3:00 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
>> From a3135f4a814ec2faba007f030ca96ea2297484ef Mon Sep 17 00:00:00 2001
>> From: Gu Zheng <guz.fnst@cn.fujitsu.com>
>> Date: Thu, 18 Apr 2013 17:27:40 +0900
>> Subject: [PATCH 2/3] PCI: rename alloc_pci_dev() to pci_alloc_dev()
>>
>> Rename alloc_pci_dev() to pci_alloc_dev() to make the name style the same
>> as pci_alloc_bus(), pci_destroy_dev().
>>
>> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
>> Reviewed-by: Li Guang <lig.fnst@cn.fujitsu.com>
>> ---
>>  arch/powerpc/kernel/pci_of_scan.c |    2 +-
>>  drivers/char/agp/alpha-agp.c      |    2 +-
>>  drivers/char/agp/parisc-agp.c     |    2 +-
>>  drivers/pci/iov.c                 |    2 +-
>>  drivers/pci/probe.c               |    6 +++---
>>  drivers/scsi/megaraid.c           |    2 +-
>>  include/linux/pci.h               |    2 +-
>>  7 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
>> index 9e0f6fd..2e35d11 100644
>> --- a/arch/powerpc/kernel/pci_of_scan.c
>> +++ b/arch/powerpc/kernel/pci_of_scan.c
>> @@ -128,7 +128,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>>         const char *type;
>>         struct pci_slot *slot;
>>
>> -       dev = alloc_pci_dev();
>> +       dev = pci_alloc_dev();
>>         if (!dev)
>>                 return NULL;
>>         type = of_get_property(node, "device_type", NULL);
>> diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
>> index dd84af4..aad2756 100644
>> --- a/drivers/char/agp/alpha-agp.c
>> +++ b/drivers/char/agp/alpha-agp.c
>> @@ -174,7 +174,7 @@ alpha_core_agp_setup(void)
>>         /*
>>          * Build a fake pci_dev struct
>>          */
>> -       pdev = alloc_pci_dev();
>> +       pdev = pci_alloc_dev();
>>         if (!pdev)
>>                 return -ENOMEM;
>>         pdev->vendor = 0xffff;
>> diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
>> index 94821ab..1dd1914 100644
>> --- a/drivers/char/agp/parisc-agp.c
>> +++ b/drivers/char/agp/parisc-agp.c
>> @@ -333,7 +333,7 @@ parisc_agp_setup(void __iomem *ioc_hpa, void __iomem *lba_hpa)
>>         struct agp_bridge_data *bridge;
>>         int error = 0;
>>
>> -       fake_bridge_dev = alloc_pci_dev();
>> +       fake_bridge_dev = pci_alloc_dev();
>>         if (!fake_bridge_dev) {
>>                 error = -ENOMEM;
>>                 goto fail;
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index 18798a7..4a15274 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -77,7 +77,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>>         struct resource *res;
>>         struct pci_sriov *iov = dev->sriov;
>>
>> -       virtfn = alloc_pci_dev();
>> +       virtfn = pci_alloc_dev();
>>         if (!virtfn)
>>                 return -ENOMEM;
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 44a6f7d..44f29d3 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1199,7 +1199,7 @@ static void pci_release_bus_bridge_dev(struct device *dev)
>>         kfree(bridge);
>>  }
>>
>> -struct pci_dev *alloc_pci_dev(void)
>> +struct pci_dev *pci_alloc_dev(void)
>>  {
>>         struct pci_dev *dev;
>>
>> @@ -1211,7 +1211,7 @@ struct pci_dev *alloc_pci_dev(void)
>>
>>         return dev;
>>  }
>> -EXPORT_SYMBOL(alloc_pci_dev);
>> +EXPORT_SYMBOL(pci_alloc_dev);
> 
> I like these patches a lot.  But I think we have some logistical
> issues to work out.
> 
> Since alloc_pci_dev() is exported, there may be out-of-tree modules
> that use it, so I don't want to simply remove alloc_pci_dev()
> completely.  I think it would be better to keep it for a while but
> mark it as __deprecated.

> 
> You can introduce a new pci_alloc_dev() here, and since it's a new
> interface, I think you might as well make it take a "struct pci_bus *"
> and acquire the reference from the beginning.
> 
> I think you could then make the final patch be the only one that
> touches powerpc, agp, megaraid, etc., to convert them from
> alloc_pci_dev(void) to pci_alloc_dev(bus).

Hi Bjorn,
	Thanks for your suggestions very much, and I'll send out a new version soon.

Best regards,
Gu 

> 
> Bjorn
> 
>>  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>>                                  int crs_timeout)
>> @@ -1261,7 +1261,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>>         if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
>>                 return NULL;
>>
>> -       dev = alloc_pci_dev();
>> +       dev = pci_alloc_dev();
>>         if (!dev)
>>                 return NULL;
>>
>> diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
>> index 9504ec0..de2e61f 100644
>> --- a/drivers/scsi/megaraid.c
>> +++ b/drivers/scsi/megaraid.c
>> @@ -2025,7 +2025,7 @@ megaraid_abort_and_reset(adapter_t *adapter, Scsi_Cmnd *cmd, int aor)
>>  static inline int
>>  make_local_pdev(adapter_t *adapter, struct pci_dev **pdev)
>>  {
>> -       *pdev = alloc_pci_dev();
>> +       *pdev = pci_alloc_dev();
>>
>>         if( *pdev == NULL ) return -1;
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index c4d064d..67edd5a 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -348,7 +348,7 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
>>         return dev;
>>  }
>>
>> -extern struct pci_dev *alloc_pci_dev(void);
>> +extern struct pci_dev *pci_alloc_dev(void);
>>
>>  #define        to_pci_dev(n) container_of(n, struct pci_dev, dev)
>>  #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
>> --
>> 1.7.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


