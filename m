Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:3352 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbbHUByg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2015 21:54:36 -0400
Message-ID: <55D68405.1000901@hisilicon.com>
Date: Fri, 21 Aug 2015 09:51:01 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<yuanzhichang@hisilicon.com>, <zhudacai@hisilicon.com>,
	<zhangjukuo@huawei.com>, <qiuzhenfa@hisilicon.com>,
	<liguozhu@hisilicon.com>
Subject: Re: [PATCH] PCI: designware: fix dw_pcie_cfg_write
References: <1440079113-165527-1-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1440079113-165527-1-git-send-email-gabriele.paoloni@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/8/20 21:58, Gabriele Paoloni wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> Currently in dw_pcie_cfg_write() if the input size is 2 bytes
> the address offset is wrongly calculated as we mask also bit0
> of "where" input parameter. Instead we should mask all bits of
> "where" except bit0 and bit1.
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  drivers/pci/host/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 69486be..a27f536 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -99,7 +99,7 @@ int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
>  	if (size == 4)
>  		writel(val, addr);
>  	else if (size == 2)
> -		writew(val, addr + (where & 2));
> +		writew(val, addr + (where & 3));
>  	else if (size == 1)
>  		writeb(val, addr + (where & 3));
>  	else
> 

Hi Jingoo,

Is there some special consideration? If we miss something, please let us know.

Thanks,
Zhou

