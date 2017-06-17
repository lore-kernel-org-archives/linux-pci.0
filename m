Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbdFQAhT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jun 2017 20:37:19 -0400
Date: Fri, 16 Jun 2017 19:37:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: bhelgaas@google.com, linuxarm@huawei.com,
        linux-pci@vger.kernel.org, lukas@wunner.de,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        hch@infradead.org, liudongdong3@huawei.com
Subject: Re: [PATCH v5 0/2] add MSI support for PCIe port services and DPC
 IRQ support
Message-ID: <20170617003716.GI11129@bhelgaas-glaptop.roam.corp.google.com>
References: <1495549439-10372-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495549439-10372-1-git-send-email-gabriele.paoloni@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 23, 2017 at 03:23:57PM +0100, Gabriele Paoloni wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> This patchset:
> 1) adds support for MSI interrupt vectors to be used for Roor Port services
> 2) adds support for DPC Root Port service interrupt
> 
> The patchset has been tested on Hisilicon Hip08 Chipset
> 
> Changes from v4:
> - removed meaningless comment
> 
> Changes from v3:
> - removed 2 extra lines at the bottom of comments
> 
> Changes from v2:
> - Fixed comment mismatch for function pcie_port_enable_irq_vec
> - removed redundant commet on pci_irq_vector()
> 
> Changes from v1:
> According to comments from Christoph Hellwig in
> https://www.spinics.net/lists/kernel/msg2508842.html
> and
> https://www.spinics.net/lists/kernel/msg2508850.html
> 
> - reduced the calls of pci_alloc_irq_vectors by ORing PCI_IRQ_MSIX and 
>   PCI_IRQ_MSI
> - used a unique macro for the max number of MSI/MSIx interrupt vectors
> - reworked pcie_init_service_irqs() to call pci_alloc_irq_vectors() only
>   for legacy IRQ
> 
> 
> Gabriele Paoloni (1):
>   PCI/portdrv: add support for different MSI interrupts for PCIe port
>     services
> 
> gabriele paoloni (1):
>   PCI/portdrv: allocate MSI/MSIx vector for DPC RP service
> 
>  drivers/pci/pcie/portdrv.h      |  8 ++++--
>  drivers/pci/pcie/portdrv_core.c | 63 +++++++++++++++++++++++++++++------------
>  2 files changed, 50 insertions(+), 21 deletions(-)

Applied to pci/portdrv for v4.13, thanks!

I tweaked the PME/hotplug no-MSI logic in pcie_init_service_irqs()
because I thought it was getting hard to read with the negations and
conjunctions.  Please double-check to make sure I didn't break it.

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/portdrv

I also capitalized your name consistently, Gabriele :)
