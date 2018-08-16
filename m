Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbeHPX7m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 19:59:42 -0400
Date: Thu, 16 Aug 2018 15:59:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] PCI: add a callback to struct pci_host_bridge for
 adding a new device
Message-ID: <20180816205901.GA15085@bhelgaas-glaptop.roam.corp.google.com>
References: <20180801151403.20660-1-hch@lst.de>
 <20180801151403.20660-2-hch@lst.de>
 <20180802165430.GA13725@red-moon>
 <20180815195227.GG28888@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180815195227.GG28888@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 15, 2018 at 02:52:28PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 02, 2018 at 05:54:30PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Aug 01, 2018 at 05:14:01PM +0200, Christoph Hellwig wrote:
> > > There is currently no way for a PCIe bridge to impose constraints on
> > > devices added to it.  For example, the Xilinx PCIe host bridge only
> > > supports 32-bit physical addresses (due to a limitation on the AXI
> > > port's address width).  Thus, even devices that claim to support 64-bit
> > > DMA addresses must be restricted to 32-bit addresses when attached to
> > > this host controller.
> > > 
> > > This patch adds a "add_dev" method  to struct pci_host_bridge that
> > > allows the host driver to act upon acting adding devices.
> > > 
> > > Based on an earlier patch from Wesley W. Terpstra <wesley@sifive.com>.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  drivers/pci/probe.c | 4 ++++
> > >  include/linux/pci.h | 1 +
> > >  2 files changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index ac876e32de4b..8736d78ffc66 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -2290,6 +2290,7 @@ static void pci_set_msi_domain(struct pci_dev *dev)
> > >  
> > >  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
> > >  {
> > > +	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> > >  	int ret;
> > >  
> > >  	pci_configure_device(dev);
> > > @@ -2331,6 +2332,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
> > >  	/* Set up MSI IRQ domain */
> > >  	pci_set_msi_domain(dev);
> > >  
> > > +	if (host->add_dev)
> > > +		host->add_dev(dev);
> > 
> > Hi Christoph,
> > 
> > while at it, IMHO it would be good to match the current
> > pcibios_add_device() prototype (ie returning an int error value)
> > so that this change can pave the way to removing yet another
> > pcibios call.
> > 
> > Actually we could make pcibios_add_device() removal as part of this
> > series but you would have to patch all related host bridge drivers
> > initializations so I am happy for this patch to go standalone (I can
> > patch the rest of the code) - I leave it to Bjorn's decision.
> 
> This patch seems OK to me.
> 
> I don't really care about the prototype.  There's only one
> pcibios_add_device() implementation (x86) that returns anything other
> than 0, and that's a pretty obscure error case related to f9a37be0f02a
> ("x86: Use PCI setup data"), which lets us use ROM data from boot
> services.  Even then the only thing that happens is a WARN_ON().  A
> more descriptive printk would be a lot more useful.

Thinking about this some more, I'm not so sure about the connection
with removing pcibios_add_device().  This host_bridge->add_dev() hook
would be for host bridge-specific things, while pcibios_add_device()
is for arch-specific things.

I'd still love to get rid of pcibios_add_device() (especially the
non-arch-specific things like the pci_claim_resource() in s390); I'm
just not sure yet whether this particular patch is the vehicle.
