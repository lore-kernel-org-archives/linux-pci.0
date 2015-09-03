Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38124 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbbICU7w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2015 16:59:52 -0400
Received: by igbut12 with SMTP id ut12so1565480igb.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2015 13:59:51 -0700 (PDT)
Date: Thu, 3 Sep 2015 15:59:43 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: linux-pci@vger.kernel.org, wangzhou1@hisilicon.com,
	jingoohan1@gmail.com, pratyush.anand@gmail.com,
	yuanzhichang@hisilicon.com, zhudacai@hisilicon.com,
	zhangjukuo@huawei.com, qiuzhenfa@hisilicon.com,
	liguozhu@hisilicon.com
Subject: Re: [PATCH] PCI: designware: fix dw_pcie_cfg_write
Message-ID: <20150903205943.GJ829@google.com>
References: <1440079113-165527-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440079113-165527-1-git-send-email-gabriele.paoloni@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 20, 2015 at 09:58:33PM +0800, Gabriele Paoloni wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> Currently in dw_pcie_cfg_write() if the input size is 2 bytes
> the address offset is wrongly calculated as we mask also bit0
> of "where" input parameter. Instead we should mask all bits of
> "where" except bit0 and bit1.

I think there are two problems in this area:

1) Most calls of dw_pcie_cfg_write() are of the form:

    dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, ...)
    dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3), where, ...)

   This is needlessly repetitive because the caller has to mention
   "where" twice and do the masking itself.  We could simply pass
   "pp->dbi_base" and "where" and let dw_pcie_cfg_write() do all the
   required masking internally.

2) Pratyush, this one's for you :)  spear13xx_pcie_establish_link()
   calls dw_pcie_cfg_read() and dw_pcie_cfg_write() several times like
   this:

    dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, ...)
    dw_pcie_cfg_write(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, ...)

   I think these are incorrect because dw_pcie_cfg_read() and
   dw_pcie_cfg_write() don't add anything to the "addr" argument
   ("pp->dbi_base" in this case) except the 0-3 byte select offset, so
   they use the correct alignment, but access the wrong registers.

As far as the original patch below, I don't think I have a strong
opinion either way.  You could consider doing something like:

  if (size == 4) {
    if (addr & 3) return PCIBIOS_BAD_REGISTER_NUMBER;
    writel(val, addr);
  } else if (size == 2) {
    if (addr & 1) return PCIBIOS_BAD_REGISTER_NUMBER;
    writew(val, addr);
  } ...

This is similar to what we do in pci_bus_write_config_word() (see
drivers/pci/access.c).

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
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
