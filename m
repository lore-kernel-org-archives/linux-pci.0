Return-Path: <SRS0=6mTy=IL=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=6mTy=IL=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 24 May 2018 17:58:25 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc: "myron.stowe@redhat.com" <myron.stowe@redhat.com>,
	"hch@lst.de" <hch@lst.de>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"Bauer, Scott" <scott.bauer@intel.com>,
	"jroedel@suse.de" <jroedel@suse.de>,
	"Fugate, David" <david.fugate@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH 0/5] Enable an additional VMD device id
Message-ID: <20180524165825.GA26309@e107981-ln.cambridge.arm.com>
References: <20180518192802.20371-1-jonathan.derrick@intel.com>
 <20180524114452.GA20732@e107981-ln.cambridge.arm.com>
 <1527178507.20527.2.camel@intel.com>
 <20180524163420.GA24940@e107981-ln.cambridge.arm.com>
 <1527179806.8026.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527179806.8026.1.camel@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2018 at 04:36:48PM +0000, Derrick, Jonathan wrote:
> On Thu, 2018-05-24 at 17:34 +0100, Lorenzo Pieralisi wrote:
> > On Thu, May 24, 2018 at 04:15:08PM +0000, Derrick, Jonathan wrote:
> > > Hi Lorenzo,
> > > 
> > > On Thu, 2018-05-24 at 12:44 +0100, Lorenzo Pieralisi wrote:
> > > > On Fri, May 18, 2018 at 01:27:57PM -0600, Jon Derrick wrote:
> > > > > This patchset enables an additional VMD device ID to the VMD
> > > > > driver
> > > > > supporting assignment of the membar addresses from shadow
> > > > > registers
> > > > > and
> > > > > allows more flexibility in assigning bus numbers to a VMD PCIe
> > > > > domain.
> > > > > Additional VMD root port device ids have been added to the VMD
> > > > > AER
> > > > > quirk.
> > > > > 
> > > > > Changes from rfc include comments, code structure, and using
> > > > > pci_add_resource_offset to correctly assign addresses while
> > > > > virtualized.
> > > > > 
> > > > > Applies to Bjorn's next branch
> > > > 
> > > > Hi Jon,
> > > > 
> > > > You should base it on v4.17-rc1 and if there is a dependency on
> > > > later -rc* or a branch in Bjorn/my queue please let us know.
> > > 
> > > It looks like it applies cleanly to 4.17-rc1 and rc6.
> > > 
> > > > > Jon Derrick (5):
> > > > >   PCI: Add Intel VMD devices to pci ids
> > > > >   PCI/VMD: Assign membar addresses from shadow registers
> > > > >   PCI/VMD: Add offset to bus numbers if necessary
> > > > >   x86/PCI: Add additional VMD device root ports to VMD AER
> > > > > quirk
> > > > >   PCI/VMD: Add an additional VMD device id to driver device id
> > > > > table
> > > > > 
> > > > >  arch/x86/pci/fixup.c    |  4 +++
> > > > >  drivers/pci/host/vmd.c  | 91
> > > > > +++++++++++++++++++++++++++++++++++++++++++------
> > > > >  include/linux/pci_ids.h |  2 ++
> > > > >  3 files changed, 87 insertions(+), 10 deletions(-)
> > > > 
> > > > I need Bjorn's ACK on patch (4), or if Bjorn is keen on pulling
> > > > the
> > > > series, here's mine on the series:
> > > > 
> > > > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > 
> > > Would you like me to rebase it and resend with Bjorn's ack?
> > 
> > No need to resend but I need Bjorn's ACK on patch (4) in order to
> > queue it.
> > 
> > Thanks,
> > Lorenzo
> 
> Here's Bjorn's ack since you may not have it seen it yet:
> https://patchwork.ozlabs.org/patch/916565/

Ok sorry it is because I am not CC'ed on the patches, I did not notice.

Applied the series to pci/vmd for v4.18, thanks.

Lorenzo
