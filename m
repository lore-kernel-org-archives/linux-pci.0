Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47310 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbdCaStG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2017 14:49:06 -0400
Subject: Re: [RFC 1/8] Introduce Peer-to-Peer memory (p2pmem) device
To: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-2-git-send-email-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <cb102386-0314-a3a3-ed44-b42debdf1512@codeaurora.org>
Date: Fri, 31 Mar 2017 14:49:01 -0400
MIME-Version: 1.0
In-Reply-To: <1490911959-5146-2-git-send-email-logang@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Logan,

> +/**
> + * p2pmem_unregister() - unregister a p2pmem device
> + * @p: the device to unregister
> + *
> + * The device will remain until all users are done with it
> + */
> +void p2pmem_unregister(struct p2pmem_dev *p)
> +{
> +	if (!p)
> +		return;
> +
> +	dev_info(&p->dev, "unregistered");
> +	device_del(&p->dev);
> +	ida_simple_remove(&p2pmem_ida, p->id);

Don't you need to clean up the p->pool here.

> +	put_device(&p->dev);
> +}
> +EXPORT_SYMBOL(p2pmem_unregister);
> +

I don't like the ugliness around the switch port to be honest. 

Going to whitelist/blacklist looks simpler in my opinion.

Sinan


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
