Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53889 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932533AbcF3Pne (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Jun 2016 11:43:34 -0400
Date: Thu, 30 Jun 2016 09:35:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] pci: tegra: correctly program PADS_REFCLK registers
Message-ID: <20160630093523.24cd5767@t450s.home>
In-Reply-To: <20160630132001.GA26758@ulmo.ba.sec>
References: <20160621184640.19885-1-swarren@wwwdotorg.org>
	<20160622125749.GJ26943@ulmo.ba.sec>
	<576AAFFD.4050404@wwwdotorg.org>
	<20160623084448.GA8608@ulmo.ba.sec>
	<20160630132001.GA26758@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 30 Jun 2016 15:20:01 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Thu, Jun 23, 2016 at 10:44:48AM +0200, Thierry Reding wrote:
> > On Wed, Jun 22, 2016 at 09:34:21AM -0600, Stephen Warren wrote:  
> > > On 06/22/2016 06:57 AM, Thierry Reding wrote:  
> > > > On Tue, Jun 21, 2016 at 12:46:40PM -0600, Stephen Warren wrote:  
> > > > > From: Stephen Warren <swarren@nvidia.com>
> > > > > 
> > > > > The value that should be programmed into the PADS_REFCLK register varies
> > > > > per SoC. Fix the Tegra PCIe driver to program the correct values. Future
> > > > > SoCs will require different values in cfg0/1, so the two values are stored
> > > > > separately in the per-SoC data structures.
> > > > > 
> > > > > For reference, the values are all documented in NV bug 1771116 comment 20.
> > > > > Rhe ASIC team has validated all these values, except for the Tegra20 value
> > > > > which is simply left unchanged in this patch.  
> > >   
> > > > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c  
> > >   
> > > > > @@ -2078,6 +2070,7 @@ static const struct tegra_pcie_soc_data tegra20_pcie_data = {
> > > > >   	.msi_base_shift = 0,
> > > > >   	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
> > > > >   	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
> > > > > +	.pads_refclk_cfg0 = 0xfa5cfa5c,
> > > > >   	.has_pex_clkreq_en = false,
> > > > >   	.has_pex_bias_ctrl = false,
> > > > >   	.has_intr_prsnt_sense = false,
> > > > > @@ -2090,6 +2083,8 @@ static const struct tegra_pcie_soc_data tegra30_pcie_data = {
> > > > >   	.msi_base_shift = 8,
> > > > >   	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
> > > > >   	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
> > > > > +	.pads_refclk_cfg0 = 0xfa5cfa5c,
> > > > > +	.pads_refclk_cfg1 = 0xfa5cfa5c,
> > > > >   	.has_pex_clkreq_en = true,
> > > > >   	.has_pex_bias_ctrl = true,
> > > > >   	.has_intr_prsnt_sense = true,
> > > > > @@ -2102,6 +2097,7 @@ static const struct tegra_pcie_soc_data tegra124_pcie_data = {
> > > > >   	.msi_base_shift = 8,
> > > > >   	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
> > > > >   	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
> > > > > +	.pads_refclk_cfg0 = 0x44ac44ac,
> > > > >   	.has_pex_clkreq_en = true,
> > > > >   	.has_pex_bias_ctrl = true,
> > > > >   	.has_intr_prsnt_sense = true,  
> > > > 
> > > > I think it'd be nice to have these decoded into their individual fields,
> > > > to reduce the magic. We already define the register fields, so it seems
> > > > sensible to use them.  
> > > 
> > > I did consider that. However, the specification from the ASIC team is always
> > > the raw values. Decoding them into bitfields is only going to make it harder
> > > to verify whether the correct values are present (since the reader has to
> > > manually expand the math), and introduce the possibility of errors during
> > > the expansion process. I think using raw numbers is better in this case.  
> > 
> > Alright, fine with me:
> > 
> > Acked-by: Thierry Reding <treding@nvidia.com>  
> 
> Hi Bjorn,
> 
> I do have a couple of other patches, mostly minor cleanup and prep-work
> for 64-bit ARM support, that I'd like to get into v4.8. Would you mind
> if I took Stephen's patches into a branch and send it all out via pull
> request after it passed testing?

Hi Theirry,

Bjorn is on holiday and will be back at the beginning of the v4.8 merge
window, assuming everything sticks to a regular schedule.  I expect
that anything that consolidates and prioritizes potential v4.8 content
for easy evaluation on his return would be appreciated.  Thanks,

Alex
