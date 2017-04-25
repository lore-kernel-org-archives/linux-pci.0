Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH 3/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models
 30h-3fh) Processors
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-4-git-send-email-deathsimple@vodafone.de>
 <20170324154744.GE25380@bhelgaas-glaptop.roam.corp.google.com>
 <a1ac66f3-3c3f-e9c6-82c9-6e9ca5715b67@vodafone.de>
 <20170412165530.GE25197@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <de846814-5884-69a5-3eb6-fec5c5c6896d@vodafone.de>
Date: Tue, 25 Apr 2017 15:01:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170412165530.GE25197@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 12.04.2017 um 18:55 schrieb Bjorn Helgaas:
> [SNIP]
>>> I think the specs would envision this being done via an ACPI _SRS
>>> method on the PNP0A03 host bridge device.  That would be a more
>>> generic path that would work on any host bridge.  Did you explore that
>>> possibility?  I would prefer to avoid adding device-specific code if
>>> that's possible.
>> I've checked quite a few boards, but none of them actually
>> implements it this way.
>>
>> M$ is working on a new ACPI table to enable this vendor neutral, but
>> I guess that will still take a while.
>>
>> I want to support this for all AMD CPU released in the past 5 years
>> or so, so we are going to deal with a bunch of older boards as well.
> I've never seen _SRS for host bridges either.  I'm curious about what
> sort of new table will be proposed.  It seems like the existing ACPI
> resource framework could manage it, but I certainly don't know all the
> issues.

No idea either since I'm not involved into that. My job is to get it 
working on the existing hw generations and that alone is enough work :)

My best guess is that MS is going to either make _SRS on the host bridge 
or a pre-configured 64bit window mandatory for the BIOS.

>>>> +	pci_bus_add_resource(dev->bus, res, 0);
>>> We would need some sort of printk here to explain how this new window
>>> magically appeared.
>> Good point, consider this done.
>>
>> But is this actually the right place of doing it? Or would you
>> prefer something to be added to the probing code?
>>
>> I think those fixups are applied a bit later, aren't they?
> Logically, this should be done before we enumerate the PCI devices
> below the host bridge, so a PCI device fixup is not the ideal place
> for it, but it might be the most practical.

Since the modification must be done on a device connected to the root 
bus I run into quite a chicken and egg problem if I try to do it before 
the enumeration.

> I could imagine some sort of quirk like the ones in
> drivers/pnp/quirks.c that could add the window to the host bridge _CRS
> and program the bridge to open it.  But the PCI host bridges aren't
> handled through the path that applies those fixups, and it would be
> messy to identify your bridges (you currently use PCI vendor/device
> IDs, which are only available after enumerating the device).  So this
> doesn't seem like a viable strategy.

I've tried that, but gave up rather quickly. Looks like the current 
approach indeed work find even with "pci=realloc", so I'm going to stick 
with that.

Regards,
Christian.
