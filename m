Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60479 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964886AbcBQRc3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Feb 2016 12:32:29 -0500
Date: Wed, 17 Feb 2016 11:32:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PATCH] MAINTAINERS: Update EEH details and maintainership
Message-ID: <20160217173224.GA28147@localhost>
References: <1455689164-12128-1-git-send-email-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455689164-12128-1-git-send-email-ruscur@russell.cc>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 17, 2016 at 05:06:04PM +1100, Russell Currey wrote:
> Enhanced Error Handling could mean anything in the context of the entire
> kernel, so change the name to reference that it is both for PCI and
> powerpc.
> 
> EEH covers a bit more than the previously listed files, so add the headers
> and platform-specific code to the EEH maintained section.
> 
> In addition, I am taking over the maintainership.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>

This is fine with me.  I expect it will be merged via the powerpc tree,
since I think that's how all of Gavin Shan's recent patches in this area
are being handled.

> ---
>  MAINTAINERS | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28eb61b..95d999e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4222,13 +4222,6 @@ M:	Maxim Levitsky <maximlevitsky@gmail.com>
>  S:	Maintained
>  F:	drivers/media/rc/ene_ir.*
>  
> -ENHANCED ERROR HANDLING (EEH)
> -M:	Gavin Shan <shangw@linux.vnet.ibm.com>
> -L:	linuxppc-dev@lists.ozlabs.org
> -S:	Supported
> -F:	Documentation/powerpc/eeh-pci-error-recovery.txt
> -F:	arch/powerpc/kernel/eeh*.c
> -
>  EPSON S1D13XXX FRAMEBUFFER DRIVER
>  M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
>  S:	Maintained
> @@ -8244,6 +8237,15 @@ L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.txt
>  
> +PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> +M:	Russell Currey <ruscur@russell.cc>
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Supported
> +F:	Documentation/powerpc/eeh-pci-error-recovery.txt
> +F:	arch/powerpc/kernel/eeh*.c
> +F:	arch/powerpc/platforms/*/eeh*.c
> +F:	arch/powerpc/include/*/eeh*.h
> +
>  PCI SUBSYSTEM
>  M:	Bjorn Helgaas <bhelgaas@google.com>
>  L:	linux-pci@vger.kernel.org
> -- 
> 2.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
