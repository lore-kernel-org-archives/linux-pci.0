Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 14 Apr 2017 14:04:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@ml01.01.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
Message-ID: <20170414190452.GA15679@bhelgaas-glaptop.roam.corp.google.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1491974532.7236.43.camel@kernel.crashing.org>
 <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
 <1492034124.7236.77.camel@kernel.crashing.org>
 <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
 <20170413232631.GB24910@bhelgaas-glaptop.roam.corp.google.com>
 <20170414041656.GA30694@obsidianresearch.com>
 <1492169849.25766.3.camel@kernel.crashing.org>
 <630c1c63-ff17-1116-e069-2b8f93e50fa2@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <630c1c63-ff17-1116-e069-2b8f93e50fa2@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 14, 2017 at 11:30:14AM -0600, Logan Gunthorpe wrote:
> On 14/04/17 05:37 AM, Benjamin Herrenschmidt wrote:
> > I object to designing a subsystem that by design cannot work on whole
> > categories of architectures out there.
> 
> Hardly. That's extreme. We'd design a subsystem that works for the easy
> cases and needs more work to support the offset cases. It would not be
> designed in such a way that it could _never_ support those
> architectures. It would simply be such that it only permits use by the
> cases that are known to work. Then those cases could be expanded as time
> goes on and people work on adding more support.

I'm a little hesitant about excluding offset support, so I'd like to
hear more about this.

Is the issue related to PCI BARs that are not completely addressable
by the CPU?  If so, that sounds like a first-class issue that should
be resolved up front because I don't think the PCI core in general
would deal well with that.

If all the PCI memory of interest is in fact addressable by the CPU,
I would think it would be pretty straightforward to support offsets --
everywhere you currently use a PCI bus address, you just use the
corresponding CPU physical address instead.

> There's tons of stuff that needs to be done to get this upstream. I'd
> rather not require it to work for every possible architecture from the
> start. The testing alone would be impossible. Many subsystems start by
> working for x86 first and then adding support in other architectures
> later. (Often with that work done by the people who care about those
> systems and actually have the hardware to test with.)

I don't think exhaustive testing is that big a deal.  PCI offset
support is generic, so you shouldn't need any arch-specific code to
deal with it.  I'd rather have consistent support across the board,
even though some arches might not be tested.  I think that's simpler
and better than adding checks to disable functionality on some arches
merely on the grounds that it hasn't been tested there.

Bjorn
