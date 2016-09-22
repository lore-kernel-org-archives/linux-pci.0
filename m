Return-Path: <cov@codeaurora.org>
Return-Path: <cov@codeaurora.org>
Subject: Re: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific
 register range for ACPI case
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <1473449047-10499-4-git-send-email-tn@semihalf.com>
 <20160919180900.GB13775@localhost>
 <49f53bfc-4421-a8b0-694c-bce7e61e1c9e@semihalf.com>
 <20160920133327.GB13855@localhost>
 <CAKv+Gu-AE7fft_j2cqBCN=xrsf5Yh=mePf5x3dZJuKAmdxF-Gg@mail.gmail.com>
 <20160920140518.GD13855@localhost>
 <CAKv+Gu-j-gKiNMx-TvSxezJth1619FN8W1rAy7DKpkmfX9ii6A@mail.gmail.com>
 <20160920191744.GA4941@localhost> <20160921140549.GA11968@red-moon>
 <20160921180457.GB20006@localhost> <20160922094955.GB18637@red-moon>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Tomasz Nowicki <tn@semihalf.com>, David Daney <ddaney@caviumnetworks.com>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>,
 Sinan Kaya <okaya@codeaurora.org>, Jayachandran C <jchandra@broadcom.com>,
 Duc Dang <dhdang@apm.com>, Robert Richter
 <robert.richter@caviumnetworks.com>, Marcin Wojtas <mw@semihalf.com>,
 Liviu Dudau <Liviu.Dudau@arm.com>, Yijing Wang <wangyijing@huawei.com>,
 Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 Jon Masters <jcm@redhat.com>, Andrea Gallo <andrea.gallo@linaro.org>,
 Jeremy Linton <jeremy.linton@arm.com>, Dongdong Liu
 <liudongdong3@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jeff Hugo <jhugo@codeaurora.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <e7887f62-a719-e2fc-afa2-d03e6ac5ef17@codeaurora.org>
