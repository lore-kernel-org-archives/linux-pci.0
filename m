Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:46160 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbaGERzC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jul 2014 13:55:02 -0400
Received: by mail-ig0-f180.google.com with SMTP id h18so3137830igc.13
        for <linux-pci@vger.kernel.org>; Sat, 05 Jul 2014 10:55:01 -0700 (PDT)
Date: Sat, 5 Jul 2014 11:54:58 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	rmk+kernel@arm.linux.org.uk, linux-pci@vger.kernel.org
Subject: Re: [PATCH 09/13] PCI: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
Message-ID: <20140705175458.GF26618@google.com>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
 <1404075603-31838-12-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404075603-31838-12-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 29, 2014 at 10:59:58PM +0200, Andrew Lunn wrote:
> mach-kirkwood and mach-dove have been removed, now that these SoCs
> lives in mach-mvebu. ARCH_MVEBU is sufficient.

Looks like there's still discussion about the cubox regression, so
I'll wait until that's resolved and Thomas or Jason ack this.

> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 21df477be0c8..b9692deeb99a 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -3,7 +3,7 @@ menu "PCI host controller drivers"
>  
>  config PCI_MVEBU
>  	bool "Marvell EBU PCIe controller"
> -	depends on ARCH_MVEBU || ARCH_DOVE || ARCH_KIRKWOOD
> +	depends on ARCH_MVEBU
>  	depends on OF
>  
>  config PCIE_DW
> -- 
> 2.0.0
> 
