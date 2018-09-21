Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07BC433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 13:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F662154F
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 13:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="La4K4o7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F662154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeIUSs7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbeIUSs7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 14:48:59 -0400
Received: from localhost (252.sub-174-234-146.myvzw.com [174.234.146.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21BA21532;
        Fri, 21 Sep 2018 13:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537534813;
        bh=hA5iPYdQ0jTpDnLtGsIrSdBsuzOxXx5TPBOpzhMh7pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=La4K4o7gyJDI/svllE5SIfTrGw1/wqdiV6lEG/r8oJXMEDRk7PbVPbnkcVibXNHDE
         i9cBd1W1sm6F6B8FT2M0MYZdYSVM+bPEuNCh8h6ADTWYbLcG8NxrtBMY2QMYdqTK+O
         uMCgeRHXNfeKf68PVmgT+ysp68D5nM/S6j0Q5tHI=
Date:   Fri, 21 Sep 2018 08:00:10 -0500
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
Subject: Re: [PATCH v6 01/13] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180921130010.GE224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-2-logang@deltatee.com>
 <20180920223829.GD224714@bhelgaas-glaptop.roam.corp.google.com>
 <ab733346-9518-ed68-492d-e52929586293@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab733346-9518-ed68-492d-e52929586293@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 20, 2018 at 04:47:49PM -0600, Logan Gunthorpe wrote:
> On 2018-09-20 4:38 PM, Bjorn Helgaas wrote:
> >> +#define pr_fmt(fmt) "pci-p2pdma: " fmt
> > 
> > Is pr_fmt() actually used anywhere?
> 
> It's used in a Patch 4 to print errors in the configfs helpers.

Ideally pr_fmt() would be added in the same patch that uses it, but
obviously pretty trivial.
