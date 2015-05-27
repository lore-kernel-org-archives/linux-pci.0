Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5565AA8D.1090702@linux.intel.com>
Date: Wed, 27 May 2015 19:29:17 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Liviu Dudau <Liviu.Dudau@arm.com>
CC: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
Subject: Re: [PATCH 01/11] ARM64 / PCI: introduce struct pci_controller for
 ACPI
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org> <1432644564-24746-2-git-send-email-hanjun.guo@linaro.org> <20150526165844.GD2175@e106497-lin.cambridge.arm.com> <5564AB68.6080502@linux.intel.com> <20150527094702.GE2175@e106497-lin.cambridge.arm.com>
In-Reply-To: <20150527094702.GE2175@e106497-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/27 17:47, Liviu Dudau wrote:
> On Tue, May 26, 2015 at 06:20:40PM +0100, Jiang Liu wrote:
>> On 2015/5/27 0:58, Liviu Dudau wrote:
>>> On Tue, May 26, 2015 at 01:49:14PM +0100, Hanjun Guo wrote:
>>>> ARM64 ACPI based PCI host bridge init needs a arch dependent
>>>> struct pci_controller to accommodate common PCI host bridge
>>>> code which is introduced later, or it will lead to compile
>>>> errors on ARM64.
>>>
>>> Hi Hanjun,
>>>
>>> Two questions: why don't you introduce this patch next to the
>>> one that is going to make use of it (or even merge it there)?
>>> Second, why is the whole struct pci_controller not surrounded
>>> by #ifdef CONFIG_ACPI as you are implying that this is needed
>>> only for ACPI?
>>>
>>> Btw, looking through the whole series I'm not (yet) convinced
>>> that this is needed at all.
>> Hi Liviu,
>> 	This structure is required by the requested patch set
>> at http://patchwork.ozlabs.org/patch/472249/, which consolidates
>> the common code to support PCI host bridge into ACPI core.
>> Thanks!
>> Gerry
> 
> Hi Jiang,
> 
> Thanks for pointing me on the right answer, I've missed that series!
> Probably not the best place to comment on that series here, but I
> wonder why did you not made the pci_controller structure available
> in a more generic header file that can be included so that arches
> don't have to redefine the structure every time. After all, you are
> trying to consolidate things.
> 
> Oh, and pci_controller name throws a lot of false negatives, maybe
> a more specific one (acpi_pci_controller?) would make things clear?
Hi Liviu,
	It's a trade-off. Once I tried to rename it too, but gave up
later. There are several reasons to keep it as is:
1) Several architectures define pci_controller to support PCI
   root bus.
2) struct pci_controller is a generic concept, I guess, and ACPI code
   extends pci_controller to host some ACPI specific data on IA64 and
   x86.
3) It will cause big code changes if we rename pci_controller to
   something else.
Thanks!
Gerry

> 
> Best regards,
> Liviu
> 
>>
>>>
>>> Best regards,
>>> Liviu
>>>
>>>>
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>>> CC: Arnd Bergmann <arnd@arndb.de>
>>>> CC: Catalin Marinas <catalin.marinas@arm.com>
>>>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
>>>> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>>>> CC: Will Deacon <will.deacon@arm.com>
>>>> ---
>>>>  arch/arm64/include/asm/pci.h | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
>>>> index b008a72..7088495 100644
>>>> --- a/arch/arm64/include/asm/pci.h
>>>> +++ b/arch/arm64/include/asm/pci.h
>>>> @@ -10,6 +10,16 @@
>>>>  #include <asm-generic/pci-bridge.h>
>>>>  #include <asm-generic/pci-dma-compat.h>
>>>>  
>>>> +struct acpi_device;
>>>> +
>>>> +struct pci_controller {
>>>> +#ifdef CONFIG_ACPI
>>>> +	struct acpi_device *companion;	/* ACPI companion device */
>>>> +#endif
>>>> +	int		segment;	/* PCI domain */
>>>> +	int		node;		/* NUMA node */
>>>> +};
>>>> +
>>>>  #define PCIBIOS_MIN_IO		0x1000
>>>>  #define PCIBIOS_MIN_MEM		0
>>>>  
>>>> -- 
>>>> 1.9.1
>>>>
>>>
>>
> 
