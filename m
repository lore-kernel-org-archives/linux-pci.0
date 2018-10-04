Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AE2C64EBC
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 22:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881ED2087D
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 22:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881ED2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeJEFQ3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:16:29 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35966 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeJEFQ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Oct 2018 01:16:29 -0400
Received: by mail-yw1-f68.google.com with SMTP id e201-v6so4470265ywa.3;
        Thu, 04 Oct 2018 15:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qsh1AzCrUxH5XAt373Dy+4PyCAxk2BXr/sjoXR3u4wE=;
        b=KsdamkpO0ndW/v5L8TfkvxreJnyG/xCceCgswR0o5VMRz6ZG+U7gnKhXx9NN7cZnBr
         IcdnAb1QwOs3OWs8az0NnTqR8y71cnWJiQXK19sm/jXT7u7zrUBxzVjc3/Pvf2P4SRhT
         fp2EG0NIhn3hNr3wCDQsvTevvdBM1MXhyYOWyKAMT0PyhLCJ39G5LSkmmf7tFUHk+2Js
         YEdoezIvcc2d3NJ2Ma9EtUEH+5XuITNnpAHzBhe2uVpBHcEBv7M3lMfvc2ZpuQv2epFA
         6QO/qFWFz1Vh1s+stE1RTO1zLcrb4eFzeq+qFP0q2rwAKqY8ctbMemITkZkNJRwF1pvp
         c/Ng==
X-Gm-Message-State: ABuFfoimR89frR6ngjx9G5KsePBnC4x4pm5Fxc1ZwnX9lssl4F+2ZcmW
        b/luxDpa1vj4qASoloZ+w3M=
X-Google-Smtp-Source: ACcGV60DLCAMRvtDwLT8TeoFogSUZnag1rQxccyvQr2F2VGrqRgxQJSLbfv3JhUk4UI2ynCcj2Uz/A==
X-Received: by 2002:a81:ae4e:: with SMTP id g14-v6mr4834626ywk.248.1538691659425;
        Thu, 04 Oct 2018 15:20:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l69-v6sm3894260ywl.51.2018.10.04.15.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 15:20:58 -0700 (PDT)
Subject: Re: [PATCH v9 13/13] nvmet: Optionally use PCI P2P memory
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>
References: <20181004212747.6301-1-logang@deltatee.com>
 <20181004212747.6301-14-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a3af4bda-0b73-c964-c7d6-5d59f0710768@grimberg.me>
Date:   Thu, 4 Oct 2018 15:20:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004212747.6301-14-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index e7b7406c4e22..4333e2c5b4f5 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -26,6 +26,7 @@
>   #include <linux/configfs.h>
>   #include <linux/rcupdate.h>
>   #include <linux/blkdev.h>
> +#include <linux/radix-tree.h>
>   
>   #define NVMET_ASYNC_EVENTS		4
>   #define NVMET_ERROR_LOG_SLOTS		128
> @@ -77,6 +78,9 @@ struct nvmet_ns {
>   	struct completion	disable_done;
>   	mempool_t		*bvec_pool;
>   	struct kmem_cache	*bvec_cache;
> +
> +	int			use_p2pmem;
> +	struct pci_dev		*p2p_dev;
>   };
>   
>   static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
> @@ -84,6 +88,11 @@ static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
>   	return container_of(to_config_group(item), struct nvmet_ns, group);
>   }
>   
> +static inline struct device *nvmet_ns_dev(struct nvmet_ns *ns)
> +{
> +	return disk_to_dev(ns->bdev->bd_disk);
> +}

This needs to handle non bdev namespaces.

> +
>   struct nvmet_cq {
>   	u16			qid;
>   	u16			size;
> @@ -184,6 +193,9 @@ struct nvmet_ctrl {
>   
>   	char			subsysnqn[NVMF_NQN_FIELD_LEN];
>   	char			hostnqn[NVMF_NQN_FIELD_LEN];
> +
> +	struct device *p2p_client;
> +	struct radix_tree_root p2p_ns_map;
>   };
>   
>   struct nvmet_subsys {
> @@ -294,6 +306,9 @@ struct nvmet_req {
>   
>   	void (*execute)(struct nvmet_req *req);
>   	const struct nvmet_fabrics_ops *ops;
> +
> +	struct pci_dev *p2p_dev;
> +	struct device *p2p_client;
>   };
>   
>   extern struct workqueue_struct *buffered_io_wq;
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 9e091e78a2f0..3f7971d3706d 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -749,6 +749,8 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
>   		cmd->send_sge.addr, cmd->send_sge.length,
>   		DMA_TO_DEVICE);
>   
> +	cmd->req.p2p_client = &queue->dev->device->dev;
> +
>   	if (!nvmet_req_init(&cmd->req, &queue->nvme_cq,
>   			&queue->nvme_sq, &nvmet_rdma_ops))
>   		return;

And this?
--
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index ef286b72d958..3d12f5f4568d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2280,6 +2280,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport 
*tgtport,
         fod->req.cmd = &fod->cmdiubuf.sqe;
         fod->req.rsp = &fod->rspiubuf.cqe;
         fod->req.port = tgtport->pe->port;
+       fod->req.p2p_client = tgtport->dev;

         /* clear any response payload */
         memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
--

Other than that this looks good!
