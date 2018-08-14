Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbeHNRGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Aug 2018 13:06:50 -0400
Date: Tue, 14 Aug 2018 09:19:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: f.bluethner@mailbox.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PCI: Add function 1 DMA alias quirk for Marvell 88SS9183
Message-ID: <20180814141926.GP113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180813194123.GM113140@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180813194123.GM113140@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 13, 2018 at 02:41:23PM -0500, Bjorn Helgaas wrote:
> Hi,
> 
> Thanks a lot for your new report
> (https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134).
> 
> Can you confirm that the patch below is equivalent to what you tested and
> it resolves the problem?  If so, I'll try to include it for v4.19.

I applied this to pci/virtualization for v4.19.  Please let me know if you
see any issues.

> commit dd4e0ad485e12c9c04eb7a21ba69c24f12cb1918
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Mon Aug 13 14:30:41 2018 -0500
> 
>     PCI: Add function 1 DMA alias quirk for Marvell 88SS9183
>     
>     Add function 1 DMA alias quirk for Marvell 88SS9183 PCIe SSD Controller.
>     
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134
>     Reported-by: <f.bluethner@mailbox.org>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index deb051583eda..6994544125ff 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3845,6 +3845,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x917a,
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c78 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9182,
>  			 quirk_dma_func1_alias);
> +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134 */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9183,
> +			 quirk_dma_func1_alias);
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c46 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0,
>  			 quirk_dma_func1_alias);
