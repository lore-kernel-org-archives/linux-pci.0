Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
To: Arnd Bergmann <arnd@arndb.de>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <5802577.H74A3Lg5B3@wuerfel> <5638E1CE.9000805@codeaurora.org>
 <3736182.0iiYWufyXZ@wuerfel>
Cc: Tomasz Nowicki <tn@semihalf.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bhelgaas@google.com, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5638F243.2050907@codeaurora.org>
Date: Tue, 3 Nov 2015 12:43:31 -0500
MIME-Version: 1.0
In-Reply-To: <3736182.0iiYWufyXZ@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/3/2015 11:55 AM, Arnd Bergmann wrote:
> On Tuesday 03 November 2015 11:33:18 Sinan Kaya wrote:
>>
>> On 11/3/2015 10:59 AM, Arnd Bergmann wrote:
>>> On Tuesday 03 November 2015 10:10:21 Sinan Kaya wrote:
>>>>
>>>> I don't see anywhere in the SBSA spec addendum that the PCI
>>>> configuration space section that unaligned accesses *MUST* be supported.
>>>>
>>>> If this is required, please have this info added to the spec. I can work
>>>> with the designers for the next chip.
>>>>
>>>> Unaligned access on the current hardware returns incomplete values or
>>>> can cause bus faults. The behavior is undefined.
>>>
>>> Unaligned accesses are not allowed, but any PCI compliant device must
>>> support aligned 1, 2 or 4 byte accesses on its configuration space,
>>> though the byte-enable mechanism. In an ECAM host bridge, those are
>>> mapped to load/store accesses from the CPU with the respective width
>>> and natural alignment.
>>
>> As far as I see, the endpoints do not have any problems with unaligned
>> accesses. It is the host bridge itself (stuff that doesn't get on the
>> PCIe bus and uses traditional AXI kind bus internally) has problems with
>> alignment.
>>
>> If Linux is expecting all HW vendors to implement alignment support,
>> this needs to be put in the SBSA spec as a hard requirement.
>
> As I said, it's not unaligned accesses at all, just 1-byte and aligned
> 2-byte accesses, and it's not Linux mandating this but the PCI
> spec. Please read Russell's email again, it is not possible for PCI
> to work according to the specification unless the host bridge allows
> sub-32-bit accesses.

I'll check back with the hardware designers. Seeing readb/readw/readl 
made me nervous that we are trying unaligned access from any boundaries.

In any case, the hardware document says 32 bit configuration space 
access to the host bridge only. I'll get more clarification.

>
> You can probably work around this by using the legacy I/O port method
> rather than ECAM, if the PCI host bridge itself is functional and just
> the host bus it is connected to is buggy.

 From the sounds of it, we'll need a quirk for config space. We support 
legacy I/O only to make the endpoints happy. Some endpoints do not get 
initialized if they don't have a BAR address assigned to all the BAR 
resources.

I just saw David Daney's email. I like his idea. I think this chip will 
fit into the same category.

>
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
