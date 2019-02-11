Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C45C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 03:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E562120855
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 03:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfBKDs5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 10 Feb 2019 22:48:57 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45935 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfBKDs4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Feb 2019 22:48:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so10630925qtr.12
        for <linux-pci@vger.kernel.org>; Sun, 10 Feb 2019 19:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9SH+FNtWUzl3EBdhIt2v1zJml0cnCuPGJNiTzdrPpuc=;
        b=j6gRYWgN7408dpKP028iPdgmDuFrsH/q0LSpcJ20NTm4HQsonD66fZTM/7O0vEFwrB
         SDKrnSejHEo1GMTOPS7Ny4U6SpphRwnDprQres6eM/8+SupSycBOGdmtC1uTgj8IAjJc
         iWb8BVMixgqBvoI8EVM9tDioWBuRSPbYfre0PFZkLVNJ3KCgm2g03lBW7ByIRofqyrkJ
         APH/S2Lep90PPZZrHoInUSCwjrAlY0W/M7n7a0lNe+kLQeXEjRixE9+BRuftx/AN3zGY
         Uki1nRw22OP8925R7b5E28RXIi2HP93WjptXY3CHGzQfaGWQB11hYewdvtScj5SmdcXn
         z7ug==
X-Gm-Message-State: AHQUAuZDR6nScmsxwNhGJ6IgsWCAHpDSNMDQe5fTVhzXYjIYQqJUN01y
        fF9HbPPtojxL88gWrt9PhrYEZ0Mmfzo=
X-Google-Smtp-Source: AHgI3IZziF0OjG6J/MqqTyyJoNIggKzNCSjdKIJWLpERg2Hs7UOsr6Pxs5D8AuHVl79u1CfcCH7Iew==
X-Received: by 2002:ac8:7218:: with SMTP id a24mr18794953qtp.94.1549856935231;
        Sun, 10 Feb 2019 19:48:55 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id w123sm29639498qkw.80.2019.02.10.19.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 19:48:53 -0800 (PST)
Date:   Sun, 10 Feb 2019 22:48:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Xuyandong (Yandong Xu, Euler5)" <xuyandong2@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ofer Hayut <ofer@lightbitslabs.com>,
        Roy Shterman <roys@lightbitslabs.com>,
        Keith Busch <keith.busch@intel.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Probe bridge window attributes once at
 enumeration-time
Message-ID: <20190210224716-mutt-send-email-mst@kernel.org>
References: <154818377425.41851.650909794935936003.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20190129224333.GE91506@google.com>
 <20190129174504-mutt-send-email-mst@kernel.org>
 <20190129230225.GF91506@google.com>
 <20190205132323-mutt-send-email-mst@kernel.org>
 <7CECC2DFC21538489F72729DF5EFB4D909EF3236@DGGEMM501-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CECC2DFC21538489F72729DF5EFB4D909EF3236@DGGEMM501-MBX.china.huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 11, 2019 at 01:57:20AM +0000, Xuyandong (Yandong Xu, Euler5) wrote:
