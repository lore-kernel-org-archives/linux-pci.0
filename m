Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <556ECA93.7040800@linux.intel.com>
Date: Wed, 03 Jun 2015 17:36:19 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"x86 @ kernel . org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Patch v4 5/8] ARM64/PCI/ACPI: Introduce struct pci_controller
 for ACPI
References: <1433225576-8215-1-git-send-email-jiang.liu@linux.intel.com> <1433225576-8215-6-git-send-email-jiang.liu@linux.intel.com> <20150602093525.GA23543@red-moon> <556EBE6D.90907@linaro.org>
In-Reply-To: <556EBE6D.90907@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/3 16:44, Hanjun Guo wrote:
> On 2015年06月02日 17:35, Lorenzo Pieralisi wrote:
>> On Tue, Jun 02, 2015 at 07:12:53AM +0100, Jiang Liu wrote:
>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>
>>> ARM64 ACPI based PCI host bridge init needs a arch dependent
>>> struct pci_controller to accommodate common PCI host bridge
>>> code which is introduced later, or it will lead to compile
>>> errors on ARM64.
>>>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>> CC: Arnd Bergmann <arnd@arndb.de>
>>> CC: Catalin Marinas <catalin.marinas@arm.com>
>>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
>>> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>>> CC: Will Deacon <will.deacon@arm.com>
>>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>>> ---
>>>   arch/arm64/include/asm/pci.h |   10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
>>> index b008a72f8bc0..70884957f253 100644
>>> --- a/arch/arm64/include/asm/pci.h
>>> +++ b/arch/arm64/include/asm/pci.h
>>> @@ -10,6 +10,16 @@
>>>   #include <asm-generic/pci-bridge.h>
>>>   #include <asm-generic/pci-dma-compat.h>
>>>
>>> +struct acpi_device;
>>> +
>>> +struct pci_controller {
>>> +#ifdef CONFIG_ACPI
>>> +    struct acpi_device *companion;    /* ACPI companion device */
>>> +#endif
>>> +    int        segment;    /* PCI domain */
>>> +    int        node;        /* NUMA node */
>>> +};
>>
>> There is nothing ARM64 specific in this structure. The only
>> reason I see you want to keep it arch specific is the iommu
>> pointer on x86,
> 
> And also plarform_data for IA64 too.
> 
>> but I think we should find a way to make
>> the common bits shared across archs (ie the struct above) and
>> add (maybe a void*) to the generic struct to cater for arch
>> specific data.
>>
>> Thoughts ?
> 
> We discussed this already, it has limitations to make it
> common to all archs, I think the limitation are:
> 
>   - struct pci_controller are also used for other archs
>     such as PowerPC and Tile, they will not use it for
>     ACPI purpose, so we can not used for all archs.
> 
>   - if we let struct pci_controller defined only for archs
>     using ACPI, such as introduce it in linux/acpi.h, we still
>     can not satisfy that the struct pci_controller is not
>     only used for ACPI case on x86, it will be used for
>     non-ACPI too.
> 
> So it's pretty difficult to share it with across archs to me,
> any more ideas?
Hi Hanjun and Lorenzo,
	As mentioned by Hanjun, I have no idea yet about how to
consolidating "struct pci_controller" further. One possible
way is to move "struct pci_controller" related code into
arch, but apparently that will reduce code reusing.
Thanks!
Gerry

> 
> Thanks
> Hanjun
