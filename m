Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:60499 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933494AbaKMRwm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 12:52:42 -0500
Received: by mail-pd0-f170.google.com with SMTP id z10so15052555pdj.29
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 09:52:42 -0800 (PST)
Date: Thu, 13 Nov 2014 10:52:37 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org, 'Mohit Kumar' <mohit.kumar@st.com>
Subject: Re: [PATCH] PCI: designware: Add a blank line after declarations
Message-ID: <20141113175237.GO5064@google.com>
References: <002a01cffe28$87fb3d10$97f1b730$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002a01cffe28$87fb3d10$97f1b730$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 12:27:04PM +0900, Jingoo Han wrote:
> This patch fixes the following checkpatch warning.
> 
>   WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to pci/host-designware for v3.19, thanks!

> ---
>  drivers/pci/host/pcie-designware.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index dfed00a..f9be371 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -380,6 +380,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  	/* Get the I/O and memory ranges from DT */
>  	for_each_of_pci_range(&parser, &range) {
>  		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
> +
>  		if (restype == IORESOURCE_IO) {
>  			of_pci_range_to_resource(&range, np, &pp->io);
>  			pp->io.name = "I/O";
> -- 
> 1.7.9.5
> 
> 
