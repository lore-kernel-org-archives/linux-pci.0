Return-Path: <SRS0=7amg=6Q=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=7amg=6Q=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 13 Jul 2017 10:26:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/2] Workaround for uPD72020x USB3 chips
Message-ID: <20170713082640.GA6367@kroah.com>
References: <20170710155230.8622-1-marc.zyngier@arm.com>
 <20170713031234.GD4486@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713031234.GD4486@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 12, 2017 at 10:12:34PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 10, 2017 at 04:52:28PM +0100, Marc Zyngier wrote:
> > Ard and myself have just spent quite some time lately trying to pin
> > down an issue in the DMA code which was taking the form of a PCIe USB3
> > controller issuing a DMA access at some bizarre address, and being
> > caught red-handed by the IOMMU.
> > 
> > After much head scratching and most of a week-end spent on tracing the
> > damn thing, I'm now convinced that the DMA code is fine, the XHCI
> > driver is correct, but that the HW (a Renesas uPD720202 chip) is a
> > nasty piece of work.
> > 
> > The issue is as follow:
> > 
> > - EFI initializes the controller using physical addresses above the
> >   4GB limit (this is on an arm64 box where the memory starts at
> >   0x80_00000000...).
> > 
> > - The kernel takes over, sends a XHCI reset to the controller, and
> >   because we have an IOMMU sitting between the controller and memory,
> >   provides *virtual* addresses. Trying to make things a bit faster for
> >   our controller, it issues IOVAs in the low 4GB range).
> > 
> > - Low and behold, the controller is now issuing transactions with a
> >   0x80 prefix in front of our IOVA. Yes, the same prefix that was
> >   programmed during the EFI configuration. IOMMU fault, not happy.
> > 
> > If the kernel is hacked to only generate IOVAs that are more than
> > 32bit wide, the HW behaves correctly. The only way I can explain this
> > behaviour is that the HW latches the top 32bit of the ERST (it is
> > always the ERST IOVA that appears in my traces) in some internal
> > register, and that the XHCI reset fails to clear it. Writing zero in
> > the top bits is not enough to clear it either.
> > 
> > So far, the only solution we have for this lovely piece of kit is to
> > force a PCI reset at probe time, which puts it right. The patches are
> > pretty ugly, but that's the best I could come up with so far.
> > 
> > Tested on a pair of AMD Opteron 1100 boxes with Renesas uPD720201 and
> > uPD720202 controllers.
> > 
> > Marc Zyngier (2):
> >   PCI: Implement pci_reset_function_locked
> >   usb: host: pci_quirks: Force hard reset of Renesas uPD72020x USB
> >     controller
> > 
> >  drivers/pci/pci.c             | 35 +++++++++++++++++++++++++++++++++++
> >  drivers/usb/host/pci-quirks.c | 20 ++++++++++++++++++++
> >  drivers/usb/host/pci-quirks.h |  1 +
> >  drivers/usb/host/xhci-pci.c   |  7 +++++++
> >  include/linux/pci.h           |  1 +
> >  5 files changed, 64 insertions(+)
> 
> I provisionally applied this to pci/virtualization.  I'd like to have an
> XHCI ack before going further, though.

The xhci maintainer is on vacation, let's wait a week for him to get
back to get this.  Given the long time that this has been broken on this
hardware, I think we can wait another week just fine :)

thanks,

greg k-h
