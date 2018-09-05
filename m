Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-8-logang@deltatee.com>
 <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
 <20180901082812.GB670@lst.de>
 <5f79c012-c6e1-56bb-62fd-0689181fb2c9@deltatee.com>
 <59b28977-8f2a-6228-2050-03fae6bdbedd@kernel.dk>
 <1b4283da-44df-4a02-3167-e295243cef78@deltatee.com>
 <09258b9b-3aed-9890-b31a-bd70a133966c@kernel.dk>
 <20180905195647.GA1626@lst.de>
 <bcc1b3cf-2fd9-fa61-9cfb-b0e4d84e5d94@kernel.dk>
 <20180905201152.GA1893@lst.de>
 <eb42fb94-9da6-955b-8524-0a0f5ac4bd19@deltatee.com>
 <2a3394bd-5f13-4818-43f4-dfc61f501e05@kernel.dk>
 <e3ef26e6-6c8d-25b8-fa64-14594a51263c@deltatee.com>
 <3af4d1d4-da07-c0a6-8464-9ddc1378f2f4@kernel.dk>
 <f9e660cd-b597-bb6e-56a2-82fe71cb3649@deltatee.com>
 <34d9b2f7-9e6d-4a0a-77e5-ec0e99610f5c@kernel.dk>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c41c802c-9235-5383-2dfa-af9c1553f11b@deltatee.com>
Date: Wed, 5 Sep 2018 15:03:18 -0600
MIME-Version: 1.0
In-Reply-To: <34d9b2f7-9e6d-4a0a-77e5-ec0e99610f5c@kernel.dk>
Subject: Re: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 05/09/18 02:36 PM, Jens Axboe wrote:
> On 9/5/18 2:32 PM, Logan Gunthorpe wrote:
>>
>>
>> On 05/09/18 02:19 PM, Jens Axboe wrote:
>>> On 9/5/18 2:18 PM, Logan Gunthorpe wrote:
>>>>
>>>>
>>>> On 05/09/18 02:14 PM, Jens Axboe wrote:
>>>>> But if the caller must absolutely know where the bio will end up, then
>>>>> it seems super redundant. So I'd vote for killing this check, it buys
>>>>> us absolutely nothing and isn't even exhaustive in its current form.
>>>>
>>>>
>>>> Ok, I'll remove it for v6.
>>>
>>> Since the drivers needs to know it's doing it right, it might not
>>> hurt to add a sanity check helper for that. Just have the driver
>>> call it, and don't add it in the normal IO submission path.
>>
>> I'm not sure I really see the value in that. It's the same principle in
>> asking the driver to do the WARN: if the developer knew enough to use
>> the special helper, they probably knew well enough to do the rest correctly.
> 
> I don't agree with that at all. It's a "is my request valid" helper,
> it's not some obscure and rarely used functionality. You're making up
> this API right now, if you really want it done for every IO, make it
> part of the p2p submission process. You could even hide it behind a
> debug thing, if you like.

There is no special p2p submission process. In the nvme-of case we are
using the existing process and with the code in blk-core it didn't
change it's process at all. Creating a helper will create one and I can
look at making a pci_p2pdma_submit_bio() for v6; but if the developer
screws up and still calls the regular submit_bio() things will only be
very subtly broken and that won't be obvious.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
