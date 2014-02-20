Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60247 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751834AbaBTU3V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 15:29:21 -0500
Date: Thu, 20 Feb 2014 21:29:14 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
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
Message-ID: <20140220212914.29ddc031@skate>
In-Reply-To: <20140220173518.GA19893@obsidianresearch.com>
References: <51DD9A8C.10608@keymile.com>
	<20130711163220.2b3adf38@skate>
	<53039894.10905@keymile.com>
	<20140218212751.07c2aeb5@skate>
	<53046D98.6020801@keymile.com>
	<20140219102658.76eec91e@skate>
	<53047BBB.6040108@keymile.com>
	<20140219143749.65ff3155@skate>
	<CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
	<20140220095518.7ca36f0a@skate>
	<20140220173518.GA19893@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Thu, 20 Feb 2014 10:35:18 -0700, Jason Gunthorpe wrote:
> On Thu, Feb 20, 2014 at 09:55:18AM +0100, Thomas Petazzoni wrote:
> 
> > Does that make sense? Keep in mind that I'm still not completely
> > familiar with the PCI terminology, so maybe the above explanation does
> > not use the right terms.
> 
> Stated another way, the Marvel PCI-E to PCI-E bridge config space has
> a quirk that requires the window BARs to be aligned on their size and
> sized to a power of 2.

Correct.

> The first requirement is already being handled by hooking through
> ARM's 'align_resource' callback.

Absolutely.

> One avenue would be to have mvebu_pcie_align_resource return a struct
> resource and manipulate the size as well. Assuming the PCI core will
> accommodate that.

That would effectively be the easiest solution from the point of view
of the PCIe driver.

In practice, the story is a little bit more subtle than that: the PCIe
driver may want to decide to either tell the PCI core to enlarge the
window BAR up to the next power of two size, or to dedicate two windows
to it.

For example:

 * If the PCI core allocates a 96 KB BAR, we clearly want it to be
   enlarged to 128 KB, so that we have to create a single window for it.

 * However, if the PCI core allocates a 192 MB BAR, we may want to
   instead create two windows: a first one of 128 MB and a second one
   of 64 MB. This consumes two windows, but saves 64 MB of physical
   address space.

(Note that I haven't tested myself the creation of two windows for the
same target device, but I was told by Lior that it should work).

As you can see from the two examples above, we may not necessarily want
to enforce this power-of-two constraint in all cases. We may want to
accept a non-power-of-2 size in the case of the 192 MB BAR, and let the
mvebu-mbus driver figure out that it should allocate several
consecutive windows to cover these 192 MB.

But to begin with, rounding up all window BARs up to the next power of
two size would be perfectly OK.

Jason, would you mind maybe replying to Bjorn Helgaas email (Thu, 20
Feb 2014 12:18:42 -0700) ? I believe that a lot of the misunderstanding
between Bjorn and me is due to the fact that I don't use the correct
PCI terminology to describe how the Marvell hardware works, and how the
Marvell PCIe driver copes with it. I'm sure you would explain it in a
way that would be more easily understood by someone very familiar with
the PCI terminology such as Bjorn. Thanks a lot!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
