Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46547 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754665AbaDGQzl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Apr 2014 12:55:41 -0400
Date: Mon, 7 Apr 2014 09:58:08 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Add new PCI id for Intel GPU interrupt quirk
Message-ID: <20140407165808.GC7119@kroah.com>
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

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
