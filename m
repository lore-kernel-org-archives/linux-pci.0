Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56398 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751483AbeCMH13 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 03:27:29 -0400
Date: Tue, 13 Mar 2018 08:27:28 +0100
From: "hch@lst.de" <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, "hch@lst.de" <hch@lst.de>,
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
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus
        infrastructure
Message-ID: <20180313072727.GA32191@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <6a76df69-8c6c-52a6-0afd-fd0b8d2ff703@codeaurora.org> <HE1PR0401MB24250A8631823FB3108EA62CE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <HE1PR0401MB24250A8631823FB3108EA62CE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 13, 2018 at 04:22:53AM +0000, Nipun Gupta wrote:
> > Isn't this one or the other one but not both?
> > 
> > Something like:
> > 
> > if (dev->of_node)
> > 	of_dma_deconfigure(dev);
> > else
> > 	acpi_dma_deconfigure(dev);
> > 
> > should work.
> 
> I understand your point. Seems reasonable as we should not expect
> the 'of/acpi DMA deconfigure' API to not fail when they are not configured.
> 
> But, here we would also need to get dma_device (just as we get in
> 'pci_dma_configure') and need a check on it as for PCI there 'of_node'
> is present in the dma_dev.

Both of_dma_deconfigure and acpi_dma_deconfigure just end up calling
arch_teardown_dma_ops.  So my preference would be to just remove
of_dma_deconfigure and acpi_dma_deconfigure and call arch_teardown_dma_ops
as a prep patch before this one.
