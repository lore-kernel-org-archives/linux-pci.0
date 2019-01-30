Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0701CC282D4
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 07:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA05821852
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 07:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfA3Hw7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:52:59 -0500
Received: from verein.lst.de ([213.95.11.211]:50704 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfA3Hw6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 02:52:58 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C07BF68CEC; Wed, 30 Jan 2019 08:52:56 +0100 (CET)
Date:   Wed, 30 Jan 2019 08:52:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Message-ID: <20190130075256.GA29665@lst.de>
References: <20190129174728.6430-1-jglisse@redhat.com> <20190129174728.6430-4-jglisse@redhat.com> <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com> <20190129191120.GE3176@redhat.com> <c2c02af7-1d6f-e54f-c7fb-99c5b7776014@deltatee.com> <20190129194418.GG3176@redhat.com> <b3264844-2c04-6c34-f1e7-6b3bf9849a75@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3264844-2c04-6c34-f1e7-6b3bf9849a75@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 01:43:02PM -0700, Logan Gunthorpe wrote:
> It's hard to reason about an interface when you can't see what all the
> layers want to do with it. Most maintainers (I'd hope) would certainly
> never merge code that has no callers, and for much the same reason, I'd
> rather not review patches that don't have real use case examples.

Yes, we should never review, nevermind merge code without users.
We had one example recently where this was not followed, which was HMM
and that turned out to be a desaster.
