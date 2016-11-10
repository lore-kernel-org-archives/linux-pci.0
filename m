Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933521AbcKJW2v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 17:28:51 -0500
Date: Thu, 10 Nov 2016 16:28:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci/vmd: Update maintainers file
Message-ID: <20161110222846.GA12055@bhelgaas-glaptop.roam.corp.google.com>
References: <1478812244-5519-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478812244-5519-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 10, 2016 at 04:10:44PM -0500, Keith Busch wrote:
> Updating MAINTAINERS to reflect the new location of the vmd driver.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Applied to for-linus for v4.9, thanks, Keith.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 906e969..aefa6bf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9318,7 +9318,7 @@ PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
>  M:	Keith Busch <keith.busch@intel.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -F:	arch/x86/pci/vmd.c
> +F:	drivers/pci/host/vmd.c
>  
>  PCIE DRIVER FOR ST SPEAR13XX
>  M:	Pratyush Anand <pratyush.anand@gmail.com>
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
