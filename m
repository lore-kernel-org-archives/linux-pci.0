Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55960 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbdGETHQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jul 2017 15:07:16 -0400
Date: Wed, 5 Jul 2017 21:07:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: chris hyser <chris.hyser@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Alan Adamson <alan.adamson@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-pci@vger.kernel.org, Mark Nelson <markn@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        iommu@lists.linux-foundation.org
Subject: Re: DMA_ATTR_WEAK_ORDERING defintion, was Re: [PATCH] nvme: set
        DMA_ATTR_WEAK_ORDERING attribute on dma buffers
Message-ID: <20170705190714.GA7107@lst.de>
References: <1497645290-31041-1-git-send-email-alan.adamson@oracle.com> <20170617115703.GA13002@lst.de> <6a32f30b-433a-9857-164f-1717405a6082@oracle.com> <20170624073539.GE14580@lst.de> <f485b21a-0cf7-d2f0-c957-03d234447561@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f485b21a-0cf7-d2f0-c957-03d234447561@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 27, 2017 at 04:46:31PM -0400, chris hyser wrote:
> I put this in for SPARC. In our case the host bridge/RC itself follows very 
> strict ordering unless the relaxed order bit is set in the TLP. This works 
> great for devices that actually allow the driver to enable it. We however 
> also have to support an infiniband card that does not support enabling this 
> in the HW and thus in the TLP but is actually fine with relaxed order for 
> the data buffers (ie the streaming I/O vs the coherent control buffers). In 
> fact w/o relaxed order the performance is absolutely atrocious ... w/ 
> exceeds x86. This flag enables the driver to signal to us when we map the 
> buffer in the IOMMU to enable the relaxed order attribute for our HW.

We'll really need to start writing down our semantics.  As I said
given how our streaming dma mappings (dma_map_single/page/sg) are
defined I can't think of any way how relaxed vs strict ordering would
matter for them, so just enabling it by default seems like the right
thing in this case, instead of having to patch every PCIe driver people
might ever use on sparc to work around your bridge.
