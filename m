Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22659C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 18:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B305A2089D
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 18:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B305A2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeIZAzp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:55:45 -0400
Received: from ale.deltatee.com ([207.54.116.67]:44110 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbeIZAzo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 20:55:44 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g4sM0-0004QW-G5; Tue, 25 Sep 2018 12:46:37 -0600
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
 <20180925162231.4354-4-logang@deltatee.com>
 <1537896805.11137.25.camel@acm.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <18e5d3f2-c56b-645b-ac96-f0d861d12cc2@deltatee.com>
Date:   Tue, 25 Sep 2018 12:46:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1537896805.11137.25.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: axboe@kernel.dk, christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bvanassche@acm.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-09-25 11:33 a.m., Bart Van Assche wrote:
>> +	/*
>> +	 * p2pdma mappings are not compatible with devices that use
>> +	 * dma_virt_ops. If the upper layers do the right thing
>> +	 * this should never happen because it will be prevented
>> +	 * by the check in pci_p2pdma_add_client()
>> +	 */
>> +	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
>> +			 dev->dma_ops == &dma_virt_ops))
>> +		return 0;
> 
> Are you assuming that the compiler will optimize out the dev->dma_ops
> == &dma_virt_ops test if CONFIG_DMA_VIRT_OPS=n such that no reference to the
> dma_virt_ops symbol appears in the object file? Are you sure all compilers
> and compiler versions that are used to build the Linux kernel will do that?

Hmm, I can't say for certain but I would definitely expect any sane
compiler to do so. It's a fairly obvious optimization and the kbuild
robot is happy with it.

I just did a test compile on 4.9 (which is the earliest compiler version
I have readily available) and it worked fine. The minimum gcc the kernel
supports is 4.6 right now.

I've also done a similar test on godbolt.org[1] and can't find any
compiler version that doesn't work.

Logan


[1] https://godbolt.org/z/d5Mhee
