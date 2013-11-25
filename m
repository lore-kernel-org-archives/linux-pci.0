Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:49587 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab3KYUhH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2013 15:37:07 -0500
Received: by mail-oa0-f52.google.com with SMTP id h16so4994593oag.11
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2013 12:37:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131125205441.5046e0cb@neptune.home>
References: <20131125205441.5046e0cb@neptune.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 25 Nov 2013 13:36:46 -0700
Message-ID: <CAErSpo5D1uFVGcuGJyX+FGFL6mfaXZQ6dOZPsRwDACXxqe5j_w@mail.gmail.com>
Subject: Re: [RFC patch] PCI: Extend boot_vga sysfs attribute lookup to fix X
 on MBA+EFI
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dave Airlie <airlied@linux.ie>, Peter Jones <pjones@redhat.com>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 25, 2013 at 12:54 PM, Bruno Prémont
<bonbons@linux-vserver.org> wrote:
> On a MacBookAir2,1, booting to Linux with EFI though having
> no efifb built-in Xorg refuses to start with "no devices detected"
> because for the only VGA device available (NVidia Geforce 9400M)
> the sysfs attribute boot_vga is zero (instead of expected 1).
>
> When CONFIG_FB_EFI is selected, efifb does provide its own
> vga_default_device() to report the PCI device matching global
> screen_info as determined during efifb setup.
>
> Otherwise there is just a dummy or VGA_ARB's vga_default_device()
> that does not provide the right information.

Wouldn't it be cleaner to fix vga_default_device() so it returns the
correct thing even when CONFIG_FB_EFI=n?

> On the other hand, boot_vga_show() falls back to poking PCI
> resources to flag a PCI device as boot_vga if vga_default_device()
> returned no PCI device (NULL).
>
> To complement this PCI resource poking, this patch copies the
> validation code used to determine which PCI device to report as
> default VGA device by efifb into boot_vga_show().

If we do have to use logic like this, I'd like it better if it were
factored into a single function called both here and from
efifb_setup().

> Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> ---
> Would it make sense to kill the corresponding code from efifb
> as it covers only a single case?
>
> The other EFI capable system I have (AMD Ilano based, Gigabyte
> mainboard does report boot_vga=1, possibly through the resources
> poking and there Xorg starts properly without efifb built in.
>
> Selecting CONFIG_X86_SYSFB (combined with CONFIG_FB_SIMPLE) does
> not help by itself, patching that one instead of PCI's boot_vga
> attribute directly would still not cover the case when neither
> of them is enabled.
>
>
>  drivers/pci/pci-sysfs.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7128cfd..91cac71 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -28,6 +28,7 @@
>  #include <linux/pci-aspm.h>
>  #include <linux/slab.h>
>  #include <linux/vgaarb.h>
> +#include <linux/screen_info.h>
>  #include <linux/pm_runtime.h>
>  #include "pci.h"
>
> @@ -540,6 +541,26 @@ boot_vga_show(struct device *dev, struct device_attribute *attr, char *buf)
>         if (vga_dev)
>                 return sprintf(buf, "%u\n", (pdev == vga_dev));
>
> +       if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {
> +               resource_size_t start, end;
> +               int i;
> +
> +               for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +                       if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
> +                               continue;
> +
> +                       start = pci_resource_start(pdev, i);
> +                       end  = pci_resource_end(pdev, i);
> +
> +                       if (!start || !end)
> +                               continue;
> +
> +                       if (screen_info.lfb_base >= start &&
> +                               (screen_info.lfb_base + screen_info.lfb_size) < end)
> +                               return sprintf(buf, "1\n");
> +               }
> +       }
> +
>         return sprintf(buf, "%u\n",
>                 !!(pdev->resource[PCI_ROM_RESOURCE].flags &
>                    IORESOURCE_ROM_SHADOW));
