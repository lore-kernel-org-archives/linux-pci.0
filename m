Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:36240 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeIDTzN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 15:55:13 -0400
Date: Tue, 4 Sep 2018 09:31:02 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Subject: Re: [PATCH 14/16] pciehp: Ignore link events during DPC event
Message-ID: <20180904153101.GA18331@localhost.localdomain>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-15-keith.busch@intel.com>
 <20180902142714.wsqi4rfggundjli7@wunner.de>
 <20180904141602.GG9677@localhost.localdomain>
 <20180904144014.f3et3jy2lbffh27l@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180904144014.f3et3jy2lbffh27l@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 04, 2018 at 04:40:14PM +0200, Lukas Wunner wrote:
> On Tue, Sep 04, 2018 at 08:16:02AM -0600, Keith Busch wrote:
> > On Sun, Sep 02, 2018 at 04:27:14PM +0200, Lukas Wunner wrote:
> > > On Fri, Aug 31, 2018 at 03:26:37PM -0600, Keith Busch wrote:
> > > > This patch adds a channel state to a subordinate bus. When a DPC event is
> > > > triggered, the DPC driver will set the channel state to frozen, and the
> > > > pciehp driver will ignore link events if the subordinate bus is being
> > > > managed by DPC error handling.
> > > > 
> > > > This is safe because the pciehp and DPC drivers share the same
> > > > interrupt. The DPC driver sets the bus state in the top-half interrupt
> > > > context, and the pciehp driver checks and masks off link events in its
> > > > bottom-half error handler.
> > > 
> > > I really liked Sinan's approach of checking in pciehp whether a fatal
> > > error is pending and waiting for it to be handled:
> > > https://patchwork.ozlabs.org/patch/959464/
> > > 
> > > This seemed to avoid any races with DPC and is small and simple.
> > > Can we pursue a solution along those lines?
> > 
> > That introduces a completely different race between the error handling
> > and hotplug threads. We don't control  which interrupt fires first or
> > any way ensure they're even the same event.
> 
> pciehp may react quicker than dpc, hence needs to determine a fatal
> error is pending without relying on dpc.  My understanding is that
> this is achieved by Sinan checking PCI_EXP_DEVSTA_FED directly from
> pciehp.

That's only true if the bridge detects ERR_FATAL, which is one of several
ways to trigger DPC or AER. If the message comes from the end device,
then PCI_EXP_DEVSTA_FED won't be set in the bridge that pciehp can
read.

> For the case when dpc reacts quicker and clears the error before
> pciehp checks for PCI_EXP_DEVSTA_FED, you need an additional
> synchronization mechanism between dpc and pciehp, such as a flag
> that is set by dpc before clearing the error, and that is checked
> by pciehp.  Though you need to take care that pciehp does not see
> a stale flag when the next error occurs.

Yes, the pci_bus error_state this patch creates was intended to be
that flag.
