Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 14 Jun 2017 11:11:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: kishon@ti.com, bhelgaas@google.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: dra7xx: Fix compilation warning.
Message-ID: <20170614161110.GA4918@bhelgaas-glaptop.roam.corp.google.com>
References: <9ec4f891371506238afa813227b4be90341fee88.1497338120.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9ec4f891371506238afa813227b4be90341fee88.1497338120.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 13, 2017 at 12:48:24PM +0530, Arvind Yadav wrote:
> drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_msi_interrupts’:
> drivers/pci/dwc/pci-dra7xx.c:177:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>        ~LEG_EP_INTERRUPTS & ~MSI);
>        ^
> drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_wrapper_interrupts’:
> drivers/pci/dwc/pci-dra7xx.c:187:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>        ~INTERRUPTS);
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 8decf46..328d480 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -174,7 +174,7 @@ static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
>  static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
>  {
>  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
> -			   ~LEG_EP_INTERRUPTS & ~MSI);
> +			   (u32)~LEG_EP_INTERRUPTS & (u32)~MSI);

Can you put the casts in the definitions of LEG_EP_INTERRUPTS, MSI,
INTERRUPTS, etc., instead of at every use?

>  
>  	dra7xx_pcie_writel(dra7xx,
>  			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
> @@ -184,7 +184,7 @@ static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
>  static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
>  {
>  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
> -			   ~INTERRUPTS);
> +			   (u32)~INTERRUPTS);
>  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
>  			   INTERRUPTS);
>  }
> -- 
> 1.9.1
> 
