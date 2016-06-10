Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49544 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbcFJX6U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 19:58:20 -0400
Date: Fri, 10 Jun 2016 18:58:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Steven Graham <sgraham@xes-inc.com>
Subject: Re: [PATCH] PCI: Add function 1 DMA alias quirk for 88SE9182
Message-ID: <20160610235814.GB16462@localhost>
References: <1302254871.144378.1463521541328.JavaMail.zimbra@xes-inc.com>
 <1362465642.29195.1463580259749.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362465642.29195.1463580259749.JavaMail.zimbra@xes-inc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 18, 2016 at 09:04:19AM -0500, Aaron Sierra wrote:
> We found this quirk reported in the same thread as other Marvell
> devices, but no patch resulted:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=42679#c78
> 
> Signed-off-by: Steven Graham <sgraham@xes-inc.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>

Applied to pci/virtualization for v4.8, thanks, Steven and Aaron.

> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 8e67802..90ac106 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3651,6 +3651,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9172,
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c59 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x917a,
>  			 quirk_dma_func1_alias);
> +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c78 */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9182,
> +			 quirk_dma_func1_alias);
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c46 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0,
>  			 quirk_dma_func1_alias);
> -- 
> 1.9.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
