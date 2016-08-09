Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34974 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419AbcHIQ5X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Aug 2016 12:57:23 -0400
Date: Tue, 9 Aug 2016 11:57:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Drop CONFIG_KEXEC_CORE ifdeffery
Message-ID: <20160809165717.GC27301@localhost>
References: <0be33af4eef7e2ef328360c3622bb0581e69f437.1470735088.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0be33af4eef7e2ef328360c3622bb0581e69f437.1470735088.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 09, 2016 at 11:53:11AM +0200, Lukas Wunner wrote:
> Commit 2b94ed245861 ("kexec: define kexec_in_progress in !CONFIG_KEXEC
> case") has made this unnecessary.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/misc for v4.9, thanks, Lukas!

> ---
>  drivers/pci/pci-driver.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index e39a67c..edd78e0 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -466,7 +466,6 @@ static void pci_device_shutdown(struct device *dev)
>  	pci_msi_shutdown(pci_dev);
>  	pci_msix_shutdown(pci_dev);
>  
> -#ifdef CONFIG_KEXEC_CORE
>  	/*
>  	 * If this is a kexec reboot, turn off Bus Master bit on the
>  	 * device to tell it to not continue to do DMA. Don't touch
> @@ -476,7 +475,6 @@ static void pci_device_shutdown(struct device *dev)
>  	 */
>  	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
>  		pci_clear_master(pci_dev);
> -#endif
>  }
>  
>  #ifdef CONFIG_PM
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
