Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 19 Sep 2017 14:36:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ravi Shankar Jonnalagadda <venkata.ravi.jonnalagadda@xilinx.com>
Subject: Re: [PATCH v2 1/5] PCI:xilinx-nwl: Enable Root DMA
Message-ID: <20170919193635.GE22312@bhelgaas-glaptop.roam.corp.google.com>
References: <1504873388-29195-1-git-send-email-vjonnal@xilinx.com>
 <1504873388-29195-2-git-send-email-vjonnal@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1504873388-29195-2-git-send-email-vjonnal@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 dmaengine@vger.kernel.org, vinod.koul@intel.com, linux-pci@vger.kernel.org,
 michal.simek@xilinx.com, linux-kernel@vger.kernel.org, vjonnal@xilinx.com,
 robh+dt@kernel.org, rgummal@xilinx.com, linux-arm-kernel@lists.infradead.org,
 bhelgaas@google.com, dan.j.williams@intel.com, bharat.kumar.gogada@xilinx.com,
 soren.brinkmann@xilinx.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ravi,

Please make the subject line follow the existing convention, i.e., run

  $ git log --oneline drivers/pci/host/pcie-xilinx-nwl.c

and make yours match spacing, capitalization, and style (imperative
sentence).

Also waiting for ack from Michal.

On Fri, Sep 08, 2017 at 05:53:03PM +0530, Ravi Shankar Jonnalagadda wrote:
> Enabling Root DMA interrupts
> 
> Adding Root DMA translations to bridge for Register Access
> 
> Signed-off-by: Ravi Shankar Jonnalagadda <vjonnal@xilinx.com>
> Signed-off-by: RaviKiran Gummaluri <rgummal@xilinx.com>
> ---
>  drivers/pci/host/pcie-xilinx-nwl.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index eec641a..5766582 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -39,6 +39,11 @@
>  #define E_ECAM_CONTROL			0x00000228
>  #define E_ECAM_BASE_LO			0x00000230
>  #define E_ECAM_BASE_HI			0x00000234
> +#define E_DREG_CTRL			0x00000288
> +#define E_DREG_BASE_LO			0x00000290
> +
> +#define DREG_DMA_EN			BIT(0)
> +#define DREG_DMA_BASE_LO		0xFD0F0000
>  
>  /* Ingress - address translations */
>  #define I_MSII_CAPABILITIES		0x00000300
> @@ -57,6 +62,10 @@
>  #define MSGF_MSI_STATUS_HI		0x00000444
>  #define MSGF_MSI_MASK_LO		0x00000448
>  #define MSGF_MSI_MASK_HI		0x0000044C
> +/* Root DMA Interrupt register */
> +#define MSGF_DMA_MASK			0x00000464
> +
> +#define MSGF_INTR_EN			BIT(0)
>  
>  /* Msg filter mask bits */
>  #define CFG_ENABLE_PM_MSG_FWD		BIT(1)
> @@ -766,6 +775,12 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
>  			  MSGF_LEG_SR_MASKALL, MSGF_LEG_STATUS);
>  
> +	/* Enabling DREG translations */
> +	nwl_bridge_writel(pcie, DREG_DMA_EN, E_DREG_CTRL);
> +	nwl_bridge_writel(pcie, DREG_DMA_BASE_LO, E_DREG_BASE_LO);
> +	/* Enabling Root DMA interrupts */
> +	nwl_bridge_writel(pcie, MSGF_INTR_EN, MSGF_DMA_MASK);
> +
>  	/* Enable all legacy interrupts */
>  	nwl_bridge_writel(pcie, MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
>  
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
