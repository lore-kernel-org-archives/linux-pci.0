Return-Path: <SRS0=93Wk=3W=au1.ibm.com=benh@kernel.org>
Return-Path: <SRS0=93Wk=3W=au1.ibm.com=benh@kernel.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe
	 <jgunthorpe@obsidianresearch.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "James
 E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise
 <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>, Max
 Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@ml01.01.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>
Date: Fri, 14 Apr 2017 21:39:52 +1000
In-Reply-To: <1492169879.25766.4.camel@kernel.crashing.org>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
	 <1491974532.7236.43.camel@kernel.crashing.org>
	 <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
	 <1492034124.7236.77.camel@kernel.crashing.org>
	 <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
	 <20170413232631.GB24910@bhelgaas-glaptop.roam.corp.google.com>
	 <20170414041656.GA30694@obsidianresearch.com>
	 <08c32f0d-6c7c-b65f-6453-dde0d7c173d1@deltatee.com>
	 <1492169879.25766.4.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1492169992.25766.5.camel@au1.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2017-04-14 at 21:37 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2017-04-13 at 22:40 -0600, Logan Gunthorpe wrote:
> > 
> > On 13/04/17 10:16 PM, Jason Gunthorpe wrote:
> > > I'd suggest just detecting if there is any translation in bus
> > > addresses anywhere and just hard disabling P2P on such systems.
> > 
> > That's a fantastic suggestion. It simplifies things significantly.
> > Unless there are any significant objections I think I will plan on
> > doing
> > that.
> 
> I object.

Note: It would also make your stuff fundamentally incompatible with
KVM guest pass-through since KVM plays with remapping BARs all over
the place.

Ben.

> > > On modern hardware with 64 bit BARs there is very little reason
> > > to
> > > have translation, so I think this is a legacy feature.
> > 
> > Yes, p2pmem users are likely to be designing systems around it (ie
> > JBOFs) and not trying to shoehorn it onto legacy architectures.
> > 
> > At the very least, it makes sense to leave it out and if someone
> > comes
> > along who cares they can put in the effort to support the address
> > translation.
> > 
> > Thanks,
> > 
> > Logan
