Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:47546 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbeIJWQb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Sep 2018 18:16:31 -0400
Date: Mon, 10 Sep 2018 11:22:46 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 16/20] PCI/pciehp: Implement error handling callbacks
Message-ID: <20180910172246.GA7753@localhost.localdomain>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-17-keith.busch@intel.com>
 <20180910132033.ei5nk4iibt7pesd5@wunner.de>
 <20180910145641.GA7466@localhost.localdomain>
 <20180910160926.7grtfdyw3iv2xg4x@wunner.de>
 <20180910164528.GC7466@localhost.localdomain>
 <20180910170848.7q2qii2mm655eghw@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180910170848.7q2qii2mm655eghw@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 10, 2018 at 07:08:48PM +0200, Lukas Wunner wrote:
> On Mon, Sep 10, 2018 at 10:45:28AM -0600, Keith Busch wrote:
> > On Mon, Sep 10, 2018 at 06:09:26PM +0200, Lukas Wunner wrote:
> > > On Mon, Sep 10, 2018 at 08:56:42AM -0600, Keith Busch wrote:
> > > > The sysfs entries still function. Their actions are only temporarily
> > > > stalled during error handling. Once the slot reset is called, the
> > > > ctrl->pending_events is queried to take requested actions.
> > > 
> > > Okay I see.  Still, releasing the IRQ and requesting it again seems fairly
> > > heavy-wheight.  Why not just acquire ctrl->reset_lock?
> > 
> > That was looking like a nice way to handle it, but it introduces
> > circular locking between ctrl->reset_lock and pci_bus_sem:
> > 
> > CPU A                               CPU B
> > ---------------------------------   ------------------------
> > pci_walk_bus                        pciehp_ist
> >  down_read(&pci_bus_sem)             down_read(&ctrl->reset_lock);
> >   pcie_portdrv_error_detected         pciehp_handle_presence_or_link_change
> >    pciehp_error_detected               pciehp_unconfigure_device
> >     down_write(&ctrl->reset_lock)       pci_stop_and_remove_bus_devicea
> >                                          down_write(&pci_bus_sem);
> 
> Why is pciehp bringing down the slot?  Is that in reaction to a
> Link Down caused by the error?  

This could just be something that happens if a hotplug and error event
occur about the same time.

> Can this be solved with Sinan's
> approach to check in pciehp whether PCI_EXP_DEVSTA_FED is set
> and if so, waiting for it to be handled?

That only helps if the downstream port detected a fatal error, but
error handling happens for any device reported error.

> FWIW you can use synchronize_irq() in pciehp_error_detected()
> if you need to wait for the IRQ thread to stop before taking
> the reset_lock.

That would just be a different dead lock: pciehp_error_detected is
holding a read lock on pci_bus_sem, and irq thread may request a
write lock, so both threads are dead locked on each other.
