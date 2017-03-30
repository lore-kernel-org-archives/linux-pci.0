Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
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
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 30 Mar 2017 16:12:31 -0600
Message-Id: <1490911959-5146-1-git-send-email-logang@deltatee.com>
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

As discussed at LSF/MM we'd like to present our work to enable
copy offload support in NVMe fabrics RDMA targets. We'd appreciate
some review and feedback from the community on our direction.
This series is not intended to go upstream at this point.

The concept here is to use memory that's exposed on a PCI BAR as
data buffers in the NVME target code such that data can be transferred
from an RDMA NIC to the special memory and then directly to an NVMe
device avoiding system memory entirely. The upside of this is better
QoS for applications running on the CPU utilizing memory and lower
PCI bandwidth required to the CPU (such that systems could be designed
with fewer lanes connected to the CPU). However, presently, the trade-off
is currently a reduction in overall throughput. (Largely due to hardware
issues that would certainly improve in the future).

Due to these trade-offs we've designed the system to only enable using
the PCI memory in cases where the NIC, NVMe devices and memory are all
behind the same PCI switch. This will mean many setups that could likely
work well will not be supported so that we can be more confident it
will work and not place any responsibility on the user to understand
their topology. (We've chosen to go this route based on feedback we
received at LSF).

In order to enable this functionality we introduce a new p2pmem device
which can be instantiated by PCI drivers. The device will register some
PCI memory as ZONE_DEVICE and provide an genalloc based allocator for
users of these devices to get buffers. We give an example of enabling
p2p memory with the cxgb4 driver, however currently these devices have
some hardware issues that prevent their use so we will likely be
dropping this patch in the future. Ideally, we'd want to enable this
functionality with NVME CMB buffers, however we don't have any hardware
with this feature at this time.

In nvmet-rdma, we attempt to get an appropriate p2pmem device at
queue creation time and if a suitable one is found we will use it for
all the (non-inlined) memory in the queue. An 'allow_p2pmem' configfs
attribute is also created which is required to be set before any p2pmem
is attempted.

This patchset also includes a more controversial patch which provides an
interface for userspace to obtain p2pmem buffers through an mmap call on
a cdev. This enables userspace to fairly easily use p2pmem with RDMA and
O_DIRECT interfaces. However, the user would be entirely responsible for
knowing what their doing and inspecting sysfs to understand the pci
topology and only using it in sane situations.

Thanks,

Logan


Logan Gunthorpe (6):
  Introduce Peer-to-Peer memory (p2pmem) device
  nvmet: Use p2pmem in nvme target
  scatterlist: Modify SG copy functions to support io memory.
  nvmet: Be careful about using iomem accesses when dealing with p2pmem
  p2pmem: Support device removal
  p2pmem: Added char device user interface

Steve Wise (2):
  cxgb4: setup pcie memory window 4 and create p2pmem region
  p2pmem: Add debugfs "stats" file

 drivers/memory/Kconfig                          |   5 +
 drivers/memory/Makefile                         |   2 +
 drivers/memory/p2pmem.c                         | 697 ++++++++++++++++++++++++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h      |   3 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |  97 +++-
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h    |   5 +
 drivers/nvme/target/configfs.c                  |  31 ++
 drivers/nvme/target/core.c                      |  18 +-
 drivers/nvme/target/fabrics-cmd.c               |  28 +-
 drivers/nvme/target/nvmet.h                     |   2 +
 drivers/nvme/target/rdma.c                      | 183 +++++--
 drivers/scsi/scsi_debug.c                       |   7 +-
 include/linux/p2pmem.h                          | 120 ++++
 include/linux/scatterlist.h                     |   7 +-
 lib/scatterlist.c                               |  64 ++-
 15 files changed, 1189 insertions(+), 80 deletions(-)
 create mode 100644 drivers/memory/p2pmem.c
 create mode 100644 include/linux/p2pmem.h

--
2.1.4
