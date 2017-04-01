Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>, Christoph Hellwig <hch@lst.de>,
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
 <cb102386-0314-a3a3-ed44-b42debdf1512@codeaurora.org>
 <7158f2e8-2016-f398-e77f-0fcbe6cb41dd@deltatee.com>
 <e6a74aeb-9f54-51c5-8ad9-3b6fb92c03b3@codeaurora.org>
 <0280fbb4-ba9e-ac64-6bb3-b72590a54e57@deltatee.com>
 <0ae27bca-21be-b89c-aba4-6cc9766ebd7b@codeaurora.org>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c8edc480-a2ac-a763-8438-18f3396db483@deltatee.com>
Date: Fri, 31 Mar 2017 19:57:36 -0600
MIME-Version: 1.0
In-Reply-To: <0ae27bca-21be-b89c-aba4-6cc9766ebd7b@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 1/8] Introduce Peer-to-Peer memory (p2pmem) device
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 31/03/17 05:51 PM, Sinan Kaya wrote:
> You can put a restriction with DMI/SMBIOS such that all devices from 2016
> work else they belong to blacklist.

How do you get a manufacturing date for a given device within the
kernel? Is this actually something generically available?

Logan
