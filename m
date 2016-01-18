Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V3 19/21] pci, acpi: Support for ACPI based generic PCI
 host controller init
To: Hanjun Guo <hanjun.guo@linaro.org>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-20-git-send-email-tn@semihalf.com>
 <5698C299.2080702@linaro.org>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <569CB715.7040306@semihalf.com>
Date: Mon, 18 Jan 2016 10:57:41 +0100
MIME-Version: 1.0
In-Reply-To: <5698C299.2080702@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15.01.2016 10:57, Hanjun Guo wrote:
> Hi Tomasz,
>
> On 2016/1/13 21:21, Tomasz Nowicki wrote:
>> Because of two patch series:
>> 1. Jiang Liu's common interface to support PCI host controller init
>> 2. MMCONFIG refactoring (part of this patch set)
>> now we can think about generic ACPI based PCI host controller init
>> implementation out of arch/ directory.
>>
>> These calls use information from MCFG table (PCI config space regions)
>> and _CRS method (IO/irq resources) to initialize PCI hostbridge.
>>
>> TBD: We are still not sure whether we should reassign resources
>> after PCI bus enumeration or trust firmware to do all that work for
>> us properly.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
>> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/Kconfig    |   5 ++
>>   drivers/acpi/pci_root.c | 131
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 136 insertions(+)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index c3664be..e315061 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -335,6 +335,11 @@ config ACPI_PCI_SLOT
>>         i.e., segment/bus/device/function tuples, with physical slots in
>>         the system.  If you are unsure, say N.
>>
>> +config ACPI_PCI_HOST_GENERIC
>> +    bool "Generic ACPI PCI host controller"
>> +    help
>> +      Say Y here if you want to support generic ACPI PCI host
>> controller.
>
> Since x86 and IA64 will not use ACPI_PCI_HOST_GENERIC in this
> patch, it should be defined as
>
> config ACPI_PCI_HOST_GENERIC
>      bool
>
> and select for ARCHs, or will default y on x86 and IA64 too.

Right, I will fix that in v4.

>
> Compiling the kernel on a IA64 machine, will send out the
> result when it's ready.
>

Thanks,
Tomasz
