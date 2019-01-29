Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F6EC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 18:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BD920869
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 18:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfA2S0P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:26:15 -0500
Received: from ale.deltatee.com ([207.54.116.67]:58764 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfA2S0O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 13:26:14 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1goY5B-00053B-Qg; Tue, 29 Jan 2019 11:26:02 -0700
To:     jglisse@redhat.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-3-jglisse@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <98d345af-7928-2a50-7bc4-582916dfac80@deltatee.com>
Date:   Tue, 29 Jan 2019 11:26:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129174728.6430-3-jglisse@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, jroedel@suse.de, robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, jgg@mellanox.com, Felix.Kuehling@amd.com, christian.koenig@amd.com, bhelgaas@google.com, rafael@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 2/5] drivers/base: add a function to test peer to peer
 capability
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-29 10:47 a.m., jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> device_test_p2p() return true if two devices can peer to peer to
> each other. We add a generic function as different inter-connect
> can support peer to peer and we want to genericaly test this no
> matter what the inter-connect might be. However this version only
> support PCIE for now.

This doesn't appear to be used in any of the further patches; so it's
very confusing.

I'm not sure a struct device wrapper is really necessary...

Logan
