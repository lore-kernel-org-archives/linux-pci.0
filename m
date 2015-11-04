Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60798 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030324AbbKDPBt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Nov 2015 10:01:49 -0500
Date: Wed, 4 Nov 2015 15:01:47 +0000
From: "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Magnus <magnus.damm@gmail.com>
Subject: Re: PCIe host controller behind IOMMU on ARM
Message-ID: <20151104150147.GT963@e106497-lin.cambridge.arm.com>
References: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151104142412.GS963@e106497-lin.cambridge.arm.com>
 <PS1PR06MB11804263DD55C54C5987654EF52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <PS1PR06MB11804263DD55C54C5987654EF52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 04, 2015 at 02:48:38PM +0000, Phil Edworthy wrote:
> Hi Liviu,
> 
> On 04 November 2015 14:24, Liviu wrote:
> > On Wed, Nov 04, 2015 at 01:57:48PM +0000, Phil Edworthy wrote:
> > > Hi,
> > >
> > > I am trying to hook up a PCIe host controller that sits behind an IOMMU,
> > > but having some problems.
> > >
> > > I'm using the pcie-rcar PCIe host controller and it works fine without
> > > the IOMMU, and I can attach the IOMMU to the controller such that any calls
> > > to dma_alloc_coherent made by the controller driver uses the iommu_ops
> > > version of dma_ops.
> > >
> > > However, I can't see how to make the endpoints to utilise the dma_ops that
> > > the controller uses. Shouldn't the endpoints inherit the dma_ops from the
> > > controller?
> > 
> > No, not directly.
> > 
> > > Any pointers for this?
> > 
> > You need to understand the process through which a driver for endpoint get
> > an address to be passed down to the device. Have a look at
> > Documentation/DMA-API-HOWTO.txt, there is a nice explanation there.
> > (Hint: EP driver needs to call dma_map_single).
> > 
> > Also, you need to make sure that the bus address that ends up being set into
> > the endpoint gets translated correctly by the host controller into an address
> > that the IOMMU can then translate into physical address.
> Sure, though since this is bog standard Intel PCIe ethernet card which works
> fine when the IOMMU is effectively unused, I don’t think there is a problem
> with that.
> 
> The driver for the PCIe controller sets up the IOMMU mapping ok when I
> do a test call to dma_alloc_coherent() in the controller's driver. i.e. when I
> do this, it ends up in arm_iommu_alloc_attrs(), which calls
> __iommu_alloc_buffer() and __alloc_iova().
> 
> When an endpoint driver allocates and maps a dma coherent buffer it
> also needs to end up in arm_iommu_alloc_attrs(), but it doesn't.

Why do you think that? Remember that the only thing attached to the IOMMU is the
host controller. The endpoint is on the PCIe bus, which gets a different translation
that the IOMMU knows nothing about. If it helps you to visualise it better, think
of the host controller as another IOMMU device. It's the ops of the host controller
that should be invoked, not the IOMMU's.

Best regards,
Liviu

> 
> Thanks
> Phil

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
