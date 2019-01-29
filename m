Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338BEC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 23:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E759921848
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 23:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548802952;
	bh=Y1Y2Nor0CraNdmmai6dyx3yog3bOMAUEZs+2FAQ7qkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K93Z8mRLlBnXSY77xyYWLB0HhK2OdrgY/FLUw0ZKKPEKElEypuzgclrxpR0rT0e4W
	 Zs5zC+XkbfrcsDg6xcDhTujl83rBss964kca1AAz6UXQvR4yyZvy5aUtFVdvJRInDM
	 A41doBSL77Vc+dHWm3WhbrMoAzZHEk8LwzLSMgDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfA2XCb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:02:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfA2XCb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 18:02:31 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB702175B;
        Tue, 29 Jan 2019 23:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548802949;
        bh=Y1Y2Nor0CraNdmmai6dyx3yog3bOMAUEZs+2FAQ7qkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cWhIb6AXjjcHc7CK8oLyXz/zfBZlFYRy+Scu1UuRaZaD97LGA9jG598QP28a1xF4f
         6ojGYNqpV8ecuf13M6JAQg7prPgLOX8yNSfNQRP93lbkh//xn6/N95sJJI56IbwWW9
         ZzyiDR64nluqg4qQSrkEXxYrpaINTla4wcH1CqVk=
Date:   Tue, 29 Jan 2019 17:02:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-pci@vger.kernel.org, xuyandong <xuyandong2@huawei.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ofer Hayut <ofer@lightbitslabs.com>,
        Roy Shterman <roys@lightbitslabs.com>,
        Keith Busch <keith.busch@intel.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Probe bridge window attributes once at
 enumeration-time
Message-ID: <20190129230225.GF91506@google.com>
References: <154818377425.41851.650909794935936003.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20190129224333.GE91506@google.com>
 <20190129174504-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129174504-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 05:47:32PM -0500, Michael S. Tsirkin wrote:
> On Tue, Jan 29, 2019 at 04:43:33PM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 22, 2019 at 01:02:54PM -0600, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > pci_bridge_check_ranges() determines whether a bridge supports the optional
> > > I/O and prefetchable memory windows and sets the flag bits in the bridge
> > > resources.  This *could* be done once during enumeration except that the
> > > resource allocation code completely clears the flag bits, e.g., in the
> > > pci_assign_unassigned_bridge_resources() path.
> > > 
> > > The problem with pci_bridge_check_ranges() in the resource allocation path
> > > is that we may allocate resources after devices have been claimed by
> > > drivers, and pci_bridge_check_ranges() *changes* the window registers to
> > > determine whether they're writable.  This may break concurrent accesses to
> > > devices behind the bridge.
> > > 
> > > Add a new pci_read_bridge_windows() to determine whether a bridge supports
> > > the optional windows, call it once during enumeration, remember the
> > > results, and change pci_bridge_check_ranges() so it doesn't touch the
> > > bridge windows but sets the flag bits based on those remembered results.
> > > 
> > > Link: https://lore.kernel.org/linux-pci/1506151482-113560-1-git-send-email-wangzhou1@hisilicon.com
> > > Link: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02082.html
> > > Reported-by: xuyandong <xuyandong2@huawei.com>
> > > Tested-by: xuyandong <xuyandong2@huawei.com>
> > > Cc: Sagi Grimberg <sagi@grimberg.me>
> > > Cc: Ofer Hayut <ofer@lightbitslabs.com>
> > > Cc: Roy Shterman <roys@lightbitslabs.com>
> > > Cc: Keith Busch <keith.busch@intel.com>
> > > Cc: Zhou Wang <wangzhou1@hisilicon.com>
> > 
> > Applied to pci/enumeration for v5.1.
> > 
> > This is fairly simple in concept, but doesn't meet the letter of the
> > restrictions in Documentation/process/stable-kernel-rules.rst, so I
> > didn't tag it for stable.
> > 
> > Is there a compelling argument to mark it for stable?
> 
> Well it's needed downstream.
> It's a bit above 100 lines with context. Is this what you mean?

Yep, I should have been explicit about that.

> If yes how about using my patch for stable as an alternative?
> The rules allow for equivalent patches.

Well, yes, that would be a possibility.

I would rather develop an argument for marking *this* patch for
stable.  Even though it is technically too large, I think we could
make it work if we have compelling reasons.

Those would need to be fleshed out a little more than "needed
downstream" -- something about the scenarios where this happens, what
the serious problem is, etc.

The *ideal* thing would be to have an actual bugzilla.kernel.org
report of the problem with a way to reproduce it and dmesg
illustrating the problem.

