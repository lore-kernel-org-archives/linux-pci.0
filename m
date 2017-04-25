Return-Path: <SRS0=g+ct=4B=oracle.com=knut.omang@kernel.org>
Return-Path: <SRS0=g+ct=4B=oracle.com=knut.omang@kernel.org>
Message-ID: <1493101803.3171.246.camel@oracle.com>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Knut Omang <knut.omang@oracle.com>
To: Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt
	 <benh@kernel.crashing.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>,
        Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley"
 <jejb@linux.vnet.ibm.com>,
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
Date: Tue, 25 Apr 2017 08:30:03 +0200
In-Reply-To: <9b6c0830-a728-c7ca-e6c6-2135f3f760ed@deltatee.com>
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
	 <5e43818e-8c6b-8be8-23ff-b798633d2a73@deltatee.com>
	 <1492381907.25766.49.camel@kernel.crashing.org>
	 <1493019397.3171.118.camel@oracle.com>
	 <9b6c0830-a728-c7ca-e6c6-2135f3f760ed@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2017-04-24 at 10:14 -0600, Logan Gunthorpe wrote:
>=20
> On 24/04/17 01:36 AM, Knut Omang wrote:
> > My first reflex when reading this thread was to think that this whole d=
omain
> > lends it self excellently to testing via Qemu. Could it be that doing t=
his in=C2=A0
> > the opposite direction might be a safer approach in the long run even t=
hough=C2=A0
> > (significant) more work up-front?
>=20
> That's an interesting idea. We did do some very limited testing on qemu
> with one iteration of our work. However, it's difficult because there is
> no support for any RDMA devices which are a part of our primary use
> case.=20

Yes, that's why I used 'significant'. One good thing is that given resource=
s=C2=A0
it can easily be done in parallel with other development, and will give add=
itional
insight of some form.

> I also imagine it would be quite difficult to develop those models
> given the array of hardware that needs to be supported and the deep
> functional knowledge required to figure out appropriate restrictions.

>From my naive perspective it seems it need not even be a full model to get =
some benefits,
just low level functionality tests with some instances of a
device that offers some MMIO space 'playground'.

Or maybe you can leverage some of the already implemented emulated devices =
in Qemu?

Knut

>=20
> Logan
