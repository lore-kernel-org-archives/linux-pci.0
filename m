Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:60555 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbbK3F0T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2015 00:26:19 -0500
Subject: Re: [PATCH] PCI: hisi: fix the hisi_pcie_cfg_read bug when size=4
To: Dongdong Liu <liudongdong3@huawei.com>, <linux-pci@vger.kernel.org>
References: <1448600280-83695-1-git-send-email-liudongdong3@huawei.com>
CC: <bhelgaas@google.com>, <gabriele.paoloni@huawei.com>,
	<qiujiang@huawei.com>, <zhangjukuo@huawei.com>,
	<haifeng.wei@huawei.com>, <yisen.zhuang@huawei.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <565BDDBD.1040500@hisilicon.com>
Date: Mon, 30 Nov 2015 13:25:17 +0800
MIME-Version: 1.0
In-Reply-To: <1448600280-83695-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/11/27 12:58, Dongdong Liu wrote:
> Current hisi_pcie_cfg_read code read the RC configuration space,
> this has a problem that the output parameter "*val" have not been
> assigned when size=4, so we fix the bug by "*val = reg_val" when size=4.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Hi Dongdong,

Sorry for late. You are right, I made a mistake here. So
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>

Many thanks,
Zhou

> ---
>  drivers/pci/host/pcie-hisi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> index 35457ec..da677b1 100644
> --- a/drivers/pci/host/pcie-hisi.c
> +++ b/drivers/pci/host/pcie-hisi.c
> @@ -61,7 +61,9 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
>  		*val = *(u8 __force *) walker;
>  	else if (size == 2)
>  		*val = *(u16 __force *) walker;
> -	else if (size != 4)
> +	else if (size == 4)
> +		*val = reg_val;
> +	else
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	return PCIBIOS_SUCCESSFUL;
> 

