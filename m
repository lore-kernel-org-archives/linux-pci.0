Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:56452 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab3LGWgD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Dec 2013 17:36:03 -0500
Received: by mail-yh0-f52.google.com with SMTP id i72so1562071yha.11
        for <linux-pci@vger.kernel.org>; Sat, 07 Dec 2013 14:36:02 -0800 (PST)
Date: Sat, 7 Dec 2013 15:35:57 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 04/12] PCI/portdrv: Remove superfluous name cast
Message-ID: <20131207223557.GA7901@google.com>
References: <1384283245-9419-1-git-send-email-geert@linux-m68k.org>
 <1384283245-9419-5-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384283245-9419-5-git-send-email-geert@linux-m68k.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 12, 2013 at 08:07:17PM +0100, Geert Uytterhoeven wrote:
> device_driver.name is "const char *"
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Applied to pci/misc for v3.14, thanks!

> ---
>  drivers/pci/pcie/portdrv_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 31063ac30992..833c18c3eb96 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -553,7 +553,7 @@ int pcie_port_service_register(struct pcie_port_service_driver *new)
>  	if (pcie_ports_disabled)
>  		return -ENODEV;
>  
> -	new->driver.name = (char *)new->name;
> +	new->driver.name = new->name;
>  	new->driver.bus = &pcie_port_bus_type;
>  	new->driver.probe = pcie_port_probe_service;
>  	new->driver.remove = pcie_port_remove_service;
> -- 
> 1.7.9.5
> 
