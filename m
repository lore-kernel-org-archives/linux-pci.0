Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752002AbcJJNgw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Oct 2016 09:36:52 -0400
Date: Mon, 10 Oct 2016 08:36:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pci@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/8] PCI: exynos: Name private struct pointer "exynos"
 consistently
Message-ID: <20161010133644.GA30267@localhost>
References: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161008194144.GA2991@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161008194144.GA2991@kozik-lap>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Krzysztof,

Thanks a lot for taking the time to look these over.

On Sat, Oct 08, 2016 at 10:41:44PM +0300, Krzysztof Kozlowski wrote:
> On Fri, Oct 07, 2016 at 11:35:26AM -0500, Bjorn Helgaas wrote:
> > Use a device-specific name, "exynos", for struct exynos_pcie pointers
> > to hint that this is device-specific information.
> 
> I don't get it. "exynos_pcie" is already a exynos-device-specific name.
> There are a lot of changes but I don't see the real reason/benefit. What
> was your intention?

I'm looking across all the drivers in drivers/pci/host/, not just
exynos.  Many of them used "pcie" as name for pointers to the
device-specific struct, leading to things like "pcie->lut" or
"pcie->breg_base".  These *look* like they should be sort of generic,
but in fact they are device-specific.

My idea was to replace that "pcie" name with something
device-specific, and I started with the simplest possible name, e.g.,
"exynos".  Others pointed out that that for SoCs, that is often not
enough specific enough, and something like "exynos_pcie" is more
appropriate.

In the specific case of exynos, it already uses "exynos_pcie" in most
cases, so I tweaked this patch to use it in the few remaining places
where it didn't (the register accessor functions).

> > No functional change
> > intended.
> 
> Oh, but there is. Inline disappeared in first functions. Although I
> don't mind but this should be seprate from trivial rename.

I didn't think of "inline" as a functional change, but I split it out
into its own patch.  I'm embarrassed at how much churn this turned out
to be, so I didn't want to add more patches than I had to, but I did
split it out for you.

I repushed the branch.

> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/host/pci-exynos.c |  272 ++++++++++++++++++++---------------------
> >  1 file changed, 135 insertions(+), 137 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> > index f559b49..05eb246 100644
> > --- a/drivers/pci/host/pci-exynos.c
> > +++ b/drivers/pci/host/pci-exynos.c
> > @@ -102,221 +102,221 @@ struct exynos_pcie {
> >  #define PCIE_PHY_TRSV3_PD_TSV		(0x1 << 7)
> >  #define PCIE_PHY_TRSV3_LVCC		0x31c
> >  
> > -static inline void exynos_elb_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
> > +static void exynos_elb_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
> >  {
> > -	writel(val, pcie->elbi_base + reg);
> > +	writel(val, exynos->elbi_base + reg);
> >  }
> >  
> > -static inline u32 exynos_elb_readl(struct exynos_pcie *pcie, u32 reg)
> > +static u32 exynos_elb_readl(struct exynos_pcie *exynos, u32 reg)
> >  {
> > -	return readl(pcie->elbi_base + reg);
> > +	return readl(exynos->elbi_base + reg);
> >  }
> >  
> > -static inline void exynos_phy_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
> > +static void exynos_phy_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
> >  {
> > -	writel(val, pcie->phy_base + reg);
> > +	writel(val, exynos->phy_base + reg);
> >  }
> >  
> > -static inline u32 exynos_phy_readl(struct exynos_pcie *pcie, u32 reg)
> > +static u32 exynos_phy_readl(struct exynos_pcie *exynos, u32 reg)
> >  {
> > -	return readl(pcie->phy_base + reg);
> > +	return readl(exynos->phy_base + reg);
> >  }
> >  
> > -static inline void exynos_blk_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
> > +static void exynos_blk_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
> >  {
> > -	writel(val, pcie->block_base + reg);
> > +	writel(val, exynos->block_base + reg);
> >  }
> >  
> > -static inline u32 exynos_blk_readl(struct exynos_pcie *pcie, u32 reg)
> > +static u32 exynos_blk_readl(struct exynos_pcie *exynos, u32 reg)
> >  {
> > -	return readl(pcie->block_base + reg);
> > +	return readl(exynos->block_base + reg);
> >  }
> >  
> >  static void exynos_pcie_sideband_dbi_w_mode(struct pcie_port *pp, bool on)
> >  {
> >  	u32 val;
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> >  	if (on) {
> > -		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_AWMISC);
> > +		val = exynos_elb_readl(exynos, PCIE_ELBI_SLV_AWMISC);
> >  		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> > -		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_AWMISC);
> > +		exynos_elb_writel(exynos, val, PCIE_ELBI_SLV_AWMISC);
> >  	} else {
> > -		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_AWMISC);
> > +		val = exynos_elb_readl(exynos, PCIE_ELBI_SLV_AWMISC);
> >  		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> > -		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_AWMISC);
> > +		exynos_elb_writel(exynos, val, PCIE_ELBI_SLV_AWMISC);
> >  	}
> >  }
> >  
> >  static void exynos_pcie_sideband_dbi_r_mode(struct pcie_port *pp, bool on)
> >  {
> >  	u32 val;
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> >  	if (on) {
> > -		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_ARMISC);
> > +		val = exynos_elb_readl(exynos, PCIE_ELBI_SLV_ARMISC);
> >  		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> > -		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_ARMISC);
> > +		exynos_elb_writel(exynos, val, PCIE_ELBI_SLV_ARMISC);
> >  	} else {
> > -		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_ARMISC);
> > +		val = exynos_elb_readl(exynos, PCIE_ELBI_SLV_ARMISC);
> >  		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> > -		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_ARMISC);
> > +		exynos_elb_writel(exynos, val, PCIE_ELBI_SLV_ARMISC);
> >  	}
> >  }
> >  
> >  static void exynos_pcie_assert_core_reset(struct pcie_port *pp)
> >  {
> >  	u32 val;
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> > -	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
> > +	val = exynos_elb_readl(exynos, PCIE_CORE_RESET);
> >  	val &= ~PCIE_CORE_RESET_ENABLE;
> > -	exynos_elb_writel(exynos_pcie, val, PCIE_CORE_RESET);
> > -	exynos_elb_writel(exynos_pcie, 0, PCIE_PWR_RESET);
> > -	exynos_elb_writel(exynos_pcie, 0, PCIE_STICKY_RESET);
> > -	exynos_elb_writel(exynos_pcie, 0, PCIE_NONSTICKY_RESET);
> > +	exynos_elb_writel(exynos, val, PCIE_CORE_RESET);
> > +	exynos_elb_writel(exynos, 0, PCIE_PWR_RESET);
> > +	exynos_elb_writel(exynos, 0, PCIE_STICKY_RESET);
> > +	exynos_elb_writel(exynos, 0, PCIE_NONSTICKY_RESET);
> >  }
> >  
> >  static void exynos_pcie_deassert_core_reset(struct pcie_port *pp)
> >  {
> >  	u32 val;
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> > -	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
> > +	val = exynos_elb_readl(exynos, PCIE_CORE_RESET);
> >  	val |= PCIE_CORE_RESET_ENABLE;
> >  
> > -	exynos_elb_writel(exynos_pcie, val, PCIE_CORE_RESET);
> > -	exynos_elb_writel(exynos_pcie, 1, PCIE_STICKY_RESET);
> > -	exynos_elb_writel(exynos_pcie, 1, PCIE_NONSTICKY_RESET);
> > -	exynos_elb_writel(exynos_pcie, 1, PCIE_APP_INIT_RESET);
> > -	exynos_elb_writel(exynos_pcie, 0, PCIE_APP_INIT_RESET);
> > -	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_MAC_RESET);
> > +	exynos_elb_writel(exynos, val, PCIE_CORE_RESET);
> > +	exynos_elb_writel(exynos, 1, PCIE_STICKY_RESET);
> > +	exynos_elb_writel(exynos, 1, PCIE_NONSTICKY_RESET);
> > +	exynos_elb_writel(exynos, 1, PCIE_APP_INIT_RESET);
> > +	exynos_elb_writel(exynos, 0, PCIE_APP_INIT_RESET);
> > +	exynos_blk_writel(exynos, 1, PCIE_PHY_MAC_RESET);
> >  }
> >  
> >  static void exynos_pcie_assert_phy_reset(struct pcie_port *pp)
> >  {
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> > -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_MAC_RESET);
> > -	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_GLOBAL_RESET);
> > +	exynos_blk_writel(exynos, 0, PCIE_PHY_MAC_RESET);
> > +	exynos_blk_writel(exynos, 1, PCIE_PHY_GLOBAL_RESET);
> >  }
> >  
> >  static void exynos_pcie_deassert_phy_reset(struct pcie_port *pp)
> >  {
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> > -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_GLOBAL_RESET);
> > -	exynos_elb_writel(exynos_pcie, 1, PCIE_PWR_RESET);
> > -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
> > -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_CMN_REG);
> > -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSVREG_RESET);
> > -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSV_RESET);
> > +	exynos_blk_writel(exynos, 0, PCIE_PHY_GLOBAL_RESET);
> > +	exynos_elb_writel(exynos, 1, PCIE_PWR_RESET);
> > +	exynos_blk_writel(exynos, 0, PCIE_PHY_COMMON_RESET);
> > +	exynos_blk_writel(exynos, 0, PCIE_PHY_CMN_REG);
> > +	exynos_blk_writel(exynos, 0, PCIE_PHY_TRSVREG_RESET);
> > +	exynos_blk_writel(exynos, 0, PCIE_PHY_TRSV_RESET);
> >  }
> >  
> >  static void exynos_pcie_power_on_phy(struct pcie_port *pp)
> >  {
> >  	u32 val;
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> > -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
> > +	val = exynos_phy_readl(exynos, PCIE_PHY_COMMON_POWER);
> >  	val &= ~PCIE_PHY_COMMON_PD_CMN;
> > -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_COMMON_POWER);
> > +	exynos_phy_writel(exynos, val, PCIE_PHY_COMMON_POWER);
> >  
> > -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV0_POWER);
> > +	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV0_POWER);
> >  	val &= ~PCIE_PHY_TRSV0_PD_TSV;
> > -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV0_POWER);
> > +	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV0_POWER);
> >  
> > -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV1_POWER);
> > +	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV1_POWER);
> >  	val &= ~PCIE_PHY_TRSV1_PD_TSV;
> > -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV1_POWER);
> > +	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV1_POWER);
> >  
> > -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV2_POWER);
> > +	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV2_POWER);
> >  	val &= ~PCIE_PHY_TRSV2_PD_TSV;
> > -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV2_POWER);
> > +	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV2_POWER);
> >  
> > -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV3_POWER);
> > +	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV3_POWER);
> >  	val &= ~PCIE_PHY_TRSV3_PD_TSV;
> > -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
> > +	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV3_POWER);
> >  }
> >  
> >  static void exynos_pcie_power_off_phy(struct pcie_port *pp)
> >  {
> >  	u32 val;
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> > -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
> > +	val = exynos_phy_readl(exynos, PCIE_PHY_COMMON_POWER);
> >  	val |= PCIE_PHY_COMMON_PD_CMN;
> > -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_COMMON_POWER);
> > +	exynos_phy_writel(exynos, val, PCIE_PHY_COMMON_POWER);
> >  
> > -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV0_POWER);
> > +	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV0_POWER);
> >  	val |= PCIE_PHY_TRSV0_PD_TSV;
> > -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV0_POWER);
> > +	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV0_POWER);
> >  
> > -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV1_POWER);
> > +	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV1_POWER);
> >  	val |= PCIE_PHY_TRSV1_PD_TSV;
> > -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV1_POWER);
> > +	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV1_POWER);
> >  
> > -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV2_POWER);
> > +	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV2_POWER);
> >  	val |= PCIE_PHY_TRSV2_PD_TSV;
> > -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV2_POWER);
> > +	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV2_POWER);
> >  
> > -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV3_POWER);
> > +	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV3_POWER);
> >  	val |= PCIE_PHY_TRSV3_PD_TSV;
> > -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
> > +	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV3_POWER);
> >  }
> >  
> >  static void exynos_pcie_init_phy(struct pcie_port *pp)
> >  {
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> >  	/* DCC feedback control off */
> > -	exynos_phy_writel(exynos_pcie, 0x29, PCIE_PHY_DCC_FEEDBACK);
> > +	exynos_phy_writel(exynos, 0x29, PCIE_PHY_DCC_FEEDBACK);
> >  
> >  	/* set TX/RX impedance */
> > -	exynos_phy_writel(exynos_pcie, 0xd5, PCIE_PHY_IMPEDANCE);
> > +	exynos_phy_writel(exynos, 0xd5, PCIE_PHY_IMPEDANCE);
> >  
> >  	/* set 50Mhz PHY clock */
> > -	exynos_phy_writel(exynos_pcie, 0x14, PCIE_PHY_PLL_DIV_0);
> > -	exynos_phy_writel(exynos_pcie, 0x12, PCIE_PHY_PLL_DIV_1);
> > +	exynos_phy_writel(exynos, 0x14, PCIE_PHY_PLL_DIV_0);
> > +	exynos_phy_writel(exynos, 0x12, PCIE_PHY_PLL_DIV_1);
> >  
> >  	/* set TX Differential output for lane 0 */
> > -	exynos_phy_writel(exynos_pcie, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
> > +	exynos_phy_writel(exynos, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
> >  
> >  	/* set TX Pre-emphasis Level Control for lane 0 to minimum */
> > -	exynos_phy_writel(exynos_pcie, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
> > +	exynos_phy_writel(exynos, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
> >  
> >  	/* set RX clock and data recovery bandwidth */
> > -	exynos_phy_writel(exynos_pcie, 0xe7, PCIE_PHY_PLL_BIAS);
> > -	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV0_RXCDR);
> > -	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV1_RXCDR);
> > -	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV2_RXCDR);
> > -	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV3_RXCDR);
> > +	exynos_phy_writel(exynos, 0xe7, PCIE_PHY_PLL_BIAS);
> > +	exynos_phy_writel(exynos, 0x82, PCIE_PHY_TRSV0_RXCDR);
> > +	exynos_phy_writel(exynos, 0x82, PCIE_PHY_TRSV1_RXCDR);
> > +	exynos_phy_writel(exynos, 0x82, PCIE_PHY_TRSV2_RXCDR);
> > +	exynos_phy_writel(exynos, 0x82, PCIE_PHY_TRSV3_RXCDR);
> >  
> >  	/* change TX Pre-emphasis Level Control for lanes */
> > -	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
> > -	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
> > -	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
> > -	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
> > +	exynos_phy_writel(exynos, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
> > +	exynos_phy_writel(exynos, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
> > +	exynos_phy_writel(exynos, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
> > +	exynos_phy_writel(exynos, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
> >  
> >  	/* set LVCC */
> > -	exynos_phy_writel(exynos_pcie, 0x20, PCIE_PHY_TRSV0_LVCC);
> > -	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV1_LVCC);
> > -	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV2_LVCC);
> > -	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV3_LVCC);
> > +	exynos_phy_writel(exynos, 0x20, PCIE_PHY_TRSV0_LVCC);
> > +	exynos_phy_writel(exynos, 0xa0, PCIE_PHY_TRSV1_LVCC);
> > +	exynos_phy_writel(exynos, 0xa0, PCIE_PHY_TRSV2_LVCC);
> > +	exynos_phy_writel(exynos, 0xa0, PCIE_PHY_TRSV3_LVCC);
> >  }
> >  
> >  static void exynos_pcie_assert_reset(struct pcie_port *pp)
> >  {
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> > -	if (exynos_pcie->reset_gpio >= 0)
> > -		devm_gpio_request_one(pp->dev, exynos_pcie->reset_gpio,
> > +	if (exynos->reset_gpio >= 0)
> > +		devm_gpio_request_one(pp->dev, exynos->reset_gpio,
> >  				GPIOF_OUT_INIT_HIGH, "RESET");
> >  }
> >  
> >  static int exynos_pcie_establish_link(struct pcie_port *pp)
> >  {
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  	u32 val;
> >  
> >  	if (dw_pcie_link_up(pp)) {
> > @@ -338,9 +338,9 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
> >  	exynos_pcie_init_phy(pp);
> >  
> >  	/* pulse for common reset */
> > -	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_COMMON_RESET);
> > +	exynos_blk_writel(exynos, 1, PCIE_PHY_COMMON_RESET);
> >  	udelay(500);
> > -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
> > +	exynos_blk_writel(exynos, 0, PCIE_PHY_COMMON_RESET);
> >  
> >  	/* de-assert core reset */
> >  	exynos_pcie_deassert_core_reset(pp);
> > @@ -352,15 +352,15 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
> >  	exynos_pcie_assert_reset(pp);
> >  
> >  	/* assert LTSSM enable */
> > -	exynos_elb_writel(exynos_pcie, PCIE_ELBI_LTSSM_ENABLE,
> > +	exynos_elb_writel(exynos, PCIE_ELBI_LTSSM_ENABLE,
> >  			  PCIE_APP_LTSSM_ENABLE);
> >  
> >  	/* check if the link is up or not */
> >  	if (!dw_pcie_wait_for_link(pp))
> >  		return 0;
> >  
> > -	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
> > -		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
> > +	while (exynos_phy_readl(exynos, PCIE_PHY_PLL_LOCKED) == 0) {
> > +		val = exynos_blk_readl(exynos, PCIE_PHY_PLL_LOCKED);
> >  		dev_info(pp->dev, "PLL Locked: 0x%x\n", val);
> >  	}
> >  	/* power off phy */
> > @@ -372,21 +372,21 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
> >  static void exynos_pcie_clear_irq_pulse(struct pcie_port *pp)
> >  {
> >  	u32 val;
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> > -	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_PULSE);
> > -	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_PULSE);
> > +	val = exynos_elb_readl(exynos, PCIE_IRQ_PULSE);
> > +	exynos_elb_writel(exynos, val, PCIE_IRQ_PULSE);
> >  }
> >  
> >  static void exynos_pcie_enable_irq_pulse(struct pcie_port *pp)
> >  {
> >  	u32 val;
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> >  	/* enable INTX interrupt */
> >  	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
> >  		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
> > -	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_PULSE);
> > +	exynos_elb_writel(exynos, val, PCIE_IRQ_EN_PULSE);
> >  }
> >  
> >  static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
> > @@ -407,14 +407,14 @@ static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
> >  static void exynos_pcie_msi_init(struct pcie_port *pp)
> >  {
> >  	u32 val;
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> >  
> >  	dw_pcie_msi_init(pp);
> >  
> >  	/* enable MSI interrupt */
> > -	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_EN_LEVEL);
> > +	val = exynos_elb_readl(exynos, PCIE_IRQ_EN_LEVEL);
> >  	val |= IRQ_MSI_ENABLE;
> > -	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_LEVEL);
> > +	exynos_elb_writel(exynos, val, PCIE_IRQ_EN_LEVEL);
> >  }
> >  
> >  static void exynos_pcie_enable_interrupts(struct pcie_port *pp)
> > @@ -466,8 +466,8 @@ static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
> >  
> >  static int exynos_pcie_link_up(struct pcie_port *pp)
> >  {
> > -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> > -	u32 val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_RDLH_LINKUP);
> > +	struct exynos_pcie *exynos = to_exynos_pcie(pp);
> > +	u32 val = exynos_elb_readl(exynos, PCIE_ELBI_RDLH_LINKUP);
> >  
> >  	if (val == PCIE_ELBI_LTSSM_ENABLE)
> >  		return 1;
> > @@ -538,7 +538,7 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
> >  
> >  static int __init exynos_pcie_probe(struct platform_device *pdev)
> >  {
> > -	struct exynos_pcie *exynos_pcie;
> > +	struct exynos_pcie *exynos;
> >  	struct pcie_port *pp;
> >  	struct device_node *np = pdev->dev.of_node;
> >  	struct resource *elbi_base;
> > @@ -546,54 +546,52 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
> >  	struct resource *block_base;
> >  	int ret;
> >  
> > -	exynos_pcie = devm_kzalloc(&pdev->dev, sizeof(*exynos_pcie),
> > -				GFP_KERNEL);
> > -	if (!exynos_pcie)
> > +	exynos = devm_kzalloc(&pdev->dev, sizeof(*exynos), GFP_KERNEL);
> > +	if (!exynos)
> >  		return -ENOMEM;
> >  
> > -	pp = &exynos_pcie->pp;
> > -
> > +	pp = &exynos->pp;
> >  	pp->dev = &pdev->dev;
> >  
> > -	exynos_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> > +	exynos->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> >  
> > -	exynos_pcie->clk = devm_clk_get(&pdev->dev, "pcie");
> > -	if (IS_ERR(exynos_pcie->clk)) {
> > +	exynos->clk = devm_clk_get(&pdev->dev, "pcie");
> > +	if (IS_ERR(exynos->clk)) {
> >  		dev_err(&pdev->dev, "Failed to get pcie rc clock\n");
> > -		return PTR_ERR(exynos_pcie->clk);
> > +		return PTR_ERR(exynos->clk);
> >  	}
> > -	ret = clk_prepare_enable(exynos_pcie->clk);
> > +	ret = clk_prepare_enable(exynos->clk);
> >  	if (ret)
> >  		return ret;
> >  
> > -	exynos_pcie->bus_clk = devm_clk_get(&pdev->dev, "pcie_bus");
> > -	if (IS_ERR(exynos_pcie->bus_clk)) {
> > +	exynos->bus_clk = devm_clk_get(&pdev->dev, "pcie_bus");
> > +	if (IS_ERR(exynos->bus_clk)) {
> >  		dev_err(&pdev->dev, "Failed to get pcie bus clock\n");
> > -		ret = PTR_ERR(exynos_pcie->bus_clk);
> > +		ret = PTR_ERR(exynos->bus_clk);
> >  		goto fail_clk;
> >  	}
> > -	ret = clk_prepare_enable(exynos_pcie->bus_clk);
> > +	ret = clk_prepare_enable(exynos->bus_clk);
> >  	if (ret)
> >  		goto fail_clk;
> >  
> >  	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	exynos_pcie->elbi_base = devm_ioremap_resource(&pdev->dev, elbi_base);
> > -	if (IS_ERR(exynos_pcie->elbi_base)) {
> > -		ret = PTR_ERR(exynos_pcie->elbi_base);
> > +	exynos->elbi_base = devm_ioremap_resource(&pdev->dev, elbi_base);
> > +	if (IS_ERR(exynos->elbi_base)) {
> > +		ret = PTR_ERR(exynos->elbi_base);
> >  		goto fail_bus_clk;
> >  	}
> >  
> >  	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > -	exynos_pcie->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
> > -	if (IS_ERR(exynos_pcie->phy_base)) {
> > -		ret = PTR_ERR(exynos_pcie->phy_base);
> > +	exynos->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
> > +	if (IS_ERR(exynos->phy_base)) {
> > +		ret = PTR_ERR(exynos->phy_base);
> >  		goto fail_bus_clk;
> >  	}
> >  
> >  	block_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> > -	exynos_pcie->block_base = devm_ioremap_resource(&pdev->dev, block_base);
> > -	if (IS_ERR(exynos_pcie->block_base)) {
> > -		ret = PTR_ERR(exynos_pcie->block_base);
> > +	exynos->block_base = devm_ioremap_resource(&pdev->dev, block_base);
> > +	if (IS_ERR(exynos->block_base)) {
> > +		ret = PTR_ERR(exynos->block_base);
> >  		goto fail_bus_clk;
> >  	}
> >  
> > @@ -601,22 +599,22 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
> >  	if (ret < 0)
> >  		goto fail_bus_clk;
> >  
> > -	platform_set_drvdata(pdev, exynos_pcie);
> > +	platform_set_drvdata(pdev, exynos);
> >  	return 0;
> >  
> >  fail_bus_clk:
> > -	clk_disable_unprepare(exynos_pcie->bus_clk);
> > +	clk_disable_unprepare(exynos->bus_clk);
> >  fail_clk:
> > -	clk_disable_unprepare(exynos_pcie->clk);
> > +	clk_disable_unprepare(exynos->clk);
> >  	return ret;
> >  }
> >  
> >  static int __exit exynos_pcie_remove(struct platform_device *pdev)
> >  {
> > -	struct exynos_pcie *exynos_pcie = platform_get_drvdata(pdev);
> > +	struct exynos_pcie *exynos = platform_get_drvdata(pdev);
> >  
> > -	clk_disable_unprepare(exynos_pcie->bus_clk);
> > -	clk_disable_unprepare(exynos_pcie->clk);
> > +	clk_disable_unprepare(exynos->bus_clk);
> > +	clk_disable_unprepare(exynos->clk);
> >  
> >  	return 0;
> >  }
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
