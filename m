Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64013 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933111Ab2KEWI0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2012 17:08:26 -0500
Received: by mail-wi0-f172.google.com with SMTP id hq12so3634635wib.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Nov 2012 14:08:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1351617953-4201-1-git-send-email-abbotti@mev.co.uk>
References: <1351521618-6818-1-git-send-email-abbotti@mev.co.uk> <1351617953-4201-1-git-send-email-abbotti@mev.co.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 5 Nov 2012 15:08:05 -0700
Message-ID: <CAErSpo7=BpH2TA4Ox=Ftc2XjbiycBrhZzNW4DQkJeJS-i+Kc=w@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] PCI: add workaround for PLX PCI 9050 bug
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 30, 2012 at 11:25 AM, Ian Abbott <abbotti@mev.co.uk> wrote:
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
> v2: Use dev_info() to report when quirk applied.
> ---
>  drivers/pci/quirks.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7a451ff..2d0d1c2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1790,6 +1790,34 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
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
> +                       dev_info(&dev->dev,
> +                                "Re-allocating PLX PCI 9050 BAR %u to length 256 to avoid bit 7 bug\n",
> +                                bar);
> +                       r->start = 0;
> +                       r->end = 0xff;
> +               }
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
> +                        quirk_plx_pci9050);
> +
>  static void __devinit quirk_netmos(struct pci_dev *dev)
>  {
>         unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;
> --

I applied both these patches to my pci/misc branch as v3.8 material.

Thanks!
