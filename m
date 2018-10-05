Return-Path: <SRS0=s+SA=MR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588B7C00449
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 15:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2996421480
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 15:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2996421480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJEWlc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:41:32 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60374 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeJEWlc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Oct 2018 18:41:32 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g8SEw-0007ab-Hr; Fri, 05 Oct 2018 09:42:07 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <298e6e20-c8b6-de4b-46f5-94d1d3e2445c@deltatee.com>
Date:   Fri, 5 Oct 2018 09:42:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005070720.GA23725@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: swise@opengridcomputing.com, axboe@kernel.dk, christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, keith.busch@intel.com, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, sagi@grimberg.me, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v9 13/13] nvmet: Optionally use PCI P2P memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-10-05 1:07 a.m., Christoph Hellwig wrote:
> On Thu, Oct 04, 2018 at 04:29:19PM -0600, Logan Gunthorpe wrote:
>>> This needs to handle non bdev namespaces.
>>
>> As it's coded now the helper never gets called unless ns->bdev is not
>> null. But in general, yes you are right, we should probably return NULL
>> if ns->bdev is NULL.
> 
> I'd rather skip that for now.

Ok, if I do a v10 I'll add it but I don't have anything else queued up
at the moment.


>> Sure, I guess that makes sense. I've never tried it with fc hardware but
>> I assume there's no reason it wouldn't work.
>>
>> I'll queue these changes up for a v10.
> 
> And I'd wait until someone has actually tested this case.

Agreed.

Thanks for the review!

Logan

