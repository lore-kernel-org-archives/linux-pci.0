Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755150AbeF3CUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 22:20:31 -0400
Date: Fri, 29 Jun 2018 21:20:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rex Zhu <Rex.Zhu@amd.com>
Cc: bhelgaas@google.com, michel.daenzer@amd.com,
        alexander.deucher@amd.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Avoid access memory outside the resource window
Message-ID: <20180630022029.GP40928@bhelgaas-glaptop.roam.corp.google.com>
References: <1528163206-4136-1-git-send-email-Rex.Zhu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528163206-4136-1-git-send-email-Rex.Zhu@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 05, 2018 at 09:46:45AM +0800, Rex Zhu wrote:
> change ">" to ">=" to avoid access beyond the actual
> length of io memory.
> 
> Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>

Both applied with Alex's reviewed-by to pci/resource for v4.19, thanks!

I also added a patch to make pci_get_rom_size() static, since it's only
used by pci_map_rom().

> ---
>  drivers/pci/rom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index 374a334..a5c6016 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -108,7 +108,7 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
>  		length = readw(pds + 16);
>  		image += length * 512;
>  		/* Avoid iterating through memory outside the resource window */
> -		if (image > rom + size)
> +		if (image >= rom + size)
>  			break;
>  	} while (length && !last_image);
>  
> -- 
> 1.9.1
> 
