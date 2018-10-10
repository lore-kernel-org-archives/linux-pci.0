Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC75C43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87BF20652
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="onXzDl2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87BF20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJKDX7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:23:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43261 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeJKDXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Oct 2018 23:23:53 -0400
Received: by mail-io1-f66.google.com with SMTP id y10-v6so4834572ioa.10
        for <linux-pci@vger.kernel.org>; Wed, 10 Oct 2018 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3V2BDI3Fu3E4wa2XeEZMZHiif+lnEO/ghUleh70DIVE=;
        b=onXzDl2vzAfqn0OS8mxpiER3t4SZHOGLbotCpbWDRHsqPdDeiYt4cTgf6Ne8tQ3CZM
         VuFqPml1kMGXEGA3wtr2L/7NnCzdYgB7hr+qF1YYL5a0mmIP2a3RplWdOzkGS43KnD68
         2XUCisMD820dxUSRHhWKy+dV2WUrqS/ZDRXaod+7pnEEZdFTl1nzSX/t0p0Xl9GkHY2U
         lbVL3JpUEGxzvXxVfaPvXUq2yxkUWLt8hNCppd+pglzWy4Fpmd8zNpcwcQsDMK2cdFrY
         MSLx2u3wGLA8eDG83ZA+dJKyrvihKkD5RvuBszteT4hVII8MaEs8j5HENwcE4Qf+q+zl
         BLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3V2BDI3Fu3E4wa2XeEZMZHiif+lnEO/ghUleh70DIVE=;
        b=kmzdLYQFQ9hjaPZnR1F+GPoTm5/8veY54DyHhnno+We1zo1sD8yZxufDe81+ZFmckG
         AupT6+e+EglAgQRNQohtVlKdRnxBfrLPm/uNETxklAGkwYGBGOZz2QOVRyUYd0qdmeDA
         C9Vyok0CyzBhR6naVhBfKB1iqpJai8r7MsgjYvhvjKexpioy3YILmEAvqETjGAb7t/nO
         GpRe3g3lT8/bgD0E49nZ4DWB8VAcjp37vDRcxTHYVe07pYv/pYrM0VG9LbdG6MCWyoEc
         mbsXjZjEr4OMhs/d+E/9LU3kQANq1nzWvCzBxtOYjFgJLcR5LVO921rNlTyJ5yZcu9mR
         CoyQ==
X-Gm-Message-State: ABuFfojlpSqYr7vjLxD8NmFuSlMTUbRd58bD9vwg86H8OFPUsy78kPpS
        2ImedDI4GdPwGw07Do7T7F4jPw==
X-Google-Smtp-Source: ACcGV63MirCpyelXedBuhP5KSOWg7gO7sZ5wpcO3Stpglrv0b5b0Bk6b0IwfDMVnemQ2/E9s3ftTIw==
X-Received: by 2002:a6b:d611:: with SMTP id w17-v6mr23624068ioa.216.1539201611146;
        Wed, 10 Oct 2018 13:00:11 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r9-v6sm8464059iob.49.2018.10.10.13.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 13:00:09 -0700 (PDT)
Subject: Re: [PATCH v9 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Stephen Bates <sbates@raithlin.com>,
        Keith Busch <keith.busch@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181004212747.6301-1-logang@deltatee.com>
 <20181004212747.6301-8-logang@deltatee.com>
 <485de371-0e84-6f20-7f3b-cec5635b87fe@kernel.dk>
 <20181010195901.GE5906@bhelgaas-glaptop.roam.corp.google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <167fcf01-4bbc-f870-3750-6e950bfd6471@kernel.dk>
Date:   Wed, 10 Oct 2018 14:00:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181010195901.GE5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/10/18 1:59 PM, Bjorn Helgaas wrote:
> On Fri, Oct 05, 2018 at 07:16:04PM -0600, Jens Axboe wrote:
>> On 10/4/18 3:27 PM, Logan Gunthorpe wrote:
>>> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
>>> supports targeting P2P memory. This will be used by P2P providers and
>>> orchestrators (in subsequent patches) to ensure block devices can
>>> support P2P memory before submitting P2P backed pages to submit_bio().
>>
>> Nit pick, but the subject line still says that it checks support
>> for requests. This patch just adds the ability to flag support
>> in the queue.
> 
> What about the following?  MAINTAINERS doesn't list a specific
> maintainer for include/linux/blkdev.h (maybe the "BLOCK LAYER" entry
> should have an F: pattern for it?), but I'd really like your ack
> before merging this.
> 
> commit 7e647ae1eda290786851c3dff4f38189b982386d
> Author: Logan Gunthorpe <logang@deltatee.com>
> Date:   Thu Oct 4 15:27:41 2018 -0600
> 
>     block: Add PCI P2P flag for request queue
>     
>     Add QUEUE_FLAG_PCI_P2P, meaning a driver's request queue supports targeting
>     P2P memory.  This will be used by P2P providers and orchestrators (in
>     subsequent patches) to ensure block devices can support P2P memory before
>     submitting P2P-backed pages to submit_bio().
>     
>     Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>

You can add my acked-by to this one.

-- 
Jens Axboe

