Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:33061 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeGHROW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Jul 2018 13:14:22 -0400
Date: Sun, 8 Jul 2018 19:14:18 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180708171418.GA11476@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 03, 2018 at 11:43:26AM -0400, Sinan Kaya wrote:
> On 7/3/2018 10:34 AM, Lukas Wunner wrote:
> > We've already got the ->reset_slot callback in struct hotplug_slot_ops,
> > I'm wondering if we really need additional ones for this use case.
> 
> As I have informed you before on my previous reply, the pdev->slot is
> only valid for children objects such as endpoints not for a bridge when
> using pciehp.
> 
> The pointer is NULL for the host bridge itself.

Right, sorry, I had misremembered how this works.  So essentially the
pointer is only set for the devices "in" the slot, but not for the bridge
"to" that slot.  If the slot isn't occupied, *no* pci_dev points the
struct pci_slot.  Seems counter-intuitive to be honest.

Thanks for the explanation of the various reset codepaths, I'm afraid my
understanding of that portion of the PCI core is limited.

Browsing through drivers/pci/pci.c, I notice pci_dev_lock() and
pci_dev_save_and_disable(), both are called from reset codepaths and
apparently seek to stop access to the device during reset.  I'm wondering
why DPC and AER remove devices in order to avoid accesses to them during
reset, instead of utilizing these two functions?

My guess is that a lot of the reset code is historically grown and
could be simplified and made more consistent, but that requires digging
into the code and getting a complete picture.  I've sort of done that
for pciehp, I think I'm now intimately familiar with 90% of it,
so I'll be happy to review patches for it and answer questions,
but I'm pretty much stumped when it comes to reset code in the PCI core.

I treated the ->reset_slot() callback as one possible entry point into
pciehp and asked myself if it's properly serialized with the rest of the
driver and whether driver ->probe and ->remove is ordered such that
the driver is always properly initialized when the entry point might be
taken.  I did not look too closely at the codepaths actually leading to
invocation of the ->reset_slot() callback.


> I was curious if we could use a single work queue for all pcie portdrv
> services. This would also eliminate the need for locks that Lukas is
> adding.
> 
> If hotplug starts first,  hotplug code would run to completion before AER
> and DPC service starts recovery.
> 
> If DPC/AER starts first, my patch would mask the hotplug interrupts.
> 
> My solution doesn't help if link down interrupt is observed before the AER
> or DPC services.

If pciehp gets an interrupt quicker than dpc/aer, it will (at least with
my patches) remove all devices, check if the presence bit is set, and
if so, try to bring the slot up again.  My (limited) understanding is
that the link will stay down until dpc/aer react.  pciehp_check_link_status()
will wait 1 sec for the link, wait another 100 msec, then poll the vendor
register for 1 sec before giving up.  So if dpc/aer are locked out for this
long, they will only be able to reset the slot after 2100 msec.

I've had a brief look at the PCIe r4.0 base spec and could not find
anything about how pciehp and dpc/aer should coordinate.  Maybe that's
an oversight, or the PCISIG just leaves this to the OS.


> Another possibility is to add synchronization logic between these threads
> obviously.

Maybe call pci_channel_offline() in the poll loops of pcie_wait_for_link()
and pci_bus_check_dev() to avoid waiting for the link if an error needs to
be acted upon first?

Thanks,

Lukas
