Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0058.outbound.protection.outlook.com ([157.56.111.58]:11680
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933241AbbJINrl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 09:47:41 -0400
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
	"hauke@hauke-m.de" <hauke@hauke-m.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ravikiran Gummaluri" <rgummal@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Date: Fri, 9 Oct 2015 13:47:35 +0000
Message-ID: <8520D5D51A55D047800579B09414719801690DEC@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1444146289-28940-1-git-send-email-bharatku@xilinx.com>
 <5613F310.6060305@arm.com>
In-Reply-To: <5613F310.6060305@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Hi Bharat,
>> > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> >
> > +/* SSPL ERROR */
> > +#define SLVERR					0x02
> > +#define DECERR					0x03
> > +
> > +struct nwl_msi {			/* struct nwl_msi - MSI information
> */
> > +	struct msi_controller chip;	/* chip: MSI controller */
> 
> We're moving away from msi_controller altogether, as the kernel now has all
> the necessary infrastructure to do this properly.
> 
> Please convert this driver to msi domains (see drivers/pci/host/pci-xgene-
> msi.c or the gic-v2m driver as examples of how this is being done).

As suggested I have gone through the code in pci-gene-msi.c for msi domains, 
and have gone through IRQ Domain documentation. 
I mainly observe when we have more than one interrupt controller involved
between device and cpu we use "Hierarchy IRQ domain" (parent and child msi domains). But in our case we 
don't have any such Hierarchy and we have single interrupt controller.
In such case is it necessary to use multiple domains in software which actually isn't case in hardware.

Thanks 
Bharat
> 
> > +	DECLARE_BITMAP(used, INT_PCI_MSI_NR);	/* used: Declare
> Bitmap
> > +						for MSI	*/
> > +	struct irq_domain *domain;	/* domain: IRQ domain pointer */
> > +	unsigned long pages;		/* pages: MSI pages */
> 
> Overall, I think it would make sense to split the PCIe controller driver and the
> MSI controller (in separate files as well).
> 
> Please keep me posted on the updates.
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
