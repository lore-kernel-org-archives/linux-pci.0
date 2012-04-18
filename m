Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([58.251.152.66]:52403 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab2DRIDZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Apr 2012 04:03:25 -0400
Received: from huawei.com (szxga03-in [172.24.2.9])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M2O00DJT0GQA6@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 18 Apr 2012 15:50:50 +0800 (CST)
Received: from szxrg02-dlp.huawei.com ([172.24.2.119])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M2O00FR50GO3Y@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 18 Apr 2012 15:50:50 +0800 (CST)
Date: Wed, 18 Apr 2012 15:49:59 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH V4 6/6] PCI, ACPI,
 x86: update MMCFG information when hot-plugging PCI host bridges
In-reply-to: <20120418154725.92833e4d.izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Message-id: <4F8E7227.1050707@huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com>
 <1334103063-2283-7-git-send-email-jiang.liu@huawei.com>
 <20120418154725.92833e4d.izumi.taku@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Taku,
	Thanks for your comments and please refer to inline comments
below.
	gerry
On 2012-4-18 14:47, Taku Izumi wrote:
>
> Hi Jiang,
>
> On Wed, 11 Apr 2012 08:11:03 +0800
> Jiang Liu<liuj97@gmail.com>  wrote:
>
>> This patch enhances pci_root driver to update MMCFG information when
>> hot-plugging PCI root bridges on x86 platforms.
>>
>> Signed-off-by: Jiang Liu<jiang.liu@huawei.com>
>> ---
>>   arch/x86/include/asm/pci_x86.h |    1 +
>>   arch/x86/pci/acpi.c            |   58 ++++++++++++++++++++++++++++++++++++++++
>>   arch/x86/pci/mmconfig_32.c     |    2 +-
>>   arch/x86/pci/mmconfig_64.c     |    2 +-
>>   drivers/acpi/pci_root.c        |   16 +++++++++++
>>   include/acpi/acnames.h         |    1 +
>>   include/acpi/acpi_bus.h        |    1 +
>>   include/linux/pci-acpi.h       |    3 ++
>>   8 files changed, 82 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
>> index 3252c97..5e1d9a6 100644
>> --- a/arch/x86/include/asm/pci_x86.h
>> +++ b/arch/x86/include/asm/pci_x86.h
>> @@ -100,6 +100,7 @@ struct pci_raw_ops {
>>   extern const struct pci_raw_ops *raw_pci_ops;
>>   extern const struct pci_raw_ops *raw_pci_ext_ops;
>>
>> +extern const struct pci_raw_ops pci_mmcfg;
>>   extern const struct pci_raw_ops pci_direct_conf1;
>>   extern bool port_cf9_safe;
>>
>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>> index da0149d..729d694 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -4,6 +4,7 @@
>>   #include<linux/irq.h>
>>   #include<linux/dmi.h>
>>   #include<linux/slab.h>
>> +#include<linux/pci-acpi.h>
>>   #include<asm/numa.h>
>>   #include<asm/pci_x86.h>
>>
>> @@ -488,6 +489,63 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>>   	return bus;
>>   }
>>
>> +int __devinit arch_acpi_pci_root_add(struct acpi_pci_root *root)
>> +{
>> +	int result = 0;
>> +	acpi_status status;
>> +	unsigned long long base_addr;
>> +
>> +	/* MMCFG not in use */
>> +	if (raw_pci_ext_ops&&  raw_pci_ext_ops !=&pci_mmcfg)
>> +		return result;
>> +
>> +	status = acpi_evaluate_integer(root->device->handle, METHOD_NAME__CBA,
>> +				       NULL,&base_addr);
>> +	if (ACPI_FAILURE(status))
>> +		base_addr = 0;
>> +	/*
>> +	 * Try to insert MMCFG information for host bridge
>> +	 */
>> +	result = pci_mmconfig_insert(root->segment, root->secondary.start,
>> +				     root->secondary.end, base_addr);
>
> 	This logic looks strange.
> 	If the evaluation of "_CBA" failed (for example, "_CBA" didn't exist),
> 	pci_mmconfig_insert() should not be invoked.
>
Yes, the code looks a little strange here, maybe need more clear
comments here.

For hotplug capable (physical hotplug) host bridges, BIOS should provide
_CBA method for them and we should insert the new MMCFG info here.
For non-hotplug-capable host bridges, we check that MMCFG information
for the host bridge already exists.

So the magic part is in function pci_mmconfig_insert(). The algorithm
for function pci_mmconfig_insert() is
{
	if (base_addr is not zero)
		return try_to_insert_MMCFG_info();
	else if (MMCFG info for (seg, start, bus) already exists)
		return -EEXIST;
	else
		return -EINVAL;
}

We will check for -EEXIST on return from pci_mmconfig_insert() for the
special case.

>
>> +	if (result == -EEXIST)
>> +		result = 0;
>> +	else if (!result) {
>> +		root->mmconf_added = true;
>> +
>> +		/* Try to enable MMCFG if it hasn't been enabled yet */
>> +		if (raw_pci_ext_ops == NULL) {
>> +			if (pci_probe&  PCI_PROBE_MMCONF)
>> +				raw_pci_ext_ops =&pci_mmcfg;
>> +			else {
>> +				arch_acpi_pci_root_remove(root);
>> +				result = -ENODEV;
>> +			}
>> +		}
>> +	}
>> +	if (result)
>> +		printk(KERN_ERR
>> +			"can't add MMCFG information for Bus %04x:%02x\n",
>> +			root->segment, (unsigned int)root->secondary.start);
>> +
>> +	/* still could use conf1 with it */
>> +	if (!root->segment)
>> +		result = 0;
>> +
>> +	return result;
>> +}
>> +
>> +void arch_acpi_pci_root_remove(struct acpi_pci_root *root)
>> +{
>> +	if (root->mmconf_added) {
>> +		pci_mmconfig_delete(root->segment,
>> +				    root->secondary.start,
>> +				    root->secondary.end);
>> +		root->mmconf_added = false;
>> +	}
>> +}
>> +
>>   int __init pci_acpi_init(void)
>>   {
>>   	struct pci_dev *dev = NULL;
>> diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
>> index a22785d..db63ac2 100644
>> --- a/arch/x86/pci/mmconfig_32.c
>> +++ b/arch/x86/pci/mmconfig_32.c
>> @@ -126,7 +126,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
>>   	return 0;
>>   }
>>
>> -static const struct pci_raw_ops pci_mmcfg = {
>> +const struct pci_raw_ops pci_mmcfg = {
>>   	.read =		pci_mmcfg_read,
>>   	.write =	pci_mmcfg_write,
>>   };
>> diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
>> index 4e05779..34c08dd 100644
>> --- a/arch/x86/pci/mmconfig_64.c
>> +++ b/arch/x86/pci/mmconfig_64.c
>> @@ -90,7 +90,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
>>   	return 0;
>>   }
>>
>> -static const struct pci_raw_ops pci_mmcfg = {
>> +const struct pci_raw_ops pci_mmcfg = {
>>   	.read =		pci_mmcfg_read,
>>   	.write =	pci_mmcfg_write,
>>   };
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 4a7d575..b7c0b53 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -448,6 +448,15 @@ out:
>>   }
>>   EXPORT_SYMBOL(acpi_pci_osc_control_set);
>>
>> +int __weak arch_acpi_pci_root_add(struct acpi_pci_root *root)
>> +{
>> +	return 0;
>> +}
>> +
>> +void __weak arch_acpi_pci_root_remove(struct acpi_pci_root *root)
>> +{
>> +}
>> +
>>   static int __devinit acpi_pci_root_add(struct acpi_device *device)
>>   {
>>   	unsigned long long segment, bus;
>> @@ -504,6 +513,11 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>>   	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
>>   	device->driver_data = root;
>>
>> +	if (arch_acpi_pci_root_add(root)) {
>> +		result = -ENODEV;
>> +		goto out_free;
>> +	}
>> +
>>   	/*
>>   	 * All supported architectures that use ACPI have support for
>>   	 * PCI domains, so we indicate this in _OSC support capabilities.
>> @@ -629,6 +643,7 @@ out_del_root:
>>   	list_del_rcu(&root->node);
>>   	mutex_unlock(&acpi_pci_root_lock);
>>   	synchronize_rcu();
>> +	arch_acpi_pci_root_remove(root);
>>   out_free:
>>   	kfree(root);
>>   	return result;
>> @@ -679,6 +694,7 @@ out:
>>   	list_del_rcu(&root->node);
>>   	mutex_unlock(&acpi_pci_root_lock);
>>   	synchronize_rcu();
>> +	arch_acpi_pci_root_remove(root);
>>   	kfree(root);
>>
>>   	return 0;
>> diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
>> index 38f5088..99bda75 100644
>> --- a/include/acpi/acnames.h
>> +++ b/include/acpi/acnames.h
>> @@ -62,6 +62,7 @@
>>   #define METHOD_NAME__AEI        "_AEI"
>>   #define METHOD_NAME__PRW        "_PRW"
>>   #define METHOD_NAME__SRS        "_SRS"
>> +#define METHOD_NAME__CBA	"_CBA"
>>
>>   /* Method names - these methods must appear at the namespace root */
>>
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index f1c8ca6..cb4f402 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -370,6 +370,7 @@ struct acpi_pci_root {
>>
>>   	u32 osc_support_set;	/* _OSC state of support bits */
>>   	u32 osc_control_set;	/* _OSC state of control bits */
>> +	bool mmconf_added;
>>   };
>>
>>   /* helper */
>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> index ac93634..7745b8a 100644
>> --- a/include/linux/pci-acpi.h
>> +++ b/include/linux/pci-acpi.h
>> @@ -18,6 +18,9 @@ extern acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
>>   					     struct pci_dev *pci_dev);
>>   extern acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev);
>>
>> +int arch_acpi_pci_root_add(struct acpi_pci_root *root);
>> +void arch_acpi_pci_root_remove(struct acpi_pci_root *root);
>> +
>>   static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
>>   {
>>   	struct pci_bus *pbus = pdev->bus;
>> --
>> 1.7.5.4
>>
>>
>
>


