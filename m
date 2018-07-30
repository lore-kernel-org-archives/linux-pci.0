Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:47919 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbeG3Rk2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jul 2018 13:40:28 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lukas Wunner' <lukas@wunner.de>
CC: "Alex_Gagniuc@Dellteam.com" <Alex_Gagniuc@Dellteam.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Austin.Bolen@dell.com" <Austin.Bolen@dell.com>,
        "Stuart.Hayes@dell.com" <Stuart.Hayes@dell.com>,
        "Narendra.K@dell.com" <Narendra.K@dell.com>,
        "Christopher.Arzola@dell.com" <Christopher.Arzola@dell.com>,
        "David.Chalfant@dell.com" <David.Chalfant@dell.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: RE: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Date: Mon, 30 Jul 2018 16:06:24 +0000
Message-ID: <eada407c21c54449acd3a57413930f72@AcuMS.aculab.com>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <20180728183130.GA21482@wunner.de>
 <11e48a8d8e144259b4d0fb073c6899c7@AcuMS.aculab.com>
 <20180730135421.GA2680@wunner.de>
In-Reply-To: <20180730135421.GA2680@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lukas Wunner
> Sent: 30 July 2018 14:54
> 
> On Mon, Jul 30, 2018 at 01:28:14PM +0000, David Laight wrote:
> > From: Lukas Wunner
> > > Sent: 28 July 2018 19:32
> > ...
> > > Finally, if the card was quickly swapped and the link to the new
> > > card is already up, you may be accessing that new card.  (mmio
> > > accesses may then still return all ones if the BARs are blank,
> > > but at least config space accesses should work.)
> >
> > On my i7-7700 system that no longer works (at least with some cards).
> > If I take the PCIe link down completely (reset the FPGA on the card)
> > it doesn't recover (loops through detect active/quiet and a third
> > state I can't quite remember).
> >
> > ISTR that it recovers from the link going down when I short out
> > the PCIe data lines.
> >
> > It worked fine on a XEON E5-2609 system - I did it a lot when
> > updating the fpga image.
> >
> > Can anyone else verify whether this works on other systems?
> > Or whether the kernel (or BIOS) needs to (re-)initialise
> > some register to make link recovery work.
> 
> Huh?  Can you be a bit more specific what exactly no longer works
> and which branch or kernel version introduced the regression?

I've just rerun the test on the failing system.
I believe it is related to the CPU/BIOS version, not the kernel.
What I'm actually doing is:

1) Boot the system and load the PCIe drivers for a card we make.
2) echo 1 >/sys/devices/pci..../remove
3) Completely reset the Altera(Intel) fpga at the far end of the PCIe link.

I now expect the link to recover, on the XEON E5-2609 it does (with a 4.15-rc6
kernel) but on the i7-7700 it does not (and hasn't for much older kernels).

I also don't think it makes any difference whether the PCIe slot is
directly connected to the cpu or off the companion chip.

We don't have a PCIe analyser, but the fpga traces ltssm state transitions
to an internal memory buffer which we can read using a serial link when the
PCIe link is down.

After the fpga reset I get:

     clocks: abs delta
status:        2 +4G2 Detect Quiet, set l2_exit, set hotrst_exit, set dlup_exit
status:        3   +1 Polling Compliance, clear l2_exit, clear hotrst_exit, clear dlup_exit
status:        6   +3 Polling Compliance, link speed 1, set link2 de-emphasis level
status:       75 +111 Polling Compliance, set link data link active
status:       76   +1 Polling Active
status:      289 +531 Polling Active, set pld_clk_inuse
status:   16e3da +1M4 Detect Quiet
status:   22558b +M75 Detect Active
status:   22b1a3 +23k Polling Active

Repeats forever at the same rate.

status: 2dd8a0c7 +23k Polling Active
status: 2def8429 +1M5 Detect Quiet
status: 2dfaf5da +M75 Detect Active
status: 2dfb51f3 +23k Polling Active
status: 2e123555 +1M5 Detect Quiet
status: 2e1da706 +M75 Detect Active
status: 2e1e031f +23k Polling Active
status: 2e34e681 +1M5 Detect Quiet
status: 2e405832 +M75 Detect Active
status: 2e40b44b +23k Polling Active

Until I do a 'reboot' when it all recovers

status: 2e48c9d9 +M52 Polling Active, set avalon bus reset
status: 2e48c9dd   +4 Polling Active, clear avalon bus reset
status: 2e48c9de   +1 Detect Quiet
status: 2e48c9df   +1 Detect Quiet, clear pld_clk_inuse
status: 2e48c9e5   +6 Detect Quiet, set pld_clk_inuse
status: 2e48c9e6   +1 Detect Quiet, clear pld_clk_inuse
status: 2e48c9e8   +2 Detect Quiet, set pld_clk_inuse
status: 2e48c9e9   +1 Detect Active
status: 2e48c9eb   +2 Detect Active, clear link data link active
status: 2e48c9f3   +8 Detect Active, set link data link active

The trace suppresses repeated 'Detect active' 'Detect quiet' traces
because they happen for a considerable period during a reboot'.

time: Thu Jan  1 01:10:33 1970
status: 32fd4f1f +78M Detect Quiet, active<=>quiet bounces 102
status: 3308c162 +M75 Detect Active
status: 33091d54 +23k Polling Active
status: 33170b7f +M91 Polling Configuration
status: 33170bc7  +72 Config Link width start, link width 8
status: 33170be7  +32 Config Link accept
status: 33171c1d +4k1 Config Lane num wait
status: 33171c2d  +16 Config Lane num accept
status: 33171c61  +52 Config Complete
status: 33171c67   +6 Config Complete, link width 1
status: 33171caa  +67 Config Idle
status: 33171cba  +16 L0

I'm not sure what 'Polling active' means.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
