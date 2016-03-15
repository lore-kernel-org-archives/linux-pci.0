Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55816 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934783AbcCONsO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Mar 2016 09:48:14 -0400
Date: Tue, 15 Mar 2016 08:48:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andreas Ziegler <andreas.ziegler@fau.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: cleanup pci/pcie/Kconfig
Message-ID: <20160315134810.GB19974@localhost>
References: <1458041312-11317-1-git-send-email-andreas.ziegler@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458041312-11317-1-git-send-email-andreas.ziegler@fau.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 15, 2016 at 12:28:32PM +0100, Andreas Ziegler wrote:
> This change cleans up style issues in drivers/pci/pcie/Kconfig, in
> particular all indentation is now done using tabs, not spaces, and
> the definition of PCIEASPM_DEBUG is now separated from the definition
> of PCIEASPM with a newline.
> 
> Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>

Applied to pci/kconfig for v4.6, thanks, Andreas!

> ---
>  drivers/pci/pcie/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index e294713..72db7f4 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -44,6 +44,7 @@ config PCIEASPM
>  	  /sys/module/pcie_aspm/parameters/policy
>  
>  	  When in doubt, say Y.
> +
>  config PCIEASPM_DEBUG
>  	bool "Debug PCI Express ASPM"
>  	depends on PCIEASPM
> @@ -58,20 +59,20 @@ choice
>  	depends on PCIEASPM
>  
>  config PCIEASPM_DEFAULT
> -        bool "BIOS default"
> +	bool "BIOS default"
>  	depends on PCIEASPM
>  	help
>  	  Use the BIOS defaults for PCI Express ASPM.
>  
>  config PCIEASPM_POWERSAVE
> -        bool "Powersave"
> +	bool "Powersave"
>  	depends on PCIEASPM
>  	help
>  	  Enable PCI Express ASPM L0s and L1 where possible, even if the
>  	  BIOS did not.
>  
>  config PCIEASPM_PERFORMANCE
> -        bool "Performance"
> +	bool "Performance"
>  	depends on PCIEASPM
>  	help
>  	  Disable PCI Express ASPM L0s and L1, even if the BIOS enabled them.
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
