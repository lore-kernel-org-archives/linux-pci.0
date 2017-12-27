Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:38555 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbdL0W3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Dec 2017 17:29:13 -0500
Date: Wed, 27 Dec 2017 23:29:09 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/18] PCI: designware-ep: Add generic function for
 raising MSI irq
Message-ID: <20171227222909.GA14106@axis.com>
References: <20171219232940.659-1-niklas.cassel@axis.com>
 <20171219232940.659-7-niklas.cassel@axis.com>
 <5fc44bf0-9d0e-e905-32fb-449d9ed1b01a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5fc44bf0-9d0e-e905-32fb-449d9ed1b01a@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 26, 2017 at 06:20:54PM +0530, Kishon Vijay Abraham I wrote:
> Hi Niklas,

Hello Kishon

> 
> On Wednesday 20 December 2017 04:59 AM, Niklas Cassel wrote:
> > Add a generic function for raising MSI irqs that can be used by all
> > DWC based controllers.
> > 
> > Note that certain controllers, like DRA7xx, have a special convenience
> > register for raising MSI irqs that doesn't require you to explicitly map
> > the MSI address. Therefore, it is likely that certain drivers will
> > not use this generic function, even if they can.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/dwc/pcie-designware-ep.c | 35 +++++++++++++++++++++++++++++++++++
> >  drivers/pci/dwc/pcie-designware.h    |  9 +++++++++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> > index 700ed2f4becf..c5aa1cac5041 100644
> > --- a/drivers/pci/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/dwc/pcie-designware-ep.c
> > @@ -282,6 +282,41 @@ static const struct pci_epc_ops epc_ops = {
> >  	.stop			= dw_pcie_ep_stop,
> >  };
> >  
> > +int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
> > +			     u8 interrupt_num)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct pci_epc *epc = ep->epc;
> > +	u16 msg_ctrl, msg_data;
> > +	u32 msg_addr_lower, msg_addr_upper;
> > +	u64 msg_addr;
> > +	bool has_upper;
> > +	int ret;
> > +
> > +	/* Raise MSI per the PCI Local Bus Specification Revision 3.0, 6.8.1. */
> > +	msg_ctrl = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
> > +	has_upper = !!(msg_ctrl & PCI_MSI_FLAGS_64BIT);
> > +	msg_addr_lower = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_L32);
> > +	if (has_upper) {
> > +		msg_addr_upper = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_U32);
> > +		msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_64);
> > +	} else {
> > +		msg_addr_upper = 0;
> > +		msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_32);
> > +	}
> > +	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
> > +	ret = dw_pcie_ep_map_addr(epc, ep->msi_mem_phys, msg_addr,
> > +				  epc->mem->page_size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	writel(msg_data | (interrupt_num - 1), ep->msi_mem);
> 
> Shouldn't this be msg_data + (interrupt_num - 1)?

I'm not quite sure about this, but if there is a pending irq,
not yet processed by the RC, the msg_data we read out in this
function should have a bit set, matching the pending irq.

If that irq is the same as the irq we are trying to raise,
doing an addition will produce a bogus vector number,
but a bitwise or should work.

For that reason, I think that doing bitwise or seems safer.
However, other than this case, I don't see why it should
matter if we do an addition or a bitwise or.

Are you having some problem with the code?
It seems to be working fine on ARTPEC-6:

# ./pcitest -m 1
MSI1:           OKAY
# ./pcitest -m 2
MSI2:           OKAY
# ./pcitest -m 3
MSI3:           OKAY
# ./pcitest -m 4
MSI4:           OKAY
# ./pcitest -m 5
MSI5:           OKAY
# ./pcitest -m 6
MSI6:           OKAY
# ./pcitest -m 7
MSI7:           OKAY
# ./pcitest -m 8
MSI8:           OKAY
# ./pcitest -m 9
MSI9:           OKAY
# cat /proc/interrupts | grep -i msi
 82:          9          0     GIC-0 180 Level     artpec6-pcie-msi
188:          1          0   PCI-MSI  16 Edge      pci-endpoint-test
189:          1          0   PCI-MSI  17 Edge      pci-endpoint-test
190:          1          0   PCI-MSI  18 Edge      pci-endpoint-test
191:          1          0   PCI-MSI  19 Edge      pci-endpoint-test
192:          1          0   PCI-MSI  20 Edge      pci-endpoint-test
193:          1          0   PCI-MSI  21 Edge      pci-endpoint-test
194:          1          0   PCI-MSI  22 Edge      pci-endpoint-test
195:          1          0   PCI-MSI  23 Edge      pci-endpoint-test
196:          1          0   PCI-MSI  24 Edge      pci-endpoint-test
197:          0          0   PCI-MSI  25 Edge      pci-endpoint-test
198:          0          0   PCI-MSI  26 Edge      pci-endpoint-test
199:          0          0   PCI-MSI  27 Edge      pci-endpoint-test
200:          0          0   PCI-MSI  28 Edge      pci-endpoint-test
201:          0          0   PCI-MSI  29 Edge      pci-endpoint-test
202:          0          0   PCI-MSI  30 Edge      pci-endpoint-test
203:          0          0   PCI-MSI  31 Edge      pci-endpoint-test

>From EP:
irq: 1 read msg_data: 0x10 writing: 0x10
irq: 2 read msg_data: 0x10 writing: 0x11
irq: 3 read msg_data: 0x10 writing: 0x12
irq: 4 read msg_data: 0x10 writing: 0x13
irq: 5 read msg_data: 0x10 writing: 0x14
irq: 6 read msg_data: 0x10 writing: 0x15
irq: 7 read msg_data: 0x10 writing: 0x16
irq: 8 read msg_data: 0x10 writing: 0x17
irq: 9 read msg_data: 0x10 writing: 0x18

This also looks correct, since I enabled 16 irqs,
I'm only allowed to modify bits 0-3.


Regards,
Niklas
