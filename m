Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC 2/8] cxgb4: setup pcie memory window 4 and create p2pmem
 region
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
 <1490911959-5146-3-git-send-email-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f269d9e1-8dcf-7970-382e-cb0d9a020efc@grimberg.me>
Date: Tue, 4 Apr 2017 13:42:57 +0300
MIME-Version: 1.0
In-Reply-To: <1490911959-5146-3-git-send-email-logang@deltatee.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> +static void setup_memwin_p2pmem(struct adapter *adap)
> +{
> +	unsigned int mem_base = t4_read_reg(adap, CIM_EXTMEM2_BASE_ADDR_A);
> +	unsigned int mem_size = t4_read_reg(adap, CIM_EXTMEM2_ADDR_SIZE_A);
> +
> +	if (!use_p2pmem)
> +		return;

This is weird, why even call this if !use_p2pmem?

> +static int init_p2pmem(struct adapter *adapter)
> +{
> +	unsigned int mem_size = t4_read_reg(adapter, CIM_EXTMEM2_ADDR_SIZE_A);
> +	struct p2pmem_dev *p;
> +	int rc;
> +	struct resource res;
> +
> +	if (!mem_size || !use_p2pmem)
> +		return 0;

Again, weird...
