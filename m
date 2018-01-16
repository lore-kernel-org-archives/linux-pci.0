Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbeAPRnL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jan 2018 12:43:11 -0500
Date: Tue, 16 Jan 2018 11:43:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lists@binarus.de
Subject: Re: [PATCH] PCI: Add Marvell 9128 to DMA alias quirks
Message-ID: <20180116174304.GA10860@bhelgaas-glaptop.roam.corp.google.com>
References: <20180116170457.22911.89578.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180116170457.22911.89578.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 16, 2018 at 10:05:26AM -0700, Alex Williamson wrote:
> This is the original device generating bug 42679, from which many
> other Marvell DMA alias quirks have been sourced, but we didn't have
> positive confirmation of the fix on 9128 until now.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=42679
> Link: https://www.spinics.net/lists/kvm/msg161459.html
> Reported-by: Binarus <lists@binarus.de>
> Tested-by: Binarus <lists@binarus.de>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/virtualization for v4.16, thanks!

> ---
>  drivers/pci/quirks.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 10684b17d0bd..db0c652c01cb 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3879,6 +3879,8 @@ static void quirk_dma_func1_alias(struct pci_dev *dev)
>  			 quirk_dma_func1_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
>  			 quirk_dma_func1_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9128,
> +			 quirk_dma_func1_alias);
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
>  			 quirk_dma_func1_alias);
> 
