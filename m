Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33998 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbbGOUOU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2015 16:14:20 -0400
Received: by iebmu5 with SMTP id mu5so41655867ieb.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 13:14:19 -0700 (PDT)
Date: Wed, 15 Jul 2015 15:14:14 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: linux-pci@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] PCI / ACPI: Fix pci_acpi_optimize_delay() comment
Message-ID: <20150715201414.GA25591@google.com>
References: <20150715092915.GA8262@intel-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150715092915.GA8262@intel-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Aaron]

On Wed, Jul 15, 2015 at 02:59:46PM +0530, Srinidhi Kasagar wrote:
> The function takes ACPI handle, not the device itself. Fix the
> comment
> 
> Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>

Applied to pci/misc for v4.3, thanks!

> ---
> Add this as part of your trivial commenting fixes patch series
> 
>  drivers/pci/pci-acpi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 6f6f175f51f7..d2e2bf4ef0a4 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -594,7 +594,7 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
>  /**
>   * pci_acpi_optimize_delay - optimize PCI D3 and D3cold delay from ACPI
>   * @pdev: the PCI device whose delay is to be updated
> - * @adev: the companion ACPI device of this PCI device
> + * @handle: ACPI handle of this device
>   *
>   * Update the d3_delay and d3cold_delay of a PCI device from the ACPI _DSM
>   * control method of either the device itself or the PCI host bridge.
> -- 
> 1.7.9.5
> 
> 
> -- 
