Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34731 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751840AbeCNJDI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 05:03:08 -0400
Date: Wed, 14 Mar 2018 10:03:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: Christoph Hellwig <hch@lst.de>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus
        infrastructure
Message-ID: <20180314090306.GF28983@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <20180313073448.GA32269@lst.de> <HE1PR0401MB242509FE2B60674CAF306A4AE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <HE1PR0401MB242509FE2B60674CAF306A4AE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Agree. There is no good point in duplicating the code.
> So this new API will be part of 'drivers/base/dma-mapping.c' file?

Yes.

> > As mention in my previous reply I think we don't even need a deconfigure
> > callback at this point - just remove the ACPI and OF wrappers and
> > clear the dma ops.
> > 
> > Also in this series we should replace the force_dma flag by use of the
> > proper method, e.g. give a force parameter to of_dma_configure and the
> > new dma_common_configure helper that the busses that want it can set.
> 
> I am more inclined to what Robin states in other mail to keep symmetry.
> i.e. to keep dma_configure() and dma_deconfigure() and call
> dev->bus->dma_configure from dma_configure(). Is this okay?

Sure.
