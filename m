Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54191C43218
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18871206C1
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 13:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556199757;
	bh=b+VUUbbFjef4E4E2GK35OLcuM9tZyU2ccYPs14hOQ1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jMCP7sVuBSrCwsYHdpLL8omE0E0zQKhRvR3Iejnj4RqAV1EXcymh0R43M9COu7lUC
	 WobzoxwWUJGeVUt9EEzoXoNHhRgw/ysBADo3C3YFuqoodPp2rOuXBw87shmjSDUc9u
	 jNJcU8KoPIUrJcCbfFEvNpLMOjsHdAOcrTL2Klro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfDYNmg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDYNmg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Apr 2019 09:42:36 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F6F92067C;
        Thu, 25 Apr 2019 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556199754;
        bh=b+VUUbbFjef4E4E2GK35OLcuM9tZyU2ccYPs14hOQ1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEOHGtIDAStGWYu7MmX5vy7B6Q8IFcBUHfxt6zIfDuPAtE1Y+eWLR7bNewnwlK1MR
         3jg89AOcu5f+3LvD9hlJvWb84gF5bAX1fiSZaY51AmX1XjI+eMJZEaY+5FRDBeCmtL
         I8yM3Z/7BBkTjwHBi3HVuFiiRdGkvkE79lApPaTU=
Date:   Thu, 25 Apr 2019 08:42:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v4 3/4] PCI: Modify kernel parameters to differentiate
 between MMIO and MMIO_PREF sizes
Message-ID: <20190425134233.GC214428@google.com>
References: <20190417141610.6730-1-nicholas.johnson-opensource@outlook.com.au>
 <PS2P216MB0642A4E43D8528D0B65C077780250@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB0642A4E43D8528D0B65C077780250@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 17, 2019 at 02:16:59PM +0000, Nicholas Johnson wrote:
> Add kernel parameter pci=hpmemprefsize=nn[KMG] to control MMIO_PREF
> size for PCI hotplug bridges.
> 
> Change behaviour of pci=hpmemsize=nn[KMG] to only control MMIO size,
> rather than controlling both MMIO and MMIO_PREF sizes.

If I understand correctly, this patch as-is changes the behavior of
just specifying "pci=hpmemsize", and I think that will require some
users to change their boot configuration.

If the user doesn't specify "pci=hpmemprefsize", I think we might want
to preserve the existing behavior, i.e.,

  - "pci=hpmemsize=XX" affects both MMIO and MMIO_PREF windows, as it
    does today

  - "pci=hpmemprefsize=XX" affects only MMIO_PREF window, use default
    for MMIO window size

  - "pci=hpmemsize=XX pci=hpmemprefsize=YY" sets MMIO window size to
    XX and MMIO_PREF window size to YY

That way a user will not see any change in behavior unless he/she
actually uses the new kernel parameter.

