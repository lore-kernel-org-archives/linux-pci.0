Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-de.keymile.com ([195.8.104.250]:53108 "EHLO
	mail-de.keymile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbaBUI62 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 03:58:28 -0500
Message-ID: <5307152D.3020804@keymile.com>
Date: Fri, 21 Feb 2014 09:58:21 +0100
From: Gerlando Falauto <gerlando.falauto@keymile.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: pci-mvebu driver on km_kirkwood
References: <53039894.10905@keymile.com>	<20140218212751.07c2aeb5@skate>	<53046D98.6020801@keymile.com>	<20140219102658.76eec91e@skate>	<53047BBB.6040108@keymile.com>	<20140219143749.65ff3155@skate>	<CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>	<20140220095518.7ca36f0a@skate>	<20140220173518.GA19893@obsidianresearch.com>	<20140220212914.29ddc031@skate>	<20140221003227.GF19893@obsidianresearch.com> <20140221093444.35870a73@skate>
In-Reply-To: <20140221093444.35870a73@skate>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi guys,

first of all thank you for your support and the explanations.
I'm slowly starting to understand something more about this kind of stuff.

On 02/21/2014 09:34 AM, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
>
> On Thu, 20 Feb 2014 17:32:27 -0700, Jason Gunthorpe wrote:
>
>>> In practice, the story is a little bit more subtle than that: the PCIe
>>> driver may want to decide to either tell the PCI core to enlarge the
>>> window BAR up to the next power of two size, or to dedicate two windows
>>> to it.
>>
>> That is a smart, easy solution! Maybe that is the least invasive way
>> to proceed for now?
>
> So you suggest that the mvebu-mbus driver should accept a
> non power-of-two window size, and do internally the job of cutting that
> into several power-of-two sized areas and creating the corresponding
> windows?
>
>> I have no idea how you decide when to round up and when to allocate
>> more windows, that feels like a fairly complex optimization problem!
>
> Yes, it is a fairly complex problem. I was thinking of a threshold of
> "lost space". Below this threshold, it's better to enlarge the window,
> above the threshold it's better to create two windows. But not easy.
>
>> Alternatively, I suspect you can use the PCI quirk mechanism to alter
>> the resource sizing on a bridge?
>
> Can you give more details about this mechanism, and how it could be
> used to alter the size of resources on a bridge?

I'm not sure I understand all the details... but I guess some sort of 
rounding mechanism is indeed already in place somewhere:

pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xebffffff]
pci 0000:01:00.0: BAR 1: assigned [mem 0xe0000000-0xe7ffffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xe8000000-0xe87fffff]
pci 0000:01:00.0: BAR 4: assigned [mem 0xe8800000-0xe8801fff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe8802000-0xe8802fff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xe8803000-0xe8803fff]
pci 0000:01:00.0: BAR 5: assigned [mem 0xe8804000-0xe8804fff]
pci 0000:00:01.0: PCI bridge to [bus 01]

If you look at the numbers, the total size required by BAR0-5 is 
0x8805000, so around 136MB, that is 128MB+8MB+2K+1K+1K.
This gets rounded up (on this 'virtual' BAR 8) to 192MB (I don't know 
where or why), which is 1.5x a power of two (i.e. two consecutive bits 
followed by all zeroes).

If that's not just a coincidence, finding a coverage subset becomes a 
trivial matter (128MB+64MB).

In any case, even if we have an odd number like the above (0x8805000), I 
believe we could easily find a suboptimal coverage by just taking the 
most significant one and the second most significant one (possibly left 
shifted by 1 if there's a third one somewhere else).
In the above case, that would be 0x8000000 + 0x1000000. That's 
128MB+16MB, which is even smaller than the rounding above (192MB).

What do you think?

Thanks again!
Gerlando