> > > ---
> > >  drivers/pci/probe.c     |   52 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/pci/setup-bus.c |   45 ++++-------------------------------------
> > >  include/linux/pci.h     |    3 +++
> > >  3 files changed, 59 insertions(+), 41 deletions(-)
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 257b9f6f2ebb..2ef8b954c65a 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -348,6 +348,57 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
> > >  	}
> > >  }
> > >  
> > > +static void pci_read_bridge_windows(struct pci_dev *bridge)
> > > +{
> > > +	u16 io;
> > > +	u32 pmem, tmp;
> > > +
> > > +	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > > +	if (!io) {
> > > +		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
> > > +		pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > > +		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
> > > +	}
> > > +	if (io)
> > > +		bridge->io_window = 1;
> > > +
> > > +	/*
> > > +	 * DECchip 21050 pass 2 errata: the bridge may miss an address
> > > +	 * disconnect boundary by one PCI data phase.  Workaround: do not
> > > +	 * use prefetching on this device.
> > > +	 */
> > > +	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
> > > +		return;
> > > +
> > > +	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
> > > +	if (!pmem) {
> > > +		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
> > > +					       0xffe0fff0);
> > > +		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
> > > +		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
> > > +	}
> > > +	if (!pmem)
> > > +		return;
> > > +
> > > +	bridge->pref_window = 1;
> > > +
> > > +	if ((pmem & PCI_PREF_RANGE_TYPE_MASK) == PCI_PREF_RANGE_TYPE_64) {
> > > +
> > > +		/*
> > > +		 * Bridge claims to have a 64-bit prefetchable memory
> > > +		 * window; verify that the upper bits are actually
> > > +		 * writable.
> > > +		 */
> > > +		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &pmem);
> > > +		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
> > > +				       0xffffffff);
> > > +		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &tmp);
> > > +		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, pmem);
> > > +		if (tmp)
> > > +			bridge->pref_64_window = 1;
> > > +	}
> > > +}
> > > +
> > >  static void pci_read_bridge_io(struct pci_bus *child)
> > >  {
> > >  	struct pci_dev *dev = child->self;
> > > @@ -1739,6 +1790,7 @@ int pci_setup_device(struct pci_dev *dev)
> > >  		pci_read_irq(dev);
> > >  		dev->transparent = ((dev->class & 0xff) == 1);
> > >  		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
> > > +		pci_read_bridge_windows(dev);
> > >  		set_pcie_hotplug_bridge(dev);
> > >  		pos = pci_find_capability(dev, PCI_CAP_ID_SSVID);
> > >  		if (pos) {
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index ed960436df5e..1941bb0a6c13 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -735,58 +735,21 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
> > >     base/limit registers must be read-only and read as 0. */
> > >  static void pci_bridge_check_ranges(struct pci_bus *bus)
> > >  {
> > > -	u16 io;
> > > -	u32 pmem;
> > >  	struct pci_dev *bridge = bus->self;
> > > -	struct resource *b_res;
> > > +	struct resource *b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> > >  
> > > -	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> > >  	b_res[1].flags |= IORESOURCE_MEM;
> > >  
> > > -	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > > -	if (!io) {
> > > -		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
> > > -		pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > > -		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
> > > -	}
> > > -	if (io)
> > > +	if (bridge->io_window)
> > >  		b_res[0].flags |= IORESOURCE_IO;
> > >  
> > > -	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
> > > -	    disconnect boundary by one PCI data phase.
> > > -	    Workaround: do not use prefetching on this device. */
> > > -	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
> > > -		return;
> > > -
> > > -	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
> > > -	if (!pmem) {
> > > -		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
> > > -					       0xffe0fff0);
> > > -		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
> > > -		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
> > > -	}
> > > -	if (pmem) {
> > > +	if (bridge->pref_window) {
> > >  		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
> > > -		if ((pmem & PCI_PREF_RANGE_TYPE_MASK) ==
> > > -		    PCI_PREF_RANGE_TYPE_64) {
> > > +		if (bridge->pref_64_window) {
> > >  			b_res[2].flags |= IORESOURCE_MEM_64;
> > >  			b_res[2].flags |= PCI_PREF_RANGE_TYPE_64;
> > >  		}
> > >  	}
> > > -
> > > -	/* double check if bridge does support 64 bit pref */
> > > -	if (b_res[2].flags & IORESOURCE_MEM_64) {
> > > -		u32 mem_base_hi, tmp;
> > > -		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32,
> > > -					 &mem_base_hi);
> > > -		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
> > > -					       0xffffffff);
> > > -		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &tmp);
> > > -		if (!tmp)
> > > -			b_res[2].flags &= ~IORESOURCE_MEM_64;
> > > -		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
> > > -				       mem_base_hi);
> > > -	}
> > >  }
> > >  
> > >  /* Helper function for sizing routines: find first available
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 65f1d8c2f082..40b327b814aa 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -373,6 +373,9 @@ struct pci_dev {
> > >  	bool		match_driver;		/* Skip attaching driver */
> > >  
> > >  	unsigned int	transparent:1;		/* Subtractive decode bridge */
> > > +	unsigned int	io_window:1;		/* Bridge has I/O window */
> > > +	unsigned int	pref_window:1;		/* Bridge has pref mem window */
> > > +	unsigned int	pref_64_window:1;	/* Pref mem window is 64-bit */
> > >  	unsigned int	multifunction:1;	/* Multi-function device */
> > >  
> > >  	unsigned int	is_busmaster:1;		/* Is busmaster */
> > > 
