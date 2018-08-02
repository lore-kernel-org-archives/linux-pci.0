Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:38209 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbeHBI7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Aug 2018 04:59:23 -0400
Date: Thu, 2 Aug 2018 09:14:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wesley Terpstra <wesley@sifive.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: add support for Xilinx PCIe root ports on RISC-V v2
Message-ID: <20180802071414.GA11584@lst.de>
References: <20180801151403.20660-1-hch@lst.de> <CAMgXwThU2h3Grm+10S0Env1ZUYK5Q7pze+ckADjjyHEUVGs7=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMgXwThU2h3Grm+10S0Env1ZUYK5Q7pze+ckADjjyHEUVGs7=A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 01, 2018 at 04:02:34PM -0700, Wesley Terpstra wrote:
> FYI, I don't believe this solution is the one we intended to merge
> upstream. There is a different approach used in the riscv-linux tree
> from Palmer.

This is the solution I as the dma-mapping maintainer want for upstream,
and I'm trying to convince the PCI maintainers to agree with me.

What is in the RISC-V trees is a horribly bad idea that should have
never seen the light of day (copying dma_map_ops and patching them up).
