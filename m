Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:54783 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeG3P3a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jul 2018 11:29:30 -0400
Date: Mon, 30 Jul 2018 15:54:21 +0200
From: Lukas Wunner <lukas@wunner.de>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "Alex_Gagniuc@Dellteam.com" <Alex_Gagniuc@Dellteam.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Austin.Bolen@dell.com" <Austin.Bolen@dell.com>,
        "Stuart.Hayes@dell.com" <Stuart.Hayes@dell.com>,
        "Narendra.K@dell.com" <Narendra.K@dell.com>,
        "Christopher.Arzola@dell.com" <Christopher.Arzola@dell.com>,
        "David.Chalfant@dell.com" <David.Chalfant@dell.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Message-ID: <20180730135421.GA2680@wunner.de>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <20180728183130.GA21482@wunner.de>
 <11e48a8d8e144259b4d0fb073c6899c7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11e48a8d8e144259b4d0fb073c6899c7@AcuMS.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 30, 2018 at 01:28:14PM +0000, David Laight wrote:
> From: Lukas Wunner
> > Sent: 28 July 2018 19:32
> ...
> > Finally, if the card was quickly swapped and the link to the new
> > card is already up, you may be accessing that new card.  (mmio
> > accesses may then still return all ones if the BARs are blank,
> > but at least config space accesses should work.)
> 
> On my i7-7700 system that no longer works (at least with some cards).
> If I take the PCIe link down completely (reset the FPGA on the card)
> it doesn't recover (loops through detect active/quiet and a third
> state I can't quite remember).
> 
> ISTR that it recovers from the link going down when I short out
> the PCIe data lines.
> 
> It worked fine on a XEON E5-2609 system - I did it a lot when
> updating the fpga image.
> 
> Can anyone else verify whether this works on other systems?
> Or whether the kernel (or BIOS) needs to (re-)initialise
> some register to make link recovery work.

Huh?  Can you be a bit more specific what exactly no longer works
and which branch or kernel version introduced the regression?

Thanks,

Lukas
