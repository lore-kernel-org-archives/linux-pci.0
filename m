Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:40741 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab2KTRu4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2012 12:50:56 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so2158621lag.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Nov 2012 09:50:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1353349642-3677-16-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-16-git-send-email-wfp5p@virginia.edu>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 20 Nov 2012 10:50:33 -0700
Message-ID: <CAErSpo5+wynH3LDPZbdoQVh1w1igzuMNS45hDO-69TNjQ8TLMg@mail.gmail.com>
Subject: Re: [PATCH 016/493] PCI: always build setup-bus when PCI is enabled
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 19, 2012 at 11:19 AM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is being removed so setup-bus always needs to be built
> as part of PCI.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: linux-pci@vger.kernel.org

These all look fine to me.  Please make the changelog subjects
consistently capitalize the "PCI" acronym and also the first word of
the rest, e.g., "PCI: Always ..."

If you want me to take them through my PCI tree, I can, but I assume
Greg is going to take them through the driver core tree, and that's
fine with me.

FWIW, I agree with Grant Likely's comments about squashing the
devinit/devexit/etc patches.  That would be fine with me.

> ---
>  drivers/pci/Makefile | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 36f119d..0c3efcf 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -4,7 +4,7 @@
>
>  obj-y          += access.o bus.o probe.o host-bridge.o remove.o pci.o \
>                         pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
> -                       irq.o vpd.o
> +                       irq.o vpd.o setup-bus.o
>  obj-$(CONFIG_PROC_FS) += proc.o
>  obj-$(CONFIG_SYSFS) += slot.o
>
> @@ -58,9 +58,6 @@ obj-$(CONFIG_ACPI)    += pci-acpi.o
>  # SMBIOS provided firmware instance and labels
>  obj-$(CONFIG_PCI_LABEL) += pci-label.o
>
> -# Cardbus & CompactPCI use setup-bus
> -obj-$(CONFIG_HOTPLUG) += setup-bus.o
> -
>  obj-$(CONFIG_PCI_SYSCALL) += syscall.o
>
>  obj-$(CONFIG_PCI_STUB) += pci-stub.o
> --
> 1.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
