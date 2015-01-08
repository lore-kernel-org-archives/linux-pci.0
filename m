Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:56307 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbbAHWYj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jan 2015 17:24:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Rob Herring <robherring2@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Will Deacon <will.deacon@arm.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 2/4] of: move of_dma_configure() to device,c to help re-use
Date: Thu, 08 Jan 2015 23:24:11 +0100
Message-ID: <2083932.v1GzgAfexK@wuerfel>
In-Reply-To: <54AED9EC.1020703@ti.com>
References: <1420656594-8908-1-git-send-email-m-karicheri2@ti.com> <3861625.CJ6m15sZMh@wuerfel> <54AED9EC.1020703@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 08 January 2015 14:26:36 Murali Karicheri wrote:
> On 01/08/2015 03:40 AM, Arnd Bergmann wrote:
> > On Wednesday 07 January 2015 17:37:56 Rob Herring wrote:
> >> On Wed, Jan 7, 2015 at 12:49 PM, Murali Karicheri<m-karicheri2@ti.com>  wrote:
> >>
> >>> +       ret = of_dma_get_range(np,&dma_addr,&paddr,&size);
> >>> +       if (ret<  0) {
> >>> +               dma_addr = offset = 0;
> >>> +               size = dev->coherent_dma_mask + 1;
> >>
> >> If coherent_dma_mask is DMA_BIT_MASK(64), then you will overflow and
> >> have a size of 0. There may also be a problem when the mask is only
> >> 32-bit type.
> >
> > The mask is always a 64-bit type, it's not optional. But you are right,
> > the 64-bit mask case is broken, so I guess we have to fix it differently
> > by always passing the smaller value into arch_setup_dma_ops and
> > adapting that function instead.
> Arnd,
> 
> What is the smaller value you are referring to in the below code? 
> between *dev->dma_mask and size from DT? But overflow can still happen 
> when size is to be calculated in arch_setup_dma_ops() for Non DT case or 
> when DT size is configured to be equivalent of DMA_BIT_MASK(64) + 1. Can 
> we discuss the code change you have in mind when you get a chance?

I meant changing every function that the size values gets passed into
to take a mask like 0xffffffff instead of a size like 0x100000000, so
we can represent a 64-bit capable bus correctly.

This means we also need to adapt the value returned from of_dma_get_range.
A minor complication here is that the DT properties sometimes already
contain the mask value, in particular when we want to represent a
full mapping like 

	bus {
		#address-cells = <1>;
		#size-cells = <1>;
		dma-ranges = <0 0 0xffffffff>; /* all 4 GB, DMA_BIT_MASK(32) */
	};

as opposed to

	bus {
		#address-cells = <1>;
		#size-cells = <1>;
		dma-ranges = <0 0 0x80000000>; /* only lower 2GB, DMA_BIT_MASK(31) */
	};

or

	bus {
		#address-cells = <2>;
		#size-cells = <2>;
		dma-ranges = <0 0 0x0000000100000000>; /* 4GB of 64-bit address space */
	};


	Arnd
