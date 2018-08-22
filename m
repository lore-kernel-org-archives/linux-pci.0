Return-Path: <SRS0=JUc6=LF=gmail.com=hkallweit1@kernel.org>
Return-Path: <SRS0=JUc6=LF=gmail.com=hkallweit1@kernel.org>
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Miller <davem@davemloft.net>, helgaas@kernel.org,
 jian-hong@endlessm.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@endlessm.com, linux-pci@vger.kernel.org,
 marc.zyngier@arm.com, hch@lst.de
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
 <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com>
 <20180821.123108.89921430801253333.davem@davemloft.net>
 <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com>
 <alpine.DEB.2.21.1808221222260.2514@nanos.tec.linutronix.de>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <36bd086d-8d26-5162-ae24-95b259571221@gmail.com>
Date: Wed, 22 Aug 2018 21:49:56 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808221222260.2514@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 22.08.2018 13:44, Thomas Gleixner wrote:
> On Tue, 21 Aug 2018, Heiner Kallweit wrote:
>> On 21.08.2018 21:31, David Miller wrote:
>>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>> Date: Mon, 20 Aug 2018 22:46:48 +0200
>>>
>>>> I'm in contact with Realtek and according to them few chip versions
>>>> seem to clear MSI-X table entries on resume from suspend. Checking
>>>> with them how this could be fixed / worked around.
>>>> Worst case we may have to disable MSI-X in general.
>>>
>>> I worry that if the chip does this, and somehow MSI-X is enabled and
>>> an interrupt is generated, the chip will write to the cleared out
>>> MSI-X address.  This will either write garbage into memory or cause
>>> a bus error and require PCI error recovery.
>>>
>>> It also looks like your test patch doesn't fix things for people who
>>> have tested it.
>>>
>> The test patch was based on the first info from Realtek which made me
>> think that the base address of the MSI-X table is cleared, what
>> obviously is not the case.
>>
>> After some further tests it seems that the solution isn't as simple
>> as storing the MSI-X table entries on suspend and restore them on
>> resume. On my system (where MSI-X works fine) MSI-X table entries
>> on resume are partially different from the ones on suspend.
> 
> Which is not a surprise. Please don't try to fiddle with that at the driver
> level. The irq and PCI core code are the ones in charge and if you'd
> restore at the wrong point then hell breaks lose.
> 
Instead of spending a lot of effort on a workaround which may not be
acceptable, it may be better to fall back to MSI on all affected chip
versions. For two chip versions which were reported to have this issues
we're doing this already. I asked Realtek whether they have an overview
which chip versions are affected, let's see ..

The Realtek chips provide an alternative, register-based way to access
the MSI-X table, and their Windows driver seems to use it. See here:
https://patchwork.kernel.org/patch/4149171/

But as we handle all MSI-X basics in the PCI core, this isn't an option.


> Can you please do the following:
> 
>  1) Store the PCI config space at suspend time
>  2) Compare the PCI config space at resume time and print the difference
> 
> Do that on a working and a non-working version of Realtek NICs.
> 
> Thanks,
> 
> 	tglx
> 
> 
> 
