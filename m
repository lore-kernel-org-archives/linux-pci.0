Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752281AbdEENeo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 May 2017 09:34:44 -0400
Date: Fri, 5 May 2017 08:34:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 04/13] sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit
 resource in OF parsing
Message-ID: <20170505133439.GE9648@bhelgaas-glaptop.roam.corp.google.com>
References: <20170421050500.13957-1-yinghai@kernel.org>
 <20170421050500.13957-5-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170421050500.13957-5-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 10:04:51PM -0700, Yinghai Lu wrote:
> For device resource with PREF bit setting under bridge 64-bit pref resource,
> we need to make sure only set PREF for 64bit resource.
> 
> so this patch set IORESOUCE_MEM_64 for 64bit resource during OF device

s/IORESOUCE_MEM_64/IORESOURCE_MEM_64/

This misspelling occurs three times in the series; please fix them all.

> resource flags parsing.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  arch/sparc/kernel/of_device_32.c | 5 +++--
>  arch/sparc/kernel/of_device_64.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
> index 185aa96..3e9f273 100644
> --- a/arch/sparc/kernel/of_device_32.c
> +++ b/arch/sparc/kernel/of_device_32.c
> @@ -83,11 +83,12 @@ static unsigned long of_bus_pci_get_flags(const u32 *addr, unsigned long flags)
>  	case 0x01:
>  		flags |= IORESOURCE_IO;
>  		break;
> -
>  	case 0x02: /* 32 bits */
> -	case 0x03: /* 64 bits */
>  		flags |= IORESOURCE_MEM;
>  		break;
> +	case 0x03: /* 64 bits */
> +		flags |= IORESOURCE_MEM | IORESOURCE_MEM_64;
> +		break;
>  	}
>  	if (w & 0x40000000)
>  		flags |= IORESOURCE_PREFETCH;
> diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
> index 7bbdc26..defee61 100644
> --- a/arch/sparc/kernel/of_device_64.c
> +++ b/arch/sparc/kernel/of_device_64.c
> @@ -146,11 +146,12 @@ static unsigned long of_bus_pci_get_flags(const u32 *addr, unsigned long flags)
>  	case 0x01:
>  		flags |= IORESOURCE_IO;
>  		break;
> -
>  	case 0x02: /* 32 bits */
> -	case 0x03: /* 64 bits */
>  		flags |= IORESOURCE_MEM;
>  		break;
> +	case 0x03: /* 64 bits */
> +		flags |= IORESOURCE_MEM | IORESOURCE_MEM_64;
> +		break;
>  	}
>  	if (w & 0x40000000)
>  		flags |= IORESOURCE_PREFETCH;
> -- 
> 2.9.3
> 
