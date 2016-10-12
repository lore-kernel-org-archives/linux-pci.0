Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:35679 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbcJLLEX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2016 07:04:23 -0400
Subject: Re: [patch] PCI: rockchip: Indent an if statement
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <20161012105409.GA19070@mwanda>
Cc: shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
        kernel-janitors@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <2916ad6b-e6a4-b221-5820-c1c5f9387f76@rock-chips.com>
Date: Wed, 12 Oct 2016 19:04:11 +0800
MIME-Version: 1.0
In-Reply-To: <20161012105409.GA19070@mwanda>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/10/12 18:54, Dan Carpenter wrote:
> The if statement wasn't intended.  Add a tab.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for this patch.

Currently the driver is under cleanup, so it would be fine
for Bjorn to pick it up for host-rockchip branch. :)

>
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
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>


-- 
Best Regards
Shawn Lin

