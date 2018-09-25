Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A5FC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 18:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A2D2086E
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 18:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A2D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeIZBAR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:00:17 -0400
Received: from ale.deltatee.com ([207.54.116.67]:44166 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbeIZBAR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 21:00:17 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g4sQP-0004TR-Sc; Tue, 25 Sep 2018 12:51:10 -0600
To:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20180925162231.4354-1-logang@deltatee.com>
 <20180925162231.4354-3-logang@deltatee.com>
 <1537896555.11137.22.camel@acm.org>
 <9241a6af-9826-d1ff-c13b-882cb3b6a34a@deltatee.com>
 <1537900280.11137.30.camel@acm.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <834b26a8-545c-98e0-fd95-231b701abae6@deltatee.com>
Date:   Tue, 25 Sep 2018 12:51:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1537900280.11137.30.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: axboe@kernel.dk, christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bvanassche@acm.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 02/13] PCI/P2PDMA: Add sysfs group to display p2pmem
 stats
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-09-25 12:31 p.m., Bart Van Assche wrote:
> On Tue, 2018-09-25 at 12:15 -0600, Logan Gunthorpe wrote:
>> On 2018-09-25 11:29 a.m., Bart Van Assche wrote:
>>> On Tue, 2018-09-25 at 10:22 -0600, Logan Gunthorpe wrote:
>>>> @@ -83,9 +132,14 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
>>>>  
>>>>  	pdev->p2pdma = p2p;
>>>>  
>>>> +	error = sysfs_create_group(&pdev->dev.kobj, &p2pmem_group);
>>>> +	if (error)
>>>> +		goto out_pool_destroy;
>>>> +
>>>>  	return 0;
>>>>  
>>>>  out_pool_destroy:
>>>> +	pdev->p2pdma = NULL;
>>>>  	gen_pool_destroy(p2p->pool);
>>>>  out:
>>>>  	devm_kfree(&pdev->dev, p2p);
>>>
>>> This doesn't look right to me. Shouldn't devm_remove_action() be called instead
>>> of devm_kfree() if sysfs_create_group() fails?
>>
>> That makes no sense to me. We are reversing a devm_kzalloc() not a
>> custom action....
> 
> In case what I wrote was not clear: both devm_kzalloc() and
> devm_add_action_or_reset() have to be reversed if sysfs_create_group() fails.
> devm_add_action_or_reset() calls devres_add(). The latter function adds an
> element to the dev->devres_head list. So I think that only calling devm_kfree()
> if sysfs_create_group() fails will lead to corruption of the dev->devres_head
> list.

I don't see how it would corrupt the list. devres_remove() uses
list_del_init() which doesn't require that you only remove the tail from
the list... The way I read the code, you can remove any devm action at
any time.

Logan
