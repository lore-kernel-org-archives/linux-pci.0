Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:35418 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729283AbeG3PIF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jul 2018 11:08:05 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lukas Wunner' <lukas@wunner.de>,
        "Alex_Gagniuc@Dellteam.com" <Alex_Gagniuc@Dellteam.com>
CC: "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Austin.Bolen@dell.com" <Austin.Bolen@dell.com>,
        "Stuart.Hayes@dell.com" <Stuart.Hayes@dell.com>,
        "Narendra.K@dell.com" <Narendra.K@dell.com>,
        "Christopher.Arzola@dell.com" <Christopher.Arzola@dell.com>,
        "David.Chalfant@dell.com" <David.Chalfant@dell.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: RE: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Date: Mon, 30 Jul 2018 13:28:14 +0000
Message-ID: <11e48a8d8e144259b4d0fb073c6899c7@AcuMS.aculab.com>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <20180728183130.GA21482@wunner.de>
In-Reply-To: <20180728183130.GA21482@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lukas Wunner
> Sent: 28 July 2018 19:32
...
> Finally, if the card was quickly swapped and the link to the new
> card is already up, you may be accessing that new card.  (mmio
> accesses may then still return all ones if the BARs are blank,
> but at least config space accesses should work.)

On my i7-7700 system that no longer works (at least with some cards).
If I take the PCIe link down completely (reset the FPGA on the card)
it doesn't recover (loops through detect active/quiet and a third
state I can't quite remember).

ISTR that it recovers from the link going down when I short out
the PCIe data lines.

It worked fine on a XEON E5-2609 system - I did it a lot when
updating the fpga image.

Can anyone else verify whether this works on other systems?
Or whether the kernel (or BIOS) needs to (re-)initialise
some register to make link recovery work.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
