Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:41659 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbeGCORw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2018 10:17:52 -0400
Date: Tue, 3 Jul 2018 16:17:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: poza@codeaurora.org
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180703141750.GC18639@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
 <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
 <bd04c9d1-6dfe-3071-69f9-beb0d649b6c0@codeaurora.org>
 <20180703135956.GA18639@wunner.de>
 <1658f1759864e22fed4273a22d501a8e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1658f1759864e22fed4273a22d501a8e@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 03, 2018 at 07:40:46PM +0530, poza@codeaurora.org wrote:
> On 2018-07-03 19:29, Lukas Wunner wrote:
> >On Tue, Jul 03, 2018 at 09:31:24AM -0400, Sinan Kaya wrote:
> >>Issue is observing hotplug link down event in the middle of AER recovery
> >>as in my previous reply.
> >>
> >>If we mask hotplug interrupts before secondary bus reset via my patch,
> >>then hotplug driver will not observe both link up and link down
> >>interrupts.
> >>
> >>If we don't mask hotplug interrupts, we have a race condition.
> >
> >I assume that a bus reset not only causes a link and presence event but
> >also clears the Presence Detect State bit in the Slot Status register
> >and the Data Link Layer Link Active bit in the Link Status register
> >momentarily.
> >
> >pciehp may access those two bits concurrently to the AER driver
> >performing a slot reset.  So it may not be sufficient to mask
> >the interrupt.
> >
> >I've posted this patch to address the issue:
> >https://patchwork.ozlabs.org/patch/930391/
> 
> Was just wondering that you are protecting Presence Detect State bit with
> reset_lock, mainly in pciehp_ist
> but with hotplug interrupt disabled, is there another way that it hotplug
> code gets activated ?

The user may turn the slot on/off via sysfs.  If an Attention Button
is present, the user may also press that button to turn the slot on/off
after 5 seconds.  Either way, it may cause pciehp's IRQ thread to run
concurrently to a reset initiated by the AER driver, independently of
any events signalled by the slot.

Thanks,

Lukas
