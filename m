Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933838AbcKWWxJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Nov 2016 17:53:09 -0500
Date: Wed, 23 Nov 2016 16:53:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        linux-kernel@vger.kernel.org, Oza Oza <oza.oza@broadcom.com>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: iproc: fix 32-bit build
Message-ID: <20161123225305.GI16033@bhelgaas-glaptop.roam.corp.google.com>
References: <20161122141844.1655574-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161122141844.1655574-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 22, 2016 at 03:17:51PM +0100, Arnd Bergmann wrote:
> The newly added code to setup the inbound ranges causes a link error
> on 32-bit machines from a 32-bit division:
> 
> drivers/pci/host/pcie-iproc.o: In function `iproc_pcie_setup_ib':
> pcie-iproc.c:(.text.iproc_pcie_setup_ib+0x14c): undefined reference to `__aeabi_uldivmod'
> 
> As both sides of the division are always power-of-two numbers and
> we already rely on that, we can use a shift instead.
> 
> Fixes: 87c240b19bba ("PCI: iproc: Add inbound DMA mapping support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I folded these fixes into the pci/host-iproc branch for v4.10, thanks!

For some reason, I don't see Ray's responses on the list.  Maybe still
some email problem?

> ---
>  drivers/pci/host/pcie-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index d10e6aa32e0d..857ff5198317 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -865,7 +865,7 @@ static int iproc_pcie_ib_write(struct iproc_pcie *pcie, int region_idx,
>  	 * Now program the IMAP registers.  Each IARR region may have one or
>  	 * more IMAP windows.
>  	 */
> -	size /= nr_windows;
> +	size >>= ilog2(nr_windows);
>  	for (window_idx = 0; window_idx < nr_windows; window_idx++) {
>  		val = readl(pcie->base + imap_offset);
>  		val |= lower_32_bits(axi_addr) | IMAP_VALID;
> -- 
> 2.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
