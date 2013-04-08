Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:39478 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934819Ab3DHRU2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2013 13:20:28 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp18so5404733obc.14
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2013 10:20:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201304081305.r38D5765032748@d01av04.pok.ibm.com>
References: <201304081305.r38D5765032748@d01av04.pok.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 8 Apr 2013 11:20:08 -0600
Message-ID: <CAErSpo45Zok=cpVzvb8ugaoJCjJYQa7z1nOZTfZ6-q9buGFLFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pci: Set dev->dev.type in alloc_pci_dev
To: Brian King <brking@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	klebers <klebers@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 8, 2013 at 7:05 AM, Brian King <brking@linux.vnet.ibm.com> wrote:
>
> Set dev->dev.type in alloc_pci_dev so that archs that have their own
> versions of pci_setup_device get this set properly in order to ensure
> things like the boot_vga sysfs parameter get created as expected.
>
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Feel free to put this in the powerpc tree along with the "set default
VGA device" patch.

> ---
>
>  drivers/pci/probe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -puN drivers/pci/probe.c~pci_set_dev_type_early drivers/pci/probe.c
> --- linux/drivers/pci/probe.c~pci_set_dev_type_early    2013-04-08 06:12:51.000000000 -0500
> +++ linux-bjking1/drivers/pci/probe.c   2013-04-08 06:14:33.000000000 -0500
> @@ -988,7 +988,6 @@ int pci_setup_device(struct pci_dev *dev
>         dev->sysdata = dev->bus->sysdata;
>         dev->dev.parent = dev->bus->bridge;
>         dev->dev.bus = &pci_bus_type;
> -       dev->dev.type = &pci_dev_type;
>         dev->hdr_type = hdr_type & 0x7f;
>         dev->multifunction = !!(hdr_type & 0x80);
>         dev->error_state = pci_channel_io_normal;
> @@ -1208,6 +1207,7 @@ struct pci_dev *alloc_pci_dev(void)
>                 return NULL;
>
>         INIT_LIST_HEAD(&dev->bus_list);
> +       dev->dev.type = &pci_dev_type;
>
>         return dev;
>  }
> _
>
