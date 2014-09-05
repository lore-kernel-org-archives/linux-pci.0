Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:49797 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098AbaIERe5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Sep 2014 13:34:57 -0400
Received: by mail-pa0-f41.google.com with SMTP id lf10so650392pab.28
        for <linux-pci@vger.kernel.org>; Fri, 05 Sep 2014 10:34:56 -0700 (PDT)
Date: Fri, 5 Sep 2014 11:34:53 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
Cc: linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] PCI: Add another ID for Intel GPU "spurious interrupt"
 quirk
Message-ID: <20140905173453.GC8080@google.com>
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

Dropping for now, please resend if necessary after resolving Daniel's
question.

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
>  
>  /*
>   * PCI devices which are on Intel chips can skip the 10ms delay
> -- 
> 1.9.3
> 
