Return-Path: <SRS0=7J7L=PE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC40C43387
	for <linux-pci@archiver.kernel.org>; Thu, 27 Dec 2018 13:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78992070C
	for <linux-pci@archiver.kernel.org>; Thu, 27 Dec 2018 13:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbeL0NIh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Dec 2018 08:08:37 -0500
Received: from verein.lst.de ([213.95.11.211]:56578 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbeL0NIg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Dec 2018 08:08:36 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C0ED268AFE; Thu, 27 Dec 2018 14:08:34 +0100 (CET)
Date:   Thu, 27 Dec 2018 14:08:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme pci: try to allocate multiple irq vectors
 again in case of -EINVAL
Message-ID: <20181227130834.GA22967@lst.de>
References: <20181226103755.2101-1-ming.lei@redhat.com> <20181226103755.2101-3-ming.lei@redhat.com> <20181226182027.GA5866@lst.de> <20181227082136.GA14423@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227082136.GA14423@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 27, 2018 at 04:21:38PM +0800, Ming Lei wrote:
> On Wed, Dec 26, 2018 at 07:20:27PM +0100, Christoph Hellwig wrote:
> > On Wed, Dec 26, 2018 at 06:37:55PM +0800, Ming Lei wrote:
> > > It is observed on QEMU that pci_alloc_irq_vectors_affinity() may
> > > returns -EINVAL when the requested number is too big(such as 64).
> > 
> > Which is not how this API is supposed to work and documented to work.
> > 
> > We need to fix pci_alloc_irq_vectors_affinity to not return a spurious
> > error and just return the allocated number of vectors instead of
> > hacking around that in drivers.
> 
> Yeah, you are right.
> 
> The issue is that QEMU nvme-pci is MSIX-capable only, and hasn't MSI
> capability.
> 
> __pci_enable_msix_range() actually returns -ENOSPC, but __pci_enable_msi_range()
> returns -EINVAL because dev->msi_cap is zero.
> 
> Maybe we need the following fix?

Should it matter?  We still get a negative vecs back, and still fall
back to the next option.  Unless ther are no irqs available at all
for the selected types pci_alloc_irq_vectors_affinity should never
return an error.
