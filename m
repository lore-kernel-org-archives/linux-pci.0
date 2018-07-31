Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:52667 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbeGaLIZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jul 2018 07:08:25 -0400
Date: Tue, 31 Jul 2018 11:28:57 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alex_Gagniuc@Dellteam.com
Cc: mr.nuke.me@gmail.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, Austin.Bolen@dell.com,
        Stuart.Hayes@dell.com, Narendra.K@dell.com,
        Christopher.Arzola@dell.com, David.Chalfant@dell.com,
        okaya@kernel.org
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Message-ID: <20180731092857.GA13494@wunner.de>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <20180728183130.GA21482@wunner.de>
 <c9a2b3463fd04f3eb7725f985c569b03@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c9a2b3463fd04f3eb7725f985c569b03@ausx13mps321.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 30, 2018 at 09:38:04PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 07/28/2018 01:31 PM, Lukas Wunner wrote:
> > On Fri, Jul 27, 2018 at 05:51:04PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> > > I think PCI_DEV_DISCONNECTED is a documentation issue above all else.
> > > The history I was given is that drivers would take a very long time to
> > > tear down a device. Config space IO to an nonexistent device took a long
> > > while to time out. Performance was one motivation -- and was not
> > > documented.
> > 
> > Often it is possible for the driver to detect surprise removal by
> > checking if mmio reads return "all ones".  But in some cases that's
> > a valid value to read from mmio and then this approach won't work.
> > Also, checking every mmio read may negatively impact performance.
> 
> A colleague and me beat that dead horse to the afterdeath. Consensus was 
> that the return value is less reliable than a coin toss (of a two-heads 
> coin).

Can you elaborate why?  Because the "official" stance is that checking
every read where "all ones" is an invalid value is the proper way to
detect unplugged devices.  (Official as in, voiced by Greg KH and Bjorn.)
In that sense, PCI_DEV_DISCONNECTED is sort of an unloved child.

See this thread:
https://www.spinics.net/lists/linux-acpi/msg81445.html


> > FWIW, the below is what I had in mind (on top of Bjorn's pci/hotplug
> > branch).  Does this work for you?
> 
> This, and another patch (you have been CC'd) solve my problem of 
> crashing during surprise removal. Thanks!

Ok thanks, I submitted the patch this morning with your Tested-by.
Unfortunately I forgot to cc all your Dell colleagues, sorry.

Lukas
