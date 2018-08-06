Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55603 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731128AbeHFOjJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Aug 2018 10:39:09 -0400
Date: Mon, 6 Aug 2018 14:35:27 +0200
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
Message-ID: <20180806123527.GB6997@lst.de>
References: <20180804101402.10022-1-hch@lst.de> <20180804101402.10022-3-hch@lst.de> <CAMgXwTgr572J_HH396tfvT7Zj8Jj0fefKOSmVw2+Gwn8qcPR1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMgXwTgr572J_HH396tfvT7Zj8Jj0fefKOSmVw2+Gwn8qcPR1g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 05, 2018 at 01:02:58PM -0700, Wesley Terpstra wrote:
> FYI, This Xilinx PCIe IP 32-bit cap only applies to SOME instances of
> the IP. The Ultrascale+ version of Xilinx PCIe hard IP does support
> 64-bit or 32-bit. The Virtex7 version only supports 32-bit. The
> pcie-xilinx driver woks with both of these root complexes. So probably
> there should be a conditional hook in the DTS that triggers the
> work-around behaviour.

Either we'll need to able to detect which version we use based on
registrs, or we will indeed need firmware information.

Note that we already have the mechanism for firmware directed dma limits
in place, it is called the dma-ranges DT property.  If we can get the
SiFive firmware to set it up properly the RISC-V swiotlb code will
just do the right thing.
