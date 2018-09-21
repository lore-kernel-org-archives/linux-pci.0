Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8937C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 18:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25B121477
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 18:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25B121477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390959AbeIVADi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:03:38 -0400
Received: from ale.deltatee.com ([207.54.116.67]:45342 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390076AbeIVADi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 20:03:38 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g3Pvg-0001PM-0z; Fri, 21 Sep 2018 12:13:24 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvdimm@lists.01.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-4-logang@deltatee.com>
 <20180921131550.GG224714@bhelgaas-glaptop.roam.corp.google.com>
 <20180921164813.GJ224714@bhelgaas-glaptop.roam.corp.google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <506dd00c-35e9-e285-bc97-c689c766b4cf@deltatee.com>
Date:   Fri, 21 Sep 2018 12:13:21 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921164813.GJ224714@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, dan.j.williams@intel.com, maxg@mellanox.com, bhelgaas@google.com, benh@kernel.crashing.org, christian.koenig@amd.com, jgg@mellanox.com, jglisse@redhat.com, linux-block@vger.kernel.org, sbates@raithlin.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org, sagi@grimberg.me, alex.williamson@redhat.com, keith.busch@intel.com, axboe@kernel.dk, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018-09-21 10:48 AM, Bjorn Helgaas wrote:
>> I think the use of "map" in this context is slightly confusing because the
>> general expectation is that map/unmap must be balanced.

Yeah, Jason said the same thing, but having an empty unmap function
seems wasteful and Christoph said to just remove it. My opinion is that
it's not that big an issue one way or another -- if we have to add an
unmap later it's not really that hard.

>> If you keep "map", maybe add a sentence or two about why there's no
>> corresponding unmap?

Will do.

> Another wrinkle is that "map" usually takes an A and gives you back a
> B.  Now the caller has both A and B and both are still valid.
> Here we pass in an SGL and the SGL is transformed, so the caller only
> has B and A has been destroyed, i.e., the SGL can no longer be used as
> it was before, and there's no way to get A back.

I wouldn't say that. Our map_sg function is doing the same thing
dma_map_sg is: it sets the DMA address and length in the scatter list.
So B is still A just with other fields set. If the caller wanted to map
this SG in a different way they can still do so and the new DMA
address/length would override the old values. (Normally, you'd want to
unmap before doing something like that, but seeing our unmap is an empty
operation, we wouldn't have to do that.)

Logan


