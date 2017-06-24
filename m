Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56987 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdFXHfl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 24 Jun 2017 03:35:41 -0400
Date: Sat, 24 Jun 2017 09:35:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, keith.busch@intel.com,
        axboe@fb.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-pci@vger.kernel.org, Mark Nelson <markn@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        iommu@lists.linux-foundation.org
Subject: DMA_ATTR_WEAK_ORDERING defintion, was Re: [PATCH] nvme: set
        DMA_ATTR_WEAK_ORDERING attribute on dma buffers
Message-ID: <20170624073539.GE14580@lst.de>
References: <1497645290-31041-1-git-send-email-alan.adamson@oracle.com> <20170617115703.GA13002@lst.de> <6a32f30b-433a-9857-164f-1717405a6082@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6a32f30b-433a-9857-164f-1717405a6082@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I always assumed that our streaming mappings are relaxed order for
TLP anyway.  And at very least Documentation/DMA-attributes.txt seems
to imply something different:


  DMA_ATTR_WEAK_ORDERING
  ----------------------

  DMA_ATTR_WEAK_ORDERING specifies that reads and writes to the mapping
  may be weakly ordered, that is that reads and writes may pass each other.

Which to me suggest host reads, which also makes me wonder why these
would even apply to our streaming mappings.

Adding the powerpc folks that added the DMA_ATTR_WEAK_ORDERING flag
originally back in 2008, but not actual users as far as I can tell -
those are all new and from the sparc gang, except for the noveau
driver, which is a bit older but only uses for dma_alloc_attrs, where
the original description makes sense to me.

On Wed, Jun 21, 2017 at 01:30:40PM -0700, Alan Adamson wrote:
> drivers may rely on strong ordering for certain writes. For example, a 
> device may use a specific location in host memory to serve as a "done" 
> flag. The device writes data to a buffer, and those writes can be relaxed 
> because the order in which the data bytes enter the buffer is not visible 
> to software. The device then writes to the "done" flag location, to 
> indicate to the consumer that it has completed the buffer write. The write 
> to "done" cannot pass the prior writes to the data buffer; otherwise 
> software polling on the "done" location could potentially read stale data 
> from the data buffer. Device driver developers need to understand the 
> hardware behavior and only set the DMA_ATTR_WEAK_ORDERING attribute when 
> safe.
>
> Alan Adamson
