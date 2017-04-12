Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55947 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbdDLGYK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Apr 2017 02:24:10 -0400
Message-ID: <1491974532.7236.43.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@ml01.01.org, linux-kernel@vger.kernel.org
Date: Wed, 12 Apr 2017 15:22:12 +1000
In-Reply-To: <1490911959-5146-1-git-send-email-logang@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2017-03-30 at 16:12 -0600, Logan Gunthorpe wrote:
> Hello,
> 
> As discussed at LSF/MM we'd like to present our work to enable
> copy offload support in NVMe fabrics RDMA targets. We'd appreciate
> some review and feedback from the community on our direction.
> This series is not intended to go upstream at this point.
> 
> The concept here is to use memory that's exposed on a PCI BAR as
> data buffers in the NVME target code such that data can be transferred
> from an RDMA NIC to the special memory and then directly to an NVMe
> device avoiding system memory entirely. The upside of this is better
> QoS for applications running on the CPU utilizing memory and lower
> PCI bandwidth required to the CPU (such that systems could be designed
> with fewer lanes connected to the CPU). However, presently, the trade-off
> is currently a reduction in overall throughput. (Largely due to hardware
> issues that would certainly improve in the future).

Another issue of course is that not all systems support P2P
between host bridges :-) (Though almost all switches can enable it).

> Due to these trade-offs we've designed the system to only enable using
> the PCI memory in cases where the NIC, NVMe devices and memory are all
> behind the same PCI switch.

Ok. I suppose that's a reasonable starting point. Do I haven't looked
at the patches in detail yet but it would be nice if that policy was in
a well isolated component so it can potentially be affected by
arch/platform code.

Do you handle funky address translation too ? IE. the fact that the PCI
addresses aren't the same as the CPU physical addresses for a BAR ?

> This will mean many setups that could likely
> work well will not be supported so that we can be more confident it
> will work and not place any responsibility on the user to understand
> their topology. (We've chosen to go this route based on feedback we
> received at LSF).
> 
> In order to enable this functionality we introduce a new p2pmem device
> which can be instantiated by PCI drivers. The device will register some
> PCI memory as ZONE_DEVICE and provide an genalloc based allocator for
> users of these devices to get buffers.

I don't completely understand this. This is actual memory on the PCI
bus ? Where does it come from ? Or are you just trying to create struct
pages that cover your PCIe DMA target ?
 
> We give an example of enabling
> p2p memory with the cxgb4 driver, however currently these devices have
> some hardware issues that prevent their use so we will likely be
> dropping this patch in the future. Ideally, we'd want to enable this
> functionality with NVME CMB buffers, however we don't have any hardware
> with this feature at this time.

So correct me if I'm wrong, you are trying to create struct page's that
map a PCIe BAR right ? I'm trying to understand how that interacts with
what Jerome is doing for HMM.

The reason is that the HMM currently creates the struct pages with
"fake" PFNs pointing to a hole in the address space rather than
covering the actual PCIe memory of the GPU. He does that to deal with
the fact that some GPUs have a smaller aperture on PCIe than their
total memory.

However, I have asked him to only apply that policy if the aperture is
indeed smaller, and if not, create struct pages that directly cover the
PCIe BAR of the GPU instead, which will work better on systems or
architecture that don't have a "pinhole" window limitation.

However he was under the impression that this was going to collide with
what you guys are doing, so I'm trying to understand how. 

> In nvmet-rdma, we attempt to get an appropriate p2pmem device at
> queue creation time and if a suitable one is found we will use it for
> all the (non-inlined) memory in the queue. An 'allow_p2pmem' configfs
> attribute is also created which is required to be set before any p2pmem
> is attempted.
> 
> This patchset also includes a more controversial patch which provides an
> interface for userspace to obtain p2pmem buffers through an mmap call on
> a cdev. This enables userspace to fairly easily use p2pmem with RDMA and
> O_DIRECT interfaces. However, the user would be entirely responsible for
> knowing what their doing and inspecting sysfs to understand the pci
> topology and only using it in sane situations.
> 
> Thanks,
> 
> Logan
> 
> 
> Logan Gunthorpe (6):
>   Introduce Peer-to-Peer memory (p2pmem) device
>   nvmet: Use p2pmem in nvme target
>   scatterlist: Modify SG copy functions to support io memory.
>   nvmet: Be careful about using iomem accesses when dealing with p2pmem
>   p2pmem: Support device removal
>   p2pmem: Added char device user interface
> 
> Steve Wise (2):
>   cxgb4: setup pcie memory window 4 and create p2pmem region
>   p2pmem: Add debugfs "stats" file
> 
>  drivers/memory/Kconfig                          |   5 +
>  drivers/memory/Makefile                         |   2 +
>  drivers/memory/p2pmem.c                         | 697 ++++++++++++++++++++++++
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h      |   3 +
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |  97 +++-
>  drivers/net/ethernet/chelsio/cxgb4/t4_regs.h    |   5 +
>  drivers/nvme/target/configfs.c                  |  31 ++
>  drivers/nvme/target/core.c                      |  18 +-
>  drivers/nvme/target/fabrics-cmd.c               |  28 +-
>  drivers/nvme/target/nvmet.h                     |   2 +
>  drivers/nvme/target/rdma.c                      | 183 +++++--
>  drivers/scsi/scsi_debug.c                       |   7 +-
>  include/linux/p2pmem.h                          | 120 ++++
>  include/linux/scatterlist.h                     |   7 +-
>  lib/scatterlist.c                               |  64 ++-
>  15 files changed, 1189 insertions(+), 80 deletions(-)
>  create mode 100644 drivers/memory/p2pmem.c
>  create mode 100644 include/linux/p2pmem.h
> 
> --
> 2.1.4
