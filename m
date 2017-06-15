Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 15 Jun 2017 15:49:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: kishon@ti.com, bhelgaas@google.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: dra7xx: Fix compilation warning.
Message-ID: <20170615204951.GD12735@bhelgaas-glaptop.roam.corp.google.com>
References: <a2736e3907827e7b39dd85381101c1080012584c.1497514167.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <a2736e3907827e7b39dd85381101c1080012584c.1497514167.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 15, 2017 at 02:19:20PM +0530, Arvind Yadav wrote:
> drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_msi_interrupts’:
> drivers/pci/dwc/pci-dra7xx.c:177:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>        ~LEG_EP_INTERRUPTS & ~MSI);
>        ^
> drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_wrapper_interrupts’:
> drivers/pci/dwc/pci-dra7xx.c:187:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>        ~INTERRUPTS);

I don't object to the patch itself (hopefully Kishon will verify that
it's correct), but the subject and changelog are now completely wrong.

If the patch is correct, it is now a bug fix and is not at all about
fixing a compilation warning.  We used to write

  ~LEG_EP_INTERRUPTS & ~MSI
  ~(INTA | INTB | INTC | INTD) & ~MSI
  ~(BIT(0) | BIT(1) | BIT(2) | BIT(3)) & ~(BIT(4))
  ~(0x1 | 0x2 | 0x4 | 0x8) & ~(0x10)
  ~(0xf) & ~(0x10)
  0xfffffff0 & 0xffffffef
  0xffffffe0

and now we write

  LEG_EP_INTERRUPTS | MSI
  ...
  0x1f

It is about using these two registers correctly, and the fact that the
compilation warning goes away is a happy coincidence but not even
worth mentioning in the changelog.

So, if Kishon acks the content of the patch, please post this again
with an updated subject and changelog.

> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> Changes in v2:
>              Add casts in the definitions.
> Changes in v3:
>              Change logic insted of casting.
> 
>  drivers/pci/dwc/pci-dra7xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 8decf46..668dc15 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -174,7 +174,7 @@ static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
>  static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
>  {
>  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
> -			   ~LEG_EP_INTERRUPTS & ~MSI);
> +			   LEG_EP_INTERRUPTS | MSI);
>  
>  	dra7xx_pcie_writel(dra7xx,
>  			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
> @@ -184,7 +184,7 @@ static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
>  static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
>  {
>  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
> -			   ~INTERRUPTS);
> +			   INTERRUPTS);
>  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
>  			   INTERRUPTS);
>  }
> -- 
> 1.9.1
> 
