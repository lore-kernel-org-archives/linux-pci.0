Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
	linux390@de.ibm.com, linux-s390@vger.kernel.org, x86@kernel.org,
	linux-ide@vger.kernel.org, iss_storagedev@hp.com,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
	linux-driver@qlogic.com,
	Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
	"VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: [PATCH RFC 33/77] ioat: Disable MSI-X in case request of IRQ failed
Date: Wed,  2 Oct 2013 12:48:49 +0200
Message-Id: <7e419c7c306eaf3be6fad3250e20d1b3da9675a8.1380703263.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/dma/ioat/dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 5ff6fc1..acee3b2 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -937,6 +937,7 @@ msix:
 				chan = ioat_chan_by_index(device, j);
 				devm_free_irq(dev, msix->vector, chan);
 			}
+			pci_disable_msix(pdev);
 			goto msix_single_vector;
 		}
 	}
-- 
1.7.7.6

