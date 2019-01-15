Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E860C43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 23:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9E92086D
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 23:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547596148;
	bh=+GeTLL7s5e2GXsRUAtRD0sS81iR+S/emNrERpxaRdCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oO22PkrOBYk76FHfj8Dh6CnnlvRmyccxyzTqoUUl2eEBmNPUC7ksZhSQ+u5yU+9/G
	 edEKXlYTvuKIuTsBpf7EKZuB16/P5qeuqR2aLAhxAHl82M+pikqDQv6AR4g7K4Mzbh
	 IfnNjZT5QBC84BjJkNK7D5Wv/uo81AXvLLOSfUYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfAOXtH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbfAOXtH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jan 2019 18:49:07 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B5820645;
        Tue, 15 Jan 2019 23:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547596145;
        bh=+GeTLL7s5e2GXsRUAtRD0sS81iR+S/emNrERpxaRdCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bR5nlU8yYEzeoRmajDoSFhkAuVs4+VK0PDoNxq4rmqq6H5ZgWwxiF6QJF+gt7bclQ
         hj0eDfNw+tjwCwL08NXLvu4duu20NUWrq52oBxn2WUoJTa+KNskOVeqtkb3s+mjtN/
         Iiz+z3lBUYl09TCR7KKvNKMHsppknZHCSX/B2DoI=
Date:   Tue, 15 Jan 2019 17:49:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
Message-ID: <20190115234904.GB158366@google.com>
References: <20190103013106.26452-1-ming.lei@redhat.com>
 <20190114232338.GE33971@google.com>
 <20190115131140.GB28672@lst.de>
 <05cb9e71-e455-a717-c64c-b5242ec38bad@kernel.dk>
 <20190115193135.GH33971@google.com>
 <20190115224631.GA22558@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115224631.GA22558@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 16, 2019 at 06:46:32AM +0800, Ming Lei wrote:
> Hi Bjorn,
> 
> I think Christoph and Jens are correct, we should make this patch into
> 5.0 because the issue is triggered since 3b6592f70ad7b4c2 ("nvme: utilize
> two queue maps, one for reads and one for writes"), which is merged to
> 5.0-rc.
> 
> For example, before 3b6592f70ad7b4c2, one nvme controller may be
> allocated 64 irq vectors; but after that commit, only 1 irq vector
> is assigned to this controller.
> 
> On Tue, Jan 15, 2019 at 01:31:35PM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 15, 2019 at 09:22:45AM -0700, Jens Axboe wrote:
> > > On 1/15/19 6:11 AM, Christoph Hellwig wrote:
> > > > On Mon, Jan 14, 2019 at 05:23:39PM -0600, Bjorn Helgaas wrote:
> > > >> Applied to pci/msi for v5.1, thanks!
> > > >>
> > > >> If this is something that should be in v5.0, let me know and include the
> > > >> justification, e.g., something we already merged for v5.0 or regression
> > > >> info, etc, and a Fixes: line, and I'll move it to for-linus.
> > > > 
> > > > I'd be tempted to queues this up for 5.0.  Ming, what is your position?
> > > 
> > > I think we should - the API was introduced in this series, I think there's
> > > little (to no) reason NOT to fix it for 5.0.
> > 
> > I'm guessing the justification goes something like this (I haven't
> > done all the research, so I'll leave it to Ming to fill in the details):
> > 
> >   pci_alloc_irq_vectors_affinity() was added in v4.x by XXXX ("...").
> 
> dca51e7892fa3b ("nvme: switch to use pci_alloc_irq_vectors")
> 
> >   It had this return value defect then, but its min_vecs/max_vecs
> >   parameters removed the need for callers to interatively reduce the
> >   number of IRQs requested and retry the allocation, so they didn't
> >   need to distinguish -ENOSPC from -EINVAL.
> > 
> >   In v5.0, XXX ("...") added IRQ sets to the interface, which
> 
> 3b6592f70ad7b4c2 ("nvme: utilize two queue maps, one for reads and one for writes")
> 
> >   reintroduced the need to check for -ENOSPC and possibly reduce the
> >   number of IRQs requested and retry the allocation.

We're fixing a PCI core defect, so we should mention the relevant PCI
core commits, not the nvme-specific ones.  I looked them up for you
and moved this to for-linus for v5.0.


commit 77f88abd4a6f73a1a68dbdc0e3f21575fd508fc3
Author: Ming Lei <ming.lei@redhat.com>
Date:   Tue Jan 15 17:31:29 2019 -0600

    PCI/MSI: Return -ENOSPC from pci_alloc_irq_vectors_affinity()
    
    The API of pci_alloc_irq_vectors_affinity() says it returns -ENOSPC if
    fewer than @min_vecs interrupt vectors are available for @dev.
    
    However, if a device supports MSI-X but not MSI and a caller requests
    @min_vecs that can't be satisfied by MSI-X, we previously returned -EINVAL
    (from the failed attempt to enable MSI), not -ENOSPC.
    
    When -ENOSPC is returned, callers may reduce the number IRQs they request
    and try again.  Most callers can use the @min_vecs and @max_vecs
    parameters to avoid this retry loop, but that doesn't work when using IRQ
    affinity "nr_sets" because rebalancing the sets is driver-specific.
    
    This return value bug has been present since pci_alloc_irq_vectors() was
    added in v4.10 by aff171641d18 ("PCI: Provide sensible IRQ vector
    alloc/free routines"), but it wasn't an issue because @min_vecs/@max_vecs
    removed the need for callers to iteratively reduce the number of IRQs
    requested and retry the allocation, so they didn't need to distinguish
    -ENOSPC from -EINVAL.
    
    In v5.0, 6da4b3ab9a6e ("genirq/affinity: Add support for allocating
    interrupt sets") added IRQ sets to the interface, which reintroduced the
    need to check for -ENOSPC and possibly reduce the number of IRQs requested
    and retry the allocation.
    
    Signed-off-by: Ming Lei <ming.lei@redhat.com>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: Jens Axboe <axboe@fb.com>
    Cc: Keith Busch <keith.busch@intel.com>
    Cc: Christoph Hellwig <hch@lst.de>

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7a1c8a09efa5..4c0b47867258 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1168,7 +1168,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   const struct irq_affinity *affd)
 {
 	static const struct irq_affinity msi_default_affd;
-	int vecs = -ENOSPC;
+	int msix_vecs = -ENOSPC;
+	int msi_vecs = -ENOSPC;
 
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
@@ -1179,16 +1180,17 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	}
 
 	if (flags & PCI_IRQ_MSIX) {
-		vecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
-				affd);
-		if (vecs > 0)
-			return vecs;
+		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
+						    max_vecs, affd);
+		if (msix_vecs > 0)
+			return msix_vecs;
 	}
 
 	if (flags & PCI_IRQ_MSI) {
-		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
-		if (vecs > 0)
-			return vecs;
+		msi_vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs,
+						  affd);
+		if (msi_vecs > 0)
+			return msi_vecs;
 	}
 
 	/* use legacy irq if allowed */
@@ -1199,7 +1201,9 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		}
 	}
 
-	return vecs;
+	if (msix_vecs == -ENOSPC)
+		return -ENOSPC;
+	return msi_vecs;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
