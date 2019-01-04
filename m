Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76C7C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 01:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42BE217F5
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 01:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfADBrF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 20:47:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfADBrF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 20:47:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEB4B13A98;
        Fri,  4 Jan 2019 01:47:03 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9367B5C223;
        Fri,  4 Jan 2019 01:46:56 +0000 (UTC)
Date:   Fri, 4 Jan 2019 09:46:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 1/4] nvme-pci: Set tagset nr_maps just once
Message-ID: <20190104014649.GA31330@ming.t460p>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103225033.11249-2-keith.busch@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 04 Jan 2019 01:47:04 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 03, 2019 at 03:50:30PM -0700, Keith Busch wrote:
> The driver overwrites the intermediate nr_map assignments to
> HCTX_MAX_TYPES, so remove those unnecessary temporary settings.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/nvme/host/pci.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5a0bf6a24d50..98332d0a80f0 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2291,9 +2291,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  	if (!dev->ctrl.tagset) {
>  		dev->tagset.ops = &nvme_mq_ops;
>  		dev->tagset.nr_hw_queues = dev->online_queues - 1;
> -		dev->tagset.nr_maps = 2; /* default + read */
> -		if (dev->io_queues[HCTX_TYPE_POLL])
> -			dev->tagset.nr_maps++;
>  		dev->tagset.nr_maps = HCTX_MAX_TYPES;
>  		dev->tagset.timeout = NVME_IO_TIMEOUT;
>  		dev->tagset.numa_node = dev_to_node(dev->dev);
> -- 
> 2.14.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
