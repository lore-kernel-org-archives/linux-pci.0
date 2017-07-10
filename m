Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754641AbdGJVCO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 17:02:14 -0400
Date: Mon, 10 Jul 2017 16:02:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI; trivial fix for the comment of pci_vpd_srdt_{size,
 tag}
Message-ID: <20170710210209.GC5610@bhelgaas-glaptop.roam.corp.google.com>
References: <1499134595-46917-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499134595-46917-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 04, 2017 at 10:16:35AM +0800, Shawn Lin wrote:
> The comment doesn't match the argument, so fix them.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/trivial for v4.14, thanks!

> ---
> 
>  include/linux/pci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index bd68ed1..a360315 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2066,7 +2066,7 @@ static inline u16 pci_vpd_lrdt_tag(const u8 *lrdt)
>  
>  /**
>   * pci_vpd_srdt_size - Extracts the Small Resource Data Type length
> - * @lrdt: Pointer to the beginning of the Small Resource Data Type tag
> + * @srdt: Pointer to the beginning of the Small Resource Data Type tag
>   *
>   * Returns the extracted Small Resource Data Type length.
>   */
> @@ -2077,7 +2077,7 @@ static inline u8 pci_vpd_srdt_size(const u8 *srdt)
>  
>  /**
>   * pci_vpd_srdt_tag - Extracts the Small Resource Data Type Tag Item
> - * @lrdt: Pointer to the beginning of the Small Resource Data Type tag
> + * @srdt: Pointer to the beginning of the Small Resource Data Type tag
>   *
>   * Returns the extracted Small Resource Data Type Tag Item.
>   */
> -- 
> 1.9.1
> 
> 
