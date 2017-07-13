Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750933AbdGMDaG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jul 2017 23:30:06 -0400
Date: Wed, 12 Jul 2017 22:30:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH] PCI: altera: remove unused num_of_vectors variable
Message-ID: <20170713033003.GH4486@bhelgaas-glaptop.roam.corp.google.com>
References: <1499853076-71180-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499853076-71180-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 12, 2017 at 05:51:16PM +0800, Shawn Lin wrote:
> It was never used and could be removed, otherwise
> we could see a warning:
> 
> drivers/pci/host/pcie-altera-msi.c: In function 'altera_msi_isr':
> drivers/pci/host/pcie-altera-msi.c:67:6: warning: variable
> 'num_of_vectors' set but not used [-Wunused-but-set-variable]
> 
> Cc: Ley Foon Tan <lftan@altera.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-altera for v4.14, thanks!

> ---
> 
>  drivers/pci/host/pcie-altera-msi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/host/pcie-altera-msi.c
> index 4e5d628..2864030 100644
> --- a/drivers/pci/host/pcie-altera-msi.c
> +++ b/drivers/pci/host/pcie-altera-msi.c
> @@ -64,13 +64,11 @@ static void altera_msi_isr(struct irq_desc *desc)
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	struct altera_msi *msi;
>  	unsigned long status;
> -	u32 num_of_vectors;
>  	u32 bit;
>  	u32 virq;
>  
>  	chained_irq_enter(chip, desc);
>  	msi = irq_desc_get_handler_data(desc);
> -	num_of_vectors = msi->num_of_vectors;
>  
>  	while ((status = msi_readl(msi, MSI_STATUS)) != 0) {
>  		for_each_set_bit(bit, &status, msi->num_of_vectors) {
> -- 
> 1.9.1
> 
> 
