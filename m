Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:55058 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdJWFnf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2017 01:43:35 -0400
Subject: Re: [PATCH] of: Devices with pci_epf_bus_type require DMA
 configuration
To: Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20171011080041.12918-1-kishon@ti.com>
 <cae4b8e9-9944-6482-c12c-8ce87aea1487@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3599d3e2-d496-eac3-7179-2d1795fc059d@ti.com>
Date: Mon, 23 Oct 2017 11:13:23 +0530
MIME-Version: 1.0
In-Reply-To: <cae4b8e9-9944-6482-c12c-8ce87aea1487@arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wednesday 11 October 2017 10:15 PM, Robin Murphy wrote:
> On 11/10/17 09:00, Kishon Vijay Abraham I wrote:
>> pci-epc-core.c invokes of_dma_configure in order to configure
>> the coherent_dma_mask/dma_mask of endpoint function device. This is
>> required for dma_alloc_coherent to succeed in pci function driver
>> (pci-epf-test.c). However after
>> commit 723288836628bc1c08 ("of: restrict DMA configuration"),
>> of_dma_configure doesn't configure the coherent_dma_mask/dma_mask
>> of endpoint function device (since it doesn't have dma-ranges
>> property), resulting in dma_alloc_coherent in pci endpoint function
>> driver to to fail. Fix it by making sure of_dma_configure configures
>> coherent_dma_mask/dma_mask irrespective of whether the node has
>> dma-ranges property or not.
> 
> Frankly, what the endpoint stuff is doing looks wrong anyway. As I
> understand it, the endpoint functions aren't real devices, just a
> partitioning of resources - the only piece of hardware actually doing
> DMA is the EPC itself, which should already have been configured
> appropriately as a platform device.

EPF devices use EPC devices which in turn use the actual platform device for
configuring the hardware. IMO the devices in one layer shouldn't have to
explicitly use devices in another layer other than using clearly defined API's.
Here platform_device is the bottom later, above which is epc_device and on top
is epf_device.

The idea is just by doing the initial setup in the framework, the epf driver be
able to use APIs like dma_alloc_coherent using it's own *device* rather than
the EPC's "device".
> 
> It seems to me that the EPF BAR allocations should just be using the EPC
> device directly, rather than trying to pretend the EPFs are distinct DMA
> masters.
> 
> Furthermore, now that I've looked:
> 
>> 	dma_addr_t phys_addr;
> 
> please no :(
> 
> (I can easily think of more than one system with an EP-capable DWC PCIe
> block integrated behind an IOMMU)

hmm.. haven't used IOMMU but won't setting up parent-child relationship between
EPC and EPF help in the case of IOMMU?

Thanks
Kishon
