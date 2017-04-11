Return-Path: <SRS0=u2l1=3T=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=u2l1=3T=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH 3/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models
 30h-3fh) Processors
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-4-git-send-email-deathsimple@vodafone.de>
 <20170324154744.GE25380@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <a1ac66f3-3c3f-e9c6-82c9-6e9ca5715b67@vodafone.de>
Date: Tue, 11 Apr 2017 17:48:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170324154744.GE25380@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 24.03.2017 um 16:47 schrieb Bjorn Helgaas:
> On Mon, Mar 13, 2017 at 01:41:35PM +0100, Christian König wrote:
>> From: Christian König <christian.koenig@amd.com>
>>
>> Most BIOS don't enable this because of compatibility reasons.
> Can you give any more details here?  Without more hints, it's hard to
> know whether any of the compatibility reasons might apply to Linux as
> well.

Unfortunately not, I could try to ask a few more people at AMD if they 
know the background.

I was told that there are a few boards which offers that as a BIOS 
option, but so far I haven't found any (and I have quite a few here).

My best guess is that older windows versions have a problem with that.

>> Manually enable a 64bit BAR of 64GB size so that we have
>> enough room for PCI devices.
>  From the context, I'm guessing this is enabling a new 64GB window
> through the PCI host bridge?

Yes, exactly. Sorry for the confusion.

> That might be documented as a "BAR", but
> it's not anything the Linux PCI core would recognize as a BAR.

At least the AMD NB documentation calls this the host BARs. But I'm 
perfectly fine with any terminology.

How about calling it host bridge window instead?

> I think the specs would envision this being done via an ACPI _SRS
> method on the PNP0A03 host bridge device.  That would be a more
> generic path that would work on any host bridge.  Did you explore that
> possibility?  I would prefer to avoid adding device-specific code if
> that's possible.

I've checked quite a few boards, but none of them actually implements it 
this way.

M$ is working on a new ACPI table to enable this vendor neutral, but I 
guess that will still take a while.

I want to support this for all AMD CPU released in the past 5 years or 
so, so we are going to deal with a bunch of older boards as well.


>> +	pci_bus_add_resource(dev->bus, res, 0);
> We would need some sort of printk here to explain how this new window
> magically appeared.

Good point, consider this done.

But is this actually the right place of doing it? Or would you prefer 
something to be added to the probing code?

I think those fixups are applied a bit later, aren't they?

Best regards,
Christian.
