Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:41959 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755562Ab3LGWXp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Dec 2013 17:23:45 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so3695740iec.7
        for <linux-pci@vger.kernel.org>; Sat, 07 Dec 2013 14:23:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131009163304.62b439a9@endymion.delvare>
References: <20131009163304.62b439a9@endymion.delvare>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 7 Dec 2013 15:23:25 -0700
Message-ID: <CAErSpo6ikaTXXvWzX_Z0=mabwD4aedoLoSVjsd+_E5kV9YJpuA@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Set master earlier
To: Jean Delvare <jdelvare@suse.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>, Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Wed, Oct 9, 2013 at 8:33 AM, Jean Delvare <jdelvare@suse.de> wrote:
> Since kernel 3.12-rc3, I get the following warning messages at boot:
> pcieport 0000:00:07.0: driver skip pci_set_master, fix it!
> pcieport 0000:00:01.0: driver skip pci_set_master, fix it!

cf3e1feba7f9 ("PCI: Workaround missing pci_set_master in pci drivers")
added this warning and, at the same time, turned on bus mastering.

There didn't seem to be any reason for the warning and no reason why
bus mastering should be enabled in the driver rather than the core, so
fbeeb822f6f4 ("PCI: Drop warning about drivers that don't use
pci_set_master()") just dropped the warning.

This should resolve the problem, so I don't think there's a need for
this patch.  Let me know if otherwise.

Bjorn

> These are:
> 00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1 (rev 13)
> 00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 7 (rev 13)
>
> Calling pci_set_master() immediately after pci_enable_device() makes
> the warning messages go away.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
> Please note that I am far from certain that this is the correct fix.
> Another approach would be to disable the device if
> get_port_device_capability() returns no capabilities. I suppose the
> device would then be re-enabled later if really needed. What's the best
> approach?
>
>  drivers/pci/pcie/portdrv_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-3.12-rc4.orig/drivers/pci/pcie/portdrv_core.c 2013-09-24 00:41:09.000000000 +0200
> +++ linux-3.12-rc4/drivers/pci/pcie/portdrv_core.c      2013-10-09 15:43:54.205943783 +0200
> @@ -366,13 +366,13 @@ int pcie_port_device_register(struct pci
>         status = pci_enable_device(dev);
>         if (status)
>                 return status;
> +       pci_set_master(dev);
>
>         /* Get and check PCI Express port services */
>         capabilities = get_port_device_capability(dev);
>         if (!capabilities)
>                 return 0;
>
> -       pci_set_master(dev);
>         /*
>          * Initialize service irqs. Don't use service devices that
>          * require interrupts if there is no way to generate them.
>
>
> --
> Jean Delvare
> Suse L3 Support
