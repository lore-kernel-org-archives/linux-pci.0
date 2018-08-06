Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56668 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733097AbeHFSix (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Aug 2018 14:38:53 -0400
Date: Mon, 6 Aug 2018 18:34:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wesley Terpstra <wesley@sifive.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/3] PCI/xilinx: Work-around for hardware DMA limit (32
        bits)
Message-ID: <20180806163416.GA18429@lst.de>
References: <20180804101402.10022-1-hch@lst.de> <20180804101402.10022-3-hch@lst.de> <CAMgXwTgr572J_HH396tfvT7Zj8Jj0fefKOSmVw2+Gwn8qcPR1g@mail.gmail.com> <20180806123527.GB6997@lst.de> <CAMgXwTjcjdiBN9yksL9zuZQyGjckC+F+qwzSm32RjjFSWHFCPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMgXwTjcjdiBN9yksL9zuZQyGjckC+F+qwzSm32RjjFSWHFCPQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 06, 2018 at 09:21:40AM -0700, Wesley Terpstra wrote:
> On Mon, Aug 6, 2018 at 5:35 AM, Christoph Hellwig <hch@lst.de> wrote:
> > Note that we already have the mechanism for firmware directed dma limits
> > in place, it is called the dma-ranges DT property.  If we can get the
> > SiFive firmware to set it up properly the RISC-V swiotlb code will
> > just do the right thing.
> 
> Does this mean we only need to set the dma-ranges property inside the
> pci DTS node? No changes to the driver needed?

The code looks at the DT parent of the PCI bridge device.  Take a look
at drivers/pci/pci-driver.c:pci_dma_configure() and
drivers/of/device.c:of_dma_configure() in 4.18-rc (for older kernels
the involved functions are slightly different, but the functionality
is the same).
