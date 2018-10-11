Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2026CC43441
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 03:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D468B2086D
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 03:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0XgLSyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D468B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJKKoM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 06:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbeJKKoM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 06:44:12 -0400
Received: from localhost (246.sub-174-234-138.myvzw.com [174.234.138.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B8F2085B;
        Thu, 11 Oct 2018 03:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539227940;
        bh=E49epR5WKdqwOJmODbNZu7O4dUouVK7BncRNbda9nKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0XgLSyrhTah6cc9nF2wHkdGQdjBp/XFob82auiz64YBeEj4dk3UnDJcIPHaK4iag
         qGvj0tdjMJ//ApsetqN1eTu/uZ/S6E37OaBO7xmYp3t5fyuLBHmNek83J2Km5CKuWY
         riNc3jvltiUCd+gKDwZAyX9PiA+C8B2gNaVA3XAI=
Date:   Wed, 10 Oct 2018 22:18:58 -0500
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
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v9 00/13] Copy Offload in NVMe Fabrics with P2P PCI Memory
Message-ID: <20181011031858.GL5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181004212747.6301-1-logang@deltatee.com>
 <20181010201918.GF5906@bhelgaas-glaptop.roam.corp.google.com>
 <5c674a1b-2471-33eb-44f4-fe1bb8807a22@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c674a1b-2471-33eb-44f4-fe1bb8807a22@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 10, 2018 at 05:03:33PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2018-10-10 2:19 p.m., Bjorn Helgaas wrote:
> > I added the reviewed-by tags from Christoph, Jens' ack on the blkdev.h
> > change, and applied these to pci/peer-to-peer with the intent of
> > merging these for v4.20.
> > 
> > I gave up on waiting for an ack for the memremap.h and mm.h changes.
> > 
> > I dropped the "nvme-pci: Add a quirk for a pseudo CMB" quirk because
> > of Christoph's objection.  After this is all merged, I won't need to
> > be involved, and you and the NVMe folks can hash that out.
> > 
> > If there are updates to "nvmet: Optionally use PCI P2P memory" based
> > on Sagi's comments, send an incremental patch and I'll fold them in.
> 
> Thanks for picking this up. However, I hate to throw a wrench in the
> works, but I had a v10[1] queued up because kbuild found some problems
> with the series over the weekend. I can send v10 off right away if you
> want to just replace it in your branch or, if you'd like, I can generate
> some incremental patches. Let me know which you'd prefer.

I applied the updates from your v10 to my pci/peer-to-peer branch.

> [1] https://github.com/sbates130272/linux-p2pmem pci-p2p-v10
