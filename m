Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E12C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 18:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BE62080F
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 18:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfA2ShC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:37:02 -0500
Received: from ale.deltatee.com ([207.54.116.67]:58860 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfA2ShC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 13:37:02 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1goYFK-00057p-St; Tue, 29 Jan 2019 11:36:31 -0700
To:     jglisse@redhat.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
Date:   Tue, 29 Jan 2019 11:36:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129174728.6430-4-jglisse@redhat.com>
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



On 2019-01-29 10:47 a.m., jglisse@redhat.com wrote:

> +	/*
> +	 * Optional for device driver that want to allow peer to peer (p2p)
> +	 * mapping of their vma (which can be back by some device memory) to
> +	 * another device.
> +	 *
> +	 * Note that the exporting device driver might not have map anything
> +	 * inside the vma for the CPU but might still want to allow a peer
> +	 * device to access the range of memory corresponding to a range in
> +	 * that vma.
> +	 *
> +	 * FOR PREDICTABILITY IF DRIVER SUCCESSFULY MAP A RANGE ONCE FOR A
> +	 * DEVICE THEN FURTHER MAPPING OF THE SAME IF THE VMA IS STILL VALID
> +	 * SHOULD ALSO BE SUCCESSFUL. Following this rule allow the importing
> +	 * device to map once during setup and report any failure at that time
> +	 * to the userspace. Further mapping of the same range might happen
> +	 * after mmu notifier invalidation over the range. The exporting device
> +	 * can use this to move things around (defrag BAR space for instance)
> +	 * or do other similar task.
> +	 *
> +	 * IMPORTER MUST OBEY mmu_notifier NOTIFICATION AND CALL p2p_unmap()
> +	 * WHEN A NOTIFIER IS CALL FOR THE RANGE ! THIS CAN HAPPEN AT ANY
> +	 * POINT IN TIME WITH NO LOCK HELD.
> +	 *
> +	 * In below function, the device argument is the importing device,
> +	 * the exporting device is the device to which the vma belongs.
> +	 */
> +	long (*p2p_map)(struct vm_area_struct *vma,
> +			struct device *device,
> +			unsigned long start,
> +			unsigned long end,
> +			dma_addr_t *pa,
> +			bool write);
> +	long (*p2p_unmap)(struct vm_area_struct *vma,
> +			  struct device *device,
> +			  unsigned long start,
> +			  unsigned long end,
> +			  dma_addr_t *pa);

I don't understand why we need new p2p_[un]map function pointers for
this. In subsequent patches, they never appear to be set anywhere and
are only called by the HMM code. I'd have expected it to be called by
some core VMA code and set by HMM as that's what vm_operations_struct is
for.

But the code as all very confusing, hard to follow and seems to be
missing significant chunks. So I'm not really sure what is going on.

Logan
