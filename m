Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0071.outbound.protection.outlook.com ([157.56.111.71]:20824
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751329AbbKDMbm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 07:31:42 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
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
	"sbranden@broadcom.com" <sbranden@broadcom.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v7] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Date: Wed, 4 Nov 2015 12:30:16 +0000
Message-ID: <8520D5D51A55D047800579B09414719801693D38@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1446564227-4704-1-git-send-email-bharatku@xilinx.com>
 <5638DE62.6050605@arm.com>
 <8520D5D51A55D047800579B09414719801693C20@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5639C681.6060007@arm.com>
In-Reply-To: <5639C681.6060007@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> 
> >> Also, you still lack support for MSI-X (which would come for free...).
> >
> > We don't support MSI-X in root port mode.
> 
> I don't believe you. If you support single MSI, you support MSI-X (because
> that's mostly a property of the endpoint).

In our architecture specification MSI-X is unsupported for Root Port.
> 
> >>> +	.chip = &nwl_msi_irq_chip,
> >>> +};
> >>> +#endif
> >>> +
> >>> +
> >>> +	/* setup AFI/FPCI range */
> >>> +	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> >>> +	base = virt_to_phys((void *)msi->pages);
> >>> +	nwl_bridge_writel(pcie, lower_32_bits(base), I_MSII_BASE_LO);
> >>> +	nwl_bridge_writel(pcie, upper_32_bits(base), I_MSII_BASE_HI);
> >>
> >> I just read this, and I'm puzzled. Actually, puzzled is an
> >> understatement. Why on Earth do you need to give RAM to your MSI
> HW?
> >> This should be a device, not RAM. By the look of it, this could be
> >> absolutely anything. Are you sure you have to supply RAM here?
> >>
> > This is required in our hardware, so that bridge identifies incoming MWr as
> MSI.
> 
> I'm asking why this has to be RAM. What is the actual requirement?

We are allocating RAM for MSI (which is expected) and assigning this address to msi->pages
this is what EP MSI capability will be programmed with.
For the bridge to detect an incoming MWr from EP as MSI, hardware needs to know MSI address
so the same address is programmed in the hardware register for comparison purpose.
It is the actual requirement from hardware.

