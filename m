Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32952 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbbHZFAU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Aug 2015 01:00:20 -0400
Received: by pacti10 with SMTP id ti10so74866626pac.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2015 22:00:19 -0700 (PDT)
References: <1440559054-231033-1-git-send-email-wangzhou1@hisilicon.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1440559054-231033-1-git-send-email-wangzhou1@hisilicon.com>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <86AF9F47-2196-4408-8A89-BDF2ADF5F2EC@gmail.com>
Cc: "<pratyush.anand@gmail.com>" <pratyush.anand@gmail.com>,
	"<gabriele.paoloni@huawei.com>" <gabriele.paoloni@huawei.com>,
	"<linux-pci@vger.kernel.org>" <linux-pci@vger.kernel.org>,
	"<qiuzhenfa@hisilicon.com>" <qiuzhenfa@hisilicon.com>,
	"<zhangjukuo@huawei.com>" <zhangjukuo@huawei.com>,
	"<liudongdong3@huawei.com>" <liudongdong3@huawei.com>,
	"<qiujiang@huawei.com>" <qiujiang@huawei.com>,
	"<xuwei5@hisilicon.com>" <xuwei5@hisilicon.com>,
	"<liguozhu@hisilicon.com>" <liguozhu@hisilicon.com>,
	jingoohan1@gmail.com
From: Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v2] PCI: designware: Fix PORT_LOGIC_LINK_WIDTH_MASK
Date: Wed, 26 Aug 2015 14:00:10 +0900
To: Zhou Wang <wangzhou1@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015. 8. 26., at PM 12:17, Zhou Wang <wangzhou1@hisilicon.com> wrote:
> 
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

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
> drivers/pci/host/pcie-designware.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 69486be..eb549b9 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -35,7 +35,7 @@
> 
> #define PCIE_LINK_WIDTH_SPEED_CONTROL    0x80C
> #define PORT_LOGIC_SPEED_CHANGE        (0x1 << 17)
> -#define PORT_LOGIC_LINK_WIDTH_MASK    (0x1ff << 8)
> +#define PORT_LOGIC_LINK_WIDTH_MASK    (0x1f << 8)
> #define PORT_LOGIC_LINK_WIDTH_1_LANES    (0x1 << 8)
> #define PORT_LOGIC_LINK_WIDTH_2_LANES    (0x2 << 8)
> #define PORT_LOGIC_LINK_WIDTH_4_LANES    (0x4 << 8)
> -- 
> 1.9.1
> 
