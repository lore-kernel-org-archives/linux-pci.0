Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:49471 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387502AbeHAKlp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 06:41:45 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Alex_Gagniuc@Dellteam.com'" <Alex_Gagniuc@Dellteam.com>,
        "lukas@wunner.de" <lukas@wunner.de>
CC: "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Austin.Bolen@dell.com" <Austin.Bolen@dell.com>,
        "Stuart.Hayes@dell.com" <Stuart.Hayes@dell.com>,
        "Narendra.K@dell.com" <Narendra.K@dell.com>,
        "Christopher.Arzola@dell.com" <Christopher.Arzola@dell.com>,
        "David.Chalfant@dell.com" <David.Chalfant@dell.com>,
        "okaya@kernel.org" <okaya@kernel.org>
Subject: RE: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Date: Wed, 1 Aug 2018 08:58:39 +0000
Message-ID: <9870eb1907ae425bb9671c73845193f3@AcuMS.aculab.com>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <20180728183130.GA21482@wunner.de>
 <c9a2b3463fd04f3eb7725f985c569b03@ausx13mps321.AMER.DELL.COM>
 <20180731092857.GA13494@wunner.de>
 <f05149cf4d9743878397de7763561221@ausx13mps321.AMER.DELL.COM>
In-Reply-To: <f05149cf4d9743878397de7763561221@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alex_Gagniuc@Dellteam.com
> Sent: 31 July 2018 17:36
> 
> On 07/31/2018 04:29 AM, Lukas Wunner wrote:
> > On Mon, Jul 30, 2018 at 09:38:04PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> >> On 07/28/2018 01:31 PM, Lukas Wunner wrote:
> >>> On Fri, Jul 27, 2018 at 05:51:04PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> >>>> I think PCI_DEV_DISCONNECTED is a documentation issue above all else.
> >>>> The history I was given is that drivers would take a very long time to
> >>>> tear down a device. Config space IO to an nonexistent device took a long
> >>>> while to time out. Performance was one motivation -- and was not
> >>>> documented.
> >>>
> >>> Often it is possible for the driver to detect surprise removal by
> >>> checking if mmio reads return "all ones".  But in some cases that's
> >>> a valid value to read from mmio and then this approach won't work.
> >>> Also, checking every mmio read may negatively impact performance.
> >>
> >> A colleague and me beat that dead horse to the afterdeath. Consensus was
> >> that the return value is less reliable than a coin toss (of a two-heads
> >> coin).

Something cheap-ish to find out whether a -1 was caused by a card
removal might be sensible - Especially if it can be done without
a config space read.
Clearly you can't check anything BEFORE doing the read.
And reading the pci-id from config space isn't entirely useful.
If the card has reset itself (and the link recovered) then you
need to read a BAR register and check it is setup.

More interestingly a read request that is inside the bridge's address
window but outside any BAR (fairly easy to setup if the target has
a large BAR and a small one) will also timeout (and return -1) even
though there is no failure of the link.

If the target supports AER the information about the failed cycle
ends up in the target's AER registers - even if the host bridge
doesn't support AER (or it is being ignored).
So it might be useful being able to read the AER registers even when
no AER interrupt (or other notification) actually happens.

I've not managed to get linux to pick up AER interrupts even on
systems where the hardware clearly supports them (at least on
some slots).  I suspect the BIOS is carefully disabling them
because of reports of message logs being spammed with AER errors.

We also have one system (possibly a Dell 740) where any failure
of a PCIe link leads to an NMI and a kernel crash!
Not entirely useful in a server model that is supposed to have
resilience against various errors.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
