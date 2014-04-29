Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:54255 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbaD2Xf7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 19:35:59 -0400
Received: by mail-ie0-f175.google.com with SMTP id rl12so1045819iec.34
        for <linux-pci@vger.kernel.org>; Tue, 29 Apr 2014 16:35:59 -0700 (PDT)
Date: Tue, 29 Apr 2014 17:35:56 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Add new PCI id for Intel GPU interrupt quirk
Message-ID: <20140429233556.GB9912@google.com>
References: <3185796.STv3LRO1j8@storm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3185796.STv3LRO1j8@storm>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 07, 2014 at 03:10:32PM +0200, Thomas Jarosch wrote:
> After a CPU upgrade while keeping the same mainboard,
> we faced "spurious interrupt" problems again.
> 
> It turned out that the new CPU also featured a
> new GPU with a different PCI id.
> 
> -> Add this PCI id to the quirk table. Probably all other
> Intel GPU PCI ids are affected, too, but I don't want
> to add them without a test system.
> 
> Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
> Tested-by: Thomas Jarosch <thomas.jarosch@intra2net.com>

I applied this to pci/misc for v3.16, with a stable tag for v3.4+, thanks!

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e729206..0feb4a3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2954,6 +2954,7 @@ static void disable_igfx_irq(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
>  
>  /*
>   * PCI devices which are on Intel chips can skip the 10ms delay
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
