Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeILRPx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Sep 2018 13:15:53 -0400
Date: Wed, 12 Sep 2018 07:11:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joshua Abraham <j.abraham1776@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drivers: pci: remove set but unused variable
Message-ID: <20180912121137.GE118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180912023908.GA5549@josh-ThinkPad-T460s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180912023908.GA5549@josh-ThinkPad-T460s>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 11, 2018 at 04:39:08PM -1000, Joshua Abraham wrote:
> This patch removes a set but unused variable in quirks.c.
> 
> Fixes warning:
> variable ‘mmio_sys_info’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Joshua Abraham <j.abraham1776@gmail.com>

Applied to pci/misc for v4.20, thanks!

> ---
>  drivers/pci/quirks.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ef7143a274e0..690a3b71aa1f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4993,7 +4993,6 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
>  	void __iomem *mmio;
>  	struct ntb_info_regs __iomem *mmio_ntb;
>  	struct ntb_ctrl_regs __iomem *mmio_ctrl;
> -	struct sys_info_regs __iomem *mmio_sys_info;
>  	u64 partition_map;
>  	u8 partition;
>  	int pp;
> @@ -5014,7 +5013,6 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
>  
>  	mmio_ntb = mmio + SWITCHTEC_GAS_NTB_OFFSET;
>  	mmio_ctrl = (void __iomem *) mmio_ntb + SWITCHTEC_NTB_REG_CTRL_OFFSET;
> -	mmio_sys_info = mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
>  
>  	partition = ioread8(&mmio_ntb->partition_id);
>  
> -- 
> 2.17.1
> 
