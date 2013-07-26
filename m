Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:48008 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891Ab3GZW2N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jul 2013 18:28:13 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so8830844oag.14
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2013 15:28:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372677737-15485-1-git-send-email-vipul@chelsio.com>
References: <1372677737-15485-1-git-send-email-vipul@chelsio.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 26 Jul 2013 16:27:51 -0600
Message-ID: <CAErSpo7bxZKWqdR2MCOvz4=n_pO=u59KSsHZzJMBoN8qQ+E+Dw@mail.gmail.com>
Subject: Re: [PATCH] pci: Enable bus master till the FLR completes
To: Vipul Pandya <vipul@chelsio.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	leedom@chelsio.com, tomreu@chelsio.com, divy@chelsio.com,
	dm@chelsio.com, nirranjan@chelsio.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 1, 2013 at 5:22 AM, Vipul Pandya <vipul@chelsio.com> wrote:
> From: Casey Leedom <leedom@chelsio.com>
>
> T4 can wedge if there are DMAs in flight within the chip and Bus master has
> been disabled.  We need to have it on till the Function Level Reset completes.
> T4 can also suffer a Head Of Line blocking problem if MSI-X interrupts are
> disabled before the FLR has completed.
>
> Signed-off-by: Casey Leedom <leedom@chelsio.com>
> ---
>  drivers/pci/quirks.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e85d230..6357ba1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3208,6 +3208,95 @@ reset_complete:
>         return 0;
>  }
>
> +/*
> + * Device-specific reset method for Chelsio T4-based adapters.
> + */
> +static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
> +{
> +       u16 old_command;
> +       u16 status, msix_flags;
> +       int i, rc, msix_pos;
> +
> +       /*
> +        * If this isn't a Chelsio T4-based device, return -ENOTTY indicating
> +        * that we have no device-specific reset method.
> +        */
> +       if ((dev->device & 0xf000) != 0x4000)
> +               return -ENOTTY;
> +
> +       /*
> +        * If this is the "probe" phase, return 0 indicating that we can
> +        * reset this device.
> +        */
> +       if (probe)
> +               return 0;
> +
> +       /*
> +        * T4 can wedge if their are DMAs in flight within the chip and Bus
> +        * master has been disabled.  We need to have it on till the Function
> +        * Level Reset completes.
> +        */
> +       pci_read_config_word(dev, PCI_COMMAND, &old_command);
> +       pci_write_config_word(dev, PCI_COMMAND,
> +                             old_command | PCI_COMMAND_MASTER);
> +
> +       /*
> +        * Perform the actual device function reset, saving and restoring
> +        * configuration information around the reset.
> +        */
> +       pci_save_state(dev);
> +
> +       /*
> +        * T4 also suffers a Head-Of-Line blocking problem if MSI-X interrupts
> +        * are disabled when an MSI-X interrupt message needs to be delivered.
> +        * So we briefly re-enable MSI-X interrupts for the duration of the
> +        * FLR.  The pci_restore_state() below will restore the original
> +        * MSI-X state.
> +        */
> +       msix_pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);

dev->msix_cap contains the capability offset already.

> +       pci_read_config_word(dev, msix_pos+PCI_MSIX_FLAGS, &msix_flags);
> +       if ((msix_flags & PCI_MSIX_FLAGS_ENABLE) == 0)
> +               pci_write_config_word(dev, msix_pos+PCI_MSIX_FLAGS,
> +                                     msix_flags |
> +                                     PCI_MSIX_FLAGS_ENABLE |
> +                                     PCI_MSIX_FLAGS_MASKALL);
> +
> +       /*
> +        * This reset code is a copy of the guts of pcie_flr() because that's
> +        * not an exported function.
> +        */
> +
> +       /* Wait for Transaction Pending bit clean */
> +       for (i = 0; i < 4; i++) {
> +               if (i)
> +                       msleep((1 << (i - 1)) * 100);
> +
> +               pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &status);
> +               if (!(status & PCI_EXP_DEVSTA_TRPND))
> +                       goto clear;
> +       }

This is at least the fifth copy of this loop:

  pcie_flr()
  pci_af_flr()
  bnx2x_do_flr()
  reset_intel_82599_sfp_virtfn()

Can we factor this out and just implement it once?  Maybe even make it
smart enough to look at the PCIe DEVSTA if it exists, and fall back to
using PCI_AF_STATUS register if *it* exists?

> +
> +       dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
> +
> +clear:
> +       pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
> +       msleep(100);
> +
> +       /*
> +        * End of pcie_flr() code sequence.
> +        */
> +
> +       rc = 0;
> +       pci_restore_state(dev);
> +
> +       /*
> +        * Restore the original PCI Configuration Space Command word (which
> +        * probably had Bus Master disabled).

Why was Bus Master probably originally disabled?  I don't see anything
in the pci_reset_function() path that would have disabled it before
getting to this function.

But I don't think you need the comment anyway.  "Probably had Bus
Master disabled" isn't anything one can rely on.

> +        */
> +       pci_write_config_word(dev, PCI_COMMAND, old_command);
> +       return rc;

"rc" appears useless.

> +}
> +
>  #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
>  #define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
>  #define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
> @@ -3221,6 +3310,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>                 reset_ivb_igd },
>         { PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>                 reset_intel_generic_dev },
> +       { PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> +               reset_chelsio_generic_dev },
>         { 0 }
>  };
>
> --
> 1.8.0
>
