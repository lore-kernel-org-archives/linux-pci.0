Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54284 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769Ab2J3DOO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 23:14:14 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so4114093wgb.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Oct 2012 20:14:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1351521618-6818-1-git-send-email-abbotti@mev.co.uk>
References: <1351521618-6818-1-git-send-email-abbotti@mev.co.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 29 Oct 2012 21:13:52 -0600
Message-ID: <CAErSpo7mOxU=5u_-kehBnPU0Hr0thY8uZk6CXvp3kUbaqgKs7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: add workaround for PLX PCI 9050 bug
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 29, 2012 at 8:40 AM, Ian Abbott <abbotti@mev.co.uk> wrote:
> The PLX PCI 9050 PCI Target bridge controller has a bug that prevents
> its local configuration registers being read through BAR0 (memory) or
> BAR1 (i/o) if the base address lies on an odd 128-byte boundary, i.e. if
> bit 7 of the base address is non-zero.  This bug is described in the PCI
> 9050 errata list, version 1.4, May 2005.  It was fixed in the
> pin-compatible PCI 9052, which can be distinguished from the PCI 9050 by
> checking the revision in the PCI header, which is hard-coded for these
> chips.
>
> Workaround the problem by re-allocating the affected regions to a
> 256-byte boundary.  Note that BAR0 and/or BAR1 may have been disabled
> (size 0) during initialization of the PCI chip when its configuration is
> read from a serial EEPROM.
>
> Currently, the fix-up has only been used for devices with the default
> vendor and device ID of the PLX PCI 9050.  The PCI 9052 shares the same
> default device ID as the PCI 9050 but they have different PCI revision
> codes.
>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> ---
>  drivers/pci/quirks.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7a451ff..7e6be56 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1790,6 +1790,31 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
>                          PCI_DEVICE_ID_TOSHIBA_TC86C001_IDE,
>                          quirk_tc86c001_ide);
>
> +/*
> + * PLX PCI 9050 PCI Target bridge controller has an errata that prevents the
> + * local configuration registers accessible via BAR0 (memory) or BAR1 (i/o)
> + * being read correctly if bit 7 of the base address is set.
> + * The BAR0 or BAR1 region may be disabled (size 0) or enabled (size 128).
> + * Re-allocate the regions to a 256-byte boundary if necessary.
> + */
> +static void __devinit quirk_plx_pci9050(struct pci_dev *dev)
> +{
> +       unsigned int bar;
> +
> +       /* Fixed in revision 2 (PCI 9052). */
> +       if (dev->revision >= 2)
> +               return;
> +       for (bar = 0; bar <= 1; bar++)
> +               if (pci_resource_len(dev, bar) == 0x80 &&
> +                   (pci_resource_start(dev, bar) & 0x80)) {
> +                       struct resource *r = &dev->resource[bar];
> +                       r->start = 0;
> +                       r->end = 0xff;

I assume the intent here is to make these BARs "unassigned" so they
will be reassigned later?  We don't yet have a clean generic way of
indicating "unassigned," so "r->start = 0" is the best we can do for
now.

I think it'd be nice to have a dev_info() here to explain what's going
on.  Otherwise, the dmesg will be a bit mysterious.

> +               }
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
> +                        quirk_plx_pci9050);
> +
>  static void __devinit quirk_netmos(struct pci_dev *dev)
>  {
>         unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;
> --
> 1.7.12.4
>