Date: Thu, 22 Sep 2016 10:20:45 -0400
MIME-Version: 1.0
In-Reply-To: <20160922094955.GB18637@red-moon>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 09/22/2016 05:49 AM, Lorenzo Pieralisi wrote:
> On Wed, Sep 21, 2016 at 01:04:57PM -0500, Bjorn Helgaas wrote:
>> On Wed, Sep 21, 2016 at 03:05:49PM +0100, Lorenzo Pieralisi wrote:
>>> On Tue, Sep 20, 2016 at 02:17:44PM -0500, Bjorn Helgaas wrote:
>>>> On Tue, Sep 20, 2016 at 04:09:25PM +0100, Ard Biesheuvel wrote:
>>>
>>> [...]
>>>
>>>>> None of these platforms can be fixed entirely in software, and given
>>>>> that we will not be adding quirks for new broken hardware, we should
>>>>> ask ourselves whether having two versions of a quirk, i.e., one for
>>>>> broken hardware + currently shipping firmware, and one for the same
>>>>> broken hardware with fixed firmware is really an improvement over what
>>>>> has been proposed here.
>>>>
>>>> We're talking about two completely different types of quirks:
>>>>
>>>>   1) MCFG quirks to use memory-mapped config space that doesn't quite
>>>>      conform to the ECAM model in the PCIe spec, and
>>>>
>>>>   2) Some yet-to-be-determined method to describe address space
>>>>      consumed by a bridge.
>>>>
>>>> The first two patches of this series are a nice implementation for 1).
>>>> The third patch (ThunderX-specific) is one possibility for 2), but I
>>>> don't like it because there's no way for generic software like the
>>>> ACPI core to discover these resources.
>>>
>>> Ok, so basically this means that to implement (2) we need to assign
>>> some sort of _HID to these quirky PCI bridges (so that we know what
>>> device they represent and we can retrieve their _CRS). I take from
>>> this discussion that the goal is to make sure that all non-config
>>> resources have to be declared through _CRS device objects, which is
>>> fine but that requires a FW update (unless we can fabricate ACPI
>>> devices and corresponding _CRS in the kernel whenever we match a
>>> given MCFG table signature).
>>
>> All resources consumed by ACPI devices should be declared through
>> _CRS.  If you want to fabricate ACPI devices or _CRS via kernel
>> quirks, that's fine with me.  This could be triggered via MCFG
>> signature, DMI info, host bridge _HID, etc.
> 
> I think the PNP quirk approach + PNP0c02 resource put forward by Gab
> is enough.
> 
>>> We discussed this already and I think we should make a decision:
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/414722.html
>>>
>>>>>> I'd like to step back and come up with some understanding of how
>>>>>> non-broken firmware *should* deal with this issue.  Then, if we *do*
>>>>>> work around this particular broken firmware in the kernel, it would be
>>>>>> nice to do it in a way that fits in with that understanding.
>>>>>>
>>>>>> For example, if a companion ACPI device is the preferred solution, an
>>>>>> ACPI quirk could fabricate a device with the required resources.  That
>>>>>> would address the problem closer to the source and make it more likely
>>>>>> that the rest of the system will work correctly: /proc/iomem could
>>>>>> make sense, things that look at _CRS generically would work (e.g,
>>>>>> /sys/, an admittedly hypothetical "lsacpi", etc.)
>>>>>>
>>>>>> Hard-coding stuff in drivers is a point solution that doesn't provide
>>>>>> any guidance for future platforms and makes it likely that the hack
>>>>>> will get copied into even more drivers.
>>>>>>
>>>>>
>>>>> OK, I see. But the guidance for future platforms should be 'do not
>>>>> rely on quirks', and what I am arguing here is that the more we polish
>>>>> up this code and make it clean and reusable, the more likely it is
>>>>> that will end up getting abused by new broken hardware that we set out
>>>>> to reject entirely in the first place.
>>>>>
>>>>> So of course, if the quirk involves claiming resources, let's make
>>>>> sure that this occurs in the cleanest and most compliant way possible.
>>>>> But any factoring/reuse concerns other than for the current crop of
>>>>> broken hardware should be avoided imo.
>>>>
>>>> If future hardware is completely ECAM-compliant and we don't need any
>>>> more MCFG quirks, that would be great.
>>>
>>> Yes.
>>>
>>>> But we'll still need to describe that memory-mapped config space
>>>> somewhere.  If that's done with PNP0C02 or similar devices (as is done
>>>> on my x86 laptop), we'd be all set.
>>>
>>> I am not sure I understand what you mean here. Are you referring
>>> to MCFG regions reported as PNP0c02 resources through its _CRS ?
>>
>> Yes.  PCI Firmware Spec r3.0, Table 4-2, note 2 says address ranges
>> reported via MCFG or _CBA should be reserved by _CRS of a PNP0C02
>> device.
> 
> Ok, that's agreed. It goes without saying that since you are quoting
> the PCI spec, if FW fails to report MCFG regions in a PNP0c02 device
> _CRS I will consider that a FW bug.
> 
>>> IIUC PNP0C02 is a reservation mechanism, but it does not help us
>>> associate its _CRS to a specific PCI host bridge instance, right ?
>>
>> Gab proposed a hierarchy that *would* associate a PNP0C02 device with
>> a PCI bridge:
>>
>>   Device (PCI1) {
>>     Name (_HID, "HISI0080") // PCI Express Root Bridge
>>     Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
>>     Method (_CRS, 0, Serialized) { // Root complex resources (windows) }
>>     Device (RES0) {
>>       Name (_HID, "HISI0081") // HiSi PCIe RC config base address
>>       Name (_CID, "PNP0C02")  // Motherboard reserved resource
>>       Name (_CRS, ResourceTemplate () { ... }
>>     }
>>   }
>>
>> That's a possibility.  The PCI Firmware Spec suggests putting RES0 at
>> the root (under \_SB), but I don't know why.
>>
>> Putting it at the root means we couldn't generically associate it with
>> a bridge, although I could imagine something like this:
>>
>>   Device (RES1) {
>>     Name (_HID, "HISI0081") // HiSi PCIe RC config base address
>>     Name (_CID, "PNP0C02")  // Motherboard reserved resource
>>     Name (_CRS, ResourceTemplate () { ... }
>>     Method (BRDG) { "PCI1" }  // hand-wavy ASL
>>   }
>>   Device (PCI1) {
>>     Name (_HID, "HISI0080") // PCI Express Root Bridge
>>     Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
>>     Method (_CRS, 0, Serialized) { // Root complex resources (windows) }
>>   }
>>
>> Where you could search PNP0C02 devices for a cookie that matched the
>> host bridge.o
> 
> Ok, I am fine with both and I think we are converging, but the way
> to solve this problem has to be uniform for all ARM partners (and
> not only ARM). Two points here:
> 
> 1) Adding a device/subdevice allows people to add a _CRS reporting the
>    non-window bridge resources. Fine. It also allows people to chuck in
>    there all sorts of _DSD properties to describe their PCI host bridge
>    as it is done with DT properties (those _DSD can contain eg clocks
>    etc.), this may be tempting (so that they can reuse the same DT
>    driver and do not have to update their firmware) but I want to be
>    clear here: that must not happen. So, a subdevice with a _CRS to
>    report resources, yes, but it will stop there.
> 2) It is unclear to me how to formalize the above. People should not
>    write FW by reading the PCI mailing list, so these guidelines have to
>    be written, somehow. I do not want to standardize quirks, I want
>    to prevent random ACPI table content, which is different.
>    Should I report this to the ACPI spec working group ? If we do
>    not do that everyone will go solve this problem as they deem fit.

Could you add some checks to fwts?

Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
