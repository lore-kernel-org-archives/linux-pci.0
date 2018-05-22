Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-7-logang@deltatee.com>
 <59b7762e-6d38-7746-20f3-22fd762ecfe7@infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9e20024d-8b32-61ff-4b9a-c9392082987f@deltatee.com>
Date: Tue, 22 May 2018 15:28:19 -0600
MIME-Version: 1.0
In-Reply-To: <59b7762e-6d38-7746-20f3-22fd762ecfe7@infradead.org>
Subject: Re: [PATCH v4 06/14] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jonathan Corbet <corbet@lwn.net>, Alex Williamson <alex.williamson@redhat.com>,
 Stephen Bates <sbates@raithlin.com>, Keith Busch <keith.busch@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for the review Randy! I'll make the changes for the next time we
post the series.

On 22/05/18 03:24 PM, Randy Dunlap wrote:
>> +The first task an orchestrator driver must do is compile a list of
>> +all client drivers that will be involved in a given transaction. For
>> +example, the NVMe Target driver creates a list including all NVMe drives
>                                                                      ^^^^^^
>                                                                    or drivers ?
> Could be either, I guess, but the previous sentence says "compile a list of drivers."

I did mean "drives". But perhaps "devices" would be more clear. A list
of all NVMe drivers doesn't make much sense as I'm pretty sure there is
only one NVMe driver.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
