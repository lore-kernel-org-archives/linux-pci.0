Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:53228 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3HIRIO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 13:08:14 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so5141705pab.35
        for <linux-pci@vger.kernel.org>; Fri, 09 Aug 2013 10:08:13 -0700 (PDT)
Date: Fri, 9 Aug 2013 11:08:09 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Lior Amsalem <alior@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: make Marvell PCIe driver depend on OF
Message-ID: <20130809170809.GB29690@google.com>
References: <1376044550-30572-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376044550-30572-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 09, 2013 at 12:35:50PM +0200, Thomas Petazzoni wrote:
> The Marvell PCIe host controller driver is heavily tied to Device Tree
> APIs, and can only be used on platforms where the Device Tree is
> used. Therefore, it should "depends on OF" to avoid build failures on
> !OF configurations.
> 
> Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Bjorn, you can take this one through your tree. Either for 3.11 or
> 3.12, at your preference.

Applied to pci/misc for v3.12, thanks!

> ---
>  drivers/pci/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 1184ff6..e5ba4eb 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -4,6 +4,7 @@ menu "PCI host controller drivers"
>  config PCI_MVEBU
>  	bool "Marvell EBU PCIe controller"
>  	depends on ARCH_MVEBU || ARCH_KIRKWOOD
> +	depends on OF
>  
>  config PCIE_DW
>  	bool
> -- 
> 1.8.1.2
> 
