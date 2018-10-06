Return-Path: <SRS0=RTeO=MS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969B4C00449
	for <linux-pci@archiver.kernel.org>; Sat,  6 Oct 2018 01:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0B921479
	for <linux-pci@archiver.kernel.org>; Sat,  6 Oct 2018 01:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DmapE2TU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0B921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeJFIRc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 6 Oct 2018 04:17:32 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:34151 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeJFIR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Oct 2018 04:17:27 -0400
Received: by mail-pg1-f175.google.com with SMTP id g12-v6so5444511pgs.1
        for <linux-pci@vger.kernel.org>; Fri, 05 Oct 2018 18:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kkkU9e6NPdzWlq+30NnrBK3elbGcUFsjA5IRWacg35w=;
        b=DmapE2TUzmc3Z6DEB7tymyPxhkSegI3cgbwecwz9zh9u9wlyli32femmPWMl+EGTHy
         Ifihsl9HZIXk7n062XWCRPIdD8TWOXtOCVFPgHymyvNIZMZwepYq9Q6gxHDvl65MNtmw
         RzRCvfwG5iEbSh97ZIvC0rmMyEca1IqeJyY8t4TSj/cXlZPSQz2TLIgEv7QLZHyd0hS3
         wkch7jwq+8an0TjOLu8H21e6WJf+wDEItrrJ7iOo5O9+E1Hvfl/5oUaTKC5cjyyVeV7X
         aTd6EkBN0z6UVWCn5VYESmp6JOtxogNtRgyHVwPf3ZiEDsvUw4xtNHA14u5eiHIy9MLM
         eAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kkkU9e6NPdzWlq+30NnrBK3elbGcUFsjA5IRWacg35w=;
        b=LuQx2zi6lBZjj+hkfwHGGxCL2r/D9qXudOImiqxnDrKn0IXEk4Rhw4SvCqeEvTdiSy
         EJtcyHpXwveUV0/gRoxkM1BmL9f5z/zyVmHJgtczSXy0wYcmHjbJI2C+o+R4S/e1uQyf
         b0rh4W2eiyQeSIGyTc3TzqwSJWmKFLbOYQONwaMEDytwCgo8sMRwVpKapVDym0QP4aOH
         geIkFDopJZPIIaqDeW1RkuLuVI0sM1jhgjAXg5eE02AUR2TKa3EaiGNzICow47vh5br2
         /QwDVM7mRdKFIMmVDADrcCdaJBcqnW5VICNxIYgO57ENSVv8FmP9n+onjI8Ap8HgJGqb
         DrRA==
X-Gm-Message-State: ABuFfojx+RrCvBlx7u83ejmUzojsUJiFZWwEIaoydrjMfVPnFdbtJYtN
        XHUSELiUbcOasYK02XYjVI38Aw==
X-Google-Smtp-Source: ACcGV63r0ikAEGMOAxu5X0gW1kEShgGiPHOZoICu2OViKvWK0OP+2t8c87y/LwDoXW1ek+7KBeRV/w==
X-Received: by 2002:a62:ccd4:: with SMTP id j81-v6mr14800582pfk.76.1538788568829;
        Fri, 05 Oct 2018 18:16:08 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id z70-v6sm11859792pgd.64.2018.10.05.18.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 18:16:07 -0700 (PDT)
Subject: Re: [PATCH v9 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20181004212747.6301-1-logang@deltatee.com>
 <20181004212747.6301-8-logang@deltatee.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <485de371-0e84-6f20-7f3b-cec5635b87fe@kernel.dk>
Date:   Fri, 5 Oct 2018 19:16:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181004212747.6301-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/4/18 3:27 PM, Logan Gunthorpe wrote:
> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
> supports targeting P2P memory. This will be used by P2P providers and
> orchestrators (in subsequent patches) to ensure block devices can
> support P2P memory before submitting P2P backed pages to submit_bio().

Nit pick, but the subject line still says that it checks support
for requests. This patch just adds the ability to flag support
in the queue.

-- 
Jens Axboe

