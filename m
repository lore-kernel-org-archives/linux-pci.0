Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753463AbeB0OrI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Feb 2018 09:47:08 -0500
Date: Tue, 27 Feb 2018 08:47:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Vincent-Cross <me@tvc.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add function 1 DMA alias quirk for 88SE9220
Message-ID: <20180227144706.GB112033@bhelgaas-glaptop.roam.corp.google.com>
References: <20180227092035.GA16727@cornetto.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180227092035.GA16727@cornetto.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 27, 2018 at 08:20:36PM +1100, Thomas Vincent-Cross wrote:
> Add Marvell 88SE9220 DMA quirk as found and tested on bug 42679.
> 
> Signed-off-by: Thomas Vincent-Cross <me@tvc.id.au>

Applied to pci/virtualization for v4.17, thanks!

> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index fc734014206f..70a7c337463f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3896,6 +3896,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9182,
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c46 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0,
>  			 quirk_dma_func1_alias);
> +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c127 */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
> +			 quirk_dma_func1_alias);
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
>  			 quirk_dma_func1_alias);
> -- 
> 2.16.2
> 
