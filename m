Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:32926 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595AbbJ1MsB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2015 08:48:01 -0400
Received: by lbbec13 with SMTP id ec13so4853353lbb.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2015 05:47:59 -0700 (PDT)
Subject: Re: [Linaro-acpi] [PATCH V1 10/11] pci, acpi: Provide generic way to
 assign bus domain number.
To: Liviu.Dudau@arm.com, Tomasz Nowicki <tn@semihalf.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-11-git-send-email-tn@semihalf.com>
 <20151028113837.GK963@e106497-lin.cambridge.arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, arnd@arndb.de,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	catalin.marinas@arm.com, linaro-acpi@lists.linaro.org,
	will.deacon@arm.com, ddaney@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, wangyijing@huawei.com,
	robert.richter@caviumnetworks.com, bhelgaas@google.com,
	tglx@linutronix.de, jiang.liu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Message-ID: <5630C3F7.2040104@linaro.org>
Date: Wed, 28 Oct 2015 13:47:51 +0100
MIME-Version: 1.0
In-Reply-To: <20151028113837.GK963@e106497-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Liviu,

On 28.10.2015 12:38, Liviu.Dudau@arm.com wrote:
> On Tue, Oct 27, 2015 at 05:38:41PM +0100, Tomasz Nowicki wrote:
>> Architectures which support PCI_DOMAINS_GENERIC (like ARM64)
>> cannot call pci_bus_assign_domain_nr along ACPI PCI host bridge
>> initialization since this function needs valid parent device reference
>> to be able to retrieve domain number (aka segment).
>>
>> We can omit that blocker and pass down host bridge device via
>> pci_create_root_bus parameter and then be able to evaluate _SEG method
>> being in pci_bus_assign_domain_nr.
>>
>> Note that _SEG method is optional, therefore _SEG absence means
>> that all PCI buses belong to domain 0.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   drivers/acpi/pci_root.c |  2 +-
>>   drivers/pci/pci.c       | 32 +++++++++++++++++++++++++++-----
>>   2 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 850d7bf..e682dc6 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -839,7 +839,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>
>>   	pci_acpi_root_add_resources(info);
>>   	pci_add_resource(&info->resources, &root->secondary);
>> -	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
>> +	bus = pci_create_root_bus(&device->dev, busnum, ops->pci_ops,
>>   				  sysdata, &info->resources);
>
> Not sure this change should be in this patch, I don't see the relation.
>
> To put it differently: I think the patch should introduce the retrieval of the
> domain number from _SEG method and leave the passing of a valid host bridge device
> to a more appropriate patch.

I wanted to highlight that ACPI kernel using PCI_DOMAINS_GENERIC needs 
to have both in place:
1. Obtaining domain from _SEG method
2. And host bridge device reference for which we can call _SEG.
But you are right, it will be more clear if I split up patch and 
describe it in separate changelog.

>
>
>>   	if (!bus)
>>   		goto out_release_info;
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 6a9a111..17d1857 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/device.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pci_hotplug.h>
>> +#include <linux/acpi.h>
>>   #include <asm-generic/pci-bridge.h>
>>   #include <asm/setup.h>
>>   #include "pci.h"
>> @@ -4501,7 +4502,7 @@ int pci_get_new_domain_nr(void)
>>   void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>>   {
>>   	static int use_dt_domains = -1;
>> -	int domain = of_get_pci_domain_nr(parent->of_node);
>> +	int domain;
>>
>>   	/*
>>   	 * Check DT domain and use_dt_domains values.
>> @@ -4523,14 +4524,35 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>>   	 * API and update the use_dt_domains value to keep track of method we
>>   	 * are using to assign domain numbers (use_dt_domains = 0).
>>   	 *
>> +	 * IF ACPI, we expect non-DT method (use_dt_domains == -1)
>> +	 * and call _SEG method for corresponding host bridge device.
>> +	 * If _SEG method does not exist, following ACPI spec (6.5.6)
>> +	 * all PCI buses belong to domain 0.
>> +	 *
>>   	 * All other combinations imply we have a platform that is trying
>> -	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr(),
>> -	 * which is a recipe for domain mishandling and it is prevented by
>> -	 * invalidating the domain value (domain = -1) and printing a
>> -	 * corresponding error.
>> +	 * to mix domain numbers obtained from DT, ACPI and
>> +	 * pci_get_new_domain_nr(), which is a recipe for domain mishandling and
>> +	 * it is prevented by invalidating the domain value (domain = -1) and
>> +	 * printing a corresponding error.
>>   	 */
>> +
>> +	domain = of_get_pci_domain_nr(parent->of_node);
>
> Not sure what you've got here by splitting the original line into two other than an increase
> in the change count.

Yes, it does not make sense to split the original line. I will fix that.

>
> Otherwise, it looks sensible.
>
> Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>

Thanks Liviu!

Regards,
Tomasz
