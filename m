Return-Path: <SRS0=7J7L=PE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C105EC43387
	for <linux-pci@archiver.kernel.org>; Thu, 27 Dec 2018 22:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8460020811
	for <linux-pci@archiver.kernel.org>; Thu, 27 Dec 2018 22:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbeL0WQr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:16:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733136AbeL0WQq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Dec 2018 17:16:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BA852D2BFE;
        Thu, 27 Dec 2018 22:16:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F40B55DAA0;
        Thu, 27 Dec 2018 22:16:39 +0000 (UTC)
Date:   Fri, 28 Dec 2018 06:16:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] nvme pci: try to allocate multiple irq vectors again
 in case of -EINVAL
Message-ID: <20181227221631.GA22073@ming.t460p>
References: <20181226103755.2101-1-ming.lei@redhat.com>
 <20181226103755.2101-3-ming.lei@redhat.com>
 <20181226182027.GA5866@lst.de>
 <20181227082136.GA14423@ming.t460p>
 <20181227130834.GA22967@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227130834.GA22967@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 27 Dec 2018 22:16:46 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 27, 2018 at 02:08:34PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 27, 2018 at 04:21:38PM +0800, Ming Lei wrote:
> > On Wed, Dec 26, 2018 at 07:20:27PM +0100, Christoph Hellwig wrote:
> > > On Wed, Dec 26, 2018 at 06:37:55PM +0800, Ming Lei wrote:
> > > > It is observed on QEMU that pci_alloc_irq_vectors_affinity() may
> > > > returns -EINVAL when the requested number is too big(such as 64).
> > > 
> > > Which is not how this API is supposed to work and documented to work.
> > > 
> > > We need to fix pci_alloc_irq_vectors_affinity to not return a spurious
> > > error and just return the allocated number of vectors instead of
> > > hacking around that in drivers.
> > 
> > Yeah, you are right.
> > 
> > The issue is that QEMU nvme-pci is MSIX-capable only, and hasn't MSI
> > capability.
> > 
> > __pci_enable_msix_range() actually returns -ENOSPC, but __pci_enable_msi_range()
> > returns -EINVAL because dev->msi_cap is zero.
> > 
> > Maybe we need the following fix?
> 
> Should it matter?  We still get a negative vecs back, and still fall
> back to the next option.  Unless ther are no irqs available at all
> for the selected types pci_alloc_irq_vectors_affinity should never
> return an error.

The patch in last email does fix this issue.

In this case, the number of NVMe PCI's MSI-X table entries is 64, so
__pci_enable_msix_range() return -ENOSPC when we ask for 65.

However, the following __pci_enable_msi_range() returns -EINVAL because
the NVMe PCI isn't capable of MSI, then this error is returned from
pci_alloc_irq_vectors_affinity() finally to NVMe driver.

Of course, -EINVAL makes a difference because the current code only
tries to assign one irq vector in this case, and it shouldn't be
returned from pci_alloc_irq_vectors_affinity(), given there is enough
msix entries for fallback, right?

Thanks,
Ming
