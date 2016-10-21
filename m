Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:49666 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753953AbcJUQEr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Oct 2016 12:04:47 -0400
Date: Fri, 21 Oct 2016 12:15:16 -0400
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>, Wei Zhang <wzhang@fb.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCHv3 2/5] pci: Add is_removed state
Message-ID: <20161021161515.GA8596@localhost.localdomain>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
 <1475007815-28354-3-git-send-email-keith.busch@intel.com>
 <20161021153714.GA4221@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161021153714.GA4221@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 21, 2016 at 05:37:14PM +0200, Lukas Wunner wrote:
> On Tue, Sep 27, 2016 at 04:23:32PM -0400, Keith Busch wrote:
> > --- a/drivers/pci/hotplug/pciehp_pci.c
> > +++ b/drivers/pci/hotplug/pciehp_pci.c
> > @@ -109,6 +109,8 @@ int pciehp_unconfigure_device(struct slot *p_slot)
> >  				break;
> >  			}
> >  		}
> > +		if (!presence)
> > +			dev->is_removed = 1;
> >  		pci_stop_and_remove_bus_device(dev);
> >  		/*
> >  		 * Ensure that no new Requests will be generated from
> 
> Sorry for the delay Keith, I finally got around to test v3 of your
> series with hot-removed Thunderbolt devices on Apple Macs.
> 
> I've found that the above isn't sufficient, it's necessary to also
> set the is_removed bit on any child devices.  E.g. on my system
> when an Apple Gigabit Ethernet adapter is plugged in, the topology
> looks like this:

Thanks for the catch. Your proposal looks good to me. I'll send a new
revision incorporating something like this that the dpc driver can
also use.
 
> With your patch above, the is_removed bit is only set on 0000:09:00.0
> but not on its children.  Consequently the "tg3" driver tries to
> access the hot-removed Broadcom 57762 Ethernet chip as before,
> causing a soft lockup.

Is that something that can be fixed in the tg3 driver? I don't think
drivers can rely on this patch to fense off their unintended access since
we can't stop tg3 from accesses a removed device before 'is_removed'
is set.
