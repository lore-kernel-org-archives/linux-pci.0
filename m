Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2CCC43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 21:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06DD2145D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 21:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06DD2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeJBEfl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:35:41 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58704 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeJBEfl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Oct 2018 00:35:41 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g76A5-0002Pq-06; Mon, 01 Oct 2018 15:55:29 -0600
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
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-14-logang@deltatee.com>
 <5ddeed51-0580-9581-cf12-c75e18b4f7cc@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <69cd8aab-b94e-98f5-5397-48bb875e8280@deltatee.com>
Date:   Mon, 1 Oct 2018 15:55:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5ddeed51-0580-9581-cf12-c75e18b4f7cc@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: swise@opengridcomputing.com, axboe@kernel.dk, christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, keith.busch@intel.com, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v8 13/13] nvmet: Optionally use PCI P2P memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-10-01 3:34 p.m., Sagi Grimberg wrote:
>> +
>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +		pci_p2pdma_remove_client(&ctrl->p2p_clients, nvmet_ns_dev(ns));
>> +		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
> 
> Hi Logan, what is this event here?

Oops, that must have been from a bad rebase.... Will Fix.

>> +		if (sq->qid && p2p_dev) {
>> +			req->sg = pci_p2pmem_alloc_sgl(p2p_dev, &req->sg_cnt,
>> +						       req->transfer_len);
>> +			if (req->sg) {
>> +				req->p2p_dev = p2p_dev;
>> +				return 0;
>> +			}
> 
> Would be useful to comment that we fall to normal sgl allocation.

Ok.

>> +/*
>> + * If allow_p2pmem is set, we will try to use P2P memory for the SGL lists for
>> + * Ι/O commands. This requires the PCI p2p device to be compatible with the
>> + * backing device for every namespace on this controller.
>> + */
>> +static void nvmet_setup_p2pmem(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>> +{
>> +	struct nvmet_ns *ns;
>> +	int ret;
>> +
>> +	if (!req->port->use_p2pmem || !req->p2p_client)
>> +		return;
> 
> Nit, IMO would be better to check at the call-site, but not a hard
> must...

I'd rather keep the logic for whether to enable p2pmem in it's own
function. nvme_alloc_ctrl() is already very long and complicated.

> I still do not fully understand why p2p_dev has to be ctrl-wide and not
> per namespace. Sorry to keep bringing this up (again). But if people are
> OK with it then I guess I can stop asking about this...

Because you never answered my question back in March[1] (which I think
you've answered below)....

> I think that at some point we said that this looks like it should fall
> back to host memory for those namespaces.. when we allocate the sgl we
> already assigned a namespace to the request (nvmet_req_init).

I did not realize the namespace would be available at this time. I guess
I can give this a try, but it's going to be a fairly big change from
what's presented here... Though, I agree it'll probably be an improvement.

Logan

[1]
https://lore.kernel.org/lkml/7163af93-2f37-a8b6-986a-3cb2e62bee29@deltatee.com/T/#u
