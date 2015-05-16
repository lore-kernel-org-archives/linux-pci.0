Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34611 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbbEPQGs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 May 2015 12:06:48 -0400
Received: by ieczm2 with SMTP id zm2so71282561iec.1
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2015 09:06:47 -0700 (PDT)
Date: Sat, 16 May 2015 11:06:44 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Zhichang Yuan <yuanzhichang@hisilicon.com>
Cc: grant.likely@linaro.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org, gabriele.paoloni@huawei.com,
	Liviu.Dudau@arm.com
Subject: Re: [PATCH v2] of/pci: fix a bug in function pci_pio_to_address
Message-ID: <20150516160644.GL31666@google.com>
References: <1429866309-202444-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429866309-202444-1-git-send-email-yuanzhichang@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 24, 2015 at 05:05:09PM +0800, Zhichang Yuan wrote:
> In the patch whose commit id is 41f8bba7f5552d0, function pci_pio_to_address
> was modified to retieve the corresponding I/O port by CPU physical address.
> But the convertion processing is not correct. It will return a wrong I/O port.
> This patch will fix it.

Argh.  As I mentioned for v1, your patch changes pci_address_to_pio(),
but your patch title and changelog mentions pci_pio_to_address().

I fixed it for you, added Liviu's ack, and applied it to pci/host-generic
for v4.2.

The original change (41f8bba7f555) went through my tree because it was part
of a series that added arm64 PCI support, so maybe it makes sense for this
fix to go through my tree, too.  But if you'd rather send it through the OF
tree, that's fine with me.  Just let me know.

> Fixes: 41f8bba7f555 ("of/pci: Add pci_register_io_range() and pci_pio_to_address()")
> CC: stable@vger.kernel.org
> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
> ---
> changes since V1:
> Improved commit message.
> 
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
