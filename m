Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Aug 2015 19:49:06 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Mike Marciniszyn <infinipath@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>,
	"Busch, Keith" <keith.busch@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	infinipath <infinipath@intel.com>
Subject: Re: [PATCH 2/3] QIB: Removing usage of pcie_set_mps()
Message-ID: <20150818014906.GA10427@obsidianresearch.com>
References: <1438208335-19457-1-git-send-email-keith.busch@intel.com>
 <1438208335-19457-3-git-send-email-keith.busch@intel.com>
 <20150817223039.GK26431@google.com>
 <1439851811.3253.18.camel@intel.com>
 <CAErSpo7GEbAtkXr-VgifNtdcaDUCOkeFMcdzDXvdC-QH2qT7=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7GEbAtkXr-VgifNtdcaDUCOkeFMcdzDXvdC-QH2qT7=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 17, 2015 at 07:06:10PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 17, 2015 at 5:50 PM, Jiang, Dave <dave.jiang@intel.com> wrote:
> > On Mon, 2015-08-17 at 17:30 -0500, Bjorn Helgaas wrote:
> >> [+cc Mike, linux-rdma]
> >>
> >> On Wed, Jul 29, 2015 at 04:18:54PM -0600, Keith Busch wrote:
> >> > From: Dave Jiang <dave.jiang@intel.com>
> >> >
> >> > This is in perperation of un-exporting the pcie_set_mps() function
> >> > symbol. A driver should not be changing the MPS as that is the
> >> > responsibility of the PCI subsystem.
> >>
> >> Please explain the implications of removing this code.  Does this
> >> affect
> >> performance of the device?  If so, how do we get that performance
> >> back?
> >
> > Honestly I don't know. But at the same time I think the driver
> > shouldn't be touching the MPS at all. Shouldn't that be left to the
> > PCIe subsystem and rely on the PCIe subsystem to set this to a sane
> > value?
> 
> Yes, I think in principle the PCI core should own this, but I also
> don't want to introduce a performance regression, so I think we need
> to understand whether there's a problem, and if there is, fix it.

Making sure Mike is CC'd directly..

Mike: I see this has been cut and pasted to HFI1 too, I would be
disappointed if HFI needs it as well. :(

FWIW, I totally agree with the above. MPS/MRS and related have to do
with root port capability, switches in the path and any platform
bugs..

I'm not sure why a driver would ever want to mess with this, and since
this code doesn't walk the bus toward the root port, it is technically
wrong, right? I also find it strange that qib_pcie_caps defaults to
zero which means the 'tuning' reduces the payload size to the minimums
(??)

> >> >     /*
> >> >      * Now the Read Request size.
> >> >      * No field for max supported, but PCIe spec limits it to
> >> > 4096,

.. it has been a bit since I looked at this, but IIRC, MRRS is also
something that should not be touched by a driver?

Jason
