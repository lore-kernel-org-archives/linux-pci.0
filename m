Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34141 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753420AbdDDK7c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2017 06:59:32 -0400
Subject: Re: [RFC 6/8] nvmet: Be careful about using iomem accesses when
 dealing with p2pmem
To: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
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
 <1490911959-5146-7-git-send-email-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
Date: Tue, 4 Apr 2017 13:59:26 +0300
MIME-Version: 1.0
In-Reply-To: <1490911959-5146-7-git-send-email-logang@deltatee.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


>  u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off, const void *buf,
>  		size_t len)
>  {
> -	if (sg_pcopy_from_buffer(req->sg, req->sg_cnt, buf, len, off) != len)
> +	bool iomem = req->p2pmem;
> +	size_t ret;
> +
> +	ret = sg_copy_buffer(req->sg, req->sg_cnt, (void *)buf, len, off,
> +			     false, iomem);
> +
> +	if (ret != len)
>  		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
> +
>  	return 0;
>  }

We can never ever get here from an IO command, and that is a good thing
because it would have been broken if we did, regardless of what copy
method we use...

Note that the nvme completion queues are still on the host memory, so
this means we have lost the ordering between data and completions as
they go to different pcie targets.

If at all, this is the place to *emphasize* we must never get here
with p2pmem, and immediately fail if we do.

I'm not sure what will happen with to copy_from_sgl, I guess we
have the same race because the nvme submission queues are also
on the host memory (which is on a different pci target). Maybe
more likely to happen with write-combine enabled?

Anyway I don't think we have a real issue here *currently*, because
we use copy_to_sgl only for admin/fabrics commands emulation and
copy_from_sgl to setup dsm ranges...
