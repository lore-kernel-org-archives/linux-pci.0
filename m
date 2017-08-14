Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752408AbdHNW0J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Aug 2017 18:26:09 -0400
Date: Mon, 14 Aug 2017 17:26:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, Joao.Pinto@synopsys.com,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCHv2 4/6] PCI: layerscape: refactor the host_init function
Message-ID: <20170814222605.GK32525@bhelgaas-glaptop.roam.corp.google.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1501748620-42866-5-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170814213824.GJ32525@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170814213824.GJ32525@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Stanimir, Niklas, Jesper]

On Mon, Aug 14, 2017 at 04:38:24PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 03, 2017 at 04:23:38PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > Make the ls1021a's host_init reuse layerscape platform's common
> > host_init function.
> > 
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> > V2:
> >  - Removed the disable outbound windows code and the remove duplicate class code
> >    fixup code from this patch.
> > 
> >  drivers/pci/dwc/pci-layerscape.c | 54 ++++++++++++++++++++--------------------
> >  1 file changed, 27 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
> > index 09056a6..3533a8c 100644
> > --- a/drivers/pci/dwc/pci-layerscape.c
> > +++ b/drivers/pci/dwc/pci-layerscape.c
> > @@ -107,33 +107,6 @@ static int ls1021_pcie_link_up(struct dw_pcie *pci)
> >  	return 1;
> >  }
> >  
> > -static void ls1021_pcie_host_init(struct pcie_port *pp)
> > -{
> > -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > -	struct ls_pcie *pcie = to_ls_pcie(pci);
> > -	struct device *dev = pci->dev;
> > -	u32 index[2];
> > -
> > -	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> > -						     "fsl,pcie-scfg");
> > -	if (IS_ERR(pcie->scfg)) {
> > -		dev_err(dev, "No syscfg phandle specified\n");
> > -		pcie->scfg = NULL;
> > -		return;
> > -	}
> > -
> > -	if (of_property_read_u32_array(dev->of_node,
> > -				       "fsl,pcie-scfg", index, 2)) {
> > -		pcie->scfg = NULL;
> > -		return;
> > -	}
> > -	pcie->index = index[1];
> > -
> > -	dw_pcie_setup_rc(pp);
> > -
> > -	ls_pcie_drop_msg_tlp(pcie);
> > -}
> > -
> >  static int ls_pcie_link_up(struct dw_pcie *pci)
> >  {
> >  	struct ls_pcie *pcie = to_ls_pcie(pci);
> > @@ -160,6 +133,33 @@ static void ls_pcie_host_init(struct pcie_port *pp)
> >  	dw_pcie_dbi_ro_wr_dis(pci);
> >  
> >  	ls_pcie_drop_msg_tlp(pcie);
> > +
> > +	dw_pcie_setup_rc(pp);
> > +}
> > +
> > +static void ls1021_pcie_host_init(struct pcie_port *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > +	struct device *dev = pci->dev;
> > +	u32 index[2];
> > +
> > +	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +						     "fsl,pcie-scfg");
> > +	if (IS_ERR(pcie->scfg)) {
> > +		dev_err(dev, "No syscfg phandle specified\n");
> > +		pcie->scfg = NULL;
> > +		return;
> > +	}
> > +
> > +	if (of_property_read_u32_array(dev->of_node,
> > +				       "fsl,pcie-scfg", index, 2)) {
> > +		pcie->scfg = NULL;
> > +		return;
> > +	}
> > +	pcie->index = index[1];
> > +
> > +	ls_pcie_host_init(pp);
> 
> The changelog suggests that this is a simple refactoring that doesn't
> fix anything.
> 
> But because ls1021_pcie_host_init() now calls ls_pcie_host_init(), it
> now calls:
> 
>   dw_pcie_dbi_ro_wr_en(pci);
>   ls_pcie_fix_class(pcie);
>   ls_pcie_clear_multifunction(pcie);
>   dw_pcie_dbi_ro_wr_dis(pci);
> 
> when it did not call them before.
> 
> It's fine with me if you want to do that, but it should be mentioned
> in the changelog.

The order of this series is screwed up, which makes it hard to follow.

5192ec7b24dd ("PCI: layerscape: Add support for LS1043a and LS2080a")
added ls_pcie_host_init(), which didn't call dw_pcie_setup_rc().  I
think that was a bug, and you should fix that first.

Then:

  - Rebase on pci/host-designware because it conflicts with patches
    I've already applied
    (https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-designware)

  - Make ls_pcie_host_init() call dw_pcie_setup_rc() (fixes
    5192ec7b24dd)

  - Refactor ls1021_pcie_host_init() to make it call
    ls_pcie_host_init() (this will now be no functional change)

  - Disable outbound ATUs in ls_pcie_host_init() (bugfix for all
    layerscape devices)

  - Add DBI write permission accessors and use them in layerscape.
    This will make it obvious that PCIE_MISC_CONTROL_1_OFF is moving
    from layerscape to designware and that we're actually using these
    new interfaces (this will be no functional change).

  - Enable write permission in dw_pcie_setup_rc() and remove class
    code update from ls_pcie_host_init()  This will make it obvious
    that fixing dw_pcie_setup_rc() makes ls_pcie_fix_class() obsolete.

Does this dw_pcie_setup_rc() fix mean we can also get rid of the
device class check in qcom_pcie_rd_own_conf()?

I suspect it also means we can drop the write enable in
artpec6_pcie_establish_link().

> >  }
> >  
> >  static int ls_pcie_msi_host_init(struct pcie_port *pp,
> > -- 
> > 2.1.0.27.g96db324
> > 
