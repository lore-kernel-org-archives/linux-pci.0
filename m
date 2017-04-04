Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC 4/8] p2pmem: Add debugfs "stats" file
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
 <1490911959-5146-5-git-send-email-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <95928b70-0148-7297-8f5e-5031d996bb98@grimberg.me>
Date: Tue, 4 Apr 2017 13:46:09 +0300
MIME-Version: 1.0
In-Reply-To: <1490911959-5146-5-git-send-email-logang@deltatee.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> +	p2pmem_debugfs_root = debugfs_create_dir("p2pmem", NULL);
> +	if (!p2pmem_debugfs_root)
> +		pr_info("could not create debugfs entry, continuing\n");
> +

Why continue? I think it'd be better to just fail it.

Besides, this can be safely squashed into patch 1.
