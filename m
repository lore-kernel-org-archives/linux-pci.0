Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0083.outbound.protection.outlook.com ([104.47.38.83]:7485
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750853AbbKQFCA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2015 00:02:00 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Ray Jui <rjui@broadcom.com>,
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
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"dhdang@apm.com" <dhdang@apm.com>,
	"sbranden@broadcom.com" <sbranden@broadcom.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v8] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Date: Tue, 17 Nov 2015 05:01:54 +0000
Message-ID: <8520D5D51A55D047800579B0941471982585CBE6@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1447223619-30945-1-git-send-email-bharatku@xilinx.com>
 <564A55C9.40200@broadcom.com>
In-Reply-To: <564A55C9.40200@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 
> On 11/10/2015 10:33 PM, Bharat Kumar Gogada wrote:
> > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > ---
> > Added logic to allocate contiguous hwirq in nwl_irq_domain_alloc function.
> > Moved MSI functionality to separate functions.
> > Changed error return values.
> > +static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int
> virq,
> > +				unsigned int nr_irqs, void *args) {
> > +	struct nwl_pcie *pcie = domain->host_data;
> > +	struct nwl_msi *msi = &pcie->msi;
> > +	unsigned long bit;
> > +	int i;
> > +
> > +	mutex_lock(&msi->lock);
> > +	for (i = 0; i < nr_irqs; i++) {
> > +		bit = find_first_zero_bit(msi->used, INT_PCI_MSI_NR);
> > +		if (bit < INT_PCI_MSI_NR)
> > +			set_bit(bit, msi->used);
> > +		else
> > +			bit = -ENOSPC;
> 
> Don't you get a compiler warning with this? Note bit is unsigned long and you
> assign -ENOSPC to it.
> 
Ya that's a mistake, I will address these in next patch.
> > +
> > +		if (bit < 0) {
> 
> how can bit < 0 if it's unsigned long?
> 
> > +			mutex_unlock(&msi->lock);
> > +			return bit;
> > +		}
> > +
> > +		irq_domain_set_info(domain, virq, bit, &nwl_irq_chip,
> > +				domain->host_data, handle_simple_irq,
> > +				NULL, NULL);
> 
> nit, but if you do irq_domain_set_info(domain, virq + i, ...
> 
> then you can get rid of the code below.
> 
> > +		virq = virq + 1;
> > +	}
> > +	mutex_unlock(&msi->lock);
> > +	return 0;
> > +}
> > +

