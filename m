Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965111AbcKNW0J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Nov 2016 17:26:09 -0500
Date: Mon, 14 Nov 2016 16:26:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] PCI: rockchip: cleanup bit definition for
 PCIE_RC_CONFIG_LCS
Message-ID: <20161114222604.GJ9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1479096666-112668-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479096666-112668-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 14, 2016 at 12:11:05PM +0800, Shawn Lin wrote:
> PCIE_RC_CONFIG_LCS contains control and status bits specific
> to the PCIe link. The layout for this register looks the same
> as the existed PCI_EXP_LNKCTL and PCI_EXP_LNKSTA. So let's
> reuse them.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Did something change since the version you posted yesterday?
Resending a patch with no changes or with no hint about what changed
doesn't speed things up; in fact, it slows things down.

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 7f238af..1dba698 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -141,12 +141,6 @@
>  #define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
>  #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
>  #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
> -#define   PCIE_RC_CONFIG_LCS_RETRAIN_LINK	BIT(5)
> -#define   PCIE_RC_CONFIG_LCS_CCC		BIT(6)
> -#define   PCIE_RC_CONFIG_LCS_LBMIE		BIT(10)
> -#define   PCIE_RC_CONFIG_LCS_LABIE		BIT(11)
> -#define   PCIE_RC_CONFIG_LCS_LBMS		BIT(30)
> -#define   PCIE_RC_CONFIG_LCS_LAMS		BIT(31)
>  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
>  #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
>  #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
> @@ -229,7 +223,7 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
>  	u32 status;
>  
>  	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> -	status |= (PCIE_RC_CONFIG_LCS_LBMIE | PCIE_RC_CONFIG_LCS_LABIE);
> +	status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
>  	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>  }
>  
> @@ -238,7 +232,7 @@ static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
>  	u32 status;
>  
>  	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> -	status |= (PCIE_RC_CONFIG_LCS_LBMS | PCIE_RC_CONFIG_LCS_LAMS);
> +	status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
>  	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>  }
>  
> @@ -540,7 +534,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  
>  	/* Set RC's clock architecture as common clock */
>  	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> -	status |= PCIE_RC_CONFIG_LCS_CCC;
> +	status |= PCI_EXP_LNKCTL_CCC;
>  	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>  
>  	/* Enable Gen1 training */
> @@ -575,7 +569,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		 * gen1 finished.
>  		 */
>  		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> -		status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
> +		status |= PCI_EXP_LNKCTL_RL;
>  		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>  
>  		timeout = jiffies + msecs_to_jiffies(500);
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
