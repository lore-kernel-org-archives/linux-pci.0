Return-Path: <SRS0=kBs1=3Y=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=kBs1=3Y=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492381577.25766.46.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas
 <helgaas@kernel.org>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "James
 E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise
 <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>, Max
 Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm
 <linux-nvdimm@ml01.01.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>
Date: Mon, 17 Apr 2017 08:26:17 +1000
In-Reply-To: <CAPcyv4iqnz1B00Q3xG-nGrLXdOyB7ditxmwZyotksLFgUqr+jA@mail.gmail.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
	 <1491974532.7236.43.camel@kernel.crashing.org>
	 <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
	 <1492034124.7236.77.camel@kernel.crashing.org>
	 <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
	 <20170413232631.GB24910@bhelgaas-glaptop.roam.corp.google.com>
	 <20170414041656.GA30694@obsidianresearch.com>
	 <1492169849.25766.3.camel@kernel.crashing.org>
	 <630c1c63-ff17-1116-e069-2b8f93e50fa2@deltatee.com>
	 <20170414190452.GA15679@bhelgaas-glaptop.roam.corp.google.com>
	 <1492207643.25766.18.camel@kernel.crashing.org>
	 <bff1e503-95a9-e19f-bfd9-0ff962c63a81@deltatee.com>
	 <CAPcyv4jUeKzKDARp6Z35kdPLKnP-M6aF8X5KpOx55CLyjnj4dA@mail.gmail.com>
	 <1492311719.25766.37.camel@kernel.crashing.org>
	 <CAPcyv4iqnz1B00Q3xG-nGrLXdOyB7ditxmwZyotksLFgUqr+jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2017-04-16 at 08:53 -0700, Dan Williams wrote:
> > Just thinking out loud ... I don't have a firm idea or a design. But
> > peer to peer is definitely a problem we need to tackle generically, the
> > demand for it keeps coming up.
> 
> ZONE_DEVICE allows you to redirect via get_dev_pagemap() to retrieve
> context about the physical address in question. I'm thinking you can
> hang bus address translation data off of that structure. This seems
> vaguely similar to what HMM is doing.

Ok, that's interesting. That would be a way to handle the "lookup" I
was mentioning in the email I sent a few minutes ago.

We would probably need to put some "structure" to that context.

I'm very short on time to look into the details of this for at least
a month (I'm taking about 3 weeks off for personal reasons next week),
but I'm happy to dive more into this when I'm back and sort out with
Jerome how to make it all co-habitate nicely with HMM.

Cheers,
Ben.
