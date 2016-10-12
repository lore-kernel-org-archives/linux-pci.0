Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754770AbcJLMSv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:18:51 -0400
Date: Wed, 12 Oct 2016 07:18:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] PCI: rockchip: Indent an if statement
Message-ID: <20161012121845.GA21211@localhost>
References: <20161012105409.GA19070@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012105409.GA19070@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 01:54:09PM +0300, Dan Carpenter wrote:
> The if statement wasn't intended.  Add a tab.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to pci/host-rockchip for v4.9, thanks, Dan.

> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index b8c82fc..f54ef1e 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -972,7 +972,7 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie *rockchip,
>  		return -EINVAL;
>  	if (region_no == 0) {
>  		if (AXI_REGION_0_SIZE < (2ULL << num_pass_bits))
> -		return -EINVAL;
> +			return -EINVAL;
>  	}
>  	if (region_no != 0) {
>  		if (AXI_REGION_SIZE < (2ULL << num_pass_bits))
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