> > On Tue, Jan 29, 2019 at 05:02:26PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Jan 29, 2019 at 05:47:32PM -0500, Michael S. Tsirkin wrote:
> > > > On Tue, Jan 29, 2019 at 04:43:33PM -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Jan 22, 2019 at 01:02:54PM -0600, Bjorn Helgaas wrote:
> > > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > > >
> > > > > > pci_bridge_check_ranges() determines whether a bridge supports
> > > > > > the optional I/O and prefetchable memory windows and sets the
> > > > > > flag bits in the bridge resources.  This *could* be done once
> > > > > > during enumeration except that the resource allocation code
> > > > > > completely clears the flag bits, e.g., in the
> > > > > > pci_assign_unassigned_bridge_resources() path.
> > > > > >
> > > > > > The problem with pci_bridge_check_ranges() in the resource
> > > > > > allocation path is that we may allocate resources after devices
> > > > > > have been claimed by drivers, and pci_bridge_check_ranges()
> > > > > > *changes* the window registers to determine whether they're
> > > > > > writable.  This may break concurrent accesses to devices behind the
> > bridge.
> > > > > >
> > > > > > Add a new pci_read_bridge_windows() to determine whether a
> > > > > > bridge supports the optional windows, call it once during
> > > > > > enumeration, remember the results, and change
> > > > > > pci_bridge_check_ranges() so it doesn't touch the bridge windows but
> > sets the flag bits based on those remembered results.
> > > > > >
> > > > > > Link:
> > > > > > https://lore.kernel.org/linux-pci/1506151482-113560-1-git-send-e
> > > > > > mail-wangzhou1@hisilicon.com
> > > > > > Link:
> > > > > > https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02082.h
> > > > > > tml
> > > > > > Reported-by: xuyandong <xuyandong2@huawei.com>
> > > > > > Tested-by: xuyandong <xuyandong2@huawei.com>
> > > > > > Cc: Sagi Grimberg <sagi@grimberg.me>
> > > > > > Cc: Ofer Hayut <ofer@lightbitslabs.com>
> > > > > > Cc: Roy Shterman <roys@lightbitslabs.com>
> > > > > > Cc: Keith Busch <keith.busch@intel.com>
> > > > > > Cc: Zhou Wang <wangzhou1@hisilicon.com>
> > > > >
> > > > > Applied to pci/enumeration for v5.1.
> > > > >
> > > > > This is fairly simple in concept, but doesn't meet the letter of
> > > > > the restrictions in Documentation/process/stable-kernel-rules.rst,
> > > > > so I didn't tag it for stable.
> > > > >
> > > > > Is there a compelling argument to mark it for stable?
> > > >
> > > > Well it's needed downstream.
> > > > It's a bit above 100 lines with context. Is this what you mean?
> > >
> > > Yep, I should have been explicit about that.
> > >
> > > > If yes how about using my patch for stable as an alternative?
> > > > The rules allow for equivalent patches.
> > >
> > > Well, yes, that would be a possibility.
> > >
> > > I would rather develop an argument for marking *this* patch for
> > > stable.  Even though it is technically too large, I think we could
> > > make it work if we have compelling reasons.
> > >
> > > Those would need to be fleshed out a little more than "needed
> > > downstream" -- something about the scenarios where this happens, what
> > > the serious problem is, etc.
> > >
> > > The *ideal* thing would be to have an actual bugzilla.kernel.org
> > > report of the problem with a way to reproduce it and dmesg
> > > illustrating the problem.
> > 
> > xuyandong would you like to take a stub at creating the bugzilla entry?
> > If not let me know and I'll do it.
> > Thanks!
> > 
> Thanks, but I  do not want to create the bugzilla entry.

OK that's fair, you did quite a lot already.

Xuyandong thanks a lot for your contribution in reporting the problem,
proposing fixes and then testing patches, it is very much appreciated!


