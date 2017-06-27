Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751900AbdF0WhH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 18:37:07 -0400
Date: Tue, 27 Jun 2017 17:37:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM/PCI: iop13xx: address uninitialized variable
 warning
Message-ID: <20170627223704.GF17844@bhelgaas-glaptop.roam.corp.google.com>
References: <20170621215323.3921382-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170621215323.3921382-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 21, 2017 at 11:52:59PM +0200, Arnd Bergmann wrote:
> The last rework returned a variable that the compiler cannot prove
> to be initialized:
> 
> arch/arm/mach-iop13xx/pci.c: In function 'iop13xx_scan_bus':
> arch/arm/mach-iop13xx/pci.c:509:17: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> In the switch statement that sets the return value, this adds
> a default returning an error.
> 
> Fixes: ace27646da8e ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Folded into Lorenzo's series on pci/enumeration, thanks!

> ---
>  arch/arm/mach-iop13xx/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
> index b97879bfb81a..3c51a9bb9b49 100644
> --- a/arch/arm/mach-iop13xx/pci.c
> +++ b/arch/arm/mach-iop13xx/pci.c
> @@ -553,6 +553,8 @@ int iop13xx_scan_bus(int nr, struct pci_host_bridge *bridge)
>  		if (!ret)
>  			pci_bus_atue = bridge->bus;
>  		break;
> +	default:
> +		ret = -EINVAL;
>  	}
>  
>  	return ret;
> -- 
> 2.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
