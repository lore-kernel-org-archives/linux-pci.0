Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35319 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753157AbcJTBj3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2016 21:39:29 -0400
Received: by mail-pf0-f180.google.com with SMTP id s8so25627780pfj.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2016 18:39:29 -0700 (PDT)
Date: Wed, 19 Oct 2016 18:39:26 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: fix wrong print for negotiated lane
 numbers
Message-ID: <20161020013925.GD78840@google.com>
References: <1476321391-6665-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476321391-6665-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 13, 2016 at 09:16:31AM +0800, Shawn Lin wrote:
> The negotiated lane numbers was incorrectly calculated, fix it.
> 
> Fixes: e77f847df54c6b0 ("PCI: rockchip: Add Rockchip PCIe controller support")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index e0b22da..0d69d8c 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -549,7 +549,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  
>  	/* Check the final link width from negotiated lane counter from MGMT */
>  	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
> -	status =  0x1 << ((status & PCIE_CORE_PL_CONF_LANE_MASK) >>
> +	status =  0x1 << ((status >> PCIE_CORE_PL_CONF_LANE_SHIFT) &
>  			  PCIE_CORE_PL_CONF_LANE_MASK);
>  	dev_dbg(dev, "current link width is x%d\n", status);
>  

Looks good to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
