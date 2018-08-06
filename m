Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbeHFPt4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Aug 2018 11:49:56 -0400
Date: Mon, 6 Aug 2018 14:40:43 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Wesley Terpstra <wesley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/3] PCI/xilinx: Work-around for hardware DMA limit (32
 bits)
Message-ID: <20180806134043.GD18685@e107981-ln.cambridge.arm.com>
References: <20180804101402.10022-1-hch@lst.de>
 <20180804101402.10022-3-hch@lst.de>
 <CAMgXwTgr572J_HH396tfvT7Zj8Jj0fefKOSmVw2+Gwn8qcPR1g@mail.gmail.com>
 <20180806123527.GB6997@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180806123527.GB6997@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 06, 2018 at 02:35:27PM +0200, Christoph Hellwig wrote:
> On Sun, Aug 05, 2018 at 01:02:58PM -0700, Wesley Terpstra wrote:
> > FYI, This Xilinx PCIe IP 32-bit cap only applies to SOME instances of
> > the IP. The Ultrascale+ version of Xilinx PCIe hard IP does support
> > 64-bit or 32-bit. The Virtex7 version only supports 32-bit. The
> > pcie-xilinx driver woks with both of these root complexes. So probably
> > there should be a conditional hook in the DTS that triggers the
> > work-around behaviour.
> 
> Either we'll need to able to detect which version we use based on
> registrs, or we will indeed need firmware information.
> 
> Note that we already have the mechanism for firmware directed dma limits
> in place, it is called the dma-ranges DT property.  If we can get the
> SiFive firmware to set it up properly the RISC-V swiotlb code will
> just do the right thing.

It would do the right thing without patches 1 and 2 (I would
consider merging patch 1 anyway - see pcibios_add_device()
removal).

It seems to me that the best course of action consists in patching
firmware, that would remove the need for patch 2 (I will merge patch
1 anyway - even if that's for a "different" purpose, see
pcibios_add_device() removal), please let us know.

Thanks,
Lorenzo
