Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:41941 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756777AbaHHPXz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Aug 2014 11:23:55 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so5787412wgh.20
        for <linux-pci@vger.kernel.org>; Fri, 08 Aug 2014 08:23:54 -0700 (PDT)
Date: Fri, 8 Aug 2014 17:24:06 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	intel-gfx@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] PCI: Add another ID for Intel GPU "spurious
 interrupt" quirk
Message-ID: <20140808152406.GW8727@phenom.ffwll.local>
References: <12243017.yA3ijCk2M3@storm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12243017.yA3ijCk2M3@storm>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 08, 2014 at 03:54:04PM +0200, Thomas Jarosch wrote:
> New Intel G3258 CPU, new MSI board, same problem:
> The GPU interrupt fired like crazy on monitor unplug.
> 
> lspci output:
> 00:02.0 VGA compatible controller: Intel Corporation Device 0402 (rev 06)
>         Subsystem: Micro-Star International Co., Ltd. Device 7817
>         Flags: bus master, fast devsel, latency 0, IRQ 11
> 
> Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
> Tested-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
> CC: stable@vger.kernel.org  # v3.4+
> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 80c2d01..d2ff39d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2940,6 +2940,7 @@ static void disable_igfx_irq(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0402, disable_igfx_irq);

Shouldn't we just add entries for them all? See include/drm/i915_pciids.h

We might need to abstract the macro magic a bit though to reuse that list.
Also note that not all have the DEIER register. In any case I don't think
this game of whack-a-mole here is, we should plug this all for real.
-Daniel

>  
>  /*
>   * PCI devices which are on Intel chips can skip the 10ms delay
> -- 
> 1.9.3
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
