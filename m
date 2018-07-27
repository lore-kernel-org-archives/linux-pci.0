Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:53433 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbeG0Iir (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jul 2018 04:38:47 -0400
Date: Fri, 27 Jul 2018 09:18:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: Keith Busch <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Bolen, Austin" <austin_bolen@dell.com>,
        "alex_gagniuc@dellteam.com" <Alex_Gagniuc@Dellteam.com>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Message-ID: <20180727071813.GA6128@wunner.de>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 26, 2018 at 05:38:50PM -0500, Alex G. wrote:
> I was under the impression that a DLLSC or PDSC would trigger the
> PCI_DEV_DISCONNECTED bit to be set, blocking any further config access.

Only if the Presence Detect State bit in the Slot Status register is
not set.

I think the idea was that if the card is still in the slot, its driver can
be unbound orderly because the device is still accessible.  So there's no
need to set PCI_DEV_DISCONNECTED.

However if there is a already a new card in the slot, PCI_DEV_DISCONNECTED
will erroneously not be set.  Also, if card removal was triggered by the
link going down but the card is still in the slot, PCI_DEV_DISCONNECTED
will also erroneously not be set even though it's inaccessible.

The only situations when PCI_DEV_DISCONNECTED should not be set is if the
card is being removed by sysfs or by the user pressing the Attention Button.
Anything else is a surprise removal.  What we need to do is pass down a
flag to pciehp_unconfigure_device() to indicate whether one of those two
situations is at hand or not, and PCI_DEV_DISCONNECTED should be set
depending on that flag.

Are you testing Bjorn's pci/hotplug branch or something based on 4.18 or
earlier?  There is a major event handling rework queued on that branch,
so you may want to test with that.


> In the latter case, does it not make sense to have a separate bit to say
> "Don't touch this device"?

Hm, what would you need it for?

Thanks,

Lukas
