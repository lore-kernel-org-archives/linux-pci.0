Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:40894 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753864AbdGJQTi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2017 12:19:38 -0400
Subject: Re: DMA_ATTR_WEAK_ORDERING defintion, was Re: [PATCH] nvme: set
 DMA_ATTR_WEAK_ORDERING attribute on dma buffers
To: Christoph Hellwig <hch@lst.de>
References: <1497645290-31041-1-git-send-email-alan.adamson@oracle.com>
 <20170617115703.GA13002@lst.de>
 <6a32f30b-433a-9857-164f-1717405a6082@oracle.com>
 <20170624073539.GE14580@lst.de>
 <f485b21a-0cf7-d2f0-c957-03d234447561@oracle.com>
 <20170705190714.GA7107@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-pci@vger.kernel.org, Mark Nelson <markn@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        iommu@lists.linux-foundation.org
From: chris hyser <chris.hyser@oracle.com>
Message-ID: <261c7733-71a0-c283-90dd-3e03f1fa08ff@oracle.com>
Date: Mon, 10 Jul 2017 12:17:07 -0400
MIME-Version: 1.0
In-Reply-To: <20170705190714.GA7107@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/5/2017 3:07 PM, Christoph Hellwig wrote:
> On Tue, Jun 27, 2017 at 04:46:31PM -0400, chris hyser wrote:
>> I put this in for SPARC. In our case the host bridge/RC itself follows very
>> strict ordering unless the relaxed order bit is set in the TLP. This works
>> great for devices that actually allow the driver to enable it. We however
>> also have to support an infiniband card that does not support enabling this
>> in the HW and thus in the TLP but is actually fine with relaxed order for
>> the data buffers (ie the streaming I/O vs the coherent control buffers). In
>> fact w/o relaxed order the performance is absolutely atrocious ... w/
>> exceeds x86. This flag enables the driver to signal to us when we map the
>> buffer in the IOMMU to enable the relaxed order attribute for our HW.
>
> We'll really need to start writing down our semantics.  As I said

Fair enough. This will get documented.

> given how our streaming dma mappings (dma_map_single/page/sg) are
> defined I can't think of any way how relaxed vs strict ordering would
> matter for them, so just enabling it by default seems like the right
> thing in this case, instead of having to patch every PCIe driver people

People get real squeamish about just turning on relaxed order for driver/devices we actually know something about and 
test let alone everything. I do agree with your interpretation of the streaming DMA semantics. That does not mean every 
driver writer did or does. :-)

> might ever use on sparc to work around your bridge.

To be clear, this isn't really a host bridge issue. Technically no driver that runs on SPARC needs this enabled -- even 
performance critical ... if they do the HW correctly. Again, we have a necessary performance critical device which does 
not correctly signal its okayness with relaxed order for non-control DMA. This feature of the host bridge is to enable a 
workaround for just these cases (deemed needed by past history). Said differently, lots of devices are made for the 
commodity market where shortcuts like this apparently do not affect performance but are critical to performance on large 
systems.

-chrish
