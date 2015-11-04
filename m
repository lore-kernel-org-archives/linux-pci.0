Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Linaro-acpi] [PATCH V1 10/11] pci, acpi: Provide generic way to
 assign bus domain number.
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-11-git-send-email-tn@semihalf.com>
 <20151103161059.GE3574@red-moon>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, arnd@arndb.de,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	catalin.marinas@arm.com, linaro-acpi@lists.linaro.org,
	will.deacon@arm.com, ddaney@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, wangyijing@huawei.com,
	robert.richter@caviumnetworks.com, tglx@linutronix.de,
	bhelgaas@google.com, Liviu.Dudau@arm.com,
	jiang.liu@linux.intel.com, linux-arm-kernel@lists.infradead.org
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Message-ID: <5639D84A.1020809@linaro.org>
Date: Wed, 4 Nov 2015 11:04:58 +0100
MIME-Version: 1.0
In-Reply-To: <20151103161059.GE3574@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03.11.2015 17:10, Lorenzo Pieralisi wrote:
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
> If I read x86 code correctly, they rely on the first argument to be
> NULL, I think you would break x86 by doing that, see:
>
> arch/x86/pci/acpi.c (pcibios_root_bridge_prepare())
>
> By the way, can't we move the code setting up the ACPI_COMPANION
> to core PCI code and stop relying on sysdata for that ?
>

Yes, that will break x86&ia64 but as you said it may be overcome with 
consolidation of ACPI_COMPANION into the core code.

Tomasz
