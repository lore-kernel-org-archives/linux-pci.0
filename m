Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968616AbdEYH4l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2017 03:56:41 -0400
Date: Thu, 25 May 2017 00:56:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: haiyangz@microsoft.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        driverdev-devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
Message-ID: <20170525075639.GA25929@infradead.org>
References: <1495658355-13103-1-git-send-email-haiyangz@exchange.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495658355-13103-1-git-send-email-haiyangz@exchange.microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 24, 2017 at 01:39:15PM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> This patch uses the lower 16 bits of the serial number as PCI
> domain, otherwise some drivers may not be able to handle it.
> 
> Besides Nvidia drivers, we also found X.org, and DPDK handle
> only 16 bit PCI domain.

And they will all break behind VMD for example, so NAK.  Linux domains
are 32 bits.
