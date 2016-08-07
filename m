Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:14144
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750715AbcHGFYa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 7 Aug 2016 01:24:30 -0400
Subject: Re: [RFC 7/7] NVMe: CMB on DMA-BUF
To: "hch@infradead.org" <hch@infradead.org>
References: <1470034653-9097-1-git-send-email-haggaie@mellanox.com>
 <1470034653-9097-8-git-send-email-haggaie@mellanox.com>
 <20160801155206.GA23224@infradead.org>
 <1470121814.20129.8.camel@mellanox.com>
 <20160804115624.GA12004@infradead.org>
CC: Liran Liss <liranl@mellanox.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yishai Hadas <yishaih@mellanox.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"stephen.bates@microsemi.com" <stephen.bates@microsemi.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Kovalyov Artemy <artemyko@mellanox.com>,
	"j.glisse@gmail.com" <j.glisse@gmail.com>,
	William Davis <wdavis@nvidia.com>
From: Haggai Eran <haggaie@mellanox.com>
Message-ID: <666d2c1e-77cb-c2b3-963f-cd0502ee5335@mellanox.com>
Date: Sun, 7 Aug 2016 08:24:16 +0300
MIME-Version: 1.0
In-Reply-To: <20160804115624.GA12004@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/4/2016 2:56 PM, hch@infradead.org wrote:
>> Anyway, I understand exposing the CMB directly might be a little too
>> low level. What do you think would work better? Something like
>> direct_access that returns bus addresses instead of pfns?
> 
> This would be my primary choicse.  We'll really need to built an
> in-kernel framework for a) PCI P2P access involving drivers for the PCI
> switches etc, 
I was thinking perhaps the dma_map_resource patches by Will Davis [1]
could be used (adding him to the thread).

> and then on top of that build something speicifly for
> block drivers.  Which will be a bit complicated because both have the
> case of directly memory mapped device as well as indirect devices like
> the CMB.  I'm pretty sure we won't get it right at the first attempt,
> so exposing it to userspace is an absolute no-go as that will lock us
> into the first ABI forever.
I understand. I'll try to think of something for kernel usage only for
the next attempt.

Thanks,
Haggai

[1]
https://lists.linuxfoundation.org/pipermail/iommu/2015-August/014106.html
