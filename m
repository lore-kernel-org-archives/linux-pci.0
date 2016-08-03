Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37671 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbcHCK6M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2016 06:58:12 -0400
Subject: Re: [RFC 7/7] NVMe: CMB on DMA-BUF
To: Christoph Hellwig <hch@infradead.org>,
	Haggai Eran <haggaie@mellanox.com>
References: <1470034653-9097-1-git-send-email-haggaie@mellanox.com>
 <1470034653-9097-8-git-send-email-haggaie@mellanox.com>
 <20160801155206.GA23224@infradead.org>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
	Liran Liss <liranl@mellanox.com>, linux-pci@vger.kernel.org,
	Yishai Hadas <yishaih@mellanox.com>,
	Stephen Bates <stephen.bates@microsemi.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Artemy Kovalyov <artemyko@mellanox.com>,
	Jerome Glisse <j.glisse@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0c87a1be-96e0-6aa2-920c-53203b5ad9dc@grimberg.me>
Date: Wed, 3 Aug 2016 13:02:07 +0300
MIME-Version: 1.0
In-Reply-To: <20160801155206.GA23224@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey Christoph, Haggai,

>> Allocate a CMB region to user-space as a DMA-BUF object.
>
> NACK.  Absolutely no way we're going to export a low-level device
> specific feature to userspace like that.  If you want to DMA to
> the CMB do it from the kernel, and for that we'll need a proper
> block device level API.

I think that in this patch, Haggai was aiming to demonstrate the use
of dma_buf for peer2peer transactions with an RDMA device. I agree
that the CMB example can/should be exposed in the block device level,
but I also think we'd like to generalize the way we expose a bar space
of any peer device to another peer device.

How would you suggest we do that? I think Haggai's proposal is pretty
solid (considering the fact that the vast majority of RDMA applications
live in user-space).
