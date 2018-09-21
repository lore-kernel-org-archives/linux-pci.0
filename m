Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964F2ECE560
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 19:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544E821567
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 19:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xHBi263M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544E821567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391382AbeIVBhZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391160AbeIVBhZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 21:37:25 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D39552154F;
        Fri, 21 Sep 2018 19:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537559223;
        bh=bwwdKytrqE/ZeMFNEmzuY/p2evCoUPSzt2gxc6XlLNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xHBi263Me/pRUHvZiVU1oj0v/INeUveaW/+rdr2V73NuTxJqQ3X2L2k3f7rDDfQoI
         U6RjoonWmPuH+K4/s0+qJoxz4SSTONiCpUe8B+6WNl6Ydwn9BSdIOKsr0NdIrIN75J
         +SF84vNwUXniGCrCO52Khf4TB0m97hMHgrRaKx44=
Date:   Fri, 21 Sep 2018 14:47:00 -0500
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
Message-ID: <20180921194700.GM224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-7-logang@deltatee.com>
 <20180921164126.GI224714@bhelgaas-glaptop.roam.corp.google.com>
 <e9739430-b238-2078-a51f-d76bae5342d1@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9739430-b238-2078-a51f-d76bae5342d1@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 21, 2018 at 12:03:12PM -0600, Logan Gunthorpe wrote:
> On 2018-09-21 10:41 AM, Bjorn Helgaas wrote:
> >> +away, the one returned will be chosen at random. This function returns the PCI
> > 
> > s/the one returned will be chosen at random/one will be chosen
> > arbitrarily/ ?  (I doubt it's really random)
> 
> You're the second person to ask this, but yes, we really do it randomly.
> Such that if there are multiple drivers getting resources they should be
> evenly distributed. It's not the ideal solution but if it were to do it
> arbitrarily then the code would likely return the same device all the
> time and any additional devices would not get used.

Ah, I see, I should have searched for "random" in that patch and answered
my own question :)  Sorry for the noise.

Bjorn
