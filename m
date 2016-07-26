Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45346 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754887AbcGZUGq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jul 2016 16:06:46 -0400
Date: Tue, 26 Jul 2016 15:06:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [GIT PULL] PCI: tegra: Changes for v4.8-rc1
Message-ID: <20160726200641.GB15037@localhost>
References: <20160701150056.26537-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160701150056.26537-3-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 01, 2016 at 05:00:56PM +0200, Thierry Reding wrote:
> Hi Bjorn,
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-pci
> 
> for you to fetch changes up to 0f32700faed919946e21e9d1dc4d74ae8f1b1226:
> 
>   PCI: tegra: Correctly program PADS_REFCLK_CFG* registers (2016-06-30 15:30:16 +0200)
> 
> There's a minor conflict between this and your pci/host-request-windows
> branch, let me know if you'd like me to rebase on top of that.
> 
> Thierry
> 
> ----------------------------------------------------------------
> PCI: tegra: Changes for v4.8-rc1
> 
> A couple of cleanups and preparation work for 64-bit ARM support, as
> well as fixes for writing the PADS_REFCLK_CFG* registers.
> 
> ----------------------------------------------------------------
> Stephen Warren (2):
>       PCI: tegra: Actually program PADS_REFCLK_CFG* on recent SoCs

I don't see this patch on the list.  I'll attach it below for
completeness.

I don't think the original changelog is quite right; I don't see
tegra_xusb_phy_enable() being involved at all.  I replaced it with the
following:

    PCI: tegra: Program PADS_REFCLK_CFG* always, not just on legacy SoCs
    
    tegra_pcie_phy_power_on() calls tegra_pcie_phy_enable() only for legacy
    SoCs.  However, part of tegra_pcie_phy_enable() needs to happen in all
    cases.  Move that code up one level into tegra_pcie_phy_power_on().


Here's the original commit from your git tree:

commit 0ad9be61b5af
Author: Stephen Warren <swarren@nvidia.com>
Date:   Fri Jun 24 08:37:03 2016 -0600

    PCI: tegra: Actually program PADS_REFCLK_CFG* on recent SoCs
    
    On recent SoCs, tegra_pcie_phy_enable() isn't called; but instead
    tegra_pcie_enable_controller() calls tegra_xusb_phy_enable(). However,
    part of tegra_pcie_phy_enable() needs to happen in all cases. Move that
    code up one level into tegra_pcie_phy_power_on().
    
    Signed-off-by: Stephen Warren <swarren@nvidia.com>
    Reviewed-by: Simon Glass <sjg@chromium.org>
    Signed-off-by: Thierry Reding <treding@nvidia.com>

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index bbf77a4..8cac1a0 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -838,12 +838,6 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
 	value |= PADS_PLL_CTL_RST_B4SM;
 	pads_writel(pcie, value, soc->pads_pll_ctl);
 
-	/* Configure the reference clock driver */
-	value = PADS_REFCLK_CFG_VALUE | (PADS_REFCLK_CFG_VALUE << 16);
-	pads_writel(pcie, value, PADS_REFCLK_CFG0);
-	if (soc->num_ports > 2)
-		pads_writel(pcie, PADS_REFCLK_CFG_VALUE, PADS_REFCLK_CFG1);
-
 	/* wait for the PLL to lock */
 	err = tegra_pcie_pll_wait(pcie, 500);
 	if (err < 0) {
@@ -927,7 +921,9 @@ static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
 
 static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 {
+	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
 	struct tegra_pcie_port *port;
+	u32 value;
 	int err;
 
 	if (pcie->legacy_phy) {
@@ -952,6 +948,13 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 		}
 	}
 
+	/* Configure the reference clock driver */
+	value = PADS_REFCLK_CFG_VALUE | (PADS_REFCLK_CFG_VALUE << 16);
+	pads_writel(pcie, value, PADS_REFCLK_CFG0);
+
+	if (soc->num_ports > 2)
+		pads_writel(pcie, PADS_REFCLK_CFG_VALUE, PADS_REFCLK_CFG1);
+
 	return 0;
 }
 
