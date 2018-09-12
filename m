Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbeILQyo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Sep 2018 12:54:44 -0400
Date: Wed, 12 Sep 2018 12:50:31 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: yuanzhichang@hisilicon.com, dann.frazier@canonical.com,
        gabriele.paoloni@huawei.com, arnd@arndb.de, bhelgaas@google.com,
        andy.shevchenko@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, jean-philippe.brucker@arm.com,
        john.garry@huawei.com, lorenzo.pieralisi@arm.com
Subject: Re: [REGRESSION] Commit 5745392e0c2b ("PCI: Apply the new generic
 I/O management on PCI IO hosts") breaks PCI for legacy virtio devices with
 kvmtool on arm64
Message-ID: <20180912115031.GG44256@e119886-lin.cambridge.arm.com>
References: <20180907174140.GI12788@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907174140.GI12788@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 07, 2018 at 06:41:40PM +0100, Will Deacon wrote:
> Hi all,
> 
> I'm seeing a regression in Linux guests since 4.17 under kvmtool, where
> legacy virtio devices using the PCI transport fail to probe. Legacy virtio
> PCI devices must be accessed via "I/O space" (e.g. BAR0, which is
> IORESOURCE_IO) and kvmtool assigns this to the guest physical range
> 0x0 - 0x10000.
> 
> On arm64, when the virtio legacy PCI driver calls pci_iomap() for this BAR,
> it expands to ioport_map():
> 
>   static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
>   {
>   	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
>   }
> 
> Since the indirect PIO changes, MMIO_UPPER_LIMIT is defined as:
> 
>   /*
>    * We reserve 0x4000 bytes for Indirect IO as so far this library is only
>    * used by the HiSilicon LPC Host. If needed, we can reserve a wider IO
>    * area by redefining the macro below.
>    */
>   #define PIO_INDIRECT_SIZE 0x4000
>   #define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)
> 
> which corrupts the BAR address. For example, kvmtool has the BAR pointing
> at 0x6200 on my system, but pci_iomap() actually maps offset 0x2200.
> Changing PIO_INDIRECT_SIZE to 0 gets things working again.
> 
> Since this stuff doesn't revert nicely, I'm not sure how to proceed. Any
> thoughts? Generally, having a per-platform magic constant hardcoded in
> the PCI mapping code makes me feel slightly ill...

It seems that MMIO_UPPER_LIMIT (and some cases previously with IO_SPACE_LIMIT)
are not always being treated as masks - therefore ioport_map should be updated
to use the comparison operator and reject anything above MMIO_UPPER_LIMIT.

In any case modifying the address if it doesn't fit within the MMIO_UPPER_LIMIT
(or IO_SPACE_LIMIT previously) will only break something further down the code
path if the address was wrong in the first place. This function should probably
work in the same was as GENERIC_IOMAP (given it shares the same name) whereby
NULL is returned if the port is incorrect.

I will prepare a patch.

Thanks,

Andrew Murray

> 
> Cheers,
> 
> Will
