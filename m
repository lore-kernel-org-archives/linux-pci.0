Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030394AbdIZVaw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Sep 2017 17:30:52 -0400
Date: Tue, 26 Sep 2017 16:30:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sascha El-Sharkawy <elscha@sse.uni-hildesheim.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Avoid non working configurations for
 PCI_REALLOC_ENABLE_AUTO
Message-ID: <20170926213050.GT15970@bhelgaas-glaptop.roam.corp.google.com>
References: <F6127EC53C695C46907CD6EE43F346235291129068@messagesink.samelson.uni-hildesheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F6127EC53C695C46907CD6EE43F346235291129068@messagesink.samelson.uni-hildesheim.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 20, 2017 at 08:44:20AM +0200, Sascha El-Sharkawy wrote:
> Ensure only valid Kconfig configurations for PCI_REALLOC_ENABLE_AUTO. This
> is done by selecting PCI_IOV, which is required by PCI_REALLOC_ENABLE_AUTO
> to work.
> 
> Signed-off-by:  Sascha El-Sharkawy <elscha@sse.uni-hildesheim.de>

Applied to pci/virtualization for v4.15, thanks!

I had to apply this manually because it wasn't plain ASCII and had CR
line endings.  But this was small enough to do by hand :)

> ---
>  drivers/pci/Kconfig |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig index c32a77fc8b03..675d79c52709 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -42,13 +42,13 @@ config PCI_DEBUG
>  config PCI_REALLOC_ENABLE_AUTO
>  	bool "Enable PCI resource re-allocation detection"
>  	depends on PCI
> +	depends on PCI_IOV
>  	help
>  	  Say Y here if you want the PCI core to detect if PCI resource
>  	  re-allocation needs to be enabled. You can always use pci=realloc=on
> -          or pci=realloc=off to override it.  Note this feature is a no-op
> -          unless PCI_IOV support is also enabled; in that case it will
> -          automatically re-allocate PCI resources if SR-IOV BARs have not
> -          been allocated by the BIOS.
> +	  or pci=realloc=off to override it.  It will automatically
> +	  re-allocate PCI resources if SR-IOV BARs have not been allocated by
> +	  the BIOS.
>  
>  	  When in doubt, say N.
> 
