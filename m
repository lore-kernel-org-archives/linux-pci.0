Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9AEC433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 13:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D822154F
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 13:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vUUS8O9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D822154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeIUSzz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbeIUSzz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 14:55:55 -0400
Received: from localhost (252.sub-174-234-146.myvzw.com [174.234.146.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F230E21532;
        Fri, 21 Sep 2018 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537535227;
        bh=V7nu7ZMW4zuFHjhx59YSChDKK9b/IAgKtndorfVR/Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vUUS8O9CHdmjvfJAXPtaMD/H1c6/5NCqPs4bel7WS3hWDgkel+hsMeRuFyq/zZMqO
         L7HfRQMgQ7NQ/PClcisbAw9cDKwLQMQ9oRuSIfAYtPCd7DDABbC1PbLvopiII8lH9x
         73CHKEuJywxehvfwYeWSLDUOKm9AISWuLT7mtO5w=
Date:   Fri, 21 Sep 2018 08:07:05 -0500
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
Subject: Re: [PATCH v6 02/13] PCI/P2PDMA: Add sysfs group to display p2pmem
 stats
Message-ID: <20180921130705.GF224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913001156.4115-3-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 12, 2018 at 06:11:45PM -0600, Logan Gunthorpe wrote:
> Add a sysfs group to display statistics about P2P memory that is
> registered in each PCI device.
> 
> Attributes in the group display the total amount of P2P memory, the
> amount available and whether it is published or not.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +What:		/sys/bus/pci/devices/.../p2pmem/available
> +Date:		November 2017
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:
> +		If the device has any Peer-to-Peer memory registered, this
> +	        file contains the amount of memory that has not been
> +		allocated (in decimal).
> +
> +What:		/sys/bus/pci/devices/.../p2pmem/size
> +Date:		November 2017
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:
> +		If the device has any Peer-to-Peer memory registered, this
> +	        file contains the total amount of memory that the device
> +		provides (in decimal).

Maybe reorder this so the "size" (total amount) is documented before
"available" (some subset of "size")?

> +
> +What:		/sys/bus/pci/devices/.../p2pmem/published
> +Date:		November 2017
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:
> +		If the device has any Peer-to-Peer memory registered, this
> +	        file contains a '1' if the memory has been published for
> +		use inside the kernel or a '0' if it is only intended
> +		for use within the driver that published it.

It doesn't read quite right to talk about "use within the driver that
*published* it".  Is it really published in that case?  That sounds more
like "private".  I expected something like the following (but I don't claim
to understand the whole use model here):

  ... this file contains a '1' if the memory has been published for use
  outside the driver that owns the device.

