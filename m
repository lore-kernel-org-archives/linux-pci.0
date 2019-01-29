Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EF0C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433A320880
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 20:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfA2UY7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:24:59 -0500
Received: from ale.deltatee.com ([207.54.116.67]:59832 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfA2UY7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 15:24:59 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1goZwA-0006Yf-64; Tue, 29 Jan 2019 13:24:51 -0700
To:     Alex Deucher <alexdeucher@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, Joerg Roedel <jroedel@suse.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-2-jglisse@redhat.com>
 <CADnq5_N8QLA_80j+iCtMHvSZhc-WFpzdZhpk6jR9yhoNoUDFZA@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <83acb590-25a5-f8ae-1616-bdb8b069fa0f@deltatee.com>
Date:   Tue, 29 Jan 2019 13:24:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_N8QLA_80j+iCtMHvSZhc-WFpzdZhpk6jR9yhoNoUDFZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: m.szyprowski@samsung.com, christian.koenig@amd.com, robin.murphy@arm.com, bhelgaas@google.com, linux-pci@vger.kernel.org, jgg@mellanox.com, iommu@lists.linux-foundation.org, hch@lst.de, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Felix.Kuehling@amd.com, gregkh@linuxfoundation.org, rafael@kernel.org, jroedel@suse.de, linux-mm@kvack.org, jglisse@redhat.com, alexdeucher@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 1/5] pci/p2p: add a function to test peer to peer
 capability
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-29 12:56 p.m., Alex Deucher wrote:
> On Tue, Jan 29, 2019 at 12:47 PM <jglisse@redhat.com> wrote:
>>
>> From: Jérôme Glisse <jglisse@redhat.com>
>>
>> device_test_p2p() return true if two devices can peer to peer to
>> each other. We add a generic function as different inter-connect
>> can support peer to peer and we want to genericaly test this no
>> matter what the inter-connect might be. However this version only
>> support PCIE for now.
>>
> 
> What about something like these patches:
> https://cgit.freedesktop.org/~deathsimple/linux/commit/?h=p2p&id=4fab9ff69cb968183f717551441b475fabce6c1c
> https://cgit.freedesktop.org/~deathsimple/linux/commit/?h=p2p&id=f90b12d41c277335d08c9dab62433f27c0fadbe5
> They are a bit more thorough.

Those new functions seem to have a lot of overlap with the code that is
already upstream in p2pdma.... Perhaps you should be improving the
p2pdma functions if they aren't suitable for what you want already
instead of creating new ones.

Logan
