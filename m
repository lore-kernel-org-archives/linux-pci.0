Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <55E4340D.6050004@linaro.org>
Date: Mon, 31 Aug 2015 13:01:33 +0200
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>
CC: Will Deacon <Will.Deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
Subject: Re: [PATCH 05/11] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka
 ECAM) and ACPI code out of arch/x86/ directory
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org> <1432644564-24746-6-git-send-email-hanjun.guo@linaro.org> <20150526170817.GU1565@arm.com> <55657B02.5090805@linaro.org> <20150602133215.GC23650@red-moon> <55701A31.808@linaro.org> <20150604102253.GA31773@red-moon> <5570447D.3020705@linaro.org> <557504A2.3060203@linaro.org> <20150608151443.GA16151@red-moon>
In-Reply-To: <20150608151443.GA16151@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08.06.2015 17:14, Lorenzo Pieralisi wrote:
> On Mon, Jun 08, 2015 at 03:57:38AM +0100, Hanjun Guo wrote:
>
> [...]
>
>>>>>>>> Why can't we make use of the ECAM implementation used by
>>>>>>>> pci-host-generic
>>>>>>>> and drivers/pci/access.c?
>>>>>>>
>>>>>>> We had that question when I had posted MMCFG patch set separately,
>>>>>>> please see:
>>>>>>> https://lkml.org/lkml/2015/3/11/492
>>>>>>
>>>>>> Yes, but the real question is, why do we need to have PCI config space
>>>>>> up and running before a bus struct is even created ? I think the
>>>>>> reason is
>>>>>> the PCI configuration address space format (ACPI 6.0, Table 5-27, page
>>>>>> 108):
>>>>>>
>>>>>> "PCI Configuration space addresses must be confined to devices on
>>>>>> PCI Segment Group 0, bus 0. This restriction exists to accommodate
>>>>>> access to fixed hardware prior to PCI bus enumeration".
>>>>>>
>>>>>> On HW reduced platforms I do not even think this is required at all,
>>>>>> we have to look into this to avoid code duplication that might well
>>>>>> turn out useless.
>>>>>
>>>>> This is only for the fixed hardware, which will be not available for
>>>>> ARM64 (reduced hardware mode), but in Generic Hardware Programming
>>>>> Model, we using OEM-provided ACPI Machine Language (AML) code to access
>>>>> generic hardware registers, this will be available for reduced hardware
>>>>> too.
>>>>>
>>>>> So in ACPI spec, it says: (ACPI 6.0 page 66, last paragraph)
>>>>>
>>>>> ACPI defines eight address spaces that may be accessed by generic
>>>>> hardware implementations. These include:
>>>>> * System I/O space
>>>>> * System memory space
>>>>> * PCI configuration space
>>>>> * Embedded controller space
>>>>> * System Management Bus (SMBus) space
>>>>> * CMOS
>>>>> * PCI BAR Target
>>>>> * IPMI space
>>>>>
>>>>> So if any device using the PCI address space for control, such
>>>>> as a system reset control device, its address space can be reside
>>>>> in PCI configuration space (who can prevent a OEM do that crazy
>>>>> thing? :) ), and it should be accessible before the PCI bus is
>>>>> created.
>>>>
>>>> Us, by changing attitude and questioning features whose usefulness
>>>> is questionable. I will look into this and raise the point, I am not
>>>> thrilled by the idea of adding another set of PCI accessor functions
>>>> and drivers because we have to access a register through PCI before
>>>> enumerating the bus (and on arm64 this is totally useless since
>>>> we are not meant to support fixed HW anyway). Maybe we can make acpica
>>>> code use a "special" stub (ACPI specific, PCI configuration space address
>>>> space has restrictions anyway), I have to review this set in its
>>>> entirety to see how to do that (and I would kindly ask you to do
>>>> it too, before saying it is not possible to implement it).
>>>
>>> I'm willing to do that, actually, if we don't need a mechanism to
>>> access PCI config space before the bus is created, the code can be
>>> simplified a lot.
>>
>> After more investigation on the spec and the ACPI core code, I'm
>> still not convinced that accessing to PCI config space before PCI
>> bus creating is impossible, also there is no enough ARM64 hardware
>> to prove that too. But I think we can go in this way, reuse the
>> ECAM implementation by pci-host-generic for now, and implement the PCI
>> accessor functions before enumerating PCI bus when needed in the
>> future, does it make sense?
>
> You mean we rewrite the patch to make sure we can use the PCI host generic
> driver with MCFG and we leave the acpica PCI config call empty stubs on
> arm64 (as they are now) ?
>

Hi Bjorn, Rafael,

Lorenzo pointed out very important problem we are having with PCI config 
space access for ARM64. Please refer to the above discussion and add 
your 2 cents. Can we forget about accessing PCI config space (for 
Hardware Reduced profile) before PCI bus creation? If not, do you see a 
way to use drivers/pci/access.c accessors here, like acpica change? Any 
opinion is very appreciated.

Regards,
Tomasz
