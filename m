Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:44944
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750768AbbKQFGa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2015 00:06:30 -0500
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
Subject: RE: [PATCH v8] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Date: Tue, 17 Nov 2015 05:06:23 +0000
Message-ID: <8520D5D51A55D047800579B0941471982585CBF4@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1447223619-30945-1-git-send-email-bharatku@xilinx.com>
 <20151111173712.7dde8a42@arm.com>
In-Reply-To: <20151111173712.7dde8a42@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Wed, 11 Nov 2015 12:03:39 +0530
> Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:
> 
> > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > ---
> > Added logic to allocate contiguous hwirq in nwl_irq_domain_alloc function.
> > Moved MSI functionality to separate functions.
> > Changed error return values.
> > ---
> >  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   68 ++
> >  drivers/pci/host/Kconfig                           |   16 +-
> >  drivers/pci/host/Makefile                          |    1 +
> >  drivers/pci/host/pcie-xilinx-nwl.c                 | 1062 ++++++++++++++++++++
> >  4 files changed, 1144 insertions(+), 3 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
> >  create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c
> >
> > diff --git a/drivers/pci/host/pcie-xilinx-nwl.c
> > b/drivers/pci/host/pcie-xilinx-nwl.c
> > new file mode 100644
> > index 0000000..8bc509c
> > --- /dev/null
> > +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> 
> [...]
> 
> > +static struct msi_domain_info nwl_msi_domain_info = {
> > +	.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_USE_DEF_CHIP_OPS |
> > +		  MSI_FLAG_MULTI_PCI_MSI),
> 
> Given that you claim to support multi-MSI...
> 
> [...]
> 
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
> > +
> > +		if (bit < 0) {
> > +			mutex_unlock(&msi->lock);
> > +			return bit;
> > +		}
> > +
> > +		irq_domain_set_info(domain, virq, bit, &nwl_irq_chip,
> > +				domain->host_data, handle_simple_irq,
> > +				NULL, NULL);
> > +		virq = virq + 1;
> > +	}
> 
> I really don't see how this allocator guarantees that all hwirqs are contiguous.
> I already mentioned this when reviewing v7, and you still haven't got it right.
> So either you allocate *contiguous* hwirqs in an atomic fashion, or you drop
> support for multi-MSI.
> 
Yes, I understood now there is no check for allocating contiguous hwirq, I will address this in the next patch.

Regards,
Bharat
