Return-Path: <SRS0=kHOp=KI=kudzu.us=jdmason@kernel.org>
Return-Path: <SRS0=kHOp=KI=kudzu.us=jdmason@kernel.org>
Date: Tue, 24 Jul 2018 11:45:27 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxge: Remove unnecessary include of <linux/pci_hotplug.h>
Message-ID: <20180724154526.GB5871@kudzu.us>
References: <153237958637.172194.6734539971240967379.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <153237958637.172194.6734539971240967379.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 23, 2018 at 03:59:46PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The vxge driver doesn't need anything provided by pci_hotplug.h, so remove
> the unnecessary include of it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Not sure you need my ack for something so trivial, but here it is
Acked-by: Jon Mason <jdmason@kudzu.us>

> ---
>  drivers/net/ethernet/neterion/vxge/vxge-config.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
> index 358ed6118881..a2c0a93ca8b6 100644
> --- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
> +++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
> @@ -14,7 +14,6 @@
>  #include <linux/vmalloc.h>
>  #include <linux/etherdevice.h>
>  #include <linux/pci.h>
> -#include <linux/pci_hotplug.h>
>  #include <linux/slab.h>
>  
>  #include "vxge-traffic.h"
> 
