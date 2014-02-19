Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:48267 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002AbaBSVqJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 16:46:09 -0500
Received: by mail-ie0-f170.google.com with SMTP id rl12so698864iec.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2014 13:46:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140219143749.65ff3155@skate>
References: <51DD88A4.1030506@keymile.com> <20130710185706.72b124a4@skate>
 <51DD9A8C.10608@keymile.com> <20130711163220.2b3adf38@skate>
 <53039894.10905@keymile.com> <20140218212751.07c2aeb5@skate>
 <53046D98.6020801@keymile.com> <20140219102658.76eec91e@skate>
 <53047BBB.6040108@keymile.com> <20140219143749.65ff3155@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Feb 2014 14:45:48 -0700
Message-ID: <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
Subject: Re: pci-mvebu driver on km_kirkwood
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gerlando Falauto <gerlando.falauto@keymile.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 19, 2014 at 6:37 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Gerlando, Bjorn,
>
> Bjorn, I added you as the To: because there is a PCI related question
> for you below :)
>
> On Wed, 19 Feb 2014 10:39:07 +0100, Gerlando Falauto wrote:
>
>> spoiler first: SUCCESS!!!!
>
> Awesome :)
>
>> > I'm obviously interested in seeing the message that gets shown, as well
>> > as the new mvebu-mbus debugfs output.
>>
>> ----------
>> pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xebffffff]
>> PCIE 0.0: creating window at 0xe0000000, size 0xbffffff rounded up to
>> 0x10000000
>
> Right, rounding from 192 MB to 265 MB.
>
>>   cat /sys/kernel/debug/mvebu-mbus/devices
>> [00] disabled
>> [01] disabled
>> [02] disabled
>> [03] disabled
>> [04] 00000000ff000000 - 00000000ff010000 : nand
>> [05] 00000000f4000000 - 00000000f8000000 : vpcie
>> [06] 00000000fe000000 - 00000000fe010000 : dragonite
>> [07] 00000000e0000000 - 00000000f0000000 : pcie0.0
>>
>> > For good measure, if you could also dump the registers of the PCIe
>> > window. In your case, it was window 7, so dumping 0xf1020070 and
>> > 0xf1020074 would be useful.
>>
>> Isn't that where the output of debugfs comes from?
>
> It is, but the mvebu-mbus is interpreting the sequence of 1s and 0s to
> give the real size, and this involves a little bit of magic of bit
> manipulation, which I wanted to check by having a look at the raw
> values of the registers.
>
>> > I am not sure, but since we are configuring an invalid memory size,
>> > maybe the MBus behavior is undefined, and we get some completely funky
>> > behavior, where parts of the 192 MB window are actually work, but parts
>> > of it are not.
>>
>> And... Ladies and gentlemen... it turns out YOU'RE RIGHT!!!
>> With your patch now everything works fine!!!
>>
>> No words (or quads, for that matter) can express how grateful I am! ;-)
>
> Cool. However, I am not sure my fix is really correct, because is you
> had another PCIe device that needed 64 MB of memory space, the PCIe
> core would have allocated addresses 0xec000000 -> 0xf0000000 to it,
> which would have conflicted with the forced "power of 2 up-rounding"
> we've applied on the memory space of the first device.
>
> Therefore, I believe this constraint should be taken into account by
> the PCIe core when allocating the different memory regions for each
> device.
>
> Bjorn, the mvebu PCIe host driver has the constraint that the I/O and
> memory regions associated to each PCIe device of the emulated bridge
> have a size that is a power of 2.
>
> I am currently using the ->align_resource() hook to ensure that the
> start address of the resource matches certain other constraints, but I
> don't see a way of telling the PCI core that I need the resource to
> have its size rounded up to the next power of 2 size. Is there a way of
> doing this?
>
> In the case described by Gerlando, the PCI core has assigned a 192 MB
> region, but the Marvell hardware can only create windows that have a
> power of two size, i.e 256 MB. Therefore, the PCI core should be told
> this constraint, so that it doesn't allocate the next resource right
> after the 192 MB one.

I'm not sure I understand this correctly, but I *think* this 192 MB
region that gets rounded up to 256 MB because of the Marvell
constraint is a host bridge aperture.  If that's the case, it's
entirely up to you (the host bridge driver author) to round it as
needed before passing it to pci_add_resource_offset().

The PCI core will never allocate any space that is outside the host
bridge apertures.

But maybe I don't understand your situation well enough.

Bjorn
