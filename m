Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932987AbcJZUOa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 16:14:30 -0400
Date: Wed, 26 Oct 2016 15:07:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bhelgaas@google.com, Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] doc: add missing parameter for msi_setup
Message-ID: <20161026200701.GF17507@bhelgaas-glaptop.roam.corp.google.com>
References: <20161023093234.41f2d1fb@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161023093234.41f2d1fb@xeon-e3>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 23, 2016 at 09:32:34AM -0700, Stephen Hemminger wrote:
> From: Stephen Hemminger <sthemmin@microsoft.com>
> 
> commit 92ca8d20dee2 ("genirq/msi: Switch to new irq spreading")
> introduced new parameter to msi_init_setup and but did not update
> docbook comments. Fixes 'make htmldocs' warning.
> 
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>

Applied to pci/misc for v4.10, thanks, Stephen!

> ---
>  drivers/pci/msi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index bfdd074..ad70507 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -610,6 +610,7 @@ static int msi_verify_entries(struct pci_dev *dev)
>   * msi_capability_init - configure device's MSI capability structure
>   * @dev: pointer to the pci_dev data structure of MSI device function
>   * @nvec: number of interrupts to allocate
> + * @affinity: flag to indicate cpu irq affinity mask should be set
>   *
>   * Setup the MSI capability structure of the device with the requested
>   * number of interrupts.  A return value of zero indicates the successful
> @@ -752,6 +753,7 @@ static void msix_program_entries(struct pci_dev *dev,
>   * @dev: pointer to the pci_dev data structure of MSI-X device function
>   * @entries: pointer to an array of struct msix_entry entries
>   * @nvec: number of @entries
> + * @affinity: flag to indicate cpu irq affinity mask should be set
>   *
>   * Setup the MSI-X capability structure of device function with a
>   * single MSI-X irq. A return of zero indicates the successful setup of
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
