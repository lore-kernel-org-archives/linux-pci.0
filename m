Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44732 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbcHDL6a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2016 07:58:30 -0400
Date: Thu, 4 Aug 2016 04:56:24 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Haggai Eran <haggaie@mellanox.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Liran Liss <liranl@mellanox.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yishai Hadas <yishaih@mellanox.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"stephen.bates@microsemi.com" <stephen.bates@microsemi.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Kovalyov Artemy <artemyko@mellanox.com>,
	"j.glisse@gmail.com" <j.glisse@gmail.com>
Subject: Re: [RFC 7/7] NVMe: CMB on DMA-BUF
Message-ID: <20160804115624.GA12004@infradead.org>
References: <1470034653-9097-1-git-send-email-haggaie@mellanox.com>
 <1470034653-9097-8-git-send-email-haggaie@mellanox.com>
 <20160801155206.GA23224@infradead.org>
 <1470121814.20129.8.camel@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470121814.20129.8.camel@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 02, 2016 at 07:10:14AM +0000, Haggai Eran wrote:
> The reason I thought this idea might work is because of the responses
> Stephen got for his attempt to use ZONE_DEVICE for things like the CMB.
> The problem with that is that the way RDMA registration works with
> get_user_pages means that the CPU also gets access to the CMB and
> sometimes you don't want that. DMA-BUF can solve that nicely in that it
> doesn't require mapping it to the CPU - a driver can attach to it
> directly.

I'm not complaining about DMA-BUF - that might be a useful low-level
abstraction if we define a higher level API around it.

> Anyway, I understand exposing the CMB directly might be a little too
> low level. What do you think would work better? Something like
> direct_access that returns bus addresses instead of pfns?

This would be my primary choicse.  We'll really need to built an
in-kernel framework for a) PCI P2P access involving drivers for the PCI
switches etc, and then on top of that build something speicifly for
block drivers.  Which will be a bit complicated because both have the
case of directly memory mapped device as well as indirect devices like
the CMB.  I'm pretty sure we won't get it right at the first attempt,
so exposing it to userspace is an absolute no-go as that will lock us
into the first ABI forever.
