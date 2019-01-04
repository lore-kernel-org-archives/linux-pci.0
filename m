Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24882C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 02:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE34217F5
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 02:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfADCbf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:31:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfADCbf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 21:31:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB4C41B7C;
        Fri,  4 Jan 2019 02:31:34 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C42261001F41;
        Fri,  4 Jan 2019 02:31:27 +0000 (UTC)
Date:   Fri, 4 Jan 2019 10:31:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 2/4] nvme-pci: Distribute io queue types after creation
Message-ID: <20190104023121.GB31330@ming.t460p>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-3-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103225033.11249-3-keith.busch@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 04 Jan 2019 02:31:34 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 03, 2019 at 03:50:31PM -0700, Keith Busch wrote:
> The dev->io_queues types were set based on the results of the nvme set
> feature "number of queues" and the IRQ allocation. This result does not
> mean we're going to successfully allocate and create those IO queues,
> though. A failure there will cause blk-mq to have NULL hctx's because the
> map's nr_hw_queues accounts for more queues than were actually created.
> 
> Adjust the io_queue types after we've created them when we have less than
> originally desired.
> 
> Fixes: 3b6592f70ad7b ("nvme: utilize two queue maps, one for reads and one for writes")
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/nvme/host/pci.c | 46 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 98332d0a80f0..1481bb6d9c42 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1733,6 +1733,30 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
>  	return result;
>  }
>  
> +static void nvme_distribute_queues(struct nvme_dev *dev, unsigned int io_queues)
> +{
> +	unsigned int irq_queues, this_p_queues = dev->io_queues[HCTX_TYPE_POLL],
> +		     this_w_queues = dev->io_queues[HCTX_TYPE_DEFAULT];
> +
> +	if (!io_queues) {
> +		dev->io_queues[HCTX_TYPE_POLL] = 0;
> +		dev->io_queues[HCTX_TYPE_DEFAULT] = 0;
> +		dev->io_queues[HCTX_TYPE_READ] = 0;
> +		return;
> +	}
> +
> +	if (this_p_queues >= io_queues)
> +		this_p_queues = io_queues - 1;
> +	irq_queues = io_queues - this_p_queues;
> +
> +	if (this_w_queues > irq_queues)
> +		this_w_queues = irq_queues;
> +
> +	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
> +	dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
> +	dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues;
> +}
> +
>  static int nvme_create_io_queues(struct nvme_dev *dev)
>  {
>  	unsigned i, max, rw_queues;
> @@ -1761,6 +1785,13 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
>  			break;
>  	}
>  
> +	/*
> +	 * If we've created less than expected io queues, redistribute the
> +	 * dev->io_queues[] types accordingly.
> +	 */
> +	if (dev->online_queues - 1 != dev->max_qid)
> +		nvme_distribute_queues(dev, dev->online_queues - 1);
> +
>  	/*
>  	 * Ignore failing Create SQ/CQ commands, we can continue with less
>  	 * than the desired amount of queues, and even a controller without
> @@ -2185,11 +2216,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  	result = max(result - 1, 1);
>  	dev->max_qid = result + dev->io_queues[HCTX_TYPE_POLL];
>  
> -	dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
> -					dev->io_queues[HCTX_TYPE_DEFAULT],
> -					dev->io_queues[HCTX_TYPE_READ],
> -					dev->io_queues[HCTX_TYPE_POLL]);
> -
>  	/*
>  	 * Should investigate if there's a performance win from allocating
>  	 * more queues than interrupt vectors; it might allow the submission
> @@ -2203,7 +2229,15 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  		return result;
>  	}
>  	set_bit(NVMEQ_ENABLED, &adminq->flags);
> -	return nvme_create_io_queues(dev);
> +	result = nvme_create_io_queues(dev);
> +
> +	if (!result)
> +		dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
> +					dev->io_queues[HCTX_TYPE_DEFAULT],
> +					dev->io_queues[HCTX_TYPE_READ],
> +					dev->io_queues[HCTX_TYPE_POLL]);
> +	return result;
> +
>  }
>  
>  static void nvme_del_queue_end(struct request *req, blk_status_t error)
> -- 
> 2.14.4
> 

This way should be better given it covers irq allocation failure and
queue creating/initialization failure.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
