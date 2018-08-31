Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-14-logang@deltatee.com>
 <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ee3d5c87-4dff-edfb-1f85-958571cb1fef@deltatee.com>
Date: Fri, 31 Aug 2018 09:41:51 -0600
MIME-Version: 1.0
In-Reply-To: <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>
Subject: Re: [PATCH v5 13/13] nvmet: Optionally use PCI P2P memory
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Steve Wise <swise@opengridcomputing.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stephen Bates <sbates@raithlin.com>, Keith Busch <keith.busch@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Thanks, for the review.

On 30/08/18 06:25 PM, Sagi Grimberg wrote:
>> +	if (req->port->p2p_dev) {
>> +		if (!pci_p2pdma_assign_provider(req->port->p2p_dev,
>> +						&ctrl->p2p_clients)) {
>> +			pr_info("peer-to-peer memory on %s is not supported\n",
>> +				pci_name(req->port->p2p_dev));
>> +			goto free_devices;
>> +		}
>> +		ctrl->p2p_dev = pci_dev_get(req->port->p2p_dev);
>> +	} else {
> 
> When is port->p2p_dev == NULL? a little more documentation would help 
> here...

In the configfs functions, if the user enables p2p (port->use_p2pmem)
using 'auto' or 'y' then port->p2p_dev will be NULL. If the user sets a
specific p2p_dev to use, port->p2p_dev will be set to that device. I can
add a couple comments in the next version.

Logan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
