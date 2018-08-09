Return-Path: <SRS0=sP6C=KY=gmail.com=mr.nuke.me@kernel.org>
Return-Path: <SRS0=sP6C=KY=gmail.com=mr.nuke.me@kernel.org>
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex_Gagniuc@Dellteam.com, bhelgaas@google.com, keith.busch@intel.com,
 Austin.Bolen@dell.com, Shyam.Iyer@dell.com, fred@fredlawl.com,
 poza@codeaurora.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <20180809141551.GH49411@bhelgaas-glaptop.roam.corp.google.com>
 <2cae6a5ac8324be18b8dcf3d7dfcc288@ausx13mps321.AMER.DELL.COM>
 <20180809182905.GA113140@bhelgaas-glaptop.roam.corp.google.com>
 <d235e71d-647f-00d1-8a21-2784b7939c25@gmail.com>
 <20180809191832.GC113140@bhelgaas-glaptop.roam.corp.google.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <cb5bc2ce-d55f-bd39-55fb-177c6cd6c05f@gmail.com>
Date: Thu, 9 Aug 2018 14:42:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180809191832.GC113140@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 08/09/2018 02:18 PM, Bjorn Helgaas wrote:
> On Thu, Aug 09, 2018 at 02:00:23PM -0500, Alex G. wrote:
>> On 08/09/2018 01:29 PM, Bjorn Helgaas wrote:
>>> On Thu, Aug 09, 2018 at 04:46:32PM +0000, Alex_Gagniuc@Dellteam.com wrote:
>>>> On 08/09/2018 09:16 AM, Bjorn Helgaas wrote:
>> (snip_
>>>>>      enable_ecrc_checking()
>>>>>      disable_ecrc_checking()
>>>>
>>>> I don't immediately see how this would affect FFS, but the bits are part
>>>> of the AER capability structure. According to the FFS model, those would
>>>> be owned by FW, and we'd have to avoid touching them.
>>>
>>> Per ACPI v6.2, sec 18.3.2.4, the HEST may contain entries for Root
>>> Ports that contain the FIRMWARE_FIRST flag as well as values the OS is
>>> supposed to write to several AER capability registers.  It looks like
>>> we currently ignore everything except the FIRMWARE_FIRST and GLOBAL
>>> flags (ACPI_HEST_FIRMWARE_FIRST and ACPI_HEST_GLOBAL in Linux).
>>>
>>> That seems like a pretty major screwup and more than I want to fix
>>> right now.
>>
>> The logic is not very clear, but I think it goes like this:
>> For GLOBAL and FFS, disable native AER everywhere.
>> When !GLOBAL and FFS, then only disable native AER for the root port
>> described by the HEST entry.
> 
> I agree the code is convoluted, but that sounds right to me.
> 
> What I meant is that we ignore the values the HEST entry tells us
> we're supposed to write to Device Control and the AER Uncorrectable
> Error Mask, Uncorrectable Error Severity, Correctable Error Mask, and
> AER Capabilities and Control.

Wait, what? _HPX has the same information. This is madness!
Since root ports are not hot-swappable, the BIOS normally programs those 
registers. Even if linux doesn't apply said masks, the programming BIOS 
did should be sufficient to have *cough* correct *cough* behavior.

>>>> For practical considerations this is not an issue today. The ACPI error
>>>> handling code currently crashes when it encounters any fatal error, so
>>>> we wouldn't hit this in the FFS case.
>>>
>>> I wasn't aware the firmware-first path was *that* broken.  Are there
>>> problem reports for this?  Is this a regression?
>>
>> It's been like this since, I believe, 3.10, and probably much earlier. All
>> reports that I have seen of linux crashing on surprise hot-plug have been
>> caused by the panic() call in the apei code. Dell BIOSes do an extreme
>> amount of work to determine when it's safe to _not_ report errors to the OS,
>> since all known OSes crash on this path.
> 
> Oh, is this the __ghes_panic() path?  If so, I'm going to turn away
> and plead ignorance unless the PCI core is doing something wrong that
> eventually results in that panic.

I agree, and I'll quote you on that!

Alex
