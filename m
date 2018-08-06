Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43981 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733163AbeHFSbb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2018 14:31:31 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so3807486ywb.10
        for <linux-pci@vger.kernel.org>; Mon, 06 Aug 2018 09:21:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806123527.GB6997@lst.de>
References: <20180804101402.10022-1-hch@lst.de> <20180804101402.10022-3-hch@lst.de>
 <CAMgXwTgr572J_HH396tfvT7Zj8Jj0fefKOSmVw2+Gwn8qcPR1g@mail.gmail.com> <20180806123527.GB6997@lst.de>
From: Wesley Terpstra <wesley@sifive.com>
Date: Mon, 6 Aug 2018 09:21:40 -0700
Message-ID: <CAMgXwTjcjdiBN9yksL9zuZQyGjckC+F+qwzSm32RjjFSWHFCPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI/xilinx: Work-around for hardware DMA limit (32 bits)
To: Christoph Hellwig <hch@lst.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 6, 2018 at 5:35 AM, Christoph Hellwig <hch@lst.de> wrote:
> Note that we already have the mechanism for firmware directed dma limits
> in place, it is called the dma-ranges DT property.  If we can get the
> SiFive firmware to set it up properly the RISC-V swiotlb code will
> just do the right thing.

Does this mean we only need to set the dma-ranges property inside the
pci DTS node? No changes to the driver needed?
