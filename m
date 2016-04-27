Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35909 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbcD0L74 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2016 07:59:56 -0400
Received: by mail-wm0-f42.google.com with SMTP id n129so23899763wmn.1
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2016 04:59:55 -0700 (PDT)
Subject: Re: [PATCH V6 02/13] pci, acpi: Provide generic way to assign bus
 domain number.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-3-git-send-email-tn@semihalf.com>
 <20160427022649.GD6789@localhost>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5720A9A2.6000609@semihalf.com>
Date: Wed, 27 Apr 2016 13:59:30 +0200
MIME-Version: 1.0
In-Reply-To: <20160427022649.GD6789@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27.04.2016 04:26, Bjorn Helgaas wrote:
> On Fri, Apr 15, 2016 at 07:06:37PM +0200, Tomasz Nowicki wrote:
>> As we now have valid PCI host bridge device reference we can
>> introduce code that is going to find its bus domain number using
>> ACPI _SEG method.
>>
>> Note that _SEG method is optional, therefore _SEG absence means
>> that all PCI buses belong to domain 0.
>>
>> While at it, for the sake of code clarity we put ACPI and DT domain
>> assign methods into the corresponding helpers.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
>> Tested-by: Duc Dang <dhdang@apm.com>
>> Tested-by: Dongdong Liu <liudongdong3@huawei.com>
>> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Tested-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>   drivers/acpi/pci_root.c  | 18 ++++++++++++++++++
>>   drivers/pci/pci.c        | 11 +++++++++--
>>   include/linux/pci-acpi.h |  2 ++
>>   3 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 4581e0e..d9a70c4 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -419,6 +419,24 @@ out:
>>   }
>>   EXPORT_SYMBOL(acpi_pci_osc_control_set);
>>
>> +int acpi_pci_bus_domain_nr(struct device *parent)
>> +{
>> +	struct acpi_device *acpi_dev = to_acpi_device(parent);
>> +	unsigned long long segment = 0;
>> +	acpi_status status;
>> +
>> +	/*
>> +	 * If _SEG method does not exist, following ACPI spec (6.5.6)
>> +	 * all PCI buses belong to domain 0.
>> +	 */
>> +	status = acpi_evaluate_integer(acpi_dev->handle, METHOD_NAME__SEG, NULL,
>> +				       &segment);
>
> We already have code in acpi_pci_root_add() to evaluate _SEG.  We
> don't want to evaluate it *twice*, do we?

Ideally we do not want.

The main intention here was to avoid using "void *sysdata" to retrieve 
domain number. sysdata means something different for each architectures. 
This would be common way for all arch using PCI_DOMAINS_GENERIC option 
such as ARM64.

>
> I was sort of expecting that if you added it here, we'd remove the
> existing call, but it looks like you're keeping both?

I leave _SEG evaluation in acpi_pci_root_add to keep support for IA64 
and x86 which are still using arch-specific sysdata (struct 
pci_sysdata->domain for x86 and struct pci_controller->segment for IA64) 
to retrieve domain number.

ARM64 uses PCI_DOMAINS_GENERIC for DT boot method, it would be 
consistent to keep it for ACPI too.

I am open to suggestions, do you think we should use sysdata for ARM64?

Thanks,
Tomasz
