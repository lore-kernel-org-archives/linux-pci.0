Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755075AbdCWNpX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Mar 2017 09:45:23 -0400
Date: Thu, 23 Mar 2017 08:45:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: Re: [PATCH] PCI: Pull struct pci_ops definition
Message-ID: <20170323134519.GA22914@bhelgaas-glaptop.roam.corp.google.com>
References: <13b87220-8aab-3a80-1d74-8e31d2d59e20@sigmadesigns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13b87220-8aab-3a80-1d74-8e31d2d59e20@sigmadesigns.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 17, 2017 at 03:53:19PM +0100, Marc Gonzalez wrote:
> struct pci_ecam_ops embeds a struct pci_ops. Explicitly request the
> definition for struct pci_ops, otherwise gcc might complain:
> 
> include/linux/pci-ecam.h:29:19: error: field 'pci_ops' has incomplete type
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Applied to pci/misc for v4.12, thanks!

> ---
>  include/linux/pci-ecam.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 7adad206b1f4..33c4750781a0 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -16,6 +16,7 @@
>  #ifndef DRIVERS_PCI_ECAM_H
>  #define DRIVERS_PCI_ECAM_H
>  
> +#include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  
> -- 
> 2.10.0
