Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:34022 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932556AbbDVOGL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Apr 2015 10:06:11 -0400
Date: Wed, 22 Apr 2015 15:06:01 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Zhichang Yuan <yuanzhichang@hisilicon.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>
Subject: Re: [[PATCH v1]] of/pci: fix a bug in function pci_pio_to_address
Message-ID: <20150422140601.GK932@e106497-lin.cambridge.arm.com>
References: <1429709759-79006-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <1429709759-79006-1-git-send-email-yuanzhichang@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 22, 2015 at 02:35:59PM +0100, Zhichang Yuan wrote:
> In the patch whose commit id is 41f8bba7f5552d0, function pci_pio_to_address
> was introduced to retieve the corresponding I/O port by CPU address. But the
> convertion processing is not correct. It will return a wrong I/O port.
> This patch will fix it.
> 
> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Zhichang, you might want to Cc Greg KH for inclusion into stable.

Best regards,
Liviu

> ---
>  drivers/of/address.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 78a7dcb..6906a3f 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -765,7 +765,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
>  	spin_lock(&io_range_lock);
>  	list_for_each_entry(res, &io_range_list, list) {
>  		if (address >= res->start && address < res->start + res->size) {
> -			addr = res->start - address + offset;
> +			addr = address - res->start + offset;
>  			break;
>  		}
>  		offset += res->size;
> -- 
> 1.9.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

