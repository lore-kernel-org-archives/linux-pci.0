Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281CEC433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D987120858
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zAZBThdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D987120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391485AbeIVBur (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391436AbeIVBur (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 21:50:47 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6469221567;
        Fri, 21 Sep 2018 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537560022;
        bh=CrhlpLU1sMnx5ej8V4SsnscK1e+9Iyub/ZaXRbhq+4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zAZBThdK6bXl3iktj8Idzvtn6mFdtkuX3Xj1aJM35wjwtBieDHLtK/yf3UivnyyUS
         nbeAe7Q0qrhkR2E/m7PN1rdCdp7f9bLUfmDqhSQ0W9XauloTcuuzCO+WnYuMmLj5c2
         oUmKQF51bAAKafsCKEJQ/RHIcoSAqe4p8wr5JCZ8=
Date:   Fri, 21 Sep 2018 15:00:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvdimm@lists.01.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
Message-ID: <20180921200021.GN224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-4-logang@deltatee.com>
 <20180921131550.GG224714@bhelgaas-glaptop.roam.corp.google.com>
 <20180921164813.GJ224714@bhelgaas-glaptop.roam.corp.google.com>
 <506dd00c-35e9-e285-bc97-c689c766b4cf@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <506dd00c-35e9-e285-bc97-c689c766b4cf@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 21, 2018 at 12:13:21PM -0600, Logan Gunthorpe wrote:
> On 2018-09-21 10:48 AM, Bjorn Helgaas wrote:
> >> I think the use of "map" in this context is slightly confusing because the
> >> general expectation is that map/unmap must be balanced.
> 
> Yeah, Jason said the same thing, but having an empty unmap function
> seems wasteful and Christoph said to just remove it. My opinion is that
> it's not that big an issue one way or another -- if we have to add an
> unmap later it's not really that hard.
> 
> >> If you keep "map", maybe add a sentence or two about why there's no
> >> corresponding unmap?
> 
> Will do.
> 
> > Another wrinkle is that "map" usually takes an A and gives you back a
> > B.  Now the caller has both A and B and both are still valid.
> > Here we pass in an SGL and the SGL is transformed, so the caller only
> > has B and A has been destroyed, i.e., the SGL can no longer be used as
> > it was before, and there's no way to get A back.
> 
> I wouldn't say that. Our map_sg function is doing the same thing
> dma_map_sg is: it sets the DMA address and length in the scatter list.
> So B is still A just with other fields set. If the caller wanted to map
> this SG in a different way they can still do so and the new DMA
> address/length would override the old values. (Normally, you'd want to
> unmap before doing something like that, but seeing our unmap is an empty
> operation, we wouldn't have to do that.)

Ok.  I was assuming s->dma_address would have been already set before
the call and would be overwritten by pci_p2pmem_map_sg().  But I guess
that's not the case -- sounds like s->dma_address is undefined before
the call.

Bjorn
