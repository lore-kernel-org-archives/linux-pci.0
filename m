Return-Path: <cov@codeaurora.org>
Return-Path: <cov@codeaurora.org>
Subject: Re: [PATCH V6 0/5] ECAM quirks handling for ARM64 platforms
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <20160920192636.GB4941@localhost>
 <0429663d51ed8e93fb0c96261dd2ecc7@codeaurora.org>
 <20160921131107.GB10804@localhost>
 <304377c6-554d-60ea-30df-006e557c7279@codeaurora.org>
 <20160922230806.GB1514@localhost>
 <e1b1c38f-0779-82a5-5d3c-b164215a4ed3@codeaurora.org>
 <20160923191710.GB16019@localhost>
Cc: Tomasz Nowicki <tn@semihalf.com>, will.deacon@arm.com,
 catalin.marinas@arm.com, rafael@kernel.org, Lorenzo.Pieralisi@arm.com,
 arnd@arndb.de, hanjun.guo@linaro.org, okaya@codeaurora.org,
 jchandra@broadcom.com, dhdang@apm.com, ard.biesheuvel@linaro.org,
 robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com, msalter@redhat.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
 jeremy.linton@arm.com, liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
 jhugo@codeaurora.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <462d5ee7-5e21-b375-09ed-3c5cfd798ae5@codeaurora.org>
Date: Fri, 23 Sep 2016 15:22:19 -0400
MIME-Version: 1.0
In-Reply-To: <20160923191710.GB16019@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 09/23/2016 03:17 PM, Bjorn Helgaas wrote:
> On Fri, Sep 23, 2016 at 02:41:39PM -0400, Christopher Covington wrote:
>> On 09/22/2016 07:08 PM, Bjorn Helgaas wrote:
>>> On Wed, Sep 21, 2016 at 06:40:47PM -0400, Christopher Covington wrote:
>>>> Hi Bjorn,
>>>>
>>>> On 09/21/2016 09:11 AM, Bjorn Helgaas wrote:
>>>>> On Tue, Sep 20, 2016 at 09:15:14PM -0400, cov@codeaurora.org wrote:
>>>>
>>>>>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>>>>>>> index eb14f74..bb3b8ad 100644
>>>>>>> --- a/drivers/acpi/pci_mcfg.c
>>>>>>> +++ b/drivers/acpi/pci_mcfg.c
>>>>>>> @@ -42,86 +42,59 @@ struct mcfg_fixup {
>>>>>>> 	struct resource cfgres;
>>>>>>> };
>>>>>>>
>>>>>>> -#define MCFG_DOM_ANY			(-1)
>>>>>>
>>>>>> Did you delete this because there were no current users, because you'd
>>>>>> prefer users just use "-1", or for some other reason?
>>>>>
>>>>> I removed it because there were no users of it and, more importantly,
>>>>> the code doesn't implement support for it.
>>>>
>>>> It looks like a stale "First match against PCI topology <domain:bus>..."
>>>> comment remains.
>>>
>>> Yep.  I removed the comment since it's sort of obvious from the code.
>>> I also renamed a few things and pulled the match out into a helper
>>> function.
>>>
>>> I also changed the dmesg note: I think the actual resource and the
>>> name of the pci_ecam_ops is more interesting than the table IDs (which
>>> I think are already elsewhere in the dmesg log).
>>
>> It looks like the resource is already being printed from
>> drivers/pci/ecam.c:102.
> 
> Yes, but I want a hint that a quirk has overridden it because that's a
> clue that there's something wonky about the platform or the firmware.
> 
> But I guess it'd be nice to mirror the format of the existing info
> (mem first, then bus range).
> 
>>> Here's the incremental diff, which I can't really test:
>>
>> Here's what it looks like for me:
>>
>> ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-1f])
>> acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
>> acpi PNP0A08:02: _OSC: platform does not support [PCIeHotplug]
>> acpi PNP0A08:02: _OSC: OS now controls [PME AER PCIeCapability]
>> acpi PNP0A08:02: MCFG quirk: ECAM space for [bus 00-1f] at [mem 0xa0000000000-0xa0001ffffff] with pci_3
> 
> Is "pci_3" really the entire name?  If not, what happened to the rest?
> I was hoping for a symbol we could grep for.

The full name is pci_32b_ops. The print overflowed my tmux pane.

>> acpi PNP0A08:02: ECAM at [mem 0xa0000000000-0xa0001ffffff] for [bus 00-1f]
>> Remapped I/O 0x00000affffff0000 to [io  0x10000-0x1ffff window]
>> PCI host bridge to bus 0002:00

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
