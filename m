Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0081.outbound.protection.outlook.com ([104.47.37.81]:3488
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750720AbbKYFk4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2015 00:40:56 -0500
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
Date: Wed, 25 Nov 2015 05:40:49 +0000
Message-ID: <8520D5D51A55D047800579B0941471982586607F@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1447911323-12567-1-git-send-email-bharatku@xilinx.com>
 <20151124173556.18aff6b5@arm.com>
In-Reply-To: <20151124173556.18aff6b5@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Thu, 19 Nov 2015 11:05:23 +0530
> Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:
> 
> > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > +
> > +#define MSI_ADDRESS				0xDEED0000
> 
> How did you pick this value? What if it intersect with some actual RAM?
> What if a device actually does DMA to that location?
> 
> Wouldn't it make sense to actually pick a real *device* address (hint:
> your MSI controller itself) for this purpose, as the device will never DMA
> there?
>
> 
We have already mentioned in previous patch discussion, we don't have any device address on our SOC for MSI, that's 
 the reason we are allocating a page for MSI in RAM. Since our memory write is consumed by bridge and doesn't write to memory, you suggested to use 
some random address,  so using some random address.
> 
> 
> > +
> > +static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int
> virq,
> > +				unsigned int nr_irqs, void *args) {
> > +	struct nwl_pcie *pcie = domain->host_data;
> > +	struct nwl_msi *msi = &pcie->msi;
> > +	int bit;
> > +	int i;
> > +	int ret;
> > +
> > +	mutex_lock(&msi->lock);
> > +	if (nr_irqs > 1) {
> > +		ret = nwl_check_hwirq(msi, nr_irqs);
> > +		if (ret < 0) {
> > +			mutex_unlock(&msi->lock);
> > +			return ret;
> > +		}
> > +	} else {
> > +		ret = find_first_zero_bit(msi->used, INT_PCI_MSI_NR);
> > +		if (ret == INT_PCI_MSI_NR) {
> > +			mutex_unlock(&msi->lock);
> > +			return -ENOSPC;
> > +		}
> > +	}
> 
> Let's be serious for a minute. What's wrong with
> bitmap_find_next_zero_area, for example?
Ok, will explore this API and do accordingly, and address in next patch.
> 
> > +
> > +	for (i = 0; i < nr_irqs; i++) {
> > +		bit = ret + i;
> > +		set_bit(bit, msi->used);
> > +
> > +		irq_domain_set_info(domain, virq + i, bit, &nwl_irq_chip,
> > +				domain->host_data, handle_simple_irq,
> > +				NULL, NULL);
> > +	}
> > +	mutex_unlock(&msi->lock);
> > +
> > +	return 0;
> > +}
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny.
