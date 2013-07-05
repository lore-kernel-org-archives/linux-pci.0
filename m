Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44335 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab3GEVLk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jul 2013 17:11:40 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so6304517ieb.30
        for <linux-pci@vger.kernel.org>; Fri, 05 Jul 2013 14:11:39 -0700 (PDT)
Date: Fri, 5 Jul 2013 15:11:36 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pci@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] PCI: PCIE: Rename option title to something less
 confusing
Message-ID: <20130705211136.GA16551@google.com>
References: <1372970720-14016-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372970720-14016-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 04, 2013 at 05:45:20PM -0300, Ezequiel Garcia wrote:
> The previous option title "PCI Express support" is confusing.
> The name seems to imply this option is required to get PCIe support,
> which is not true.
> 
> Fix it to "PCI Express Port Bus support" which is more accurate.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Applied to pci/misc for v3.12, thanks!  I'll rebase and push this branch
after v3.11-rc1 is released.

> ---
>  drivers/pci/pcie/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 569f82f..a82e70a 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -2,7 +2,7 @@
>  # PCI Express Port Bus Configuration
>  #
>  config PCIEPORTBUS
> -	bool "PCI Express support"
> +	bool "PCI Express Port Bus support"
>  	depends on PCI
>  	help
>  	  This automatically enables PCI Express Port Bus support. Users can
> -- 
> 1.8.1.5
> 