> Update kernel-parameters documentation to reflect the above changes.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++-
>  drivers/pci/pci.c                             | 12 ++++++---
>  drivers/pci/setup-bus.c                       | 25 +++++++++++--------
>  include/linux/pci.h                           |  3 ++-
>  4 files changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2b8ee90bb..f33b590c2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3361,7 +3361,10 @@
>  				reserved for hotplug bridge's IO window.
>  				Default size is 256 bytes.
>  		hpmemsize=nn[KMG]	The fixed amount of bus space which is
> -				reserved for hotplug bridge's memory window.
> +				reserved for hotplug bridge's MMIO window.
> +				Default size is 2 megabytes.
> +		hpmemprefsize=nn[KMG]	The fixed amount of bus space which is
> +				reserved for hotplug bridge's MMIO_PREF window.
>  				Default size is 2 megabytes.
>  		hpbussize=nn	The minimum amount of additional bus numbers
>  				reserved for buses below a hotplug bridge.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c1b362f5..e0502831f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -85,10 +85,12 @@ unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
>  unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
>  
>  #define DEFAULT_HOTPLUG_IO_SIZE		(256)
> -#define DEFAULT_HOTPLUG_MEM_SIZE	(2*1024*1024)
> +#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
> +#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
>  /* pci=hpmemsize=nnM,hpiosize=nn can override this */
>  unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
> -unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
> +unsigned long pci_hotplug_mmio_size = DEFAULT_HOTPLUG_MMIO_SIZE;
> +unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
>  
>  #define DEFAULT_HOTPLUG_BUS_SIZE	1
>  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
> @@ -6245,7 +6247,11 @@ static int __init pci_setup(char *str)
>  			} else if (!strncmp(str, "hpiosize=", 9)) {
>  				pci_hotplug_io_size = memparse(str + 9, &str);
>  			} else if (!strncmp(str, "hpmemsize=", 10)) {
> -				pci_hotplug_mem_size = memparse(str + 10, &str);
> +				pci_hotplug_mmio_size =
> +					memparse(str + 10, &str);
> +			} else if (!strncmp(str, "hpmemprefsize=", 14)) {
> +				pci_hotplug_mmio_pref_size =
> +					memparse(str + 14, &str);
>  			} else if (!strncmp(str, "hpbussize=", 10)) {
>  				pci_hotplug_bus_size =
>  					simple_strtoul(str + 10, &str, 0);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 5b9ee9945..95149165a 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1187,7 +1187,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
>  	unsigned long mask, prefmask, type2 = 0, type3 = 0;
> -	resource_size_t additional_mem_size = 0, additional_io_size = 0;
> +	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
> +		additional_mmio_pref_size = 0;
>  	struct resource *b_res;
>  	int ret;
>  
> @@ -1221,7 +1222,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		pci_bridge_check_ranges(bus);
>  		if (bus->self->is_hotplug_bridge) {
>  			additional_io_size  = pci_hotplug_io_size;
> -			additional_mem_size = pci_hotplug_mem_size;
> +			additional_mmio_size = pci_hotplug_mmio_size;
> +			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
>  		}
>  		/* Fall through */
>  	default:
> @@ -1239,9 +1241,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		if (b_res[2].flags & IORESOURCE_MEM_64) {
>  			prefmask |= IORESOURCE_MEM_64;
>  			ret = pbus_size_mem(bus, prefmask, prefmask,
> -				  prefmask, prefmask,
> -				  realloc_head ? 0 : additional_mem_size,
> -				  additional_mem_size, realloc_head);
> +				prefmask, prefmask,
> +				realloc_head ? 0 : additional_mmio_pref_size,
> +				additional_mmio_pref_size, realloc_head);
>  
>  			/*
>  			 * If successful, all non-prefetchable resources
> @@ -1263,9 +1265,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		if (!type2) {
>  			prefmask &= ~IORESOURCE_MEM_64;
>  			ret = pbus_size_mem(bus, prefmask, prefmask,
> -					 prefmask, prefmask,
> -					 realloc_head ? 0 : additional_mem_size,
> -					 additional_mem_size, realloc_head);
> +				prefmask, prefmask,
> +				realloc_head ? 0 : additional_mmio_pref_size,
> +				additional_mmio_pref_size, realloc_head);
>  
>  			/*
>  			 * If successful, only non-prefetchable resources
> @@ -1274,7 +1276,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  			if (ret == 0)
>  				mask = prefmask;
>  			else
> -				additional_mem_size += additional_mem_size;
> +				additional_mmio_size +=
> +					additional_mmio_pref_size;
>  
>  			type2 = type3 = IORESOURCE_MEM;
>  		}
> @@ -1295,8 +1298,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		 * window.
>  		 */
>  		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
> -				realloc_head ? 0 : additional_mem_size,
> -				additional_mem_size, realloc_head);
> +			realloc_head ? 0 : additional_mmio_size,
> +			additional_mmio_size, realloc_head);
>  		break;
>  	}
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 77448215e..7ab8f5b88 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1964,7 +1964,8 @@ extern u8 pci_dfl_cache_line_size;
>  extern u8 pci_cache_line_size;
>  
>  extern unsigned long pci_hotplug_io_size;
> -extern unsigned long pci_hotplug_mem_size;
> +extern unsigned long pci_hotplug_mmio_size;
> +extern unsigned long pci_hotplug_mmio_pref_size;
>  extern unsigned long pci_hotplug_bus_size;
>  
>  /* Architecture-specific versions may override these (weak) */
> -- 
> 2.20.1
> 
