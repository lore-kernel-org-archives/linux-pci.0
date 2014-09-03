Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40140 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934534AbaICWu4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Sep 2014 18:50:56 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so12122669pdj.32
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2014 15:50:54 -0700 (PDT)
Date: Wed, 3 Sep 2014 16:51:30 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: thierry.reding@gmail.com, swarren@wwwdotorg.org,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: tegra: add missing cleanup in error path and
 teardown_irq
Message-ID: <20140903225130.GE26073@google.com>
References: <1406597610-6748-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406597610-6748-1-git-send-email-jszhang@marvell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 29, 2014 at 09:33:30AM +0800, Jisheng Zhang wrote:
> We should call tegra_msi_free() to free the MSI bit if
> irq_create_mapping() fails. And we need to dispose the IRQ mapping
> during IRQ teardown.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to pci/host-tegra for v3.18, with the irqd_to_hwirq() change
Thierry suggested and his Reviewed-by and Ack, thanks!

> ---
>  drivers/pci/host/pci-tegra.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 083cf37..4ccc418 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -1203,8 +1203,10 @@ static int tegra_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
>  		return hwirq;
>  
>  	irq = irq_create_mapping(msi->domain, hwirq);
> -	if (!irq)
> +	if (!irq) {
> +		tegra_msi_free(msi, hwirq);
>  		return -EINVAL;
> +	}
>  
>  	irq_set_msi_desc(irq, desc);
>  
> @@ -1222,8 +1224,10 @@ static void tegra_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
>  {
>  	struct tegra_msi *msi = to_tegra_msi(chip);
>  	struct irq_data *d = irq_get_irq_data(irq);
> +	unsigned long hwirq = d->hwirq;
>  
> -	tegra_msi_free(msi, d->hwirq);
> +	irq_dispose_mapping(irq);
> +	tegra_msi_free(msi, hwirq);
>  }
>  
>  static struct irq_chip tegra_msi_irq_chip = {
> -- 
> 2.0.1
> 
