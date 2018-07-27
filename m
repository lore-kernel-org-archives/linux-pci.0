Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:47783 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732122AbeG0S2d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jul 2018 14:28:33 -0400
Date: Fri, 27 Jul 2018 19:05:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alex_Gagniuc@Dellteam.com
Cc: mr.nuke.me@gmail.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, Austin.Bolen@dell.com,
        Stuart.Hayes@dell.com, Narendra.K@dell.com,
        Christopher.Arzola@dell.com, David.Chalfant@dell.com
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Message-ID: <20180727170543.GA5326@wunner.de>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 27, 2018 at 03:52:04PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 07/27/2018 02:18 AM, Lukas Wunner wrote:
> > On Thu, Jul 26, 2018 at 05:38:50PM -0500, Alex G. wrote:
> >> I was under the impression that a DLLSC or PDSC would trigger the
> >> PCI_DEV_DISCONNECTED bit to be set, blocking any further config access.
> > 
> > Only if the Presence Detect State bit in the Slot Status register is
> > not set.
> > 
> > I think the idea was that if the card is still in the slot, its driver can
> > be unbound orderly because the device is still accessible.  So there's no
> > need to set PCI_DEV_DISCONNECTED.
> 
> This sounds counter to what I had intuited. I mentally associate 
> DISCONNECTED with "the link is down". I don't understand the idea of a 
> driver doing an orderly removal when the link is down. Device registers 
> wouldn't be accessible in that case.

That's basically what I meant, sorry for not being clear.

> > However if there is a already a new card in the slot, PCI_DEV_DISCONNECTED
> > will erroneously not be set.  Also, if card removal was triggered by the
> > link going down but the card is still in the slot, PCI_DEV_DISCONNECTED
> > will also erroneously not be set even though it's inaccessible.
> > 
> > The only situations when PCI_DEV_DISCONNECTED should not be set is if the
> > card is being removed by sysfs or by the user pressing the Attention Button.
> > Anything else is a surprise removal.  What we need to do is pass down a
> > flag to pciehp_unconfigure_device() to indicate whether one of those two
> > situations is at hand or not, and PCI_DEV_DISCONNECTED should be set
> > depending on that flag.
> 
> That makes a little more sense. Is someone working on this?

Me, but not for 4.19, we're too late in the cycle, I'm going to post
a small number of fixup patches for Bjorn's pci/hotplug branch shortly,
to be included in 4.19, and that's it.

I posted a patch as part of the series that's now on Bjorn's pci/hotplug
branch which touched PCI_DEV_DISCONNECTED code in pciehp_pci.c, but had
to withdraw that particular patch:
https://patchwork.ozlabs.org/patch/930403/

The first problem with that patch was that I hadn't fully understood
yet when to set PCI_DEV_DISCONNECTED and when not to set it.

The second problem was that it fixed a deadlock on unplug in a way
that wasn't generic enough.  The same deadlock can occur in other
situations.  The real fix is to unbind the driver lockless in
pci_stop_dev().  That's non-trivial to achieve, but doable.
I don't think there's a way around that to fix the problem:
https://www.spinics.net/lists/linux-pci/msg73652.html

There's (still) a lot that can be improved in pciehp, I hope to
keep working on that as time permits.

Thanks,

Lukas
