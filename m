Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933866AbcKWXQ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Nov 2016 18:16:27 -0500
Date: Wed, 23 Nov 2016 17:16:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Alex Barba <alex.barba@broadcom.com>,
        Oza Oza <oza.oza@broadcom.com>
Subject: Re: [PATCH] PCI: iproc: Fix incorrect MSI address alignment
Message-ID: <20161123231617.GL16033@bhelgaas-glaptop.roam.corp.google.com>
References: <1479779310-2580-1-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479779310-2580-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 21, 2016 at 05:48:30PM -0800, Ray Jui wrote:
> In the code to handle PAXB v2 based MSI steering, the logic aligns the
> MSI register address to the size of supported inbound mapping range.
> This is incorrect since it rounds "up" the starting address to the next
> aligned address, but what we want is the starting address to be rounded
> "down" to the aligned address.
> 
> This patch fixes the issue and allows MSI writes to be properly steered
> to the GIC
> 
> Fixes: 4b073155fbd3 ("PCI: iproc: Add support for the next-gen PAXB
> controller")
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Applied to pci/host-iproc for v4.10, thanks, Ray!

> ---
>  drivers/pci/host/pcie-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 8ffb9d4..fb09668 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -1018,7 +1018,7 @@ static int iproc_pcie_paxb_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr)
>  
>  	memset(&range, 0, sizeof(range));
>  	range.size = SZ_32K;
> -	range.pci_addr = range.cpu_addr = ALIGN(msi_addr, range.size);
> +	range.pci_addr = range.cpu_addr = msi_addr & ~(range.size - 1);
>  
>  	ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_IO);
>  	return ret;
> -- 
> 2.1.4
> 
