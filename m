Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751162AbdHBVZS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 17:25:18 -0400
Date: Wed, 2 Aug 2017 16:25:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com
Subject: Re: [PATCH 1/3] PCI: designware: add accessors for write permission
 of DBI read-only registers
Message-ID: <20170802212515.GH20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1499322829-23018-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <a4510ddb-3037-0787-c00e-b2703d66d54b@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a4510ddb-3037-0787-c00e-b2703d66d54b@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 06, 2017 at 10:44:04AM +0100, Joao Pinto wrote:
> 
> Hi Zhiqiang,
> 
> Às 7:33 AM de 7/6/2017, Zhiqiang Hou escreveu:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > The read-only DBI registers can be written over the DBI when set
> > the "Write to RO Registers Using DBI" (DBI_RO_WR_EN) field of the
> > MISC_CONTROL_1_OFF register.
> 
> I would suggest you to add a cover-letter next time to explain the global
> picture of the patch-set.
> 
> I understand your need for this patch, but I don't agree on the approach.
> Sometimes the people in charge of the hardware design / configuration, forget to
> specify the device class and that can be problematic for some drivers, and so
> the typical workaround is to set it in the driver using a quirk for example.
> 
> You can see some examples here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/quirks.c

I assume you're suggesting something similar to quirk_tw686x_class() and
fixup_ti816x_class(), quirk_amd_nl_class(), quirk_eisa_bridge(),
fixup_rev1_53c810(), etc.

The current dw_pcie_setup_rc() contains this:

  /* program correct class for RC */
  dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);

That suggests that DesignWare-based devices have the wrong class code,
and we're trying to fix it.

Patch 2/3 of this series suggests that the existing fix doesn't
actually work because the register is read-only.

If it's necessary and possible to update the class code register in
dw_pcie_setup_rc(), I think that's a reasonable spot to do it.

The quirks in drivers/pci/quirks.c are necessary because per spec, the
PCI Class Code is read-only, so in general we can't update it.

In the DesignWare case, the driver has additional device-specific
knowledge that allows it to update Class Code value, and I think it
makes sense to do it there.

> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> >  drivers/pci/dwc/pcie-designware.h | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> > index b4d2a89..bbdf35b 100644
> > --- a/drivers/pci/dwc/pcie-designware.h
> > +++ b/drivers/pci/dwc/pcie-designware.h
> > @@ -76,6 +76,9 @@
> >  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
> >  #define PCIE_ATU_UPPER_TARGET		0x91C
> >  
> > +#define PCIE_MISC_CONTROL_1_OFF		0x8BC
> > +#define PCIE_DBI_RO_WR_EN		(0x1 << 0)
> > +
> >  /*
> >   * iATU Unroll-specific register definitions
> >   * From 4.80 core version the address translation will be made by unroll
> > @@ -279,6 +282,28 @@ static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
> >  	return __dw_pcie_read_dbi(pci, pci->dbi_base2, reg, 0x4);
> >  }
> >  
> > +static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
> > +{
> > +	u32 reg;
> > +	u32 val;
> > +
> > +	reg = PCIE_MISC_CONTROL_1_OFF;
> > +	val = dw_pcie_readl_dbi(pci, reg);
> > +	val |= PCIE_DBI_RO_WR_EN;
> > +	dw_pcie_writel_dbi(pci, reg, val);
> > +}
> > +
> > +static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
> > +{
> > +	u32 reg;
> > +	u32 val;
> > +
> > +	reg = PCIE_MISC_CONTROL_1_OFF;
> > +	val = dw_pcie_readl_dbi(pci, reg);
> > +	val &= ~PCIE_DBI_RO_WR_EN;
> > +	dw_pcie_writel_dbi(pci, reg, val);
> > +}
> > +
> >  #ifdef CONFIG_PCIE_DW_HOST
> >  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
> >  void dw_pcie_msi_init(struct pcie_port *pp);
> > 
> 
