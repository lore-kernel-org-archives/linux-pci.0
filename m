Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD8DC282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B757E20882
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfA2TYT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:24:19 -0500
Received: from ale.deltatee.com ([207.54.116.67]:59356 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfA2TYT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 14:24:19 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1goYzN-0005nT-QG; Tue, 29 Jan 2019 12:24:06 -0700
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c2c02af7-1d6f-e54f-c7fb-99c5b7776014@deltatee.com>
Date:   Tue, 29 Jan 2019 12:24:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129191120.GE3176@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, jroedel@suse.de, robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, jgg@mellanox.com, Felix.Kuehling@amd.com, christian.koenig@amd.com, bhelgaas@google.com, rafael@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-29 12:11 p.m., Jerome Glisse wrote:
> On Tue, Jan 29, 2019 at 11:36:29AM -0700, Logan Gunthorpe wrote:
>>
>>
>> On 2019-01-29 10:47 a.m., jglisse@redhat.com wrote:
>>
>>> +	/*
>>> +	 * Optional for device driver that want to allow peer to peer (p2p)
>>> +	 * mapping of their vma (which can be back by some device memory) to
>>> +	 * another device.
>>> +	 *
>>> +	 * Note that the exporting device driver might not have map anything
>>> +	 * inside the vma for the CPU but might still want to allow a peer
>>> +	 * device to access the range of memory corresponding to a range in
>>> +	 * that vma.
>>> +	 *
>>> +	 * FOR PREDICTABILITY IF DRIVER SUCCESSFULY MAP A RANGE ONCE FOR A
>>> +	 * DEVICE THEN FURTHER MAPPING OF THE SAME IF THE VMA IS STILL VALID
>>> +	 * SHOULD ALSO BE SUCCESSFUL. Following this rule allow the importing
>>> +	 * device to map once during setup and report any failure at that time
>>> +	 * to the userspace. Further mapping of the same range might happen
>>> +	 * after mmu notifier invalidation over the range. The exporting device
>>> +	 * can use this to move things around (defrag BAR space for instance)
>>> +	 * or do other similar task.
>>> +	 *
>>> +	 * IMPORTER MUST OBEY mmu_notifier NOTIFICATION AND CALL p2p_unmap()
>>> +	 * WHEN A NOTIFIER IS CALL FOR THE RANGE ! THIS CAN HAPPEN AT ANY
>>> +	 * POINT IN TIME WITH NO LOCK HELD.
>>> +	 *
>>> +	 * In below function, the device argument is the importing device,
>>> +	 * the exporting device is the device to which the vma belongs.
>>> +	 */
>>> +	long (*p2p_map)(struct vm_area_struct *vma,
>>> +			struct device *device,
>>> +			unsigned long start,
>>> +			unsigned long end,
>>> +			dma_addr_t *pa,
>>> +			bool write);
>>> +	long (*p2p_unmap)(struct vm_area_struct *vma,
>>> +			  struct device *device,
>>> +			  unsigned long start,
>>> +			  unsigned long end,
>>> +			  dma_addr_t *pa);
>>
>> I don't understand why we need new p2p_[un]map function pointers for
>> this. In subsequent patches, they never appear to be set anywhere and
>> are only called by the HMM code. I'd have expected it to be called by
>> some core VMA code and set by HMM as that's what vm_operations_struct is
>> for.
>>
>> But the code as all very confusing, hard to follow and seems to be
>> missing significant chunks. So I'm not really sure what is going on.
> 
> It is set by device driver when userspace do mmap(fd) where fd comes
> from open("/dev/somedevicefile"). So it is set by device driver. HMM
> has nothing to do with this. It must be set by device driver mmap
> call back (mmap callback of struct file_operations). For this patch
> you can completely ignore all the HMM patches. Maybe posting this as
> 2 separate patchset would make it clearer.
> 
> For instance see [1] for how a non HMM driver can export its memory
> by just setting those callback. Note that a proper implementation of
> this should also include some kind of driver policy on what to allow
> to map and what to not allow ... All this is driver specific in any
> way.

I'd suggest [1] should be a part of the patchset so we can actually see
a user of the stuff you're adding.

But it still doesn't explain everything as without the HMM code nothing
calls the new vm_ops. And there's still no callers for the p2p_test
functions you added. And I still don't understand why we need the new
vm_ops or who calls them and when. Why can't drivers use the existing
'fault' vm_op and call a new helper function to map p2p when appropriate
or a different helper function to map a large range in its mmap
operation? Just like regular mmap code...

Logan
