Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"tinamdar@apm.com" <tinamdar@apm.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"rjui@broadcom.com" <rjui@broadcom.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"dhdang@apm.com" <dhdang@apm.com>,
	"sbranden@broadcom.com" <sbranden@broadcom.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v9] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Date: Thu, 26 Nov 2015 05:03:20 +0000
Message-ID: <8520D5D51A55D047800579B09414719825866301@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1447911323-12567-1-git-send-email-bharatku@xilinx.com>
	<20151124173556.18aff6b5@arm.com>
	<8520D5D51A55D047800579B0941471982586607F@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20151125075018.68e97010@arm.com>
In-Reply-To: <20151125075018.68e97010@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH v9] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
> PCIe Host Controller
> 
> On Wed, 25 Nov 2015 05:40:49 +0000
> Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:
> 
> > > On Thu, 19 Nov 2015 11:05:23 +0530
> > > Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:
> > >
> > > > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> > > >
> > > > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > > > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > > > Acked-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > > +
> > > > +#define MSI_ADDRESS				0xDEED0000
> > >
> > > How did you pick this value? What if it intersect with some actual RAM?
> > > What if a device actually does DMA to that location?
> > >
> > > Wouldn't it make sense to actually pick a real *device* address (hint:
> > > your MSI controller itself) for this purpose, as the device will
> > > never DMA there?
> > >
> > >
> > We have already mentioned in previous patch discussion, we don't have
> > any device address on our SOC for MSI, that's the reason we are
> > allocating a page for MSI in RAM. Since our memory write is consumed
> > by bridge and doesn't write to memory, you suggested to use some
> > random address,  so using some random address.
> 
> This is becoming painful.
> 
> - "write is consumed by bridge and doesn't write to memory": So why are
>   you using something that has a chance of actually being memory??? Are
>   you in the business of corrupting unsuspecting data?
> 
> - "we don't have any device address on our SOC for MSI": You have
>   plenty, and that's the whole of your device space. *All of it*. So
>   just take the base address of your PCIe controller, and be done with
>   it. Or your UART. Anything that cannot be DMA'ed to from a PCIe
>   device, and that is downstream of your PCIe bridge.
> 
Yes, PCIe controller base will be fine, will send next patch addressing this.
