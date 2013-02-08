Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:47183 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759778Ab3BHEWS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 23:22:18 -0500
Received: by mail-oa0-f44.google.com with SMTP id h1so3674434oag.31
        for <linux-pci@vger.kernel.org>; Thu, 07 Feb 2013 20:22:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130207165009.73b1f340@skate>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <2776630.gp5gC9tvLk@wuerfel> <20130131180249.GA30869@obsidianresearch.com>
 <201301312046.22560.arnd@arndb.de> <20130131224459.GA11846@obsidianresearch.com>
 <20130206175128.1b64196d@skate> <20130206170903.GA28198@obsidianresearch.com>
 <20130206181852.4eca53e3@skate> <20130206175019.GA24248@obsidianresearch.com> <20130207165009.73b1f340@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 7 Feb 2013 21:21:57 -0700
Message-ID: <CAErSpo7hwG89LTO+4+eqT_Gb+yUn1XKHYJ8CnnZcf_FPo-Kpyw@mail.gmail.com>
Subject: Re: Giving special alignment/size constraints to the Linux PCI core?
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 7, 2013 at 8:50 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Bjorn,
>
> I guess I need your advice on the below problem, but here is a summary.
>
> Basically, the PCI-to-PCI bridge specifications require that the memory
> address assigned to a PCI-to-PCI bridge is aligned on a 1 MB boundary.
>
> Unfortunately, on Marvell hardware, we can only create address decoding
> windows that are aligned on a multiple of their size (a 1 MB window
> must be 1 MB aligned, a 2 MB window must be 2 MB aligned, etc.).
>
> How can we teach the Linux PCI core about this requirement, so that it
> does a proper assignment of addresses at the PCI-to-PCI bridge level?
> For the I/O addresses, Russell suggested the pcibios_window_alignment()
> hook, but it doesn't receive the size of the resource, so we can't
> determine what alignment is needed.
>
> As Jason points out below, we need to be able to tell the PCI core that
> a given memory area needs some alignment, but also that its size is
> larger than what the PCIe device claims, because we cannot create
> address decoding windows of an arbitrary size. For example, an address
> decoding window of 3 MB is not possible, so if a device wants 3 MB,
> then we would need to extend this memory area to 4 MB so that the next
> device doesn't get an address decoding window that overlaps with the
> previous one.
>
> I was hoping that the emulated PCI-to-PCI bridge could, by its
> behavior, teach the Linux PCI core about these special constraints.
> However, reading the PCI-to-PCI bridge specification, I don't see how
> to achieve that.
>
> Do you have some suggestions?

Huh.  That hardware looks less and less like a P2P bridge all the time
:(  You can't configure it via standard PCI config accesses, and the
aperture alignment and size constraints sound completely non-standard.
 Are the specs for this thing public?

I could imagine changing pcibios_window_alignment() to take the
resource, so it could deal with the alignment question (though I
haven't looked in detail and there might be some implementation issue
with that).

With regard to the size issue (3MB window using 4MB of address space),
I can't think of a reasonable way to teach the PCI core about both
sizes.  But is there any reason to program the bridge for a 3MB window
instead of a 4MB window, given that there's nothing else we can do
with the extra 1MB anyway?  Is a 3MB window even possible?  I would
think something that must be aligned on its size would be restricted
to power-of-2 sizes anyway, just like PCI BARs are.  Maybe you can
just always round up window sizes to a power of 2?

Bjorn

> On Wed, 6 Feb 2013 10:50:19 -0700, Jason Gunthorpe wrote:
>
>> > > > Can't this be solved using the window_alignement() hook we've
>> > > > been discussing separately? Just like we teach the Linux PCI
>> > > > core about our alignment requirements of 64K for the I/O
>> > > > regions, we could teach it about our alignment requirement on
>> > > > memory regions as well. No?
>> > >
>> > > Hopefully :) As long as it can adjust the start and length you
>> > > should be fine.
>> >
>> > Why would you need to adjust the length? If Linux allocates a 2 MB
>> > resource on a 1 MB boundary, we simply increase the start address to
>> > the next 2 MB boundary, and that's it. Why would the length need to
>> > change?
>>
>> Well, lets say 3MB is the example. A 3mb region needs to fit inside a
>> 4mb MBUS window. If you align the start to 4mb then the pci-e core
>> needs to know that it can't use the extra 1mb covered by the mbus
>> window. mbus windows must not overlap.
>>
>> Adjusting the bridge window length to be 4mb communicates that dead
>> space to the PCI core, and presumably this shows up in lspci and
>> whatnot.
>>
>> I suppose if you align the end to 4mb (thus creating the gap before,
>> not after) things should work out OK, but the information that the gap
>> is routed to a specific PCI link is lost..
>>
>> Jason
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
