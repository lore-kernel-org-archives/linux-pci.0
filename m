Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
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
 <95928b70-0148-7297-8f5e-5031d996bb98@grimberg.me>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d6dac1a4-8c16-d780-fca5-9cbc4d3e2407@deltatee.com>
Date: Tue, 4 Apr 2017 11:25:41 -0600
MIME-Version: 1.0
In-Reply-To: <95928b70-0148-7297-8f5e-5031d996bb98@grimberg.me>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 4/8] p2pmem: Add debugfs "stats" file
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 04/04/17 04:46 AM, Sagi Grimberg wrote:
> 
>> +    p2pmem_debugfs_root = debugfs_create_dir("p2pmem", NULL);
>> +    if (!p2pmem_debugfs_root)
>> +        pr_info("could not create debugfs entry, continuing\n");
>> +
> 
> Why continue? I think it'd be better to just fail it.

Yup, agreed. This should probably also be PTR_ERR as well.

> Besides, this can be safely squashed into patch 1.

Sure, the only real reason I kept it separate was it was authored by
Steve Wise.

Logan
