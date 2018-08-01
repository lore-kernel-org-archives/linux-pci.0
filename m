Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:44930 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeHBAun (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 20:50:43 -0400
Received: by mail-yw0-f173.google.com with SMTP id l9-v6so99246ywc.11
        for <linux-pci@vger.kernel.org>; Wed, 01 Aug 2018 16:02:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180801151403.20660-1-hch@lst.de>
References: <20180801151403.20660-1-hch@lst.de>
From: Wesley Terpstra <wesley@sifive.com>
Date: Wed, 1 Aug 2018 16:02:34 -0700
Message-ID: <CAMgXwThU2h3Grm+10S0Env1ZUYK5Q7pze+ckADjjyHEUVGs7=A@mail.gmail.com>
Subject: Re: add support for Xilinx PCIe root ports on RISC-V v2
To: Christoph Hellwig <hch@lst.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

FYI, I don't believe this solution is the one we intended to merge
upstream. There is a different approach used in the riscv-linux tree
from Palmer.

On Wed, Aug 1, 2018 at 8:14 AM, Christoph Hellwig <hch@lst.de> wrote:
> Hi all,
>
> this series with patches originally from Palmer and Wesley adds support
> for the pcie-xilinx host driver on RISC-V boards.  The interesting part
> about that is that the IP blocks is limited to 32-bit DMA internally,
> which didn't seem to be an issue with the existing users, but shows
> up easily with the Sifive RISC-V boards that have physical memory
> wired up above 4G.
>
> Note that patches 1 and 2 depend on changes in the dma-mapping tree
> to add the bus_dma_mask field to struct device and would have to merge
> through the dma-mapping tree or a shared stable branch.  Patch 3 could
> be merged independently.
>
> Changes since v1:
>  - move the add_dev method to struct pci_host_bridge
>  - use the new bus_dma_mask field
