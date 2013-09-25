Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:64189 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab3IYAFM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2013 20:05:12 -0400
Received: by mail-yh0-f42.google.com with SMTP id z12so2353256yhz.15
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2013 17:05:11 -0700 (PDT)
Date: Tue, 24 Sep 2013 18:05:08 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix comment typo for PCI_EXP_LNKCTL_LABIE
Message-ID: <20130925000508.GE9302@google.com>
References: <000001ceb2b0$ea66ffd0$bf34ff70$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001ceb2b0$ea66ffd0$bf34ff70$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 16, 2013 at 04:46:55PM +0900, Jingoo Han wrote:
> Fix trivial typo for PCI_EXP_LNKCTL_LABIE comment.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  include/uapi/linux/pci_regs.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index baa7852..18384bc 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -485,7 +485,7 @@
>  #define  PCI_EXP_LNKCTL_CLKREQ_EN 0x0100 /* Enable clkreq */
>  #define  PCI_EXP_LNKCTL_HAWD	0x0200	/* Hardware Autonomous Width Disable */
>  #define  PCI_EXP_LNKCTL_LBMIE	0x0400	/* Link Bandwidth Management Interrupt Enable */
> -#define  PCI_EXP_LNKCTL_LABIE	0x0800	/* Lnk Autonomous Bandwidth Interrupt Enable */
> +#define  PCI_EXP_LNKCTL_LABIE	0x0800	/* Link Autonomous Bandwidth Interrupt Enable */

I had already included this change in a large comment/whitespace cleanup
before I read this, so this should appear in v3.13.  Thanks!

>  #define PCI_EXP_LNKSTA		18	/* Link Status */
>  #define  PCI_EXP_LNKSTA_CLS	0x000f	/* Current Link Speed */
>  #define  PCI_EXP_LNKSTA_CLS_2_5GB 0x0001 /* Current Link Speed 2.5GT/s */
> -- 
> 1.7.10.4
> 
> 
