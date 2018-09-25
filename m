Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9297C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 18:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FF720C0A
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 18:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FF720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeIZASf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:18:35 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43830 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbeIZASf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 20:18:35 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g4rmB-00046I-05; Tue, 25 Sep 2018 12:09:35 -0600
To:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20180925162231.4354-1-logang@deltatee.com>
 <20180925162231.4354-2-logang@deltatee.com>
 <1537896340.11137.19.camel@acm.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3efcee21-e439-f6ed-230b-c52c4872f0d2@deltatee.com>
Date:   Tue, 25 Sep 2018 12:09:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1537896340.11137.19.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: axboe@kernel.dk, christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bvanassche@acm.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 01/13] PCI/P2PDMA: Support peer-to-peer memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-09-25 11:25 a.m., Bart Van Assche wrote:
> It's great to see this patch series making progress. Unfortunately I didn't
> have the time earlier to have a closer look at this patch series. I hope that
> you don't mind that I ask a few questions about the implementation?

Thanks for the review Bart!

>> +static void pci_p2pdma_percpu_kill(void *data)
>> +{
>> +	struct percpu_ref *ref = data;
>> +
>> +	if (percpu_ref_is_dying(ref))
>> +		return;
>> +
>> +	percpu_ref_kill(ref);
>> +}
> 
> The percpu_ref_is_dying() test should either be removed or a comment should be
> added above it that explains why it is necessary. Is the purpose of that call
> perhaps to protect against multiple calls of pci_p2pdma_percpu_kill()? If so,
> which mechanism serializes these multiple calls?

Hmm, yes, this was copied from device DAX, but I see it has been removed
from there since then. I'll remove it for v8.

>> +static void pci_p2pdma_release(void *data)
>> +{
>> +	struct pci_dev *pdev = data;
>> +
>> +	if (!pdev->p2pdma)
>> +		return;
>> +
>> +	wait_for_completion(&pdev->p2pdma->devmap_ref_done);
>> +	percpu_ref_exit(&pdev->p2pdma->devmap_ref);
>> +
>> +	gen_pool_destroy(pdev->p2pdma->pool);
>> +	pdev->p2pdma = NULL;
>> +}
> 
> Which code frees the memory pdev->p2pdma points at? Other functions similar to
> pci_p2pdma_release() call devm_remove_action(), e.g. hmm_devmem_ref_exit().

pdev->p2pdma is allocated using devm so it will be freed when the PCI
driver is being unwound. pci_p2pdma_release() is a devm action itself
which is registered right after the devm_kzalloc() call. Therefore the
memory will be freed in the next devm action. I don't exactly know what
hmm is doing there but we don't have similar actions to remove.

>> +static int pci_p2pdma_setup(struct pci_dev *pdev)
>> +{
>> +	int error = -ENOMEM;
>> +	struct pci_p2pdma *p2p;
>> +
>> +	p2p = devm_kzalloc(&pdev->dev, sizeof(*p2p), GFP_KERNEL);
>> +	if (!p2p)
>> +		return -ENOMEM;
>> +
>> +	p2p->pool = gen_pool_create(PAGE_SHIFT, dev_to_node(&pdev->dev));
>> +	if (!p2p->pool)
>> +		goto out;
>> +
>> +	init_completion(&p2p->devmap_ref_done);
>> +	error = percpu_ref_init(&p2p->devmap_ref,
>> +			pci_p2pdma_percpu_release, 0, GFP_KERNEL);
>> +	if (error)
>> +		goto out_pool_destroy;
>> +
>> +	percpu_ref_switch_to_atomic_sync(&p2p->devmap_ref);
> 
> Why are percpu_ref_init() and percpu_ref_switch_to_atomic_sync() called
> separately instead of passing PERCPU_REF_INIT_ATOMIC to percpu_ref_init()?
> Would using PERCPU_REF_INIT_ATOMIC eliminate a call_rcu_sched() call and
> hence make this function faster?

I can't even remember why we are switching to atomic at all. It probably
shouldn't be there. I'll remove it for v8.


>> +static struct pci_dev *find_parent_pci_dev(struct device *dev)
>
> The above function increases the reference count of the device it returns a
> pointer to. It is a good habit to explain such behavior above the function
> definition.

Will do.

>> +static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>> +{
>> +	if (!buf)
>> +		return;
>> +
>> +	seq_buf_printf(buf, "%s;", pci_name(pdev));
>> +}
> 
> NULL checks in functions that print to a seq buffer are unusual. Is it
> possible that a NULL pointer gets passed as the first argument to
> seq_buf_print_bus_devfn()?

Yes. There are two paths here one that's verbose and one that's not. In
the non-verbose case, we pass NULL instead of the seq_buf, so both calls
need to ensure the seq_buf is not NULL before trying to print to it.

>> +struct pci_p2pdma_client {
>> +	struct list_head list;
>> +	struct pci_dev *client;
>> +	struct pci_dev *provider;
>> +};
> 
> Is there a reason that the peer-to-peer client and server code exist in the
> same source file? If not, have you considered to split the p2pdma.c file into
> two files - one with the code for devices that provide p2p functionality and
> another file with the code that supports p2p users? I think that would make it
> easier to follow the code.

I see what you're saying but generally I get push back against adding
extra files. I'm going to leave it the way it is unless other people
voice their opinions in favour of the change.

>> +/**
>> + * pci_free_p2pmem - allocate peer-to-peer DMA memory
>> + * @pdev: the device the memory was allocated from
>> + * @addr: address of the memory that was allocated
>> + * @size: number of bytes that was allocated
>> + */
>> +void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size)
>> +{
>> +	gen_pool_free(pdev->p2pdma->pool, (uintptr_t)addr, size);
>> +	percpu_ref_put(&pdev->p2pdma->devmap_ref);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_free_p2pmem);
> 
> Please fix the header of this function - there is a copy-paste error in the
> function header.

Will do.

Logan
