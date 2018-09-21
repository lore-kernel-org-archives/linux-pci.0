Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482C0C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1078321571
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 18:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1078321571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390381AbeIUXxr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:53:47 -0400
Received: from ale.deltatee.com ([207.54.116.67]:45256 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390076AbeIUXxr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 19:53:47 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g3Plw-0001JR-GL; Fri, 21 Sep 2018 12:03:21 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
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
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-7-logang@deltatee.com>
 <20180921164126.GI224714@bhelgaas-glaptop.roam.corp.google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e9739430-b238-2078-a51f-d76bae5342d1@deltatee.com>
Date:   Fri, 21 Sep 2018 12:03:12 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921164126.GI224714@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: corbet@lwn.net, axboe@kernel.dk, christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018-09-21 10:41 AM, Bjorn Helgaas wrote:
>> +away, the one returned will be chosen at random. This function returns the PCI
> 
> s/the one returned will be chosen at random/one will be chosen
> arbitrarily/ ?  (I doubt it's really random)

You're the second person to ask this, but yes, we really do it randomly.
Such that if there are multiple drivers getting resources they should be
evenly distributed. It's not the ideal solution but if it were to do it
arbitrarily then the code would likely return the same device all the
time and any additional devices would not get used.

>> +Struct Page Caveats
>> +-------------------
>> +
>> +Driver writers should be very careful about not passing these special
>> +struct pages to code that isn't prepared for it. At this time, the kernel
>> +interfaces do not have any checks for ensuring this. This obviously
>> +precludes passing these pages to userspace.
> 
> Sounds like landmines here since the reader probably can't translate
> "code that isn't prepared for it" into a list of interfaces that are
> off-limits.  But that's a VM issue that is above my pay grade, so I'm
> not suggesting any change; just pointing out something that makes me
> wonder "hmmm..., how would I act on this?"

Yes, these are big landmines. These are the problems we have been
fighting with trying to get P2P memory into the kernel and the first
step seems to have settled on the developer using them has to be careful
and ensure they are only sent to paths that are used correctly. This
series does these things in the block layer and RDMA interface, but due
to Jens not wanting to add warnings to the common code, it's still
possible for a developer to code something that sends these pages to
block devices that are not prepared for it.

Logan
