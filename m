Return-Path: <SRS0=s+SA=MR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B82C00449
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 07:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13682054F
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 07:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13682054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeJEObv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:31:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39118 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbeJEObv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Oct 2018 10:31:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so4352050pfe.6;
        Fri, 05 Oct 2018 00:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SEhqGCs3D6tIVEyCVOq+J9ATvMQloVr0AmxdN/QdFsk=;
        b=ktOMNRSskAwnQyb531Skeaj5kMGGjVH+kTIFPj7F2NvPNEA4yiiFrOilcnr6OJ94pU
         8KPbJz2Rm8SMtWM+wngvq/okk6lc+7UA3ytP0kLx7N452DYMBJyZZGas8CqpQJqZThrI
         0MIo4FOApmnOGBxFcfakhQbO3mozypmcp/IZyGZPEE0Sdi3NvN2flSfp3bnAA9ihvr+8
         DyNWEP/T/rxnkji6/uJRuJLfXgQ7oqqA38ft7oJwW4UkOmYHmILr2Hs89Ajpvss2FzZt
         L4BzprHpfW7oQzpBfXtngoCggIXLO390H/WepWhmFoW5hHXxtsrscHTP8Ko4a/7q2hxk
         355A==
X-Gm-Message-State: ABuFfoimCLU9GK5CCeLsJT72W4yomaLBREP/WU/e7sa5BV6my4MxRdtz
        s5iAM5KiW/SO7akSJf2Mr3Z9V0VF
X-Google-Smtp-Source: ACcGV62v4GXHUGqx7UVBEVD0y4McXxnULW5VpdgrVx/dH4ubp2NgXLzFSJlLYHg3b9sF7HKFfv7NzQ==
X-Received: by 2002:a63:1b0b:: with SMTP id b11-v6mr8916635pgb.66.1538724863548;
        Fri, 05 Oct 2018 00:34:23 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:65ce:2bfc:fedf:1f69? ([2601:647:4800:973f:65ce:2bfc:fedf:1f69])
        by smtp.gmail.com with ESMTPSA id 70-v6sm10529605pfz.27.2018.10.05.00.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 00:34:22 -0700 (PDT)
Subject: Re: [PATCH v9 13/13] nvmet: Optionally use PCI P2P memory
To:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
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
 <2bcc0927-83ab-1bf2-d584-aebd5274cefa@deltatee.com>
 <20181005070720.GA23725@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <236ae882-34e0-50d8-ac19-ee5dab8db3f2@grimberg.me>
Date:   Fri, 5 Oct 2018 00:34:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005070720.GA23725@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


>>>> +static inline struct device *nvmet_ns_dev(struct nvmet_ns *ns)
>>>> +{
>>>> +	return disk_to_dev(ns->bdev->bd_disk);
>>>> +}
>>>
>>> This needs to handle non bdev namespaces.
>>
>> As it's coded now the helper never gets called unless ns->bdev is not
>> null. But in general, yes you are right, we should probably return NULL
>> if ns->bdev is NULL.
> 
> I'd rather skip that for now.

If there is a v10 I don't see why that cannot be addressed.

>>> index ef286b72d958..3d12f5f4568d 100644
>>> --- a/drivers/nvme/target/fc.c
>>> +++ b/drivers/nvme/target/fc.c
>>> @@ -2280,6 +2280,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport
>>> *tgtport,
>>>           fod->req.cmd = &fod->cmdiubuf.sqe;
>>>           fod->req.rsp = &fod->rspiubuf.cqe;
>>>           fod->req.port = tgtport->pe->port;
>>> +       fod->req.p2p_client = tgtport->dev;
>>>
>>>           /* clear any response payload */
>>>           memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
>>> --
>>
>> Sure, I guess that makes sense. I've never tried it with fc hardware but
>> I assume there's no reason it wouldn't work.
>>
>> I'll queue these changes up for a v10.
> 
> And I'd wait until someone has actually tested this case.

Oh yes, agreed. Should work though...
