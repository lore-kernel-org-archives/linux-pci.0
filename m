Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C22C43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 20:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C2F2087A
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 20:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sflZ9heF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C2F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbeJKEEP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbeJKEEP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 00:04:15 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB655206B2;
        Wed, 10 Oct 2018 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539204024;
        bh=+REUhVqudCDZ0ybdWwS79aPg7vizwloVonubyqav3ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sflZ9heFGKXjhZEnJivPerpUikJtEeLZAnUQ6dffc22NP1ENLdHcs7pS8ruv/pbo4
         O9ixjt0eEjPJA6yM+kMr7atVTRuw4OOwwBU6lbwCKWB1bhKS0C8wxbgAqLq0SUmTtq
         A1PcVx9MFxc9Uy0I9/NJeTSlstctsp7r9cPYFygw=
Date:   Wed, 10 Oct 2018 15:40:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: remove DMA unmap wrappers
Message-ID: <20181010204022.GG5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181009140824.18667-1-hch@lst.de>
 <20181009140824.18667-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009140824.18667-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc folks from MAINTAINERS]

On Tue, Oct 09, 2018 at 04:08:22PM +0200, Christoph Hellwig wrote:
> Only some of these were still used by the cxgb4 driver, and that despite
> the fact that the driver otherwise uses the generic DMA API.

This is trivial and I intend to apply it, so just copying cxgb4 folks
as FYI.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 10 +++++-----
>  drivers/infiniband/hw/cxgb4/t4.h |  2 +-
>  include/linux/pci-dma.h          | 12 ------------
>  include/linux/pci.h              |  1 -
>  4 files changed, 6 insertions(+), 19 deletions(-)
>  delete mode 100644 include/linux/pci-dma.h
> 
> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> index 347fe18b1a41..62d6f197ec0b 100644
> --- a/drivers/infiniband/hw/cxgb4/qp.c
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -99,7 +99,7 @@ static void dealloc_oc_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
>  static void dealloc_host_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
>  {
>  	dma_free_coherent(&(rdev->lldi.pdev->dev), sq->memsize, sq->queue,
> -			  pci_unmap_addr(sq, mapping));
> +			  dma_unmap_addr(sq, mapping));
>  }
>  
>  static void dealloc_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
> @@ -132,7 +132,7 @@ static int alloc_host_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
>  	if (!sq->queue)
>  		return -ENOMEM;
>  	sq->phys_addr = virt_to_phys(sq->queue);
> -	pci_unmap_addr_set(sq, mapping, sq->dma_addr);
> +	dma_unmap_addr_set(sq, mapping, sq->dma_addr);
>  	return 0;
>  }
>  
> @@ -2521,7 +2521,7 @@ static void free_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
>  
>  	dma_free_coherent(&rdev->lldi.pdev->dev,
>  			  wq->memsize, wq->queue,
> -			pci_unmap_addr(wq, mapping));
> +			dma_unmap_addr(wq, mapping));
>  	c4iw_rqtpool_free(rdev, wq->rqt_hwaddr, wq->rqt_size);
>  	kfree(wq->sw_rq);
>  	c4iw_put_qpid(rdev, wq->qid, uctx);
> @@ -2570,7 +2570,7 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
>  		goto err_free_rqtpool;
>  
>  	memset(wq->queue, 0, wq->memsize);
> -	pci_unmap_addr_set(wq, mapping, wq->dma_addr);
> +	dma_unmap_addr_set(wq, mapping, wq->dma_addr);
>  
>  	wq->bar2_va = c4iw_bar2_addrs(rdev, wq->qid, T4_BAR2_QTYPE_EGRESS,
>  				      &wq->bar2_qid,
> @@ -2649,7 +2649,7 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
>  err_free_queue:
>  	dma_free_coherent(&rdev->lldi.pdev->dev,
>  			  wq->memsize, wq->queue,
> -			pci_unmap_addr(wq, mapping));
> +			dma_unmap_addr(wq, mapping));
>  err_free_rqtpool:
>  	c4iw_rqtpool_free(rdev, wq->rqt_hwaddr, wq->rqt_size);
>  err_free_pending_wrs:
> diff --git a/drivers/infiniband/hw/cxgb4/t4.h b/drivers/infiniband/hw/cxgb4/t4.h
> index e42021fd6fd6..fff6d48d262f 100644
> --- a/drivers/infiniband/hw/cxgb4/t4.h
> +++ b/drivers/infiniband/hw/cxgb4/t4.h
> @@ -397,7 +397,7 @@ struct t4_srq_pending_wr {
>  struct t4_srq {
>  	union t4_recv_wr *queue;
>  	dma_addr_t dma_addr;
> -	DECLARE_PCI_UNMAP_ADDR(mapping);
> +	DEFINE_DMA_UNMAP_ADDR(mapping);
>  	struct t4_swrqe *sw_rq;
>  	void __iomem *bar2_va;
>  	u64 bar2_pa;
> diff --git a/include/linux/pci-dma.h b/include/linux/pci-dma.h
> deleted file mode 100644
> index 0f7aa7353ca3..000000000000
> --- a/include/linux/pci-dma.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_PCI_DMA_H
> -#define _LINUX_PCI_DMA_H
> -
> -#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME) DEFINE_DMA_UNMAP_ADDR(ADDR_NAME);
> -#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)   DEFINE_DMA_UNMAP_LEN(LEN_NAME);
> -#define pci_unmap_addr             dma_unmap_addr
> -#define pci_unmap_addr_set         dma_unmap_addr_set
> -#define pci_unmap_len              dma_unmap_len
> -#define pci_unmap_len_set          dma_unmap_len_set
> -
> -#endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6925828f9f25..e938e80e59c1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1342,7 +1342,6 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
>  
>  /* kmem_cache style wrapper around pci_alloc_consistent() */
>  
> -#include <linux/pci-dma.h>
>  #include <linux/dmapool.h>
>  
>  #define	pci_pool dma_pool
> -- 
> 2.19.0
> 
