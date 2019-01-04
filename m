Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4340C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 02:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F602217F5
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 02:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfADClc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:41:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfADClc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 21:41:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DD9686675;
        Fri,  4 Jan 2019 02:41:32 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AEED5D9C6;
        Fri,  4 Jan 2019 02:41:23 +0000 (UTC)
Date:   Fri, 4 Jan 2019 10:41:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 4/4] nvme-pci: Use PCI to handle IRQ reduce and retry
Message-ID: <20190104024117.GC31330@ming.t460p>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-5-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103225033.11249-5-keith.busch@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 04 Jan 2019 02:41:32 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 03, 2019 at 03:50:33PM -0700, Keith Busch wrote:
> Restore error handling for vector allocation back to the PCI core.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/nvme/host/pci.c | 77 ++++++++++++++-----------------------------------
>  1 file changed, 21 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 1481bb6d9c42..f3ef09a8e8f9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2059,37 +2059,43 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
>  	return ret;
>  }
>  
> -static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
> +static void nvme_calc_io_queues(struct irq_affinity *affd, unsigned int nvecs)
>  {
> +	struct nvme_dev *dev = affd->priv;
>  	unsigned int this_w_queues = write_queues;
>  
>  	/*
>  	 * Setup read/write queue split
>  	 */
> -	if (irq_queues == 1) {
> +	if (nvecs == 1) {

The above line can be 'nvecs <= 2', cause when nvecs is 2, one is for
admin queue, another can be for DEFAULT.

>  		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
>  		dev->io_queues[HCTX_TYPE_READ] = 0;
> -		return;
> +		goto set_sets;
>  	}
>  
>  	/*
>  	 * If 'write_queues' is set, ensure it leaves room for at least
>  	 * one read queue
>  	 */
> -	if (this_w_queues >= irq_queues)
> -		this_w_queues = irq_queues - 1;
> +	if (this_w_queues >= nvecs - 1)
> +		this_w_queues = nvecs - 1;

If we want to leave room for one read queue, 'this_w_queues' should be
set as 'nvecs - 2' given nvecs covers admin queue.

>  
>  	/*
>  	 * If 'write_queues' is set to zero, reads and writes will share
>  	 * a queue set.
>  	 */
>  	if (!this_w_queues) {
> -		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues;
> +		dev->io_queues[HCTX_TYPE_DEFAULT] = nvecs - 1;
>  		dev->io_queues[HCTX_TYPE_READ] = 0;
>  	} else {
>  		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
> -		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues;
> +		dev->io_queues[HCTX_TYPE_READ] = nvecs - this_w_queues - 1;
>  	}

In above change, looks you starts to consider admin queue vector, which
is obvious one issue in current code.

So I'd suggest to fix nvme_calc_io_queues() in one standalone patch,
just what I posted, given this patch doesn't do "Restore error
handling for vector allocation back to the PCI core" only.

http://lists.infradead.org/pipermail/linux-nvme/2018-December/021879.html

Thanks,
Ming
