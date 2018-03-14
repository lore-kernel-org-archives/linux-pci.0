Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34721 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751089AbeCNJCX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 05:02:23 -0400
Date: Wed, 14 Mar 2018 10:02:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nipun Gupta <nipun.gupta@nxp.com>, hch@lst.de,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        m.szyprowski@samsung.com, bhelgaas@google.com,
        dmitry.torokhov@gmail.com, rafael.j.wysocki@intel.com,
        jarkko.sakkinen@linux.intel.com, linus.walleij@linaro.org,
        johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus
        infrastructure
Message-ID: <20180314090221.GE28983@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <a6cd83c9-d769-2994-5230-0a97de1897e5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a6cd83c9-d769-2994-5230-0a97de1897e5@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> +	.dev_groups		= amba_dev_groups,
>> +	.match			= amba_match,
>> +	.uevent			= amba_uevent,
>> +	.pm			= &amba_pm,
>> +	.dma_configure		= amba_dma_configure,
>> +	.dma_deconfigure	= amba_dma_deconfigure,
>> +	.force_dma		= true,
>
> This patch should also be removing force_dma because it no longer makes 
> sense. If DMA configuration is now done by a bus-level callback, then a bus 
> which wants its children to get DMA configuration needs to implement that 
> callback; there's nowhere to force a "default" global behaviour any more.

Btw, we don't really know how many busses currently rely on OF or ACPI
configuration.  So maybe we need to keep those as a default?
