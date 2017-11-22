Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751307AbdKVO7H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Nov 2017 09:59:07 -0500
Date: Wed, 22 Nov 2017 14:58:55 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, nsekhar@ti.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Niklas Cassel <niklas.cassel@axis.com>
Subject: Re: [PATCH] PCI: designware-ep: Fix ->get_msi() to check MSI_EN bit
Message-ID: <20171122145847.GA14754@e107981-ln.cambridge.arm.com>
References: <20171122090427.12371-1-kishon@ti.com>
 <20171122113749.GA26278@red-moon>
 <1c958730-e50e-06ea-84b5-592e63ddeb87@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1c958730-e50e-06ea-84b5-592e63ddeb87@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 22, 2017 at 05:24:21PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On Wednesday 22 November 2017 05:07 PM, Lorenzo Pieralisi wrote:
> > On Wed, Nov 22, 2017 at 02:34:27PM +0530, Kishon Vijay Abraham I wrote:
> >> ->get_msi() now checks MSI_EN bit in the MSI CAPABILITY register to
> >> find whether the host supports MSI instead of using the
> >> MSI ADDRESS in the MSI CAPABILITY register.
> > 
> > I think that's a sensible thing to do regardless, given that I do not
> > understand why 0x0 can't be a valid MSI address in the first place.
> > 
> >> This fixes the issue with the following sequence
> >>   'modprobe pci_endpoint_test' enables MSI
> >>   'rmmod pci_endpoint_test' disables MSI but MSI address has a valid value
> >>   'modprobe pci_endpoint_test no_msi=1' - Since MSI address has a valid
> >> 	value (set during the previous insertion of the module), EP
> 
> MSI address is written in the MSI capabiltiy register by the host.
> > 
> > Where is the address set ?
> > 
> >> 	thinks host supports MSI.
> > 
> > Add a Fixes: tag please.
> 
> sure.
> > 
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/dwc/pcie-designware-ep.c | 12 +++---------
> >>  drivers/pci/dwc/pcie-designware.h    |  1 +
> >>  2 files changed, 4 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> >> index d53d5f168363..7c621877a939 100644
> >> --- a/drivers/pci/dwc/pcie-designware-ep.c
> >> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> >> @@ -197,20 +197,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, phys_addr_t addr,
> >>  static int dw_pcie_ep_get_msi(struct pci_epc *epc)
> >>  {
> >>  	int val;
> >> -	u32 lower_addr;
> >> -	u32 upper_addr;
> >>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> >>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >>  
> >> -	val = dw_pcie_readb_dbi(pci, MSI_MESSAGE_CONTROL);
> >> -	val = (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
> >> -
> >> -	lower_addr = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_L32);
> >> -	upper_addr = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_U32);
> > 
> > I can't find code that writes these registers, see above for my
> > question.
> 
> IIUC the host will write to these registers in __pci_write_msi_msg using the
> configuration writes.
> > 
> > On top of that I think that what's done the EPF test function driver in
> > struct pci_epf.bind() should be undone in struct pci_epf.unbind() and I
> > do not think that's happening for MSIs.
> > 
> >> -
> >> -	if (!(lower_addr || upper_addr))
> >> +	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
> > 
> > MSI_MESSAGE_CONTROL is written in dw_pcie_ep_set_msi(), I assume a write
> > to bit[0] (ie MSI_CAP_MSI_EN_MASK) is ignored - it would be good if you
> > can clarify that as well please.
> 
> Do you mean dw_pcie_ep_set_msi can overwrite MSI_CAP_MSI_EN and we should avoid
> that?

Yes, I think there are a lot of assumptions here. IIUC the sequence you
expect this to work is:

1) EP system (ie system where the EP is located) is brought up and EP is
   configured (inclusive of MSI)
2) host boots and enumerates PCI devices (which includes the EP)
3) host EP PCI driver probes and configure MSI, etc
4) EP system runs EP function test and to understand what the host
   system enabled on the endpoint (eg PCI EP test function driver using
   MSIs) you rely on capabilities registers host system settings that
   are reflected in the EP registers

Is my understanding correct ?

So basically the PCI EP test function works as software IP whose
behaviour is controlled by the EP system kernel/userspace.

There are obvious syncronization assumptions here - the whole thing
is racy by design (inclusive of the stepwise boot sequence above)
but if my understanding above is correct I think this patch is the
right way of handling it.

I wonder how this is going to work if the EP function BARs map a real
device (eg USB), please let me know your thoughts on that.

Thanks,
Lorenzo
