Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33697 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbbIOQux (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 12:50:53 -0400
Received: by oixx17 with SMTP id x17so99059402oix.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2015 09:50:52 -0700 (PDT)
Date: Tue, 15 Sep 2015 11:50:49 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: jingoohan1@gmail.com, pratyush.anand@gmail.com,
	gabriele.paoloni@huawei.com, linux-pci@vger.kernel.org,
	qiuzhenfa@hisilicon.com, zhangjukuo@huawei.com,
	liudongdong3@huawei.com, qiujiang@huawei.com, xuwei5@hisilicon.com,
	liguozhu@hisilicon.com
Subject: Re: [PATCH v2] PCI: designware: Fix PORT_LOGIC_LINK_WIDTH_MASK
Message-ID: <20150915165049.GD25767@google.com>
References: <1440559054-231033-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440559054-231033-1-git-send-email-wangzhou1@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 26, 2015 at 11:17:34AM +0800, Zhou Wang wrote:
> The value under PORT_LOGIC_LINK_WIDTH_MASK is 0x1, 0x2, 0x4, 0x8. Here change
> this mask to proper value.
> 
> In IP v4.2, bits [16:8] are defined for NUM_OF_LANES. But in IP v4.4, bits[12:8]
> are defined for NUM_OF_LANES, bits [16:13] are for other usages(bit 16 is
> AUTO_LANE_FLIP_CTRL_EN, bits [15:13] are PRE_DET_LANE).
> 
> As there is no conflict about NUM_OF_LANES between v4.2 and v4.4, this patch
> change above mask value to avoid future problem.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>

Applied with Jingoo's ack to pci/host-designware for v4.4, thanks!

> ---
>  drivers/pci/host/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 69486be..eb549b9 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -35,7 +35,7 @@
>  
>  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
>  #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
> -#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1ff << 8)
> +#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
>  #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
>  #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
>  #define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
