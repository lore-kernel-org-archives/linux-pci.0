Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55720 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbbLDWnj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 17:43:39 -0500
Date: Fri, 4 Dec 2015 16:43:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: wangzhou1@hisilicon.com, linux-pci@vger.kernel.org,
	bhelgaas@google.com, gabriele.paoloni@huawei.com,
	qiujiang@huawei.com, zhangjukuo@huawei.com, haifeng.wei@huawei.com,
	yisen.zhuang@huawei.com
Subject: Re: [PATCH] PCI: hisi: fix the hisi_pcie_cfg_read bug when size=4
Message-ID: <20151204224334.GL20125@localhost>
References: <1448600280-83695-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448600280-83695-1-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 27, 2015 at 12:58:00PM +0800, Dongdong Liu wrote:
> Current hisi_pcie_cfg_read code read the RC configuration space,
> this has a problem that the output parameter "*val" have not been
> assigned when size=4, so we fix the bug by "*val = reg_val" when size=4.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Wow, that's a pretty egregious bug.  Was the hisi driver ever tested
at all?  We use dword reads in pci_bus_read_dev_vendor_id() to
enumerate devices, so if those didn't return valid data, nothing at
all should have worked.

I tentatively put this on my for-linus branch for v4.4, but I wonder
whether it might be smarter to revert the driver completely until I
have more confidence in it.

What sort of testing have you done on this driver?

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
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
