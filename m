Return-Path: <SRS0=7J7L=PE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3459C43387
	for <linux-pci@archiver.kernel.org>; Thu, 27 Dec 2018 08:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D9A218E2
	for <linux-pci@archiver.kernel.org>; Thu, 27 Dec 2018 08:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbeL0IVw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:21:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbeL0IVw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Dec 2018 03:21:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 614509B309;
        Thu, 27 Dec 2018 08:21:52 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38E3A620CA;
        Thu, 27 Dec 2018 08:21:43 +0000 (UTC)
Date:   Thu, 27 Dec 2018 16:21:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme pci: try to allocate multiple irq vectors again
 in case of -EINVAL
Message-ID: <20181227082136.GA14423@ming.t460p>
References: <20181226103755.2101-1-ming.lei@redhat.com>
 <20181226103755.2101-3-ming.lei@redhat.com>
 <20181226182027.GA5866@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226182027.GA5866@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 27 Dec 2018 08:21:52 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 26, 2018 at 07:20:27PM +0100, Christoph Hellwig wrote:
> On Wed, Dec 26, 2018 at 06:37:55PM +0800, Ming Lei wrote:
> > It is observed on QEMU that pci_alloc_irq_vectors_affinity() may
> > returns -EINVAL when the requested number is too big(such as 64).
> 
> Which is not how this API is supposed to work and documented to work.
> 
> We need to fix pci_alloc_irq_vectors_affinity to not return a spurious
> error and just return the allocated number of vectors instead of
> hacking around that in drivers.

Yeah, you are right.

The issue is that QEMU nvme-pci is MSIX-capable only, and hasn't MSI
capability.

__pci_enable_msix_range() actually returns -ENOSPC, but __pci_enable_msi_range()
returns -EINVAL because dev->msi_cap is zero.

Maybe we need the following fix?

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 265ed3e4c920..b0bf260dc154 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1186,7 +1186,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
                        return vecs;
        }
 
-       if (flags & PCI_IRQ_MSI) {
+       if ((flags & PCI_IRQ_MSI) && dev->msi_cap) {
                vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
                if (vecs > 0)
                        return vecs;


Thanks,
Ming