> 
> > 
> > > > > > ---
> > > > > >  drivers/pci/probe.c     |   52
> > +++++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  drivers/pci/setup-bus.c |   45 ++++-------------------------------------
> > > > > >  include/linux/pci.h     |    3 +++
> > > > > >  3 files changed, 59 insertions(+), 41 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> > > > > > 257b9f6f2ebb..2ef8b954c65a 100644
> > > > > > --- a/drivers/pci/probe.c
> > > > > > +++ b/drivers/pci/probe.c
> > > > > > @@ -348,6 +348,57 @@ static void pci_read_bases(struct pci_dev *dev,
> > unsigned int howmany, int rom)
> > > > > >  	}
> > > > > >  }
> > > > > >
> > > > > > +static void pci_read_bridge_windows(struct pci_dev *bridge) {
> > > > > > +	u16 io;
> > > > > > +	u32 pmem, tmp;
> > > > > > +
> > > > > > +	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > > > > > +	if (!io) {
> > > > > > +		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
> > > > > > +		pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > > > > > +		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
> > > > > > +	}
> > > > > > +	if (io)
> > > > > > +		bridge->io_window = 1;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * DECchip 21050 pass 2 errata: the bridge may miss an
> > address
> > > > > > +	 * disconnect boundary by one PCI data phase.  Workaround:
> > do not
> > > > > > +	 * use prefetching on this device.
> > > > > > +	 */
> > > > > > +	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device
> > == 0x0001)
> > > > > > +		return;
> > > > > > +
> > > > > > +	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE,
> > &pmem);
> > > > > > +	if (!pmem) {
> > > > > > +		pci_write_config_dword(bridge,
> > PCI_PREF_MEMORY_BASE,
> > > > > > +					       0xffe0fff0);
> > > > > > +		pci_read_config_dword(bridge,
> > PCI_PREF_MEMORY_BASE, &pmem);
> > > > > > +		pci_write_config_dword(bridge,
> > PCI_PREF_MEMORY_BASE, 0x0);
> > > > > > +	}
> > > > > > +	if (!pmem)
> > > > > > +		return;
> > > > > > +
> > > > > > +	bridge->pref_window = 1;
> > > > > > +
> > > > > > +	if ((pmem & PCI_PREF_RANGE_TYPE_MASK) ==
> > > > > > +PCI_PREF_RANGE_TYPE_64) {
> > > > > > +
> > > > > > +		/*
> > > > > > +		 * Bridge claims to have a 64-bit prefetchable memory
> > > > > > +		 * window; verify that the upper bits are actually
> > > > > > +		 * writable.
> > > > > > +		 */
> > > > > > +		pci_read_config_dword(bridge,
> > PCI_PREF_BASE_UPPER32, &pmem);
> > > > > > +		pci_write_config_dword(bridge,
> > PCI_PREF_BASE_UPPER32,
> > > > > > +				       0xffffffff);
> > > > > > +		pci_read_config_dword(bridge,
> > PCI_PREF_BASE_UPPER32, &tmp);
> > > > > > +		pci_write_config_dword(bridge,
> > PCI_PREF_BASE_UPPER32, pmem);
> > > > > > +		if (tmp)
> > > > > > +			bridge->pref_64_window = 1;
> > > > > > +	}
> > > > > > +}
> > > > > > +
> > > > > >  static void pci_read_bridge_io(struct pci_bus *child)  {
> > > > > >  	struct pci_dev *dev = child->self; @@ -1739,6 +1790,7 @@ int
> > > > > > pci_setup_device(struct pci_dev *dev)
> > > > > >  		pci_read_irq(dev);
> > > > > >  		dev->transparent = ((dev->class & 0xff) == 1);
> > > > > >  		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
> > > > > > +		pci_read_bridge_windows(dev);
> > > > > >  		set_pcie_hotplug_bridge(dev);
> > > > > >  		pos = pci_find_capability(dev, PCI_CAP_ID_SSVID);
> > > > > >  		if (pos) {
> > > > > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > > > > index ed960436df5e..1941bb0a6c13 100644
> > > > > > --- a/drivers/pci/setup-bus.c
> > > > > > +++ b/drivers/pci/setup-bus.c
> > > > > > @@ -735,58 +735,21 @@ int pci_claim_bridge_resource(struct pci_dev
> > *bridge, int i)
> > > > > >     base/limit registers must be read-only and read as 0. */
> > > > > > static void pci_bridge_check_ranges(struct pci_bus *bus)  {
> > > > > > -	u16 io;
> > > > > > -	u32 pmem;
> > > > > >  	struct pci_dev *bridge = bus->self;
> > > > > > -	struct resource *b_res;
> > > > > > +	struct resource *b_res =
> > > > > > +&bridge->resource[PCI_BRIDGE_RESOURCES];
> > > > > >
> > > > > > -	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> > > > > >  	b_res[1].flags |= IORESOURCE_MEM;
> > > > > >
> > > > > > -	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > > > > > -	if (!io) {
> > > > > > -		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
> > > > > > -		pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > > > > > -		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
> > > > > > -	}
> > > > > > -	if (io)
> > > > > > +	if (bridge->io_window)
> > > > > >  		b_res[0].flags |= IORESOURCE_IO;
> > > > > >
> > > > > > -	/*  DECchip 21050 pass 2 errata: the bridge may miss an
> > address
> > > > > > -	    disconnect boundary by one PCI data phase.
> > > > > > -	    Workaround: do not use prefetching on this device. */
> > > > > > -	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device
> > == 0x0001)
> > > > > > -		return;
> > > > > > -
> > > > > > -	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE,
> > &pmem);
> > > > > > -	if (!pmem) {
> > > > > > -		pci_write_config_dword(bridge,
> > PCI_PREF_MEMORY_BASE,
> > > > > > -					       0xffe0fff0);
> > > > > > -		pci_read_config_dword(bridge,
> > PCI_PREF_MEMORY_BASE, &pmem);
> > > > > > -		pci_write_config_dword(bridge,
> > PCI_PREF_MEMORY_BASE, 0x0);
> > > > > > -	}
> > > > > > -	if (pmem) {
> > > > > > +	if (bridge->pref_window) {
> > > > > >  		b_res[2].flags |= IORESOURCE_MEM |
> > IORESOURCE_PREFETCH;
> > > > > > -		if ((pmem & PCI_PREF_RANGE_TYPE_MASK) ==
> > > > > > -		    PCI_PREF_RANGE_TYPE_64) {
> > > > > > +		if (bridge->pref_64_window) {
> > > > > >  			b_res[2].flags |= IORESOURCE_MEM_64;
> > > > > >  			b_res[2].flags |= PCI_PREF_RANGE_TYPE_64;
> > > > > >  		}
> > > > > >  	}
> > > > > > -
> > > > > > -	/* double check if bridge does support 64 bit pref */
> > > > > > -	if (b_res[2].flags & IORESOURCE_MEM_64) {
> > > > > > -		u32 mem_base_hi, tmp;
> > > > > > -		pci_read_config_dword(bridge,
> > PCI_PREF_BASE_UPPER32,
> > > > > > -					 &mem_base_hi);
> > > > > > -		pci_write_config_dword(bridge,
> > PCI_PREF_BASE_UPPER32,
> > > > > > -					       0xffffffff);
> > > > > > -		pci_read_config_dword(bridge,
> > PCI_PREF_BASE_UPPER32, &tmp);
> > > > > > -		if (!tmp)
> > > > > > -			b_res[2].flags &= ~IORESOURCE_MEM_64;
> > > > > > -		pci_write_config_dword(bridge,
> > PCI_PREF_BASE_UPPER32,
> > > > > > -				       mem_base_hi);
> > > > > > -	}
> > > > > >  }
> > > > > >
> > > > > >  /* Helper function for sizing routines: find first available
> > > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > > > > > 65f1d8c2f082..40b327b814aa 100644
> > > > > > --- a/include/linux/pci.h
> > > > > > +++ b/include/linux/pci.h
> > > > > > @@ -373,6 +373,9 @@ struct pci_dev {
> > > > > >  	bool		match_driver;		/* Skip attaching
> > driver */
> > > > > >
> > > > > >  	unsigned int	transparent:1;		/* Subtractive decode
> > bridge */
> > > > > > +	unsigned int	io_window:1;		/* Bridge has I/O
> > window */
> > > > > > +	unsigned int	pref_window:1;		/* Bridge has pref
> > mem window */
> > > > > > +	unsigned int	pref_64_window:1;	/* Pref mem window
> > is 64-bit */
> > > > > >  	unsigned int	multifunction:1;	/* Multi-function device */
> > > > > >
> > > > > >  	unsigned int	is_busmaster:1;		/* Is busmaster */
> > > > > >
