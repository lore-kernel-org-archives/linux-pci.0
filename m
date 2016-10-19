Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35656 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942726AbcJSRmI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2016 13:42:08 -0400
Received: by mail-pf0-f179.google.com with SMTP id s8so19632927pfj.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2016 10:42:08 -0700 (PDT)
Date: Wed, 19 Oct 2016 10:42:05 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: remove the pointer to L1 substate cap
Message-ID: <20161019174205.GA78840@google.com>
References: <1476868234-15135-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476868234-15135-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wed, Oct 19, 2016 at 05:10:34PM +0800, Shawn Lin wrote:
> Per the errata of TRM, the RC can't support L1 substate, so we
> need to remove the L1 substate cap.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index e0b22da..8370a85 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -142,6 +142,8 @@
>  #define   PCIE_RC_CONFIG_LCS_LBMS		BIT(30)
>  #define   PCIE_RC_CONFIG_LCS_LAMS		BIT(31)
>  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
> +#define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
> +#define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
>  
>  #define PCIE_CORE_AXI_CONF_BASE		0xc00000
>  #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
> @@ -558,6 +560,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip,
>  			    PCI_CLASS_BRIDGE_PCI << PCIE_RC_CONFIG_SCC_SHIFT,
>  			    PCIE_RC_CONFIG_RID_CCR);
> +
> +	/* Clear THP cap's next cap pointer to remove L1 substate cap */
> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_THP_CAP);
> +	status &= ~PCIE_RC_CONFIG_THP_CAP_NEXT_MASK;
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_THP_CAP);
> +

Tested-by: Brian Norris <briannorris@chromium.org>

>  	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
>  
>  	rockchip_pcie_write(rockchip,

You could also probably do away with the handling of L1 substates here,
since they're officially declared broken:

        /*
         * We need to read/write PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 before
         * enabling ASPM.  Otherwise L1PwrOnSc and L1PwrOnVal isn't
         * reliable and enabling ASPM doesn't work.  This is a controller
         * bug we need to work around.
         */
        status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
        rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
