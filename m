Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:50780 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab3EPQSO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2013 12:18:14 -0400
Received: by mail-pb0-f48.google.com with SMTP id md4so2447564pbc.7
        for <linux-pci@vger.kernel.org>; Thu, 16 May 2013 09:18:13 -0700 (PDT)
Message-ID: <519506BF.3010400@gmail.com>
Date: Fri, 17 May 2013 00:18:07 +0800
From: Liu Jiang <liuj97@gmail.com>
MIME-Version: 1.0
To: Kevin Hao <haokexin@gmail.com>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: unset the resource if we can't get the correct
 CPU address
References: <1368536876-27307-1-git-send-email-haokexin@gmail.com> <1368536876-27307-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1368536876-27307-3-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue 14 May 2013 09:07:56 PM CST, Kevin Hao wrote:
> In the current kernel, we just set the CPU address to the bus address
> if we can't find the match region for one specific bus address. If BAR
> of one pci device is set to address which happens to be a legitimate
> CPU address by firmware, the kernel will think this resource is legal
> and will not try to reassign later. In cases the CPU address and bus
> address isn't equal, the device will not work. So we should check
> if we can translate the bus address to CPU address correctly. If not,
> we should unset this resource and wish the kernel will reassign it
> later.
>
> Since we will invoke pcibios_bus_to_resource unconditionally if we
> don't goto fail, move it out of if/else wrap.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>   drivers/pci/probe.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 70f10fa..c96772f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -250,12 +250,10 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>   			pci_write_config_dword(dev, pos + 4, 0);
>   			region.start = 0;
>   			region.end = sz64;
> -			pcibios_bus_to_resource(dev, res, &region);
>   			bar_disabled = true;
>   		} else {
>   			region.start = l64;
>   			region.end = l64 + sz64;
> -			pcibios_bus_to_resource(dev, res, &region);
>   		}
>   	} else {
>   		sz = pci_size(l, sz, mask);
> @@ -265,7 +263,12 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>
>   		region.start = l;
>   		region.end = l + sz;
> -		pcibios_bus_to_resource(dev, res, &region);
> +	}
> +
> +	if (!pcibios_bus_to_resource(dev, res, &region)) {
> +		res->flags |= IORESOURCE_UNSET;
> +		res->end -= res->start;
> +		res->start = 0;
>   	}
>
>   	goto out;

Hi Kevin,
      Will this break subtractive decode PCI bridges and devices?
Regards!
Gerry
