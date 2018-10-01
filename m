Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E14C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 22:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCD02089A
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 22:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCD02089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeJBFD3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:03:29 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41944 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBFD3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2018 01:03:29 -0400
Received: by mail-yw1-f65.google.com with SMTP id q129-v6so6204070ywg.8;
        Mon, 01 Oct 2018 15:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DzDPLD+do0db1h4J1Wbjll7V13niIPcJiJAj2KeNWZc=;
        b=C25J8zGzInDiotnqSo3LraM2PUh1uCVAi2C7uo4F5xcdmRXOqg6MTWGLDlQh5jT2Oc
         1AHD93GmdUvdF0Um2aik3V14M+6TlYE+r1lnLzN7l0EFiIJHUJnYPjwe6dCQ4Q1pNPqy
         362zZur1ifwnHWPvrpZHE5PonMt+jMsRABMXqR5XkWOUjsO1v1CqawYDiif8h+F+wy9m
         +KfyybhzSJsdAmH+IYfMRso2k3GhYu+FGloTZbm5ZxO4goJFvdVdVImD1Rn0/CWubUHt
         CcrgCEW/ILUJHCBmXEQui6VODiCEeLijwAofJgmRzKe2/hh1v4x/GmNRrv6SCb1twGHQ
         YOug==
X-Gm-Message-State: ABuFfogEHAqr1By59h4lp8KQj+sPny1HKD/I9/FwdyekNmpH4wGefsFc
        C1iCd3Qxq9nAaO2Y1d5+5+I=
X-Google-Smtp-Source: ACcGV63e4Z+3/Mew+SVYx0xc4cWui/4JQv7dAzUUZF7Q8XWuwM2urb/EJeJXNmQv+cA60cA/KvdCKg==
X-Received: by 2002:a0d:cdc4:: with SMTP id p187-v6mr6892386ywd.292.1538432609501;
        Mon, 01 Oct 2018 15:23:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l30-v6sm13731622ywa.104.2018.10.01.15.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 15:23:28 -0700 (PDT)
Subject: Re: [PATCH v8 13/13] nvmet: Optionally use PCI P2P memory
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
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-14-logang@deltatee.com>
 <5ddeed51-0580-9581-cf12-c75e18b4f7cc@grimberg.me>
 <69cd8aab-b94e-98f5-5397-48bb875e8280@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b790b11f-41df-f495-fdd1-d8bd6d6b7dd6@grimberg.me>
Date:   Mon, 1 Oct 2018 15:23:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <69cd8aab-b94e-98f5-5397-48bb875e8280@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


>>> +/*
>>> + * If allow_p2pmem is set, we will try to use P2P memory for the SGL lists for
>>> + * Ι/O commands. This requires the PCI p2p device to be compatible with the
>>> + * backing device for every namespace on this controller.
>>> + */
>>> +static void nvmet_setup_p2pmem(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>>> +{
>>> +	struct nvmet_ns *ns;
>>> +	int ret;
>>> +
>>> +	if (!req->port->use_p2pmem || !req->p2p_client)
>>> +		return;
>>
>> Nit, IMO would be better to check at the call-site, but not a hard
>> must...
> 
> I'd rather keep the logic for whether to enable p2pmem in it's own
> function. nvme_alloc_ctrl() is already very long and complicated.

Fair enough..

>> I still do not fully understand why p2p_dev has to be ctrl-wide and not
>> per namespace. Sorry to keep bringing this up (again). But if people are
>> OK with it then I guess I can stop asking about this...
> 
> Because you never answered my question back in March[1] (which I think
> you've answered below)....

I'm sorry... I lost tracking on this...

>> I think that at some point we said that this looks like it should fall
>> back to host memory for those namespaces.. when we allocate the sgl we
>> already assigned a namespace to the request (nvmet_req_init).
> 
> I did not realize the namespace would be available at this time. I guess
> I can give this a try, but it's going to be a fairly big change from
> what's presented here... Though, I agree it'll probably be an improvement.

Thanks, if it turns out to create to much of a churn, we could defer
that to a later stage, but we can at least document it.
