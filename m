Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED1C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 16:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6656A21567
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 16:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3IER1PT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6656A21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390365AbeIUWbJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389683AbeIUWbJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 18:31:09 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 420FA21565;
        Fri, 21 Sep 2018 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537548087;
        bh=y/cdrkvx/4VQFEwAC2tZK5bwdY3HlVZb3pjDHaBktzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3IER1PTSm/Izcw1HvfR6LVGCzICd/6jXkKRZQg+uHKj8SEjFhjfisNqOAbTu2eHc
         Unpzr+tUDoyYSdBY8nRitSaibhmvqUGrG8ZWDdNHOnI3AbGbogxYkH/VMHUbQt7nHF
         XXsq9/qatJLnyNYuNudzqUcsOtShrJjIHSIrk9GI=
Date:   Fri, 21 Sep 2018 11:41:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
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
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
Message-ID: <20180921164126.GI224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913001156.4115-7-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 12, 2018 at 06:11:49PM -0600, Logan Gunthorpe wrote:
> Add a restructured text file describing how to write drivers
> with support for P2P DMA transactions. The document describes
> how to use the APIs that were added in the previous few
> commits.
> 
> Also adds an index for the PCI documentation tree even though this
> is the only PCI document that has been converted to restructured text
> at this time.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +With the client list in hand, the orchestrator may then call
> +:c:func:`pci_p2pmem_find()` to obtain a published P2P memory provider
> +that is supported (behind the same root port) as all the clients. If more
> +than one provider is supported, the one nearest to all the clients will
> +be chosen first. If there are more than one provider is an equal distance

s/If there are more/If more/

> +away, the one returned will be chosen at random. This function returns the PCI

s/the one returned will be chosen at random/one will be chosen
arbitrarily/ ?  (I doubt it's really random)

> +device to use for the provider with a reference taken and therefore
> +when it's no longer needed it should be returned with pci_dev_put().

> +Struct Page Caveats
> +-------------------
> +
> +Driver writers should be very careful about not passing these special
> +struct pages to code that isn't prepared for it. At this time, the kernel
> +interfaces do not have any checks for ensuring this. This obviously
> +precludes passing these pages to userspace.

Sounds like landmines here since the reader probably can't translate
"code that isn't prepared for it" into a list of interfaces that are
off-limits.  But that's a VM issue that is above my pay grade, so I'm
not suggesting any change; just pointing out something that makes me
wonder "hmmm..., how would I act on this?"

> +P2P memory is also technically IO memory but should never have any side
> +effects behind it. Thus, the order of loads and stores should not be important
> +and ioreadX(), iowriteX() and friends should not be necessary.
> +However, as the memory is not cache coherent, if access ever needs to
> +be protected by a spinlock then :c:func:`mmiowb()` must be used before
> +unlocking the lock. (See ACQUIRES VS I/O ACCESSES in
> +Documentation/memory-barriers.txt)
