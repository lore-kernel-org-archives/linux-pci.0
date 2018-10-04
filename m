Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A68C65BA9
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 22:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC522098A
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 22:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC522098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbeJEFZD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:25:03 -0400
Received: from ale.deltatee.com ([207.54.116.67]:53820 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbeJEFZD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Oct 2018 01:25:03 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g8C7W-0003NZ-B4; Thu, 04 Oct 2018 16:29:23 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org
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
 <a3af4bda-0b73-c964-c7d6-5d59f0710768@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2bcc0927-83ab-1bf2-d584-aebd5274cefa@deltatee.com>
Date:   Thu, 4 Oct 2018 16:29:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a3af4bda-0b73-c964-c7d6-5d59f0710768@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: swise@opengridcomputing.com, axboe@kernel.dk, christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, keith.busch@intel.com, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v9 13/13] nvmet: Optionally use PCI P2P memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-10-04 4:20 p.m., Sagi Grimberg wrote:
>> +static inline struct device *nvmet_ns_dev(struct nvmet_ns *ns)
>> +{
>> +	return disk_to_dev(ns->bdev->bd_disk);
>> +}
> 
> This needs to handle non bdev namespaces.

As it's coded now the helper never gets called unless ns->bdev is not
null. But in general, yes you are right, we should probably return NULL
if ns->bdev is NULL.

> And this?
> --
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index ef286b72d958..3d12f5f4568d 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -2280,6 +2280,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport 
> *tgtport,
>          fod->req.cmd = &fod->cmdiubuf.sqe;
>          fod->req.rsp = &fod->rspiubuf.cqe;
>          fod->req.port = tgtport->pe->port;
> +       fod->req.p2p_client = tgtport->dev;
> 
>          /* clear any response payload */
>          memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
> --

Sure, I guess that makes sense. I've never tried it with fc hardware but
I assume there's no reason it wouldn't work.

I'll queue these changes up for a v10.

Logan
