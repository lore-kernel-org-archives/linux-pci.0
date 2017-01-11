Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755062AbdAKVPn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jan 2017 16:15:43 -0500
Date: Wed, 11 Jan 2017 15:15:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: fix msi.c kernel-doc warnings
Message-ID: <20170111211506.GM14532@bhelgaas-glaptop.roam.corp.google.com>
References: <35dfbd78-99a3-39b8-3d67-6f0916d6504e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35dfbd78-99a3-39b8-3d67-6f0916d6504e@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 28, 2016 at 08:25:04AM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warnings in pci/msi.c:
> 
> ..//drivers/pci/msi.c:623: warning: No description found for parameter 'affd'
> ..//drivers/pci/msi.c:623: warning: Excess function parameter 'affinity' description in 'msi_capability_init'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, applied to pci/msi for v4.11 with this changelog:

    PCI/MSI: Fix msi_capability_init() kernel-doc warnings
    
    Fix kernel-doc warnings in pci/msi.c:
    
      ..//drivers/pci/msi.c:623: warning: No description found for parameter 'affd'
      ..//drivers/pci/msi.c:623: warning: Excess function parameter 'affinity' description in 'msi_capability_init'
    
    Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-410-rc1.orig/drivers/pci/msi.c
> +++ lnx-410-rc1/drivers/pci/msi.c
> @@ -610,7 +610,7 @@ static int msi_verify_entries(struct pci
>   * msi_capability_init - configure device's MSI capability structure
>   * @dev: pointer to the pci_dev data structure of MSI device function
>   * @nvec: number of interrupts to allocate
> - * @affinity: flag to indicate cpu irq affinity mask should be set
> + * @affd: description of automatic irq affinity assignments (may be %NULL)
>   *
>   * Setup the MSI capability structure of the device with the requested
>   * number of interrupts.  A return value of zero indicates the successful
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
