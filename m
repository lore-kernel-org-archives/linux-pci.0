Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:56261 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbaBNS3P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2014 13:29:15 -0500
Received: by mail-ig0-f171.google.com with SMTP id uy17so1338305igb.4
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2014 10:29:13 -0800 (PST)
Date: Fri, 14 Feb 2014 11:29:10 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] bus: mvebu-mbus: Fix incorrect size for PCI aperture
 resources
Message-ID: <20140214182910.GC31093@google.com>
References: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 12, 2014 at 03:57:07PM -0700, Jason Gunthorpe wrote:
> reg[0] is the DT base, reg[1] is the DT length in bytes,
> struct resource.end is the inclusive end address, so a -1 is
> required.
> 
> Tested on kirkwood.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Do these two patches need to go together?  I don't maintain
drivers/bus/mvebu-mbus.c, but if these should be kept together, I'd be
happy to merge them both, given the appropriate ack from Jason C or Thomas.

> ---
>  drivers/bus/mvebu-mbus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index 2394e97..7fd54e9 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -876,14 +876,14 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
>  	ret = of_property_read_u32_array(np, "pcie-mem-aperture", reg, ARRAY_SIZE(reg));
>  	if (!ret) {
>  		mem->start = reg[0];
> -		mem->end = mem->start + reg[1];
> +		mem->end = mem->start + reg[1] - 1;
>  		mem->flags = IORESOURCE_MEM;
>  	}
>  
>  	ret = of_property_read_u32_array(np, "pcie-io-aperture", reg, ARRAY_SIZE(reg));
>  	if (!ret) {
>  		io->start = reg[0];
> -		io->end = io->start + reg[1];
> +		io->end = io->start + reg[1] - 1;
>  		io->flags = IORESOURCE_IO;
>  	}
>  }
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
