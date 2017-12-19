Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdLSUQU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 15:16:20 -0500
Date: Tue, 19 Dec 2017 12:16:18 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Use {upper,lower}_32_bits() macros for clarity
Message-ID: <20171219201618.GA31009@codeaurora.org>
References: <20171129005334.16425-1-sboyd@codeaurora.org>
 <20171211101947.GA3225@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171211101947.GA3225@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/11, Lorenzo Pieralisi wrote:
> On Tue, Nov 28, 2017 at 04:53:34PM -0800, Stephen Boyd wrote:
> > We have macros for getting the upper or lower 32 bits of a
> > number. Use them here to shave a couple lines off the code.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/pci/dwc/pcie-designware-host.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> > index 157621175147..ae5abfddf8de 100644
> > --- a/drivers/pci/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/dwc/pcie-designware-host.c
> > @@ -89,10 +89,8 @@ void dw_pcie_msi_init(struct pcie_port *pp)
> >  	msi_target = virt_to_phys((void *)pp->msi_data);
> >  
> >  	/* program the msi_data */
> > -	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> > -			    (u32)(msi_target & 0xffffffff));
> > -	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
> > -			    (u32)(msi_target >> 32 & 0xffffffff));
> > +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4, lower_32_bits(msi_target));
> > +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, upper_32_bits(msi_target));
> >  }
> 
> Hi Stephen,
> 
> I was about to apply it but I think that for consistency it would be
> better to convert to {lower,upper}_32_bits() also code in
> dw_msi_setup_msg() and slightly reword the log accordingly; if you do
> not mind sending a v2 with those changes I will apply then.
> 

Ok. v2 coming shortly.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
