Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 30 Jan 2017 17:02:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: remove LTSSM disable workaround
Message-ID: <20170130230215.GZ20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20170120155837.2874-1-l.stach@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20170120155837.2874-1-l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
 patchwork-lst@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 kernel@pengutronix.de, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 20, 2017 at 04:58:37PM +0100, Lucas Stach wrote:
> This causes CPU hangs when the system is reset by the watchdog, as
> the GPRs aren't cleared, but the clocks are back to disabled state.
> 
> If the bootloader uses PCIe, it must take care to bring it down
> into a safe state, before passing control to the Linux kernel.
> This is the only way to get a properly operating system at all
> times and circumstances.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied to pci/host-imx6 for v4.11, thanks!

I don't really like the idea that we depend on a particular state from the
bootloader, but if there's no way around it, maybe this is the best we can
do.

> ---
>  drivers/pci/host/pci-imx6.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index c8cefb078218..42c1987ffb3d 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -247,9 +247,6 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>  
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	u32 val, gpr1, gpr12;
> -
>  	switch (imx6_pcie->variant) {
>  	case IMX6SX:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> @@ -266,33 +263,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  				   IMX6Q_GPR1_PCIE_SW_RST);
>  		break;
>  	case IMX6Q:
> -		/*
> -		 * If the bootloader already enabled the link we need some
> -		 * special handling to get the core back into a state where
> -		 * it is safe to touch it for configuration.  As there is
> -		 * no dedicated reset signal wired up for MX6QDL, we need
> -		 * to manually force LTSSM into "detect" state before
> -		 * completely disabling LTSSM, which is a prerequisite for
> -		 * core configuration.
> -		 *
> -		 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we
> -		 * have a strong indication that the bootloader activated
> -		 * the link.
> -		 */
> -		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
> -		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
> -
> -		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
> -		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
> -			val = dw_pcie_readl_rc(pp, PCIE_PL_PFLR);
> -			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
> -			val |= PCIE_PL_PFLR_FORCE_LINK;
> -			dw_pcie_writel_rc(pp, PCIE_PL_PFLR, val);
> -
> -			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> -		}
> -
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
