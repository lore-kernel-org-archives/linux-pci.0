Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51968 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683Ab2DGPKI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Apr 2012 11:10:08 -0400
Received: by iagz16 with SMTP id z16so4204116iag.19
        for <linux-pci@vger.kernel.org>; Sat, 07 Apr 2012 08:10:07 -0700 (PDT)
Message-ID: <4F8058C6.8010400@gmail.com>
Date: Sat, 07 Apr 2012 23:09:58 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] [RFC] PCI, ACPI, x86: MMCFG support for hotpluggable
 PCI hostbridges on x86, x86_64
References: <20120406115948.3536e6c8.izumi.taku@jp.fujitsu.com> <4F7E8DDD.7020603@jp.fujitsu.com>
In-Reply-To: <4F7E8DDD.7020603@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/06/2012 02:31 PM, Kenji Kaneshige wrote:
> (2012/04/06 11:59), Taku Izumi wrote:
>>
>> This patch introduces the configuration for the base address of
>> the memory mapped configuration space (MMCFG) for hot pluggable PCI
>> hostbridges on x86 and x86_64.
>>
>> The MMCFG for hotplugable host bridges must be described by using
>> ACPI _CBA method. This patch adds implementation for _CBA method
>> on ACPI pci_root driver and MMCFG manipulating functons for x86 and
>> x86_64.
>>
>> Signed-off-by: Taku Izumi<izumi.taku@jp.fujitsu.com>
>> ---
>>   arch/x86/pci/mmconfig-shared.c |   43 +++++++++++++++++++++++++++++++++++------
>>   drivers/acpi/pci_root.c        |   28 +++++++++++++++++++++++++-
>>   drivers/pci/pci.c              |   31 +++++++++++++++++++++++++++++
>>   include/acpi/acnames.h         |    1
>>   include/linux/pci.h            |    3 ++
>>   5 files changed, 99 insertions(+), 7 deletions(-)
>>
>> Index: linux-next-build/drivers/acpi/pci_root.c
>> ===================================================================
>> --- linux-next-build.orig/drivers/acpi/pci_root.c
>> +++ linux-next-build/drivers/acpi/pci_root.c
>> @@ -451,7 +451,7 @@ EXPORT_SYMBOL(acpi_pci_osc_control_set);
>>
>>   static int __devinit acpi_pci_root_add(struct acpi_device *device)
>>   {
>> -    unsigned long long segment, bus;
>> +    unsigned long long segment, bus, base_addr;
>>       acpi_status status;
>>       int result;
>>       struct acpi_pci_root *root;
>> @@ -506,6 +506,28 @@ static int __devinit acpi_pci_root_add(s
>>       device->driver_data = root;
>>
>>       /*
>> +     * Check _CBA for hot pluggable host bridge
>> +     */
>> +    base_addr = 0;
>> +    status = acpi_evaluate_integer(device->handle, METHOD_NAME__CBA, NULL,
>> +                    &base_addr);
>> +    if (ACPI_FAILURE(status)&&  status != AE_NOT_FOUND) {
>> +        printk(KERN_ERR PREFIX "can't evaluate _CBA\n");
>> +        result = -ENODEV;
>> +        goto end;
>> +    }
>> +    if (base_addr) {
>> +        if (pci_add_mmcfg_region(root->segment,
>> +                     root->secondary.start,
>> +                     root->secondary.end,
>> +                     base_addr) != 0) {
>> +            printk(KERN_ERR PREFIX "can't add MMCFG entry\n");
>> +            result = -ENODEV;
>> +            goto end;
>> +        }
> 
> how about
>         result = pci_add_mmcfg_region()
>         if (result) {
>             printk();
>             goto end;
>         }
> ?
> 
>> +    }
>> +
>> +    /*
>>        * All supported architectures that use ACPI have support for
>>        * PCI domains, so we indicate this in _OSC support capabilities.
>>        */
>> @@ -625,6 +647,8 @@ static int __devinit acpi_pci_root_add(s
>>       return 0;
>>
>>   end:
>> +    if (base_addr)
>> +        pci_remove_mmcfg_region(root->segment, root->secondary.start);
>>       if (!list_empty(&root->node))
>>           list_del(&root->node);
>>       kfree(root);
>> @@ -646,6 +670,8 @@ static int acpi_pci_root_remove(struct a
>>       device_set_run_wake(root->bus->bridge, false);
>>       pci_acpi_remove_bus_pm_notifier(device);
>>
>> +    pci_remove_mmcfg_region(root->segment, root->secondary.start);
>> +
>>       kfree(root);
>>       return 0;
>>   }
>> Index: linux-next-build/include/acpi/acnames.h
>> ===================================================================
>> --- linux-next-build.orig/include/acpi/acnames.h
>> +++ linux-next-build/include/acpi/acnames.h
>> @@ -61,6 +61,7 @@
>>   #define METHOD_NAME__AEI        "_AEI"
>>   #define METHOD_NAME__PRW        "_PRW"
>>   #define METHOD_NAME__SRS        "_SRS"
>> +#define METHOD_NAME__CBA    "_CBA"
>>
>>   /* Method names - these methods must appear at the namespace root */
>>
>> Index: linux-next-build/include/linux/pci.h
>> ===================================================================
>> --- linux-next-build.orig/include/linux/pci.h
>> +++ linux-next-build/include/linux/pci.h
>> @@ -1460,6 +1460,9 @@ void pcibios_disable_device(struct pci_d
>>   void pcibios_set_master(struct pci_dev *dev);
>>   int pcibios_set_pcie_reset_state(struct pci_dev *dev,
>>                    enum pcie_reset_state state);
>> +int pci_add_mmcfg_region(int segment, int start,
>> +             int end, u64 addr);
>> +void pci_remove_mmcfg_region(int segment, int bus);
>>
>>   #ifdef CONFIG_PCI_MMCONFIG
>>   extern void __init pci_mmcfg_early_init(void);
>> Index: linux-next-build/arch/x86/pci/mmconfig-shared.c
>> ===================================================================
>> --- linux-next-build.orig/arch/x86/pci/mmconfig-shared.c
>> +++ linux-next-build/arch/x86/pci/mmconfig-shared.c
>> @@ -28,7 +28,7 @@ static int __initdata pci_mmcfg_resource
>>
>>   LIST_HEAD(pci_mmcfg_list);
>>
>> -static __init void pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
>> +static __devinit void pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
>>   {
>>       if (cfg->res.parent)
>>           release_resource(&cfg->res);
>> @@ -45,7 +45,7 @@ static __init void free_all_mmcfg(void)
>>           pci_mmconfig_remove(cfg);
>>   }
>>
>> -static __init void list_add_sorted(struct pci_mmcfg_region *new)
>> +static __devinit void list_add_sorted(struct pci_mmcfg_region *new)
>>   {
>>       struct pci_mmcfg_region *cfg;
>>
>> @@ -61,8 +61,10 @@ static __init void list_add_sorted(struc
>>       list_add_tail(&new->list,&pci_mmcfg_list);
>>   }
>>
>> -static __init struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
>> -                            int end, u64 addr)
>> +static __devinit struct pci_mmcfg_region *pci_mmconfig_add(int segment,
>> +                               int start,
>> +                               int end,
>> +                               u64 addr)
>>   {
>>       struct pci_mmcfg_region *new;
>>       struct resource *res;
>> @@ -108,6 +110,33 @@ struct pci_mmcfg_region *pci_mmconfig_lo
>>       return NULL;
>>   }
>>
>> +int pci_add_mmcfg_region(int segment, int start, int end, u64 addr)
>> +{
>> +    struct pci_mmcfg_region *cfg;
>> +
>> +    cfg = pci_mmconfig_add(segment, start, end, addr);
>> +    if (!cfg) {
>> +        printk(KERN_WARNING PREFIX
>> +            "no memory for MMCFG entry\n");
>> +        return -ENOMEM;
>> +    }
> 
> We need to check if the region is valid (if the region is
> reserved in ACPI motherborad resource).
> 
> 
>> +
>> +    insert_resource(&iomem_resource,&cfg->res);
>> +
>> +    return 0;
>> +}
>> +
>> +void pci_remove_mmcfg_region(int segment, int bus)
>> +{
>> +    struct pci_mmcfg_region *cfg;
>> +
>> +    cfg = pci_mmconfig_lookup(segment, bus);
>> +    if (!cfg)
>> +        return;
>> +
>> +    pci_mmconfig_remove(cfg);
>> +}
>> +
>>   static const char __init *pci_mmcfg_e7520(void)
>>   {
>>       u32 win;
>> @@ -357,8 +386,10 @@ static void __init pci_mmcfg_insert_reso
>>   {
>>       struct pci_mmcfg_region *cfg;
>>
>> -    list_for_each_entry(cfg,&pci_mmcfg_list, list)
>> -        insert_resource(&iomem_resource,&cfg->res);
>> +    list_for_each_entry(cfg,&pci_mmcfg_list, list) {
> 
> We need to add lock for manipulating pci_mmcfg_list.
I have worked out a similar patch several weeks ago to address this issue,
use lock to protect the mmconfig list when pci host bridge hotplug happens.
But I can't access my dev machine from home now, and will send it out for
your reference tomorrow.
Thanks!

> 
>> +        if (!cfg->res.parent)
> 
> Why do we need this line?
> 
> Regards,
> Kenji Kaneshige
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

