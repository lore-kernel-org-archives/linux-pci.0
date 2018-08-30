Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 30 Aug 2018 15:20:12 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v5 00/13] Copy Offload in NVMe Fabrics with P2P PCI Memory
Message-ID: <20180830192012.GG3529@redhat.com>
References: <20180830185352.3369-1-logang@deltatee.com>
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-1-logang@deltatee.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 30, 2018 at 12:53:39PM -0600, Logan Gunthorpe wrote:

[...]

> =

> When the PCI P2PDMA config option is selected the ACS bits in every
> bridge port in the system are turned off to allow traffic to
> pass freely behind the root port. At this time, the bit must be disabled
> at boot so the IOMMU subsystem can correctly create the groups, though
> this could be addressed in the future. There is no way to dynamically
> disable the bit and alter the groups.

Can you provide an example on how to test this ? Like kernel command
line option, the doc patch does not have any such example. It would be
nice to add.

Maybe i have miss it in some of the patch. I just skimmed over for
now.

Cheers,
J=E9r=F4me

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
