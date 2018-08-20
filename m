Return-Path: <SRS0=aAte=LD=gmail.com=hkallweit1@kernel.org>
Return-Path: <SRS0=aAte=LD=gmail.com=hkallweit1@kernel.org>
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: David Miller <davem@davemloft.net>, jian-hong@endlessm.com,
 nic_swsd@realtek.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@endlessm.com, linux-pci@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
References: <20180815062110.16155-1-jian-hong@endlessm.com>
 <20180816.122131.604270853620318143.davem@davemloft.net>
 <458efbf9-5971-653a-e7cd-8c56ba055648@gmail.com>
 <20180816.123958.750435252621963789.davem@davemloft.net>
 <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com>
Date: Mon, 20 Aug 2018 22:46:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 20.08.2018 20:44, Bjorn Helgaas wrote:
> [+cc Marc, Thomas, Christoph, linux-pci)
> (beginning of thread at [1])
> 
> On Thu, Aug 16, 2018 at 09:50:48PM +0200, Heiner Kallweit wrote:
>> On 16.08.2018 21:39, David Miller wrote:
>>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>> Date: Thu, 16 Aug 2018 21:37:31 +0200
>>>
>>>> On 16.08.2018 21:21, David Miller wrote:
>>>>> From: <jian-hong@endlessm.com>
>>>>> Date: Wed, 15 Aug 2018 14:21:10 +0800
>>>>>
>>>>>> Found the ethernet network on ASUS X441UAR doesn't come back on resume
>>>>>> from suspend when using MSI-X.  The chip is RTL8106e - version 39.
>>>>>
>>>>> Heiner, please take a look at this.
>>>>>
>>>>> You recently disabled MSI-X on RTL8168g for similar reasons.
>>>>>
>>>>> Now that we've seen two chips like this, maybe there is some other
>>>>> problem afoot.
>>>>>
>>>> Thanks for the hint. I saw it already and just contacted Realtek
>>>> whether they are aware of any MSI-X issues with particular chip
>>>> versions. With the chip versions I have access to MSI-X works fine.
>>>>
>>>> There's also the theoretical option that the issues are caused by
>>>> broken BIOS's. But so far only chip versions have been reported
>>>> which are very similar, at least with regard to version number
>>>> (2x VER_40, 1x VER_39). So they may share some buggy component.
>>>>
>>>> Let's see whether Realtek can provide some hint.
>>>> If more chip versions are reported having problems with MSI-X,
>>>> then we could switch to a whitelist or disable MSI-X in general.
>>>
>>> It could be that we need to reprogram some register(s) on resume,
>>> which normally might not be needed, and that is what is causing the
>>> problem with some chips.
>>>
>> Indeed. That's what I'm checking with Realtek.
>> In the register list in the r8169 driver there's one entry which
>> seems to indicate that there are MSI-X specific settings.
>> However this register isn't used, and the r8168 vendor driver
>> uses only MSI. And there are no public datasheets.
> 
> Do we have any information about these chip versions in other systems?
> Or other devices using MSI-X in the same ASUS system?  It seems
> possible that there's some PCI core or suspend/resume issue with MSI-X
> and this patch just avoids it without fixing the root cause.
> 
I'm in contact with Realtek and according to them few chip versions
seem to clear MSI-X table entries on resume from suspend. Checking
with them how this could be fixed / worked around.
Worst case we may have to disable MSI-X in general.

> It might be useful to have a kernel.org bugzilla with the complete
> dmesg, "sudo lspci -vv" output, and /proc/interrupts contents archived
> for future reference.
> 
> [1] https://lkml.kernel.org/r/20180815062110.16155-1-jian-hong@endlessm.com
> 
