Return-Path: <SRS0=TGTz=4B=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=TGTz=4B=deltatee.com=logang@kernel.org>
To: Knut Omang <knut.omang@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Williams <dan.j.williams@intel.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
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
 <1493101803.3171.246.camel@oracle.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, Steve Wise <swise@opengridcomputing.com>,
 Stephen Bates <sbates@raithlin.com>, Max Gurtovoy <maxg@mellanox.com>,
 Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
 linux-scsi <linux-scsi@vger.kernel.org>, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm <linux-nvdimm@ml01.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jerome Glisse <jglisse@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0cc95df5-b9dd-6493-15fe-771d535c1020@deltatee.com>
Date: Tue, 25 Apr 2017 11:03:27 -0600
MIME-Version: 1.0
In-Reply-To: <1493101803.3171.246.camel@oracle.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 25/04/17 12:30 AM, Knut Omang wrote:
> Yes, that's why I used 'significant'. One good thing is that given resources 
> it can easily be done in parallel with other development, and will give additional
> insight of some form.

Yup, well if someone wants to start working on an emulated RDMA device
that actually simulates proper DMA transfers that would be great!

>> I also imagine it would be quite difficult to develop those models
>> given the array of hardware that needs to be supported and the deep
>> functional knowledge required to figure out appropriate restrictions.
> 
> From my naive perspective it seems it need not even be a full model to get some benefits,
> just low level functionality tests with some instances of a
> device that offers some MMIO space 'playground'.

Yes, the nvme device in qemu has a CMB buffer which is a good choice to
test with but we don't have code to use it for p2p transfers in the
kernel so it is a bit awkward. We also posted [1] to qemu which was also
handy to test with using a small out of tree module. But I don't see a
lot of value in it if you completely ignore any hardware quirks.

Logan

[1] https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg04331.html
