Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752310AbdLDVlH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Dec 2017 16:41:07 -0500
Date: Mon, 4 Dec 2017 15:41:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] PCI: use dev_info rather than dev_err for rom validation
Message-ID: <20171204214105.GA18960@bhelgaas-glaptop.roam.corp.google.com>
References: <20171127172110.16699-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171127172110.16699-1-alexander.deucher@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 27, 2017 at 12:21:10PM -0500, Alex Deucher wrote:
> On AMD GPUs, we use several mechanisms to fetch the vbios
> rom depending on the platform.  We try to read the rom
> back via the rom BAR and fall back to other methods in
> some cases.  This leads to spurious error messages
> from the pci rom code which are harmless in our case.
> This leads to bugs being files, etc.  Change these to
> dev_info rather than dev_err to avoid that.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Applied with Christian's reviewed-by to pci/resource for v4.16, thanks!
I also added links to several of the bug reports.

> ---
>  drivers/pci/rom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index b6edb187d160..7ab7c6bb17c6 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -92,14 +92,14 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
>  		void __iomem *pds;
>  		/* Standard PCI ROMs start out with these bytes 55 AA */
>  		if (readw(image) != 0xAA55) {
> -			dev_err(&pdev->dev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
> +			dev_info(&pdev->dev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
>  				readw(image));
>  			break;
>  		}
>  		/* get the PCI data structure and check its "PCIR" signature */
>  		pds = image + readw(image + 24);
>  		if (readl(pds) != 0x52494350) {
> -			dev_err(&pdev->dev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
> +			dev_info(&pdev->dev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
>  				readl(pds));
>  			break;
>  		}
> -- 
> 2.13.6
> 
