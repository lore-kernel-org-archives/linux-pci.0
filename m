Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 11 Mar 2016 12:19:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH] PCI: altera: fix altera_pcie_link_is_up()
Message-ID: <20160311181936.GD4725@localhost>
References: <1456911787-3576-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456911787-3576-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 02, 2016 at 05:43:07PM +0800, Ley Foon Tan wrote:
> The original code return true if RP_LTSSM register return non-zero
> value. This fix to return true only RP_LTSSM register is in L0 state
> (link up).
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>

Applied to pci/host-altera for v4.6 with the following changelog.
Thanks!

    PCI: altera: Fix altera_pcie_link_is_up()
    
    Originally altera_pcie_link_is_up() decided the link was up if any of the
    low four bits of the LTSSM register were set.  But the link is only up if
    the LTSSM state is L0, so check for that exact value.
    
    [bhelgaas: changelog]
    Signed-off-by: Ley Foon Tan <lftan@altera.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/host/pcie-altera.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> index 99da549..dbac6fb 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -40,6 +40,7 @@
>  #define P2A_INT_ENABLE			0x3070
>  #define P2A_INT_ENA_ALL			0xf
>  #define RP_LTSSM			0x3c64
> +#define RP_LTSSM_MASK			0x1f
>  #define LTSSM_L0			0xf
>  
>  /* TLP configuration type 0 and 1 */
> @@ -140,7 +141,7 @@ static void tlp_write_tx(struct altera_pcie *pcie,
>  
>  static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
>  {
> -	return !!(cra_readl(pcie, RP_LTSSM) & LTSSM_L0);
> +	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
>  }
>  
>  static bool altera_pcie_valid_config(struct altera_pcie *pcie,
> -- 
> 2.2.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
